// Decompiled with JetBrains decompiler
// Type: SteelCircus.Analytics.InGameAnalyticsCollector
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Controls;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using System;
using UnityEngine;

namespace SteelCircus.Analytics
{
  public class InGameAnalyticsCollector : MonoBehaviour
  {
    private bool hasUsedJoystick;
    private bool inGameAnalyticsSent;
    private float startTime;
    private float deltaTimeTotal;
    private float deltaTimeCount;
    private float rttTotal;
    private float rttCount;
    private float lossTotal;
    private float lossCount;
    private GameContext gameContext;
    private string arena;
    private bool started;
    private bool lowFpsExceptionThrown;

    public void Init(string arenaName) => this.arena = arenaName;

    private void Start()
    {
      this.gameContext = Contexts.sharedInstance.game;
      ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
    }

    private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);

    private void LastInputSourceChanged(InputSource inputSource) => this.hasUsedJoystick |= !this.KbdActive(inputSource);

    private bool KbdActive(InputSource inputSource) => inputSource == InputSource.Keyboard || inputSource == InputSource.Mouse;

    private void Update()
    {
      if (!this.started)
      {
        if (this.gameContext.matchStateEntity == null || this.gameContext.matchStateEntity.matchState.value != Imi.SharedWithServer.Game.MatchState.Intro)
          return;
        ImiServices.Instance.Analytics.OnMatchEntered(Contexts.sharedInstance.meta.metaMatch.gameType.ToString());
        if (Contexts.sharedInstance.meta.metaMatch.gameType.IsQuickMatch())
          ImiServices.Instance.Analytics.OnMatchStart();
        this.hasUsedJoystick = !this.KbdActive(ImiServices.Instance.InputService.GetLastInputSource());
        this.startTime = Time.time;
        this.started = true;
      }
      this.UpdateDeltaTime();
      this.UpdateNetworkStats();
      if (this.inGameAnalyticsSent || (double) Time.time <= (double) this.startTime + 30.0)
        return;
      this.inGameAnalyticsSent = true;
      float avgFps;
      this.SendInGameStats(out avgFps, out float _, out float _);
      if ((double) avgFps <= 30.0 && !this.lowFpsExceptionThrown)
      {
        this.lowFpsExceptionThrown = true;
        QualityManager.Level baseQuality = ImiServices.Instance.QualityManager.CurrentRenderSettings.baseQuality;
        Log.Error(string.Format("Average FPS below 30 (avg: {0}, level: {1}). Throwing an exception to gather system info. This is harmless!", (object) avgFps, (object) baseQuality));
        throw new LowFpsException(string.Format("Average FPS was {0}. Level: {1}. (This exception is harmless)", (object) avgFps, (object) baseQuality));
      }
    }

    private void SendInGameStats(out float avgFps, out float avgRtt, out float avgLoss)
    {
      if ((double) this.deltaTimeCount == 0.0)
      {
        this.deltaTimeCount = 1f;
        this.deltaTimeTotal = Time.deltaTime;
      }
      avgLoss = (double) this.lossCount != 0.0 ? this.lossTotal / this.lossCount : -1f;
      avgRtt = (double) this.rttCount != 0.0 ? this.rttTotal / this.rttCount : -1f;
      avgFps = (float) (1.0 / ((double) this.deltaTimeTotal / (double) this.deltaTimeCount));
      ImiServices.Instance.Analytics.OnInGameStatsGathered(avgFps, !this.hasUsedJoystick, avgRtt, avgLoss, this.arena, Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground());
    }

    private void UpdateDeltaTime()
    {
      if (this.gameContext.matchStateEntity == null || this.gameContext.matchStateEntity.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)
        return;
      ++this.deltaTimeCount;
      this.deltaTimeTotal += Time.deltaTime;
    }

    private void UpdateNetworkStats()
    {
      if (this.gameContext.matchStateEntity == null || this.gameContext.matchStateEntity.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)
        return;
      GameEntity entity = Contexts.sharedInstance.game.GetGroup(GameMatcher.ConnectionInfo).GetEntities()?[0];
      if (entity == null)
        return;
      ConnectionInfoComponent connectionInfo = entity.connectionInfo;
      ++this.rttCount;
      this.rttTotal += connectionInfo.rttMillis;
      ++this.lossCount;
      this.lossTotal += connectionInfo.loss;
    }

    private void OnApplicationQuit()
    {
      if (Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground() || !this.started || Contexts.sharedInstance.meta.metaState.value != MetaState.Game)
        return;
      ImiServices.Instance.Analytics.OnPlayerAbortedMatch();
    }
  }
}
