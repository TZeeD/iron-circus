// Decompiled with JetBrains decompiler
// Type: MatchViewController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.FX;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.UI;
using Imi.SteelCircus.ui.Floor;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.MatchFlow;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MatchViewController : SingletonManager<MatchViewController>
{
  [SerializeField]
  private MatchUi matchUI;
  [SerializeField]
  private PlayerUiController playerUiController;
  [SerializeField]
  private MVPScreen mvpUi;
  [SerializeField]
  private XPUi xpUi;
  [SerializeField]
  private MatchEndScreen endScreen;
  private CameraManager cameraManager;
  private Team localTeam;

  public MatchUi MatchUI => this.matchUI;

  private void Start()
  {
    this.cameraManager = ImiServices.Instance.CameraManager;
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    Log.Debug(string.Format("MatchViewController ShowCutSceneEvent received. State: {0}, Duration {1}", (object) matchState, (object) cutsceneDuration));
    switch (matchState)
    {
      case Imi.SharedWithServer.Game.MatchState.WaitingForPlayers:
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.MenuUICamera);
        break;
      case Imi.SharedWithServer.Game.MatchState.Intro:
        RazerChromaHelper.ExecuteRazerAnimation(1);
        SceneManager.SetActiveScene(GameObject.FindWithTag("ArenaRoot").scene);
        this.StartCoroutine(this.IntroCutSceneCR(cutsceneDuration));
        break;
      case Imi.SharedWithServer.Game.MatchState.GetReady:
        this.StartCoroutine(this.FixCharactesViews());
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera);
        this.cameraManager.ResetInGameCamera();
        MatchObjectsParent.FloorStateManager.SetState(FloorStateManager.State.PlayingField);
        this.localTeam = Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team;
        RazerChromaHelper.ExecuteRazerAnimationForTeam(this.localTeam);
        break;
      case Imi.SharedWithServer.Game.MatchState.StartPoint:
        this.localTeam = Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team;
        RazerChromaHelper.ExecuteRazerAnimationForTeam(this.localTeam);
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera);
        this.cameraManager.ResetInGameCamera();
        MatchObjectsParent.FloorStateManager.SetState(FloorStateManager.State.PlayingField);
        break;
      case Imi.SharedWithServer.Game.MatchState.PointInProgress:
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera);
        break;
      case Imi.SharedWithServer.Game.MatchState.Goal:
        RazerChromaHelper.ExecuteRazerAnimation(5);
        break;
      case Imi.SharedWithServer.Game.MatchState.Overtime:
        Contexts.sharedInstance.meta.metaMatch.isOvertime = true;
        if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Shenzhen"))
        {
          AudioController.PlayMusic("Music1MinuteRemainingShenzhen");
          break;
        }
        if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Mars"))
        {
          AudioController.PlayMusic("Music1MinuteRemainingMars");
          break;
        }
        break;
      case Imi.SharedWithServer.Game.MatchState.MatchOver:
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera);
        if (TeamExtensions.GetScore(Team.Alpha) != TeamExtensions.GetScore(Team.Beta))
          this.cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.VictoryCameras).GetComponentInChildren<VictoryAnimationEvents>().Setup();
        ImiServices.Instance.InputService.StopRumble();
        break;
      case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera);
        break;
      case Imi.SharedWithServer.Game.MatchState.VictoryPose:
        if (MatchViewController.SkipToMainMenu())
          return;
        this.ShowVictoryPoseScreen();
        break;
      case Imi.SharedWithServer.Game.MatchState.StatsScreens:
        if (Contexts.sharedInstance.meta.hasMetaMatch && Contexts.sharedInstance.meta.metaMatch.gameType.IsCustomMatch())
        {
          Log.Debug("MATCH(Playground) OVER:: " + Contexts.sharedInstance.meta.metaMatch.matchId);
          ImiServices.Instance.GoBackToMenu();
          return;
        }
        Log.Debug("MATCH OVER : " + Contexts.sharedInstance.meta.metaMatch.matchId);
        this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.MenuUICamera);
        this.endScreen.ShowEndScreen((float) ((double) cutsceneDuration * 3.0 / 5.0), (float) ((double) cutsceneDuration * 2.0 / 5.0));
        break;
    }
    this.matchUI.SetUiState(matchState, cutsceneDuration);
  }

  private void ShowVictoryPoseScreen()
  {
    Team team = Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value;
    MatchOutcome matchOutcomeForTeam = TeamExtensions.GetMatchOutcomeForTeam(team);
    Team winningTeam = matchOutcomeForTeam.IsWin() ? team : team.GetOpponents();
    Log.Debug(string.Format("VictoryPoses: Team: {0} - {1} TeamThatWon: {2}  TeamForfeited: {3}", (object) team, (object) matchOutcomeForTeam, (object) winningTeam, (object) TeamExtensions.GetForfeitedTeam()));
    if (!matchOutcomeForTeam.IsDraw())
    {
      VictoryAnimationEvents componentInChildren = this.cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.VictoryCameras).GetComponentInChildren<VictoryAnimationEvents>();
      componentInChildren.ShowFakeVictoryChampions();
      componentInChildren.HidePlayerChampions();
      foreach (FakeChampionView championView in componentInChildren.championViews)
        this.playerUiController.EnablePlayerHudForVictoryScreenFake(championView.playerId, championView.championView);
      this.cameraManager.ShowVictoryCamera(winningTeam);
    }
    if (!Contexts.sharedInstance.meta.hasMetaMatch || Contexts.sharedInstance.meta.metaMatch.gameType.IsCustomMatch() || Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground() || Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining() || Contexts.sharedInstance.meta.metaMatch.gameType.IsAdvancedTraining())
      return;
    Log.Debug(string.Format("Playerid: {0} - MatchId: {1}", (object) ImiServices.Instance.LoginService.GetPlayerId(), (object) Contexts.sharedInstance.meta.metaMatch.matchId));
    this.StartCoroutine(MetaServiceHelpers.GetMatchStatistics(ImiServices.Instance.LoginService.GetPlayerId(), Contexts.sharedInstance.meta.metaMatch.matchId, new Action<JObject>(this.endScreen.OnMatchStatisticsReceived)));
  }

  private static bool SkipToMainMenu()
  {
    MetaContext meta = Contexts.sharedInstance.meta;
    if (!meta.hasMetaMatch || !meta.metaMatch.gameType.IsPlayground() && !meta.metaMatch.gameType.IsBasicTraining())
      return false;
    Log.Debug(string.Format("MATCH({0}) OVER:: {1}", (object) meta.metaMatch.gameType, (object) meta.metaMatch.matchId));
    ImiServices.Instance.GoBackToMenu();
    return true;
  }

  private IEnumerator FixCharactesViews()
  {
    GameEntity[] playerEntities = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities();
    foreach (GameEntity gameEntity in playerEntities)
    {
      if (gameEntity.hasUnityView)
      {
        gameEntity.unityView.gameObject.transform.GetChild(0).gameObject.SetActive(true);
        gameEntity.unityView.gameObject.GetComponent<Player>().FloorUI.gameObject.SetActive(true);
      }
    }
    yield return (object) new WaitForSeconds(0.5f);
    foreach (GameEntity gameEntity in playerEntities)
    {
      if (gameEntity.hasUnityView)
      {
        gameEntity.unityView.gameObject.transform.GetChild(0).gameObject.SetActive(true);
        gameEntity.unityView.gameObject.GetComponent<Player>().FloorUI.gameObject.SetActive(true);
      }
    }
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private CutsceneBase GetCutsceneForCamera(GameObject cameraObject) => cameraObject.GetComponentInChildren<CutsceneBase>();

  private IEnumerator IntroCutSceneCR(float duration)
  {
    Log.Debug("Starting Intro, duration " + (object) duration);
    if (StartupSetup.configProvider.debugConfig.skipCutscenes && (double) duration > 0.0)
      duration = 1f;
    if ((double) duration > 0.0)
    {
      this.cameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.IntroCamera);
      GameObject introCamera = this.cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.IntroCamera);
      Animator animator = introCamera.GetComponentInChildren<Animator>();
      introCamera.GetComponentInChildren<IntroAnimationEvents>().Setup();
      AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
      float num = 0.0f;
      foreach (AnimationClip animationClip in animationClips)
        num += animationClip.length;
      float startTime = Time.time;
      float cTime = startTime;
      yield return (object) null;
      yield return (object) null;
      yield return (object) null;
      while ((double) cTime < (double) startTime + (double) duration)
      {
        cTime += Time.deltaTime;
        if (!Contexts.sharedInstance.game.hasMatchState || Contexts.sharedInstance.game.matchState.value == Imi.SharedWithServer.Game.MatchState.Intro)
          yield return (object) null;
        else
          break;
      }
      introCamera.SetActive(false);
      foreach (GameEntity gameEntity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player))
        gameEntity.animationState.RemoveState(AnimationStateType.ChampionIntro);
      animator.speed = 1f;
      introCamera = (GameObject) null;
      animator = (Animator) null;
    }
  }
}
