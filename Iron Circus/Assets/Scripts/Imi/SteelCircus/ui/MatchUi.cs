// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.MatchUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.ui.Floor;
using Imi.SteelCircus.Utils;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.MatchFlow;
using SteelCircus.UI.Misc;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI
{
  public class MatchUi : MonoBehaviour
  {
    [Header("Champion Selection")]
    [SerializeField]
    private LobbyChampionPickingController lobbyScreen;
    [Header("Time Info UI")]
    [SerializeField]
    private GameObject scorePanel;
    [SerializeField]
    private Text timeTxt;
    [SerializeField]
    private Text score_alphaTxt;
    [SerializeField]
    private Text score_betaTxt;
    [SerializeField]
    private OvertimeUi overtimeUi;
    [SerializeField]
    private GameObject ballIndicatorPrefab;
    [SerializeField]
    private DeathCounterUi deathCounterUi;
    [SerializeField]
    private PostGoalUiController postGoalUiController;
    [Header("Players Died UI")]
    [SerializeField]
    private KoListUi killList;
    [SerializeField]
    private LocalPlayerDeathControllerUi localPlayerDeathControllerUi;
    [Header("Victory UI")]
    [SerializeField]
    private MatchOutcomeScreen matchOutcomeScreen;
    [Header("K.O. UI")]
    [SerializeField]
    private float showKoMessageDuration;
    [SerializeField]
    private Text koMessage;
    [Header("New K.O. UI")]
    [SerializeField]
    private GameObject koPanel;
    [SerializeField]
    private Button leaveMatchButton;
    [Header("Misc")]
    [SerializeField]
    private ScreenFader screenFader;
    [SerializeField]
    private float screenFadeDuration = 1f;
    [SerializeField]
    private Transform canvas;
    private GameObject ballIndicator;
    private OffscreenObjectIndicator ballOffscreenIndicator;
    private CameraManager cameraManager;
    private bool isOvertime;
    private int numKoPlayers;

    public Transform Canvas => this.canvas;

    private void Start()
    {
      this.cameraManager = ImiServices.Instance.CameraManager;
      Events.Global.OnEventPlayerDeath += new Events.EventPlayerDeath(this.OnPlayerDeath);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen += new LoadingScreenService.OnHideLoadingScreenEventHandler(this.ShowChampionSelectionLobby);
      this.matchOutcomeScreen.Setup(this.screenFader, this.screenFadeDuration);
      this.matchOutcomeScreen.gameObject.SetActive(false);
      this.isOvertime = false;
    }

    private void ShowChampionSelectionLobby()
    {
      if (MenuController.isInMenu)
        return;
      this.lobbyScreen.EnterConnectionScreen();
    }

    private void OnDestroy()
    {
      Events.Global.OnEventPlayerDeath -= new Events.EventPlayerDeath(this.OnPlayerDeath);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen -= new LoadingScreenService.OnHideLoadingScreenEventHandler(this.ShowChampionSelectionLobby);
    }

    private void OnPlayerDeath(ulong playerId, ulong instigatorPlayerId, float respawnDuration)
    {
      Log.Debug(string.Format("Player {0} killed by Player {1} respawnTime: {2}", (object) playerId, (object) instigatorPlayerId, (object) respawnDuration));
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
      this.killList.DisplayPlayerKill(instigatorPlayerId, playerId, respawnDuration);
      this.deathCounterUi.AddDeath(entityWithPlayerId.playerTeam.value);
      AudioController.Play("PlayerKOedCrowd");
      switch (this.numKoPlayers)
      {
        case 1:
          AudioController.Play("AnnouncerKO");
          break;
        case 2:
          AudioController.Play("AnnouncerKODouble");
          break;
        case 3:
          AudioController.Play("AnnouncerKOTriple");
          break;
        default:
          AudioController.Play("AnnouncerKO");
          break;
      }
      if (entityWithPlayerId.playerTeam.value == Team.Alpha)
        AudioController.Play("AnnouncerPowerplayBlue");
      else if (entityWithPlayerId.playerTeam.value == Team.Beta)
        AudioController.Play("AnnouncerPowerplayOrange");
      if (entityWithPlayerId == null || !entityWithPlayerId.isLocalEntity)
        return;
      this.localPlayerDeathControllerUi.DisplayDeathUi(respawnDuration, instigatorPlayerId);
      JVector spawnPointForPlayer = MatchUi.GetSpawnPointForPlayer(playerId);
      entityWithPlayerId.ReplaceDeath(spawnPointForPlayer, entityWithPlayerId.transform.position, respawnDuration, 0.0f);
    }

    private static JVector GetSpawnPointForPlayer(ulong playerId)
    {
      JVector jvector = JVector.Zero;
      foreach (GameEntity gameEntity in Contexts.sharedInstance.game.GetGroup(GameMatcher.PlayerSpawnPoint))
      {
        if ((long) gameEntity.playerSpawnPoint.playerId == (long) playerId)
        {
          jvector = gameEntity.transform.position;
          break;
        }
      }
      return jvector;
    }

    private IEnumerator DoKoThings(float respawnDuration, ulong playerId)
    {
      float t = 0.0f;
      Vector3 spawnPoint = Vector3.zero;
      GameContext gameContext = Contexts.sharedInstance.game;
      foreach (GameEntity gameEntity in gameContext.GetGroup(GameMatcher.PlayerSpawnPoint))
      {
        if ((long) gameEntity.playerSpawnPoint.playerId == (long) playerId)
          spawnPoint = gameEntity.transform.position.ToVector3();
      }
      float moveToBallDuration = 1f;
      float moveToSpawnPointDuration = 1f;
      Vector3 playerPos = gameContext.GetFirstEntityWithPlayerId(playerId).transform.position.ToVector3();
      while ((double) t < (double) respawnDuration)
      {
        if ((double) t >= (double) this.showKoMessageDuration)
          this.koMessage.text = ((int) ((double) respawnDuration - (double) t) + 1).ToString();
        if ((double) t <= (double) respawnDuration - (double) moveToSpawnPointDuration)
          gameContext.ReplaceCameraTarget(Vector3.Lerp(playerPos, gameContext.ballEntity.transform.position.ToVector3(), t / moveToBallDuration).ToJVector(), true);
        else
          gameContext.ReplaceCameraTarget(Vector3.Lerp(gameContext.ballEntity.transform.position.ToVector3(), spawnPoint, (float) (((double) t - (double) moveToSpawnPointDuration) / ((double) respawnDuration - (double) moveToSpawnPointDuration))).ToJVector(), true);
        t += Time.deltaTime;
        yield return (object) null;
      }
      gameContext.cameraTarget.overrideInProgress = false;
      this.koMessage.gameObject.SetActive(false);
    }

    public void SetUiState(Imi.SharedWithServer.Game.MatchState matchState, float duration = 0.0f)
    {
      this.scorePanel.gameObject.SetActive(true);
      if ((UnityEngine.Object) this.ballIndicator != (UnityEngine.Object) null)
        this.ballIndicator.gameObject.SetActive(false);
      switch (matchState)
      {
        case Imi.SharedWithServer.Game.MatchState.WaitingForPlayers:
          this.matchOutcomeScreen.gameObject.SetActive(false);
          break;
        case Imi.SharedWithServer.Game.MatchState.Intro:
          this.matchOutcomeScreen.gameObject.SetActive(false);
          this.scorePanel.gameObject.SetActive(false);
          break;
        case Imi.SharedWithServer.Game.MatchState.GetReady:
          this.scorePanel.gameObject.SetActive(false);
          this.StartCoroutine(this.DelayedStartPointCutSceneCR(duration, 3f));
          break;
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          this.DisableDeathUi();
          this.scorePanel.gameObject.SetActive(true);
          this.StartCoroutine(this.StartPointCutSceneCR(duration));
          this.StartCoroutine(this.RemovePostGoalUi());
          if (!this.isOvertime)
            break;
          this.overtimeUi.FadeOut(0.5f);
          break;
        case Imi.SharedWithServer.Game.MatchState.PointInProgress:
          this.SetupBallIndicator();
          this.scorePanel.gameObject.SetActive(true);
          this.ballOffscreenIndicator.gameObject.SetActive(true);
          this.overtimeUi.CleanupCutscene();
          break;
        case Imi.SharedWithServer.Game.MatchState.Goal:
          Debug.Log((object) string.Format("MatchUi::GoalState: {0} - duration: {1}", (object) Time.time, (object) duration));
          this.scorePanel.gameObject.SetActive(true);
          this.score_alphaTxt.text = string.Format("{0}", (object) TeamExtensions.GetScore(Team.Alpha));
          this.score_betaTxt.text = string.Format("{0}", (object) TeamExtensions.GetScore(Team.Beta));
          this.StartCoroutine(this.GoalCutSceneCR(duration));
          this.StartCoroutine(this.ShowPostGoalUi());
          break;
        case Imi.SharedWithServer.Game.MatchState.Overtime:
          this.isOvertime = true;
          this.overtimeUi.StartMainAnimation(7f);
          this.overtimeUi.gameObject.SetActive(true);
          this.overtimeUi.FadeIn(1f);
          break;
        case Imi.SharedWithServer.Game.MatchState.MatchOver:
          this.scorePanel.gameObject.SetActive(false);
          this.matchOutcomeScreen.gameObject.SetActive(true);
          this.matchOutcomeScreen.FadeIn(duration);
          this.overtimeUi.CleanupCutsceneMatchOver();
          this.localPlayerDeathControllerUi.RemoveDeathUi();
          this.StartCoroutine(this.MatchOverCutScene(duration));
          break;
        case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
          this.scorePanel.gameObject.SetActive(false);
          this.matchOutcomeScreen.gameObject.SetActive(true);
          this.matchOutcomeScreen.StartMainAnimation(duration);
          break;
        case Imi.SharedWithServer.Game.MatchState.VictoryPose:
          this.StartCoroutine(this.VictoryPosePlayersCutSceneCR(duration));
          break;
      }
    }

    private IEnumerator RemovePostGoalUi()
    {
      yield return (object) new WaitForSeconds(2f);
      this.postGoalUiController.HidePostGoalTiles();
    }

    private IEnumerator ShowPostGoalUi()
    {
      yield return (object) new WaitForSeconds(0.25f);
      this.postGoalUiController.DisplayPlayerThatScored();
    }

    private void SetupBallIndicator()
    {
      this.ballIndicator = UnityEngine.Object.Instantiate<GameObject>(this.ballIndicatorPrefab, this.canvas, false);
      this.ballOffscreenIndicator = this.ballIndicator.GetComponent<OffscreenObjectIndicator>();
      this.ballOffscreenIndicator.cameraToUse = this.cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.InGameCamera).GetComponent<InGameCameraBehaviour>().Camera.GetMain();
      this.ballOffscreenIndicator.objectToIndicate = Contexts.sharedInstance.game.ballEntity.unityView.gameObject;
      this.ballOffscreenIndicator.gameObject.SetActive(false);
    }

    private void Update()
    {
      TimeSpan timeSpan = TimeSpan.FromSeconds((double) MatchUtils.GetRemainingTime());
      this.timeTxt.text = string.Format("{0:D2}:{1:D2}", (object) timeSpan.Minutes, (object) timeSpan.Seconds);
      if (!((UnityEngine.Object) this.ballOffscreenIndicator != (UnityEngine.Object) null))
        return;
      GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
      Color col = new Color(1f, 0.98f, 0.79f, 1f);
      if (ballEntity != null && ballEntity.hasBallOwner)
      {
        GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(ballEntity.ballOwner.playerId);
        if (entityWithPlayerId != null)
          col = entityWithPlayerId.playerTeam.value != Team.Alpha ? SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight : SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
      }
      col *= 1.1f;
      this.ballOffscreenIndicator.SetColor(col);
    }

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

    private IEnumerator StartPointCutSceneCR(float duration)
    {
      if (StartupSetup.configProvider.debugConfig.skipCutscenes)
        duration = 1f;
      MatchObjectsParent.FloorStateManager.StartCountdown();
      yield return (object) new WaitForSeconds(0.8f);
      this.score_alphaTxt.text = string.Format("{0}", (object) TeamExtensions.GetScore(Team.Alpha));
      this.score_betaTxt.text = string.Format("{0}", (object) TeamExtensions.GetScore(Team.Beta));
    }

    public IEnumerator DelayedStartPointCutSceneCR(
      float duration,
      float countdownDuration)
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      MatchUi matchUi = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        matchUi.StartCoroutine(matchUi.StartPointCutSceneCR(countdownDuration));
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) new WaitForSeconds(duration - countdownDuration);
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    private IEnumerator GoalCutSceneCR(float goalCutsceneLength)
    {
      yield return (object) null;
      MatchObjectsParent.FloorStateManager.SetState(FloorStateManager.State.Goal);
      if (StartupSetup.configProvider.debugConfig.skipCutscenes)
        goalCutsceneLength = 1f;
      Team lastTeamThatScored = Contexts.sharedInstance.game.score.lastTeamThatScored;
      if (AudioController.IsPlaying("Music1MinuteRemainingShenzhen") || AudioController.IsPlaying("Music1MinuteRemainingMars"))
        AudioController.PauseMusic();
      AudioController.Play("GoalScored");
      AudioController.Play("GoalScoredCrowdCheer");
      if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Shenzhen"))
        AudioController.Play("GoalStingerShenzhen");
      else if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Mars"))
        AudioController.Play("GoalStingerMars");
      switch (lastTeamThatScored)
      {
        case Team.Alpha:
          AudioController.Play("AnnouncerGoalOrange");
          break;
        case Team.Beta:
          AudioController.Play("AnnouncerGoalBlue");
          break;
      }
      this.cameraManager.ShowGoalCamera(lastTeamThatScored);
      Events.Global.FireEventCameraShake((Transform) null);
      float counter = goalCutsceneLength;
      while ((double) counter > 0.0)
      {
        counter -= Time.deltaTime;
        yield return (object) new WaitForSeconds(Time.deltaTime);
      }
    }

    private IEnumerator MatchOverCutScene(float duration)
    {
      AudioController.StopAll(2f);
      GameEntity singleEntity = Contexts.sharedInstance.game.GetGroup(GameMatcher.LocalEntity).GetSingleEntity();
      Team winningTeam = TeamExtensions.GetWinningTeam();
      switch (winningTeam)
      {
        case Team.Alpha:
          AudioController.Play("AnnouncerWinnerOrange");
          break;
        case Team.Beta:
          AudioController.Play("AnnouncerWinnerBlue");
          break;
      }
      if (singleEntity.playerTeam.value == Team.Alpha && winningTeam == Team.Alpha || singleEntity.playerTeam.value == Team.Beta && winningTeam == Team.Beta)
        AudioController.PlayMusic("MusicVictory");
      else if (winningTeam == Team.None)
        AudioController.PlayMusic("MusicDraw");
      else
        AudioController.PlayMusic("MusicLose");
      AudioController.Play("MatchEndingAnimation");
      AudioController.Play("KickoffCrowd");
      AudioController.Stop("AmbienceCrowdBaseLoop", 2f);
      AudioController.Stop("AmbienceCrowd1MinuteRemaining", 2f);
      yield return (object) new WaitForSeconds(duration);
    }

    private void DisableDeathUi()
    {
      if (!this.koPanel.gameObject.activeSelf)
        return;
      this.koPanel.GetComponent<Animator>().SetTrigger("exit");
      this.koPanel.SetActive(false);
    }

    private IEnumerator VictoryPosePlayersCutSceneCR(float duration)
    {
      this.scorePanel.SetActive(false);
      IGroup<GameEntity> group = Contexts.sharedInstance.game.GetGroup(GameMatcher.Player);
      Player[] playerArray = new Player[group.count];
      List<GameEntity> gameEntityList1 = new List<GameEntity>();
      List<GameEntity> gameEntityList2 = new List<GameEntity>();
      int index = 0;
      foreach (GameEntity gameEntity in group)
      {
        playerArray[index] = gameEntity.unityView.gameObject.GetComponent<Player>();
        switch (playerArray[index].PlayerTeam)
        {
          case Team.Alpha:
            gameEntityList1.Add(gameEntity);
            break;
          case Team.Beta:
            gameEntityList2.Add(gameEntity);
            break;
        }
        ++index;
      }
      foreach (Player player in playerArray)
      {
        if ((UnityEngine.Object) player.FloorUI != (UnityEngine.Object) null)
          player.FloorUI.gameObject.SetActive(false);
      }
      this.screenFader.FadeOut(this.screenFadeDuration / 2f);
      yield return (object) new WaitForSeconds(duration - this.screenFadeDuration / 2f);
      this.screenFader.FadeIn(this.screenFadeDuration / 2f);
      yield return (object) new WaitForSeconds(this.screenFadeDuration / 2f);
    }

    public void DeselectGameObject() => EventSystem.current.SetSelectedGameObject((GameObject) null, (BaseEventData) null);
  }
}
