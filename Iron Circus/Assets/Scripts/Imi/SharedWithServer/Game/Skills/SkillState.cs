// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public abstract class SkillState
  {
    protected string name;
    protected SkillGraph skillGraph;
    public Action onEnterDelegate;
    public Action onExitDelegate;
    public Action onBeforeUpdateDelegate;
    public Action onUpdateDelegate;
    public List<InPlug> inPlugs = new List<InPlug>();
    public List<OutPlug> outPlugs = new List<OutPlug>();
    public InPlug Enter;
    public InPlug Restart;
    public InPlug Exit;
    public OutPlug OnEnter;
    public OutPlug OnExit;
    public OutPlug OnUpdate;
    public SubStates SubState;
    protected bool isActive;
    protected bool wasActive;

    public string Name => this.name;

    public string GetName() => this.name;

    protected virtual SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.AlwaysUpdate;

    public virtual SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    protected InPlug AddInPlug(Action action)
    {
      InPlug inPlug = new InPlug((object) this, this.inPlugs.Count, action);
      this.inPlugs.Add(inPlug);
      return inPlug;
    }

    protected OutPlug AddOutPlug()
    {
      int count = this.outPlugs.Count;
      OutPlug outPlug = new OutPlug();
      outPlug.index = count;
      this.outPlugs.Add(outPlug);
      return outPlug;
    }

    public bool IsActive => this.isActive;

    public void SetActiveFlag(bool active) => this.isActive = active;

    public void ProcessEndOfTickStateChange()
    {
      if (this.wasActive && !this.isActive)
        this.OnBecameInactiveThisTick();
      if (!this.wasActive && this.isActive)
        this.OnBecameActiveThisTick();
      this.wasActive = this.isActive;
    }

    private bool IsSet(SkillStateExecutionFlag flag) => (this.SkillStateExecutionFlag & flag) > (SkillStateExecutionFlag) 0;

    public SkillState()
    {
      this.Enter = this.AddInPlug(new Action(this.Enter_));
      this.Exit = this.AddInPlug(new Action(this.Exit_));
      this.Restart = this.AddInPlug(new Action(this.Restart_));
      this.OnEnter = this.AddOutPlug();
      this.OnUpdate = this.AddOutPlug();
      this.OnExit = this.AddOutPlug();
    }

    public void SetUp(SkillGraph skillGraph, string name)
    {
      this.name = name;
      this.skillGraph = skillGraph;
    }

    public virtual void Initialize()
    {
    }

    public void Restart_()
    {
      this.isActive = false;
      this.Enter_();
    }

    public void Enter_()
    {
      if (this.isActive)
        return;
      try
      {
        this.isActive = true;
        if (!this.skillGraph.GetOwner().isLocalEntity)
        {
          bool flag = this.skillGraph.IsSyncing();
          if (flag && !this.IsSet(SkillStateExecutionFlag.TickRemoteEntities) || !flag && this.IsSet(SkillStateExecutionFlag.TickOnlyLocalEntity))
            return;
        }
        this.skillGraph.RegisterForTick(this);
        this.EnterDerived();
        Action onEnterDelegate = this.onEnterDelegate;
        if (onEnterDelegate != null)
          onEnterDelegate();
        this.SubState.Fire(this.skillGraph);
        this.OnEnter.Fire(this.skillGraph);
      }
      catch (Exception ex)
      {
        Log.Error("Exception in: " + this.skillGraph.GetConfig().name + "." + this.name + ".Enter_");
        throw ex;
      }
    }

    public void Tick()
    {
      try
      {
        if (!this.skillGraph.GetOwner().isLocalEntity && !this.IsSet(SkillStateExecutionFlag.TickRemoteEntities))
          return;
        if (!this.skillGraph.IsSyncing() && !this.skillGraph.IsDestroyed())
        {
          Action beforeUpdateDelegate = this.onBeforeUpdateDelegate;
          if (beforeUpdateDelegate != null)
            beforeUpdateDelegate();
        }
        this.TickDerived();
        if (!this.skillGraph.IsSyncing() && !this.skillGraph.IsDestroyed())
        {
          Action onUpdateDelegate = this.onUpdateDelegate;
          if (onUpdateDelegate != null)
            onUpdateDelegate();
        }
        this.OnUpdate.Fire(this.skillGraph);
      }
      catch (Exception ex)
      {
        Log.Error("Exception in: " + this.skillGraph.GetConfig().name + "." + this.name + ".Tick");
        throw ex;
      }
    }

    public void Exit_()
    {
      if (!this.isActive)
        return;
      try
      {
        this.isActive = false;
        if (!this.skillGraph.GetOwner().isLocalEntity)
        {
          bool flag = this.skillGraph.IsSyncing();
          if (flag && !this.IsSet(SkillStateExecutionFlag.TickRemoteEntities) || !flag && this.IsSet(SkillStateExecutionFlag.TickOnlyLocalEntity))
            return;
        }
        this.skillGraph.UnregisterFromTick(this);
        this.ExitDerived();
        if (!this.skillGraph.IsDestroyed())
        {
          Action onExitDelegate = this.onExitDelegate;
          if (onExitDelegate != null)
            onExitDelegate();
        }
        this.SubState.Abort(this.skillGraph);
        this.OnExit.Fire(this.skillGraph);
      }
      catch (Exception ex)
      {
        Log.Error("Exception in: " + this.skillGraph.GetConfig().name + "." + this.name + ".Exit_");
        throw ex;
      }
    }

    protected virtual void EnterDerived()
    {
    }

    protected virtual void TickDerived()
    {
    }

    protected virtual void ExitDerived()
    {
    }

    protected virtual void OnBecameActiveThisTick()
    {
    }

    protected virtual void OnBecameInactiveThisTick()
    {
    }

    protected GameEntity GetOwner() => this.skillGraph.GetOwner();

    public virtual void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
    }

    public virtual void Serialize(byte[] target, ref int valueIndex)
    {
    }

    public virtual void Deserialize(byte[] target, ref int valueIndex)
    {
    }

    public override string ToString() => SkillDebugUtils.GetDebugInfoString((object) this);
  }
}
