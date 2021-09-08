// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchEndScreen
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.UI.MatchFlow;
using SteelCircus.UI.OptionsUI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;

namespace SteelCircus.UI
{
  public class MatchEndScreen : MonoBehaviour
  {
    [SerializeField]
    private MVPScreen mvpUi;
    [SerializeField]
    private XPUi xpUi;
    [SerializeField]
    private SimplePromptSwitch navigatorBar;
    private GameObject currentScreen;
    public bool inMatchEndScreen;
    [SerializeField]
    private SimpleCountDown gameEndsCountDown;
    [SerializeField]
    private GameObject topPanel;
    [SerializeField]
    private GameObject backGroundImage;
    [SerializeField]
    private MVPPlayerAvatar[] mvpAvatars;
    [SerializeField]
    private GameObject avatarPrefab;
    [SerializeField]
    private Transform alphaAvatarTransform;
    [SerializeField]
    private Transform betaAvatarTransform;
    [SerializeField]
    private TextMeshProUGUI goalScoreTextLeft;
    [SerializeField]
    private TextMeshProUGUI goalScoreTextRight;
    [Header("InfoScreen")]
    [SerializeField]
    private GameObject infoScreen;
    [SerializeField]
    private GameObject loadingText;
    [SerializeField]
    private GameObject errorText;
    private bool errorReceivingStats;
    private bool receivedStatsfromServer;
    private InputService input;
    private List<MVPPlayerAvatar> allPLayerAvatars;
    private bool skipCooldownActive;
    public MatchEndScreen.tempPlayerInfo[] allPlayerInfos;

    private void Awake() => ImiServices.Instance.PartyService.OnGroupLeftEndScreen += new APartyService.OnGroupLeftEndScreenEventHandler(this.ForcedLeaveEndScreen);

    private void Start()
    {
      this.input = ImiServices.Instance.InputService;
      Events.Global.OnEventGameStatMatchFinished += new Events.EventGameStatMatchFinished(this.OnGetMatchStatistics);
      this.allPLayerAvatars = new List<MVPPlayerAvatar>();
      Events.Global.OnEventDebug += new Events.EventDebug(this.ShowDebugEndScreen);
    }

    private void OnDestroy()
    {
      ImiServices.Instance.PartyService.OnGroupLeftEndScreen -= new APartyService.OnGroupLeftEndScreenEventHandler(this.ForcedLeaveEndScreen);
      Events.Global.OnEventGameStatMatchFinished -= new Events.EventGameStatMatchFinished(this.OnGetMatchStatistics);
      Events.Global.OnEventDebug -= new Events.EventDebug(this.ShowDebugEndScreen);
    }

    private void Update()
    {
      if (this.inMatchEndScreen && !this.skipCooldownActive)
      {
        if ((this.input.GetButtonDown(DigitalInput.UISubmit) || Input.GetMouseButtonUp(0)) && !this.mvpUi.AllowVoting)
          this.SkipStep();
        if (this.input.GetButtonDown(DigitalInput.UICancel))
          this.SkipStep();
      }
      if (!this.skipCooldownActive)
        return;
      this.StartCoroutine(this.DelayedResetSkipCooldown());
    }

    private IEnumerator DelayedResetSkipCooldown()
    {
      yield return (object) null;
      this.skipCooldownActive = false;
    }

    private void ForcedLeaveEndScreen(string msg)
    {
      if (!this.inMatchEndScreen)
        return;
      Debug.Log((object) "Group owner left Endscreen - also leaving.");
      this.GoBackToMenu();
    }

    public MatchEndScreen.tempPlayerInfo GetPlayerInfo(ulong playerId)
    {
      foreach (MatchEndScreen.tempPlayerInfo allPlayerInfo in this.allPlayerInfos)
      {
        if ((long) playerId == (long) allPlayerInfo.playerId)
          return allPlayerInfo;
      }
      return new MatchEndScreen.tempPlayerInfo();
    }

    public void OnSkipStepEvent()
    {
      if (!this.gameObject.activeInHierarchy || this.skipCooldownActive)
        return;
      this.SkipStep();
    }

    public void OnSkipAllEvent()
    {
      if (!this.gameObject.activeInHierarchy)
        return;
      this.GoBackToMenu();
    }

    private void SkipStep()
    {
      if (!this.inMatchEndScreen)
        return;
      this.skipCooldownActive = true;
      if (this.errorReceivingStats)
        this.GoBackToMenu();
      if ((UnityEngine.Object) this.currentScreen == (UnityEngine.Object) this.mvpUi.gameObject)
      {
        if (!this.mvpUi.animFinished)
          this.mvpUi.SkipAnimations();
        else
          this.ShowXPScreen();
      }
      else
      {
        if (!((UnityEngine.Object) this.currentScreen == (UnityEngine.Object) this.xpUi.gameObject))
          return;
        if (!this.xpUi.animFinished)
          this.xpUi.SkipStep();
        else
          this.GoBackToMenu();
      }
    }

    private void ShowDebugEndScreen(ulong playerId, DebugEventType type)
    {
    }

    private MatchEndScreen.tempPlayerInfo SetFakeRewardStats(
      ulong playerId,
      string playerName,
      Team team,
      ChampionType champion)
    {
      return new MatchEndScreen.tempPlayerInfo()
      {
        playerId = playerId,
        playerName = playerName,
        team = team,
        champion = champion
      };
    }

    public void ShowEndScreen(float mvpTime, float xpTime, bool isDebugScreen = false)
    {
      AudioController.PlayAmbienceSound("AmbienceCrowdBaseLoop");
      if (!isDebugScreen && (Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground() || Contexts.sharedInstance.meta.metaMatch.gameType.IsCustomMatch() || Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining() || Contexts.sharedInstance.meta.metaMatch.gameType.IsAdvancedTraining()))
      {
        this.GoBackToMenu();
      }
      else
      {
        this.topPanel.SetActive(true);
        this.backGroundImage.SetActive(true);
        this.gameEndsCountDown.StartCountdown(mvpTime + xpTime);
        this.inMatchEndScreen = true;
        if (!this.receivedStatsfromServer)
          this.ShowStatsLoadingScreen();
        if (this.errorReceivingStats)
        {
          this.ShowErrorScreen();
        }
        else
        {
          this.ShowMVPScreen();
          this.StartCoroutine(this.SwitchToXPScreenAfterCountdown(mvpTime, xpTime));
        }
        this.StartCoroutine(this.ReturnToMenuAfterCountdown(mvpTime + xpTime));
        this.navigatorBar.transform.parent.gameObject.SetActive(true);
        this.navigatorBar.gameObject.SetActive(true);
        this.navigatorBar.SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.skipStep);
      }
    }

    public void ShowStatsLoadingScreen()
    {
      this.infoScreen.SetActive(true);
      this.loadingText.SetActive(true);
      this.errorText.SetActive(false);
    }

    public void ShowErrorScreen()
    {
      this.infoScreen.SetActive(true);
      this.loadingText.SetActive(false);
      this.errorText.SetActive(true);
    }

    public void HideInfoScreen()
    {
      this.infoScreen.SetActive(false);
      this.loadingText.SetActive(false);
      this.errorText.SetActive(false);
    }

    public IEnumerator ReturnToMenuAfterCountdown(float duration)
    {
      yield return (object) new WaitForSeconds(duration);
      this.GoBackToMenu();
    }

    public IEnumerator SwitchToXPScreenAfterCountdown(
      float duration,
      float xpScreenDuration)
    {
      yield return (object) new WaitForSeconds(duration);
      this.ShowXPScreen();
    }

    public void ShowMVPScreen(bool initialAnimation = true)
    {
      this.currentScreen = this.mvpUi.gameObject;
      this.mvpUi.TriggerMVPScreen();
    }

    public void ShowXPScreen(bool initialAnimation = true)
    {
      if (!((UnityEngine.Object) this.currentScreen != (UnityEngine.Object) this.xpUi.gameObject))
        return;
      this.mvpUi.Uninitialize();
      AudioController.Play("MvpScreenTransition");
      this.currentScreen = this.xpUi.gameObject;
      this.StartCoroutine(this.xpUi.PlayXPScreenCoroutine());
    }

    public void GoBackToMenu()
    {
      Log.Debug("Called GoBackToMenu - skipping statsScreen");
      AudioController.StopAmbienceSound(3f);
      ImiServices.Instance.GoBackToMenu();
    }

    public void OnMatchStatisticsReceived(JObject statsObject) => this.OnMatchStatisticsReceived(statsObject, false);

    public void OnMatchStatisticsReceived(JObject statsObject, bool debug)
    {
      Log.Debug(statsObject.ToString());
      this.receivedStatsfromServer = true;
      this.xpUi.stats = new XPUi.xpStats();
      this.errorReceivingStats = false;
      if (statsObject["error"] != null || statsObject["msg"] != null)
      {
        this.errorReceivingStats = true;
        Log.Warning("Could not receive match statistics.");
      }
      else
      {
        this.HideInfoScreen();
        Log.Debug(statsObject["experience"].ToString());
        this.xpUi.stats.xpStart = (int) statsObject["experience"][(object) "xpStart"];
        this.xpUi.stats.xpEnd = (int) statsObject["experience"][(object) "xpEnd"];
        this.xpUi.stats.xpGained = (int) statsObject["experience"][(object) "experienceGained"];
        this.xpUi.stats.xpGainedThroughMatchOutcome = (int) statsObject["experience"][(object) "experienceOutcome"];
        this.xpUi.stats.xpGainedThroughAwards = (int) statsObject["experience"][(object) "experienceAwards"];
        this.xpUi.stats.xpGainedThroughBonus = (int) statsObject["experience"][(object) "experienceBonus"];
        this.xpUi.stats.xpStartLevel = (int) statsObject["experience"][(object) "experienceStartLevel"];
        this.xpUi.stats.startLevel = (int) statsObject["experience"][(object) "startLevel"];
        this.xpUi.stats.endLevel = (int) statsObject["experience"][(object) "endLevel"];
        this.xpUi.stats.penaltiesLeft = statsObject["penaltiesLeft"] == null ? 0 : (int) statsObject["penaltiesLeft"];
        JArray jarray1 = (JArray) statsObject["experience"][(object) "levels"];
        this.xpUi.stats.levels = new XPUi.xpStats.level[jarray1.Count];
        for (int index = 0; index < jarray1.Count; ++index)
        {
          this.xpUi.stats.levels[index] = new XPUi.xpStats.level();
          this.xpUi.stats.levels[index].xpNeeded = (int) jarray1[index][(object) "xpNeeded"];
          int result1 = 0;
          int.TryParse(jarray1[index][(object) "creditReward"].ToString(), out result1);
          int result2 = 0;
          int.TryParse(jarray1[index][(object) "steelReward"].ToString(), out result2);
          Debug.Log((object) jarray1[index][(object) "itemReward"].ToString());
          if (jarray1[index][(object) "itemReward"].ToString() == "")
          {
            this.xpUi.stats.levels[index].hasItemReward = false;
          }
          else
          {
            this.xpUi.stats.levels[index].hasItemReward = true;
            this.xpUi.stats.levels[index].itemRewardId = (int) jarray1[index][(object) "itemReward"];
          }
          this.xpUi.stats.levels[index].steelReward = result2;
          this.xpUi.stats.levels[index].creditsReward = result1;
        }
        JArray jarray2 = (JArray) statsObject["experience"][(object) "expBonusItems"];
        this.xpUi.stats.boni = new XPUi.xpStats.bonusAward[jarray2.Count];
        for (int index = 0; index < jarray2.Count; ++index)
        {
          this.xpUi.stats.boni[index] = new XPUi.xpStats.bonusAward();
          this.xpUi.stats.boni[index].name = jarray2[index][(object) "bonusExpType"].ToString();
          this.xpUi.stats.boni[index].bonusXP = (int) jarray2[index][(object) "bonusExperience"];
        }
        if (statsObject["steel"] != null)
          this.xpUi.stats.steelGainedThroughMatchOutcome = (int) statsObject["steel"];
        JArray jarray3 = (JArray) statsObject["awards"];
        this.mvpUi.allAwards = new List<MVPScreen.mvpStats>();
        for (int index = 0; index < jarray3.Count; ++index)
        {
          if ((string) jarray3[index][(object) "awardId"] != "MVP")
          {
            MVPScreen.mvpStats mvpStats = new MVPScreen.mvpStats();
            mvpStats.awardId = (string) jarray3[index][(object) "awardId"];
            mvpStats.playerId = (ulong) jarray3[index][(object) "playerId"];
            JToken jtoken1 = jarray3[index][(object) "score"];
            if (jtoken1 != null)
              mvpStats.score = (int) jtoken1;
            JToken jtoken2 = jarray3[index][(object) "showStats"];
            if (jtoken2 != null)
              mvpStats.showStats = (bool) jtoken2;
            if ((long) mvpStats.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
              this.xpUi.awardStats = mvpStats;
            this.mvpUi.allAwards.Add(mvpStats);
          }
          else
          {
            ulong num = (ulong) jarray3[index][(object) "playerId"];
            this.mvpUi.mvpID = num;
            if ((long) num == (long) ImiServices.Instance.LoginService.GetPlayerId())
              this.xpUi.stats.isMVP = true;
          }
        }
        this.mvpUi.PopulateCardsWithPlayers(debug);
      }
    }

    private void OnGetMatchStatistics(
      GameStatMatchFinishedEvent gameStatMatchFinishedEvent)
    {
      gameStatMatchFinishedEvent.results.OrderByDescending<GameStatMatchFinishedEvent.MatchResult, int>((Func<GameStatMatchFinishedEvent.MatchResult, int>) (o => o.score)).ToList<GameStatMatchFinishedEvent.MatchResult>();
      if (Contexts.sharedInstance.meta.hasMetaMatch)
      {
        Log.Debug(string.Format("Playerid: {0} - MatchId: {1}", (object) ImiServices.Instance.LoginService.GetPlayerId(), (object) Contexts.sharedInstance.meta.metaMatch.matchId));
        if (!gameStatMatchFinishedEvent.matchId.Equals(Contexts.sharedInstance.meta.metaMatch.matchId))
          Log.Error("MatchId from GameStatMatchFinishedMessage dows not match our MatchId in the MetaEntity!");
      }
      Log.Debug("MATCH IS OVER : " + gameStatMatchFinishedEvent.matchId);
      GameEntity[] entities = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities();
      this.goalScoreTextLeft.text = TeamExtensions.GetScore(Team.Alpha).ToString();
      this.goalScoreTextRight.text = TeamExtensions.GetScore(Team.Beta).ToString();
      this.allPlayerInfos = new MatchEndScreen.tempPlayerInfo[entities.Length];
      for (int index = 0; index < this.allPlayerInfos.Length; ++index)
      {
        this.allPlayerInfos[index].playerId = entities[index].playerId.value;
        this.allPlayerInfos[index].playerName = !entities[index].hasPlayerUsername ? "[<color=red>[MISSING]</color>]" : entities[index].playerUsername.username;
        this.allPlayerInfos[index].champion = entities[index].championConfig.value.championType;
        this.allPlayerInfos[index].team = entities[index].playerTeam.value;
      }
      GameStatMatchFinishedEvent.MatchResult matchResult = new GameStatMatchFinishedEvent.MatchResult();
      foreach (GameStatMatchFinishedEvent.MatchResult result in gameStatMatchFinishedEvent.results)
      {
        if ((long) result.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
          matchResult = result;
      }
      this.xpUi.matchResult = matchResult;
    }

    public void PopulateAvatarsWithPlayers()
    {
      GameEntity[] entities = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities();
      List<ulong> ulongList = new List<ulong>();
      this.mvpAvatars = new MVPPlayerAvatar[entities.Length];
      for (int index = 0; index < entities.Length; ++index)
      {
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.avatarPrefab);
        gameObject.name = entities[index].playerUsername.username + "_Avatar";
        MVPPlayerAvatar component1 = gameObject.GetComponent<MVPPlayerAvatar>();
        this.allPLayerAvatars.Add(component1);
        bool twitchUserName = ImiServices.Instance.TwitchService.IsPlayerTwitchUser(entities[index].playerId.value);
        if ((long) entities[index].playerId.value == (long) ImiServices.Instance.LoginService.GetPlayerId() && (!PlayerPrefs.HasKey(TwitchAccountSettings.TwitchNameTogglePlayerPref) || PlayerPrefs.GetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref) == 0))
          twitchUserName = false;
        component1.SetMvpAvatar(entities[index].playerTeam.value, entities[index].championConfig.value.championType, entities[index].playerId.value, entities[index].playerUsername.username, twitchUserName);
        if (!entities[index].isFakePlayer)
          ulongList.Add(entities[index].playerId.value);
        else
          this.SetFakePlayerLevel(entities[index].playerId.value, 99);
        if (entities[index].playerTeam.value == Team.Alpha)
          gameObject.transform.SetParent(this.alphaAvatarTransform);
        else if (entities[index].playerTeam.value == Team.Beta)
          gameObject.transform.SetParent(this.betaAvatarTransform);
        RectTransform component2 = gameObject.GetComponent<RectTransform>();
        component2.localPosition = new Vector3(component2.position.x, component2.position.y, 0.0f);
        component2.localScale = new Vector3(1f, 1f, 1f);
        this.mvpAvatars[index] = component1;
      }
      this.GetPlayerLevels(ulongList.ToArray());
    }

    private void GetPlayerLevels(ulong[] playerIds) => SingletonManager<MetaServiceHelpers>.Instance.GetPlayerLevelsCoroutine(playerIds, (Action<JObject>) (jObj =>
    {
      if (jObj == null || jObj["error"] != null)
      {
        Log.Error("Could not Fetch player levels");
      }
      else
      {
        foreach (ulong playerId in playerIds)
        {
          Log.Debug("Trying to Parse Levels for Player: " + playerId.ToString());
          if (jObj[playerId.ToString()] != null)
          {
            int num = int.Parse(jObj[playerId.ToString()].ToString());
            this.SetPlayerLevelText(playerId, num.ToString());
          }
          else
            Log.Error(string.Format("No Player Level Data for Player: {0} reveiced", (object) playerId));
        }
        Log.Debug("Player Levels parsing finished.");
      }
    }));

    private void SetFakePlayerLevel(ulong playerId, int level) => this.SetPlayerLevelText(playerId, level.ToString());

    private void OnGetPlayerLevel(ulong playerId, JObject obj)
    {
      if (obj["msg"] != null || obj["error"] != null)
      {
        Log.Warning("GetPlayerLevel failed!");
      }
      else
      {
        Log.Debug("ProfileProgressionComponent OnSuccess. XP: " + obj["experienceAccum"].ToString());
        this.SetPlayerLevelText(playerId, obj["currentLevel"].ToString());
      }
    }

    private void SetPlayerLevelText(ulong playerId, string level)
    {
      foreach (MVPPlayerAvatar allPlayerAvatar in this.allPLayerAvatars)
      {
        if ((long) allPlayerAvatar.PlayerId == (long) playerId)
          allPlayerAvatar.SetLevel(level);
      }
    }

    public void DebugPopulateAvatarsWithPlayers()
    {
      this.mvpAvatars = new MVPPlayerAvatar[6];
      for (int index = 0; index < 6; ++index)
      {
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.avatarPrefab);
        gameObject.name = "Player_" + (object) index + "_Avatar";
        MVPPlayerAvatar component1 = gameObject.GetComponent<MVPPlayerAvatar>();
        if (index < 3)
        {
          component1.SetMvpAvatar(Team.Alpha, ChampionType.Li, (ulong) index, "Player_" + (object) index);
          gameObject.transform.SetParent(this.alphaAvatarTransform);
        }
        else
        {
          component1.SetMvpAvatar(Team.Beta, ChampionType.Bagpipes, (ulong) index, "Player_" + (object) index);
          gameObject.transform.SetParent(this.betaAvatarTransform);
        }
        RectTransform component2 = gameObject.GetComponent<RectTransform>();
        component2.localPosition = new Vector3(component2.position.x, component2.position.y, 0.0f);
        component2.localScale = new Vector3(1f, 1f, 1f);
        this.mvpAvatars[index] = component1;
      }
    }

    public struct tempPlayerInfo
    {
      public ulong playerId;
      public string playerName;
      public ChampionType champion;
      public Team team;
    }
  }
}
