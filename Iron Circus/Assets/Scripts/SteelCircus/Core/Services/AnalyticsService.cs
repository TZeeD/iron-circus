// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.AnalyticsService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using GameAnalyticsSDK.Net;
using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class AnalyticsService
  {
    private bool matchmakingTrackingInProgress;
    private bool loginTrackingInProgress = true;
    private float matchmakingStartTime;
    private float matchmakingPlayerLatency;
    private Dictionary<ulong, int> matchmakingPlayerLevels;

    public AnalyticsService() => UnitySystemConsoleRedirector.Redirect();

    public void Initialize(ulong playerId)
    {
      Log.Debug("Initialized Analytics");
      GameAnalytics.SetEnabledInfoLog(true);
      GameAnalytics.SetEnabledVerboseLog(true);
      GameAnalytics.ConfigureBuild("client 0.0.1");
      GameAnalytics.ConfigureUserId(string.Format("{0}", (object) playerId));
      GameAnalytics.Initialize("e31e2e60e39c968a8db14a0788f1dc57", "d5e5e35c816d08e747c3c0de4cc4ded626d70b41");
    }

    public void FinalizeMicroTransactionGameAnalyticsEvent(JObject obj)
    {
      Log.Debug("Analytics:  Queueing FinalizeMicroTransactionEvent");
      JToken jtoken = obj["pack"];
      if (jtoken == null)
        return;
      int amount = int.Parse(jtoken[(object) "price"].ToString());
      GameAnalytics.AddBusinessEvent(jtoken[(object) "currency"].ToString(), amount, "CreditsPack", jtoken[(object) "ShopCreditPack"][(object) "name"].ToString(), "Shop");
    }

    public void BuyChampionDlcGameAnalyticsEvent(JObject obj)
    {
      Log.Debug(obj.ToString());
      if (obj["result"] == null || !(obj["result"].ToString() != "OK"))
        return;
      foreach (JToken jtoken in (IEnumerable<JToken>) obj["result"])
      {
        if (jtoken[(object) "trackEventType"] != null)
        {
          if (jtoken[(object) "trackEventType"].ToString() == "buy")
          {
            Log.Debug("Analytics:  Queueing Buy DLC event");
            GameAnalytics.AddBusinessEvent(jtoken[(object) "currency"].ToString(), int.Parse(jtoken[(object) "final_price"].ToString()), "DLC", jtoken[(object) "steamAppId"].ToString(), "Shop");
          }
          if (jtoken[(object) "trackEventType"].ToString() == "refund")
          {
            Log.Debug("Analytics:  Queueing Refund DLC event");
            string currency = jtoken[(object) "currency"].ToString();
            int.Parse(jtoken[(object) "final_price"].ToString());
            string itemId = jtoken[(object) "steamAppId"].ToString();
            GameAnalytics.AddBusinessEvent(currency, 0, "DLC", itemId, "Refund");
          }
        }
      }
    }

    public void OnAutoSelectedQualityLevel(QualityManager.Level level)
    {
    }

    public void OnQuickMatchButtonClicked() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "QuickMatchButtonClicked");

    public void OnCreateAndJoinTrainingSession() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "CreateAndJoinTrainingSession");

    public void OnQuit()
    {
      Log.Debug("Shut down Analytics");
      GameAnalytics.OnQuit();
      Thread.Sleep(1500);
    }

    public void OnEnteredGfxSettings() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "EnteredGfxSettings");

    public void OnMatchStart()
    {
      GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Start, "MatchPlayed");
      string key = "T_MatchesPlayed";
      int num = PlayerPrefs.HasKey(key) ? PlayerPrefs.GetInt(key) + 1 : 1;
      if (num > 5 && (num % 10 != 0 || num > 100))
        return;
      GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, string.Format("MatchesStarted_{0}", (object) num));
    }

    public void OnMatchAborted() => GameAnalytics.AddDesignEvent("MatchAborted");

    public void OnPlayerAbortedMatch() => GameAnalytics.AddDesignEvent("MatchAbortedByPlayer");

    public void OnMatchEnd(bool playerTeamLost)
    {
      string key = "T_MatchesPlayed";
      int num = PlayerPrefs.HasKey(key) ? PlayerPrefs.GetInt(key) + 1 : 1;
      PlayerPrefs.SetInt(key, num);
      GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "MatchPlayed");
      if (num <= 5 || num % 10 == 0 && num <= 100)
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, string.Format("MatchesComplete_{0}", (object) num));
      if (num == 1)
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, playerTeamLost ? "FirstMatchLost" : "FirstMatchWon");
      if (num != 2 || Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining())
        return;
      GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, playerTeamLost ? "FirstMatchLost_Training" : "FirstMatchWon_Training");
    }

    public void OnMatchEntered(string matchType) => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "MatchEntered_" + matchType);

    public void OnTutorialStep(int step)
    {
      if (step == 0)
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "TutorialV2Step_Started");
      else
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, string.Format("TutorialV2Step_{0}", (object) step));
    }

    public void OnTutorialCompleted() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "TutorialV2Completed");

    public void OnTutorialMatchCompleted() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "TutorialV2MatchCompleted");

    public void OnMatchmakingStarted()
    {
      if (!this.matchmakingTrackingInProgress)
        GameAnalytics.AddDesignEvent("MatchmakingStarted");
      this.matchmakingTrackingInProgress = true;
      this.matchmakingStartTime = Time.time;
      this.matchmakingPlayerLevels = (Dictionary<ulong, int>) null;
    }

    public void OnMatchmakingPlayerLevelsReceived(Dictionary<ulong, int> playerLevels) => this.matchmakingPlayerLevels = playerLevels;

    public void OnMatchmakingPlayerLatencyReported(float playerLatency) => this.matchmakingPlayerLatency = playerLatency;

    public void OnTrackMatchmakingError(string msg)
    {
      if (!this.matchmakingTrackingInProgress)
        return;
      this.matchmakingTrackingInProgress = false;
      Log.Error("CouldntTrackMatchmaking: " + msg + " (this should not affect the game)");
      this.OnError("MatchmakingCouldntTrack:" + msg);
    }

    public void OnAppStart() => GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "App_Started");

    public void OnMatchmakingFailed(string msg)
    {
      if (!this.matchmakingTrackingInProgress)
        return;
      this.matchmakingTrackingInProgress = false;
      this.OnError("MatchmakingFailed:" + msg);
    }

    public void OnLoginFailed(string msg)
    {
      if (!this.loginTrackingInProgress)
        return;
      this.loginTrackingInProgress = false;
      this.OnError("LoginFailed:" + msg);
    }

    public void OnInGameStatsGathered(
      float avgFPS,
      bool kbdUser,
      float avgRTT,
      float avgLoss,
      string arena,
      bool isPlayground)
    {
      int num = !PlayerPrefs.HasKey("T_MatchesPlayed") ? 1 : 0;
      if (isPlayground)
        arena += "_playground";
      if (num != 0)
      {
        GameAnalytics.AddDesignEvent("FTU_InGameFPS:" + arena, (double) avgFPS);
        GameAnalytics.AddDesignEvent("FTU_InGameKBDUser", kbdUser ? 1.0 : 0.0);
        if ((double) avgRTT != -1.0)
          GameAnalytics.AddDesignEvent("FTU_InGameRTT", (double) avgRTT);
        if ((double) avgLoss != -1.0)
          GameAnalytics.AddDesignEvent("FTU_InGameLoss", (double) avgLoss);
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "FTU_InGameKBDUser_" + (kbdUser ? "yes" : "no"));
        string str = (double) avgFPS >= 30.0 ? ((double) avgFPS >= 40.0 ? ((double) avgFPS >= 50.0 ? ((double) avgFPS >= 60.0 ? "MoreThan60" : "50To60") : "40To50") : "30To40") : "LessThan30";
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "FTU_InGameFPS_" + arena + "_" + str);
        GameAnalytics.AddProgressionEvent(EGAProgressionStatus.Complete, "FTU_InGameRTT_" + ((double) avgRTT >= 50.0 ? ((double) avgRTT >= 100.0 ? ((double) avgRTT >= 200.0 ? ((double) avgRTT >= 300.0 ? "MoreThan300" : "200To300") : "100To200") : "50To100") : "LessThan50"));
      }
      else
      {
        GameAnalytics.AddDesignEvent("InGameFPS:" + arena, (double) avgFPS);
        GameAnalytics.AddDesignEvent("InGameKBDUser", kbdUser ? 1.0 : 0.0);
        if ((double) avgRTT != -1.0)
          GameAnalytics.AddDesignEvent("InGameRTT", (double) avgRTT);
        if ((double) avgLoss == -1.0)
          return;
        GameAnalytics.AddDesignEvent("InGameLoss", (double) avgLoss);
      }
    }

    public void OnGCBroke(string msg)
    {
      GameAnalytics.AddErrorEvent(EGAErrorSeverity.Error, "GCBroke" + msg);
      GameAnalytics.AddDesignEvent("Error:GCBroke:" + msg);
    }

    public void OnError(string msg)
    {
      GameAnalytics.AddErrorEvent(EGAErrorSeverity.Error, msg);
      GameAnalytics.AddDesignEvent("Error:" + msg);
    }
  }
}
