// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillGraph
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using SkillGraphDebugging;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SkillGraph
  {
    private List<SkillState> states = new List<SkillState>();
    public List<SkillVar> skillVars = new List<SkillVar>();
    private Dictionary<string, int> skillVarLookup = new Dictionary<string, int>(16);
    private List<SkillAction> skillActions = new List<SkillAction>();
    private List<int> syncActionsLastTriggerTick = new List<int>();
    private List<int> syncActionsLastProcessedTriggerTick = new List<int>();
    private ulong activeStatesBitmap;
    private readonly GameContext gameContext;
    private readonly GameEntityFactory entityFactory;
    private readonly Events events;
    private readonly bool isClient;
    private readonly SkillGraphConfig config;
    private readonly GameEntity owner;
    private readonly ulong ownerId;
    private readonly int instanceIdx;
    private IGroup<GameEntity> players;
    private EntryState startState;
    private Dictionary<SkillGraphEvent, Action> eventListerners;
    private int currentTick;
    private static float skillRechargeAmount;
    private static float sprintRechargeAmount;
    private List<SkillState> statesToExit = new List<SkillState>();
    private List<SkillGraph.ApplyStatusEffectPair> statusEffectQueue = new List<SkillGraph.ApplyStatusEffectPair>();
    private bool isSyncing;
    private bool isDestroyed;
    private JVector lastNonZeroAimDir;

    public SkillGraph(
      ulong ownerId,
      int instanceIdx,
      GameContext gameContext,
      GameEntityFactory entityFactory,
      Events events,
      bool isClient,
      SkillGraphConfig config)
    {
      this.ownerId = ownerId;
      this.instanceIdx = instanceIdx;
      this.gameContext = gameContext;
      this.entityFactory = entityFactory;
      this.events = events;
      this.isClient = isClient;
      this.config = config;
      this.owner = gameContext.GetFirstEntityWithPlayerId(ownerId);
      this.startState = this.AddState<EntryState>("Entry");
      this.activeStatesBitmap = 1UL;
      SkillGraph.skillRechargeAmount = gameContext.matchConfig.matchConfig.skillPickupRechargeAmount;
      SkillGraph.sprintRechargeAmount = gameContext.matchConfig.matchConfig.sprintPickupRechargeAmount;
      this.players = gameContext.GetGroup(GameMatcher.Player);
    }

    public void Tick(int currentTick)
    {
      this.currentTick = currentTick;
      if (this.isDestroyed)
        return;
      for (int index = 0; index < this.states.Count; ++index)
      {
        if (((long) this.activeStatesBitmap & 1L << index) != 0L)
          this.states[index].Tick();
      }
      for (int index = this.statesToExit.Count - 1; index >= 0; --index)
      {
        this.statesToExit[index].Exit_();
        this.statesToExit.RemoveAt(index);
      }
      if (this.IsRepredicting())
        return;
      foreach (SkillState state in this.states)
        state.ProcessEndOfTickStateChange();
      int index1 = 0;
      foreach (SkillAction skillAction in this.skillActions)
      {
        if (skillAction.IsNetworked)
        {
          if (this.syncActionsLastTriggerTick[index1] > this.syncActionsLastProcessedTriggerTick[index1])
          {
            skillAction.SyncedDo();
            this.syncActionsLastProcessedTriggerTick[index1] = this.syncActionsLastTriggerTick[index1];
          }
          ++index1;
        }
      }
    }

    public void EnqueuExit(SkillState state) => this.statesToExit.Add(state);

    public void AddEntryState(SkillState state) => this.startState.Go += state.Enter;

    public void AddEntryAction(SkillAction action) => this.startState.Go += action.Do;

    public T AddState<T>(string name) where T : SkillState, new()
    {
      T obj = new T();
      if (!this.states.Contains((SkillState) obj))
        this.states.Add((SkillState) obj);
      obj.SetUp(this, name);
      obj.Initialize();
      return obj;
    }

    public T AddAction<T>(string name) where T : SkillAction, new()
    {
      T obj = new T();
      obj.SetUp(this, name);
      this.AddSkillAction((SkillAction) obj);
      return obj;
    }

    public void AddSkillAction(SkillAction action)
    {
      this.skillActions.Add(action);
      if (!action.IsNetworked)
        return;
      this.syncActionsLastTriggerTick.Add(0);
      this.syncActionsLastProcessedTriggerTick.Add(0);
    }

    public SkillVar<T> AddOwnerVar<T>(string name, bool isArray = false) where T : struct => this.owner.skillGraph.AddVar<T>(name, isArray);

    public SkillVar<T> AddVar<T>(string name, bool isArray = false) where T : struct
    {
      int count = this.skillVars.Count;
      this.skillVarLookup[name] = count;
      SkillVar<T> skillVar = new SkillVar<T>(name, isArray);
      skillVar.SetAddress(this.owner.uniqueId.id, (byte) this.instanceIdx, (byte) count);
      this.skillVars.Add((SkillVar) skillVar);
      return skillVar;
    }

    public SkillVar<T> GetVar<T>(string name) where T : struct => this.skillVarLookup.ContainsKey(name) ? (SkillVar<T>) this.skillVars[this.skillVarLookup[name]] : this.owner.skillGraph.GetVar<T>(name);

    public T GetValue<T>(string name) where T : struct => this.GetVar<T>(name).Get();

    public void OnStatusEffectsAdded(StatusEffectType statusEffect)
    {
      bool flag1 = (uint) (statusEffect & StatusEffectType.Stun) > 0U;
      int num = (uint) (statusEffect & StatusEffectType.Push) > 0U ? 1 : 0;
      bool flag2 = (uint) (statusEffect & StatusEffectType.Dead) > 0U;
      bool flag3 = (uint) (statusEffect & StatusEffectType.Scrambled) > 0U;
      bool flag4 = this.owner.IsSkillUseBlocked();
      if ((num | (flag1 ? 1 : 0)) != 0)
        this.TriggerEvent(SkillGraphEvent.StunOrPush);
      if (flag2)
        this.TriggerEvent(SkillGraphEvent.Dead);
      if (flag4)
        this.TriggerEvent(SkillGraphEvent.SkillUseBlocked);
      if (flag3)
        this.TriggerEvent(SkillGraphEvent.Scrambled);
      if ((num | (flag1 ? 1 : 0) | (flag2 ? 1 : 0) | (flag4 ? 1 : 0) | (flag3 ? 1 : 0)) == 0)
        return;
      this.TriggerEvent(SkillGraphEvent.Interrupt);
    }

    public void QueueApplyStatusEffect(GameEntity target, StatusEffect effect) => this.statusEffectQueue.Add(new SkillGraph.ApplyStatusEffectPair()
    {
      target = target,
      effect = effect
    });

    public void ProcessApplyStatusEffectQueue()
    {
      for (int index = this.statusEffectQueue.Count - 1; index >= 0; --index)
      {
        SkillGraph.ApplyStatusEffectPair statusEffect = this.statusEffectQueue[index];
        statusEffect.target.AddStatusEffect(this.gameContext, statusEffect.effect);
        this.statusEffectQueue.RemoveAt(index);
      }
    }

    public void TryLockSkillGraph()
    {
      if (this.owner.skillGraph.lockingGraph == -1)
      {
        this.owner.skillGraph.lockingGraph = this.instanceIdx;
      }
      else
      {
        int lockingGraph = this.owner.skillGraph.lockingGraph;
        int instanceIdx = this.instanceIdx;
      }
    }

    public void ReleaseGraphLock()
    {
      if (this.owner.skillGraph.lockingGraph == this.instanceIdx)
      {
        this.owner.skillGraph.lockingGraph = -1;
      }
      else
      {
        int lockingGraph = this.owner.skillGraph.lockingGraph;
      }
    }

    public bool IsGraphLocked() => this.owner.skillGraph.lockingGraph != -1 && this.owner.skillGraph.lockingGraph != this.instanceIdx;

    public void RegisterForTick(SkillState state) => this.activeStatesBitmap |= (ulong) (1L << this.states.IndexOf(state));

    public void UnregisterFromTick(SkillState state) => this.activeStatesBitmap &= (ulong) ~(1L << this.states.IndexOf(state));

    public void EnqueueAction(SkillAction action)
    {
      int index = 0;
      foreach (SkillAction skillAction in this.skillActions)
      {
        if (skillAction.IsNetworked)
        {
          if (action == skillAction)
          {
            this.syncActionsLastTriggerTick[index] = this.currentTick;
            break;
          }
          ++index;
        }
      }
    }

    public SerializedSkillGraphInfo Parse()
    {
      List<SerializedSyncValueInfo> serializationInfo = new List<SerializedSyncValueInfo>();
      int valueIndex = 0;
      serializationInfo.Add(new SerializedSyncValueInfo()
      {
        name = "ActiveStates",
        type = SyncableValueType.ULong,
        size = 8,
        index = valueIndex
      });
      foreach (SkillAction skillAction in this.skillActions)
      {
        if (skillAction.IsNetworked)
        {
          serializationInfo.Add(new SerializedSyncValueInfo()
          {
            name = skillAction.Name + ".SyncActionTick",
            type = SyncableValueType.Int,
            size = 4,
            index = valueIndex
          });
          valueIndex += 3;
        }
      }
      foreach (SkillState state in this.states)
      {
        if ((state.SkillStateSyncFlag & SkillStateSyncFlag.AlwaysSync) != (SkillStateSyncFlag) 0)
          state.Parse(serializationInfo, ref valueIndex);
      }
      foreach (SkillAction skillAction in this.skillActions)
        skillAction.Parse(serializationInfo, ref valueIndex);
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Parse(serializationInfo, ref valueIndex);
      int num;
      if ((double) (num = (int) ((double) serializationInfo.Count / 8.0)) - (double) num > 0.0)
        ++num;
      return new SerializedSkillGraphInfo()
      {
        numDirtyBytes = num,
        numSyncActions = this.syncActionsLastTriggerTick.Count,
        sizeInBytes = 8 + valueIndex,
        serializedSyncValueInfos = serializationInfo
      };
    }

    public void Serialize(byte[] target, ref int writeIndex)
    {
      Unsafe.CopyBlockUnaligned(ref target[writeIndex], ref Unsafe.As<ulong, byte>(ref this.activeStatesBitmap), 8U);
      writeIndex += 8;
      for (int index = 0; index < this.syncActionsLastTriggerTick.Count; ++index)
      {
        int source = this.syncActionsLastTriggerTick[index];
        Unsafe.CopyBlockUnaligned(ref target[writeIndex], ref Unsafe.As<int, byte>(ref source), 4U);
        writeIndex += 4;
      }
      foreach (SkillState state in this.states)
      {
        if ((state.SkillStateSyncFlag & SkillStateSyncFlag.AlwaysSync) != (SkillStateSyncFlag) 0)
          state.Serialize(target, ref writeIndex);
      }
      foreach (SkillAction skillAction in this.skillActions)
        skillAction.Serialize(target, ref writeIndex);
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Serialize(target, ref writeIndex);
    }

    public void Deserialize(byte[] source, ref int readIndex)
    {
      this.SetStatesFromBitmap(BitConverter.ToUInt64(source, readIndex));
      readIndex += 8;
      for (int index = 0; index < this.syncActionsLastTriggerTick.Count; ++index)
      {
        int int32 = BitConverter.ToInt32(source, readIndex);
        this.syncActionsLastTriggerTick[index] = int32;
        readIndex += 4;
      }
      foreach (SkillState state in this.states)
      {
        if ((state.SkillStateSyncFlag & SkillStateSyncFlag.AlwaysSync) != (SkillStateSyncFlag) 0)
          state.Deserialize(source, ref readIndex);
      }
      foreach (SkillAction skillAction in this.skillActions)
        skillAction.Deserialize(source, ref readIndex);
      foreach (SkillVar skillVar in this.skillVars)
        skillVar.Deserialize(source, ref readIndex);
    }

    private void SetStatesFromBitmap(ulong bitmap)
    {
      this.isSyncing = this.owner.isLocalEntity;
      ulong activeStatesBitmap = this.activeStatesBitmap;
      for (int index = 0; index < 64; ++index)
      {
        bool flag1 = (activeStatesBitmap & (ulong) (1L << index)) > 0UL;
        bool flag2 = (bitmap & (ulong) (1L << index)) > 0UL;
        if (!flag1 & flag2)
          this.states[index].Enter_();
        else if (flag1 && !flag2)
          this.states[index].Exit_();
      }
      this.activeStatesBitmap = bitmap;
      for (int index = 0; index < this.states.Count; ++index)
      {
        bool active = (bitmap & (ulong) (1L << index)) > 0UL;
        if (active != this.states[index].IsActive)
          Log.Warning("SkillGraphSyncError! after syncing, SkillState [" + this.config.name + "][" + this.states[index].GetType().Name + " - \"" + this.states[index].Name + "\"] was [" + (!active ? "active" : "inactive") + "] but should have been [" + (active ? "active" : "inactive") + "].  Please prefer connecting states through 'SkillNodeOutPlug', as they will not create side effects during syncing");
        this.states[index].SetActiveFlag(active);
      }
      this.isSyncing = false;
    }

    public void AddEventListener(SkillGraphEvent type, Action callback)
    {
      if (this.eventListerners == null)
        this.eventListerners = new Dictionary<SkillGraphEvent, Action>();
      if (this.eventListerners.ContainsKey(type) && this.eventListerners[type] != null)
        this.eventListerners[type] += callback;
      else
        this.eventListerners[type] = callback;
    }

    public void RemoveEventListener(SkillGraphEvent type, Action callback)
    {
      if (this.eventListerners == null || !this.eventListerners.ContainsKey(type) || this.eventListerners[type] == null)
        return;
      this.eventListerners[type] -= callback;
    }

    public void TriggerEvent(SkillGraphEvent type)
    {
      if (this.eventListerners == null || !this.eventListerners.ContainsKey(type) || this.eventListerners[type] == null)
        return;
      this.eventListerners[type]();
    }

    public SkillGraphConfig GetConfig() => this.config;

    public int GetRttt() => this.owner.connectionInfo.GetRttt(this.gameContext.globalTime.fixedSimTimeStep);

    public GameEntity GetOwner() => this.owner;

    public GameEntity GetEntity(UniqueId uniqueId) => this.gameContext.GetFirstEntityWithUniqueId(uniqueId);

    public GameEntity GetPlayer(ulong playerId) => this.gameContext.GetFirstEntityWithPlayerId(playerId);

    public bool IsSyncing() => this.isSyncing;

    public bool IsDestroyed() => this.isDestroyed;

    public void Destroy()
    {
      this.isDestroyed = true;
      foreach (SkillState state in this.states)
        state.Exit_();
      this.ReleaseGraphLock();
    }

    public JVector GetMovementInputDir() => this.owner.input.GetInput(this.currentTick).moveDir;

    public JVector GetMovementInputOrLookDir()
    {
      JVector jvector = this.owner.input.GetInput(this.currentTick).moveDir;
      if (jvector.IsNearlyZero())
        jvector = this.GetLookDir();
      return jvector;
    }

    public JVector GetAimInputOrLookDir()
    {
      Input input = this.owner.input.GetInput(this.IsServer() || this.owner.isLocalEntity ? this.currentTick : this.gameContext.globalTime.lastServerTick);
      JVector moveDir = input.moveDir;
      JVector jvector = input.aimDir;
      if (jvector.IsNearlyZero())
        jvector = this.GetMovementInputOrLookDir();
      return jvector;
    }

    public void ResetLastAimDir() => this.lastNonZeroAimDir = JVector.Zero;

    public JVector GetLastNonZeroAimDir()
    {
      Input input = this.owner.input.GetInput(this.IsServer() || this.owner.isLocalEntity ? this.currentTick : this.gameContext.globalTime.lastServerTick);
      JVector moveDir = input.moveDir;
      JVector aimDir = input.aimDir;
      if (!aimDir.IsNearlyZero())
        this.lastNonZeroAimDir = aimDir;
      else if (this.lastNonZeroAimDir.IsNearlyZero())
        return this.GetLookDir();
      return this.lastNonZeroAimDir;
    }

    public float GetInputLength() => this.owner.input.GetInput(this.currentTick).moveDir.Length();

    public JVector GetLookDir() => this.owner.transform.Forward;

    public JVector GetPosition() => this.owner.transform.position;

    public bool OwnerHasBall() => this.gameContext.ballEntity != null && this.gameContext.ballEntity.hasBallOwner && (long) this.gameContext.ballEntity.ballOwner.playerId == (long) this.owner.playerId.value;

    public bool IsPointInProgress() => this.gameContext.matchState.value == Imi.SharedWithServer.Game.MatchState.PointInProgress;

    public bool IsSkillUseDisabled() => !this.IsPointInProgress() || this.owner.IsStunned() || this.owner.IsDead() || this.owner.IsPushed() || this.owner.IsSkillUseBlocked();

    public Imi.SharedWithServer.Game.MatchState GetMatchState() => this.gameContext.matchState.value;

    public float GetFixedTimeStep() => this.gameContext.globalTime.fixedSimTimeStep;

    public int GetTick() => this.currentTick;

    public ulong GetOwnerId() => this.ownerId;

    public int GetInstanceIdx() => this.instanceIdx;

    public bool IsClient() => this.isClient;

    public bool IsRepredicting() => this.gameContext.globalTime.isReprediction;

    public bool IsServer() => !this.isClient;

    public GameEntityFactory GetEntityFactory() => this.entityFactory;

    public GameContext GetContext() => this.gameContext;

    public IGroup<GameEntity> GetPlayers() => this.players;

    public List<SkillState> GetStates() => this.states;

    public int GetNumberOfStates() => this.states.Count;

    public SkillDebugDataConfig GetDebugDataConfig()
    {
      SkillDebugDataConfig skillDebugDataConfig = new SkillDebugDataConfig();
      int endIdx = 4;
      foreach (SkillState state in this.states)
        skillDebugDataConfig.nodes.Add(SkillDebugUtils.ToDebugNode(this, (object) state, endIdx, out endIdx));
      foreach (SkillAction skillAction in this.skillActions)
        skillDebugDataConfig.nodes.Add(SkillDebugUtils.ToDebugNode(this, (object) skillAction, endIdx, out endIdx));
      skillDebugDataConfig.debugStateSize = endIdx;
      skillDebugDataConfig.debugStates.Add(this.GetSerializedDebugData(skillDebugDataConfig.debugStateSize));
      return skillDebugDataConfig;
    }

    public SkillGraphDebugState GetSerializedDebugData(int bufferSize = -1)
    {
      SkillGraphDebugState skillGraphDebugState = new SkillGraphDebugState();
      skillGraphDebugState.data = bufferSize > 0 ? new byte[bufferSize] : new byte[2048];
      int endIdx = 4;
      Array.Copy((Array) BitConverter.GetBytes(this.activeStatesBitmap), 0, (Array) skillGraphDebugState.data, 0, 4);
      foreach (object state in this.states)
        SkillDebugUtils.SerializeDebugDataInto(state, skillGraphDebugState.data, endIdx, out endIdx);
      foreach (object skillAction in this.skillActions)
        SkillDebugUtils.SerializeDebugDataInto(skillAction, skillGraphDebugState.data, endIdx, out endIdx);
      return skillGraphDebugState;
    }

    public int GetDebugNodeIdx(SkillState state) => this.states.IndexOf(state);

    public int GetDebugNodeIdx(SkillAction action) => this.states.Count + this.skillActions.IndexOf(action);

    public string GetStateDescription()
    {
      string str1 = "" + string.Format("Locking Graph: [{0}]\n\n", (object) this.owner.skillGraph.lockingGraph) + "<color=#6888bd>VARIABLES --------------------------------</color>\n" + "<color=#6888bd>OWNER:</color>\n";
      foreach (SkillVar skillVar in this.owner.skillGraph.ownerVars.skillVars)
        str1 += string.Format("<color={0}>{1}</color>\n", (object) "#e3b520", (object) skillVar);
      string str2 = str1 + "<color=#6888bd>GRAPH:</color>\n";
      foreach (SkillVar skillVar in this.skillVars)
        str2 += string.Format("<color={0}>{1}</color>\n", (object) "#e3b520", (object) skillVar);
      string str3 = str2 + string.Format("Synced actions: {0}\n", (object) this.syncActionsLastTriggerTick.Count);
      for (int index = 0; index < this.syncActionsLastTriggerTick.Count; ++index)
        str3 += string.Format("[{0}] ", (object) this.syncActionsLastTriggerTick[index]);
      string str4 = str3 + "\n";
      for (int index = 0; index < this.syncActionsLastProcessedTriggerTick.Count; ++index)
        str4 += string.Format("[{0}] ", (object) this.syncActionsLastProcessedTriggerTick[index]);
      string str5 = str4 + "\n" + "\n<color=#6888bd>STATES --------------------------------</color>\n";
      for (int index = 1; index < this.states.Count; ++index)
      {
        SkillState state = this.states[index];
        str5 = !state.IsActive ? str5 + SkillDebugUtils.GetDebugInfoString((object) state) + "\n" : str5 + "<color=#00ff00>" + SkillDebugUtils.GetDebugInfoString((object) state) + "</color>\n";
      }
      string str6 = str5 + "<color=#6888bd>ACTIONS --------------------------------</color>\n";
      foreach (SkillAction skillAction in this.skillActions)
        str6 = str6 + SkillDebugUtils.GetDebugInfoString((object) skillAction) + "\n";
      return str6;
    }

    public Events GetEvents() => this.events;

    public static float CalculateRefreshCooldown(float currentCooldown, float maxCooldown) => Math.Min(Math.Max(currentCooldown - maxCooldown * SkillGraph.skillRechargeAmount, 0.0f), maxCooldown);

    public static float CalculateSprintCooldown(float currentCooldown, float maxCooldown) => Math.Min(Math.Max(currentCooldown + maxCooldown * SkillGraph.sprintRechargeAmount, 0.0f), maxCooldown);

    private struct ApplyStatusEffectPair
    {
      public GameEntity target;
      public StatusEffect effect;
    }
  }
}
