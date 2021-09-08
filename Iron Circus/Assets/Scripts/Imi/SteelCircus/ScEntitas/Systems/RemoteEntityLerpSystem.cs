// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScEntitas.Systems.RemoteEntityLerpSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils.Smoothing;
using SteelCircus.Networking;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ScEntitas.Systems
{
  public class RemoteEntityLerpSystem : ExecuteGameSystem, IInitializeSystem, ISystem
  {
    private readonly DebugConfig debugConfig;
    private const float LerpOffsetInSeconds = 0.0f;
    private const float WeightBlendDurationInSeconds = 0.05f;
    private const int HistoryBufferSize = 64;
    private List<RemoteEntityState> _lerpedRemoteStates = new List<RemoteEntityState>(10);

    public RemoteEntityLerpSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.debugConfig = entitasSetup.ConfigProvider.debugConfig;
    }

    public void Initialize() => this.gameContext.ReplaceRemoteEntityLerpState(new List<RemoteEntityLerpSystem.RemoteStateHistoryEntry>(64), new List<RemoteEntityLerpSystem.RemoteStateLerpPair>(8), 0.0f, new FilteredFloat(4f));

    public void Add(List<RemoteEntityState> states, int serverTick)
    {
      float seconds = (float) ScTime.TicksToSeconds(serverTick, this.gameContext.globalTime.fixedSimTimeStep);
      if (this.InsertIntoHistoryBuffer(new RemoteEntityLerpSystem.RemoteStateHistoryEntry(serverTick, seconds, states)) != -1)
        return;
      Log.Warning(string.Format("Trying to insert a state (tick {0}) into historyBuffer that is older than the oldest stored state, but buffer is already at capacity. Doing nothing.", (object) serverTick));
    }

    private int InsertIntoHistoryBuffer(
      RemoteEntityLerpSystem.RemoteStateHistoryEntry entry)
    {
      List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> historyBuffer = this.gameContext.remoteEntityLerpState.historyBuffer;
      if (historyBuffer.Count == 0)
      {
        historyBuffer.Add(entry);
        return 0;
      }
      int serverTick = entry.serverTick;
      for (int index1 = historyBuffer.Count - 1; index1 >= 0; --index1)
      {
        RemoteEntityLerpSystem.RemoteStateHistoryEntry stateHistoryEntry = historyBuffer[index1];
        if (serverTick > stateHistoryEntry.serverTick)
        {
          int index2 = index1 + 1;
          historyBuffer.Insert(index2, entry);
          if (historyBuffer.Count > 64)
          {
            historyBuffer.RemoveAt(0);
            --index2;
          }
          return index2;
        }
      }
      if (historyBuffer.Count + 1 > 64)
        return -1;
      historyBuffer.Insert(0, entry);
      return 0;
    }

    private RemoteEntityLerpSystem.RemoteStateLerpPair FindLerpPair(
      float timeStampInSeconds)
    {
      List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> historyBuffer = this.gameContext.remoteEntityLerpState.historyBuffer;
      if (historyBuffer.Count == 0)
        return RemoteEntityLerpSystem.RemoteStateLerpPair.Invalid;
      if (historyBuffer.Count == 1)
        return new RemoteEntityLerpSystem.RemoteStateLerpPair(historyBuffer[0], historyBuffer[0]);
      if (historyBuffer.Count == 2)
        return new RemoteEntityLerpSystem.RemoteStateLerpPair(historyBuffer[0], historyBuffer[1]);
      if ((double) historyBuffer[historyBuffer.Count - 1].timestampInSeconds < (double) timeStampInSeconds)
        return new RemoteEntityLerpSystem.RemoteStateLerpPair(historyBuffer[historyBuffer.Count - 2], historyBuffer[historyBuffer.Count - 1]);
      for (int index = historyBuffer.Count - 1; index >= 1; --index)
      {
        if ((double) historyBuffer[index].timestampInSeconds >= (double) timeStampInSeconds && (double) historyBuffer[index - 1].timestampInSeconds <= (double) timeStampInSeconds)
          return new RemoteEntityLerpSystem.RemoteStateLerpPair(historyBuffer[index - 1], historyBuffer[index]);
      }
      return new RemoteEntityLerpSystem.RemoteStateLerpPair(historyBuffer[0], historyBuffer[1]);
    }

    private void UpdateLerpsAndViewTransforms(float timeStampInSeconds)
    {
      List<RemoteEntityLerpSystem.RemoteStateLerpPair> activeLerpPairs = this.gameContext.remoteEntityLerpState.activeLerpPairs;
      RemoteEntityLerpSystem.RemoteStateLerpPair lerpPair = this.FindLerpPair(timeStampInSeconds);
      if (lerpPair.Equals(RemoteEntityLerpSystem.RemoteStateLerpPair.Invalid))
        return;
      bool flag1 = lerpPair.NeedsExtrapolation(timeStampInSeconds);
      bool flag2 = false;
      for (int index = 0; index < activeLerpPairs.Count; ++index)
      {
        if (activeLerpPairs[index].Equals(lerpPair))
        {
          flag2 = true;
          break;
        }
      }
      if (!flag2)
      {
        lerpPair.didExtrapolate = flag1;
        if (activeLerpPairs.Count == 0)
        {
          activeLerpPairs.Add(lerpPair);
        }
        else
        {
          RemoteEntityLerpSystem.RemoteStateLerpPair remoteStateLerpPair = activeLerpPairs[activeLerpPairs.Count - 1];
          if (!remoteStateLerpPair.didExtrapolate && !flag1)
          {
            lerpPair.currentWeight = remoteStateLerpPair.currentWeight;
            activeLerpPairs.RemoveAt(activeLerpPairs.Count - 1);
            activeLerpPairs.Add(lerpPair);
          }
          else
          {
            lerpPair.currentWeight = 0.0f;
            activeLerpPairs.Add(lerpPair);
          }
        }
      }
      float num = 0.05f;
      if (this.debugConfig.overrideRemoteLerpSettings)
        num = this.debugConfig.remoteLerpWeightBlendDurationInSeconds;
      RemoteEntityLerpSystem.RemoteStateLerpPair remoteStateLerpPair1;
      for (int index = 0; index < activeLerpPairs.Count; ++index)
      {
        remoteStateLerpPair1 = activeLerpPairs[index];
        remoteStateLerpPair1.didExtrapolate = remoteStateLerpPair1.NeedsExtrapolation(timeStampInSeconds);
        remoteStateLerpPair1.currentWeight = Mathf.Clamp01(remoteStateLerpPair1.currentWeight + Time.deltaTime / num);
        activeLerpPairs[index] = remoteStateLerpPair1;
      }
      for (int index = activeLerpPairs.Count - 1; index >= 1; --index)
      {
        remoteStateLerpPair1 = activeLerpPairs[index];
        if ((double) remoteStateLerpPair1.currentWeight == 1.0)
        {
          activeLerpPairs.RemoveRange(0, index);
          break;
        }
      }
      RemoteEntityLerpSystem.RemoteStateLerpPair pair1 = activeLerpPairs[0];
      this._lerpedRemoteStates.Clear();
      this._lerpedRemoteStates.AddRange((IEnumerable<RemoteEntityState>) pair1.start.states);
      this.LerpPair(this._lerpedRemoteStates, timeStampInSeconds, pair1, 1f);
      for (int index = 1; index < activeLerpPairs.Count; ++index)
      {
        RemoteEntityLerpSystem.RemoteStateLerpPair pair2 = activeLerpPairs[index];
        this.LerpPair(this._lerpedRemoteStates, timeStampInSeconds, pair2, pair2.currentWeight);
      }
      for (int index = 0; index < this._lerpedRemoteStates.Count; ++index)
      {
        RemoteEntityState lerpedRemoteState = this._lerpedRemoteStates[index];
        GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(lerpedRemoteState.uniqueId);
        if (entityWithUniqueId != null && entityWithUniqueId.hasUnityView && !entityWithUniqueId.isLocalEntity && !entityWithUniqueId.isBall)
        {
          entityWithUniqueId.unityView.gameObject.transform.position = lerpedRemoteState.position.ToVector3();
          entityWithUniqueId.unityView.gameObject.transform.rotation = lerpedRemoteState.rotation.ToQuaternion();
        }
      }
    }

    private void LerpPair(
      List<RemoteEntityState> baseStates,
      float timestampInSeconds,
      RemoteEntityLerpSystem.RemoteStateLerpPair pair,
      float weight)
    {
      RemoteEntityLerpSystem.RemoteStateHistoryEntry start = pair.start;
      RemoteEntityLerpSystem.RemoteStateHistoryEntry end = pair.end;
      float timestampInSeconds1 = start.timestampInSeconds;
      float timestampInSeconds2 = end.timestampInSeconds;
      float t = (double) timestampInSeconds1 != (double) timestampInSeconds2 ? (float) (((double) timestampInSeconds - (double) timestampInSeconds1) / ((double) timestampInSeconds2 - (double) timestampInSeconds1)) : 0.0f;
      for (int index = 0; index < baseStates.Count; ++index)
      {
        RemoteEntityState baseState = baseStates[index];
        UniqueId uniqueId = baseState.uniqueId;
        RemoteEntityState from = RemoteEntityState.Invalid;
        RemoteEntityState to1 = RemoteEntityState.Invalid;
        foreach (RemoteEntityState state in start.states)
        {
          if (state.uniqueId.Equals(uniqueId))
          {
            from = state;
            break;
          }
        }
        foreach (RemoteEntityState state in end.states)
        {
          if (state.uniqueId.Equals(uniqueId))
          {
            to1 = state;
            break;
          }
        }
        if (!from.Equals(RemoteEntityState.Invalid) && !to1.Equals(RemoteEntityState.Invalid))
        {
          RemoteEntityState to2 = RemoteEntityState.Lerp(from, to1, t);
          RemoteEntityState remoteEntityState = RemoteEntityState.Lerp(baseState, to2, weight);
          baseStates[index] = remoteEntityState;
        }
      }
    }

    private void UpdateSmoothedRtt()
    {
      GameEntity entity = this.gameContext.GetGroup(GameMatcher.ConnectionInfo).GetEntities()[0];
      if (entity == null)
        return;
      this.gameContext.remoteEntityLerpState.smoothedRTT.Add(entity.connectionInfo.rttMillis / 1000f, Time.realtimeSinceStartup);
    }

    private void UpdateLerpTimestamp(float currentTickBasedTimestamp)
    {
      if ((double) currentTickBasedTimestamp >= (double) this.gameContext.remoteEntityLerpState.currentLerpTimestamp)
        this.gameContext.remoteEntityLerpState.currentLerpTimestamp = currentTickBasedTimestamp;
      else
        Log.Warning("RemoteEntityLerpSystem: calculated timestamp for this frame is lower than last internal timestamp (i.e. our characters would be running backwards). " + string.Format("Calculated timestamp: {0} - internal timestamp {1}", (object) currentTickBasedTimestamp, (object) this.gameContext.remoteEntityLerpState.currentLerpTimestamp));
    }

    private void BypassLerpsAndUpdateViewTransforms()
    {
      List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> historyBuffer = this.gameContext.remoteEntityLerpState.historyBuffer;
      if (historyBuffer.Count == 0)
        return;
      List<RemoteEntityState> states = historyBuffer[historyBuffer.Count - 1].states;
      for (int index = 0; index < states.Count; ++index)
      {
        RemoteEntityState remoteEntityState = states[index];
        GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(remoteEntityState.uniqueId);
        if (entityWithUniqueId != null && entityWithUniqueId.hasUnityView && !entityWithUniqueId.isLocalEntity && !entityWithUniqueId.isBall)
        {
          entityWithUniqueId.unityView.gameObject.transform.position = remoteEntityState.position.ToVector3();
          entityWithUniqueId.unityView.gameObject.transform.rotation = remoteEntityState.rotation.ToQuaternion();
        }
      }
    }

    protected override void GameExecute()
    {
      this.UpdateSmoothedRtt();
      double val1 = (double) this.gameContext.remoteEntityLerpState.smoothedRTT.GetSimpleAverage() + 0.0;
      if (this.debugConfig.overrideRemoteLerpSettings)
        val1 = (double) this.debugConfig.remoteLerpOffsetInSeconds;
      this.UpdateLerpTimestamp((float) (ScTime.TicksToSeconds(this.gameContext.globalTime.currentTick, this.gameContext.globalTime.fixedSimTimeStep) + (double) this.gameContext.globalTime.timeSinceStartOfTick - Math.Max(val1, 0.0)));
      if (this.metaContext.metaState.value == MetaState.Game)
        this.UpdateLerpsAndViewTransforms(this.gameContext.remoteEntityLerpState.currentLerpTimestamp);
      else
        this.BypassLerpsAndUpdateViewTransforms();
    }

    public struct RemoteStateHistoryEntry : 
      IEquatable<RemoteEntityLerpSystem.RemoteStateHistoryEntry>
    {
      public int serverTick;
      public List<RemoteEntityState> states;
      public float timestampInSeconds;

      public static RemoteEntityLerpSystem.RemoteStateHistoryEntry Invalid => new RemoteEntityLerpSystem.RemoteStateHistoryEntry(-1, -1f, (List<RemoteEntityState>) null);

      public RemoteStateHistoryEntry(
        int serverTick,
        float timestampInSeconds,
        List<RemoteEntityState> states)
      {
        this.states = states;
        this.serverTick = serverTick;
        this.timestampInSeconds = timestampInSeconds;
      }

      public bool Equals(
        RemoteEntityLerpSystem.RemoteStateHistoryEntry other)
      {
        return this.serverTick == other.serverTick;
      }

      public override bool Equals(object obj) => obj != null && obj is RemoteEntityLerpSystem.RemoteStateHistoryEntry other && this.Equals(other);

      public override int GetHashCode() => (this.serverTick * 397 ^ (this.states != null ? this.states.GetHashCode() : 0)) * 397 ^ this.timestampInSeconds.GetHashCode();
    }

    public struct RemoteStateLerpPair : IEquatable<RemoteEntityLerpSystem.RemoteStateLerpPair>
    {
      public RemoteEntityLerpSystem.RemoteStateHistoryEntry start;
      public RemoteEntityLerpSystem.RemoteStateHistoryEntry end;
      public bool didExtrapolate;
      public float currentWeight;

      public static RemoteEntityLerpSystem.RemoteStateLerpPair Invalid => new RemoteEntityLerpSystem.RemoteStateLerpPair(RemoteEntityLerpSystem.RemoteStateHistoryEntry.Invalid, RemoteEntityLerpSystem.RemoteStateHistoryEntry.Invalid);

      public RemoteStateLerpPair(
        RemoteEntityLerpSystem.RemoteStateHistoryEntry start,
        RemoteEntityLerpSystem.RemoteStateHistoryEntry end)
      {
        this.start = start;
        this.end = end;
        this.didExtrapolate = false;
        this.currentWeight = 0.0f;
      }

      public bool NeedsExtrapolation(float timestampInSeconds) => (double) timestampInSeconds < (double) this.start.timestampInSeconds || (double) timestampInSeconds > (double) this.end.timestampInSeconds;

      public bool Equals(RemoteEntityLerpSystem.RemoteStateLerpPair other) => this.start.Equals(other.start) && this.end.Equals(other.end);

      public override bool Equals(object obj) => obj != null && obj is RemoteEntityLerpSystem.RemoteStateLerpPair other && this.Equals(other);

      public override int GetHashCode() => this.start.GetHashCode() * 397 ^ this.end.GetHashCode();
    }
  }
}
