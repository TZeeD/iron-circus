// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ui.Floor.FloorStateManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.UI.Floor;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.FX.GoalAnimations.Base;
using SteelCircus.UI.Floor;
using SteelCircus.Utils.Extensions;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ui.Floor
{
  public class FloorStateManager : MonoBehaviour
  {
    [SerializeField]
    private GameObject fieldLines;
    [SerializeField]
    private GameObject introAnimationPrefab;
    [SerializeField]
    private Transform introAnimationParent;
    private GameObject introVideoInstance;
    [SerializeField]
    private FloorCenterDisplay centerDisplay;
    [SerializeField]
    private FloorMatchBallDisplay matchBallDisplay;
    [SerializeField]
    private MeshRenderer floorNormalsBase;
    [SerializeField]
    private Transform goalAnimationParent;
    [SerializeField]
    private GameObject[] goalAnimationPrefabs;
    private GameObject currentGoalAnimation;
    [SerializeField]
    private AudioSource videoAudio;

    private void Awake() => this.transform.localEulerAngles = Vector3.zero;

    private void Start()
    {
    }

    public void Setup(ArenaConfig config)
    {
      if (!((Object) config.floorNormals != (Object) null))
        return;
      this.floorNormalsBase.material = config.floorNormals;
    }

    private void OnEnable() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchSetupComplete);

    private void OnDisable() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchSetupComplete);

    private void OnMatchSetupComplete(
      Imi.SharedWithServer.Game.MatchState matchstate,
      float cutsceneduration,
      float remainingmatchtime)
    {
      if (matchstate != Imi.SharedWithServer.Game.MatchState.Intro)
        return;
      Log.Debug("Starting intro video");
      this.SetState(FloorStateManager.State.IntroPart1);
    }

    public void StartCountdown()
    {
      this.centerDisplay.StartCountdown();
      int score1 = TeamExtensions.GetScore(Team.Alpha);
      int score2 = TeamExtensions.GetScore(Team.Beta);
      int num = StartupSetup.configProvider.matchConfig.matchPoint - 1;
      if (Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining() || score1 != num && score2 != num)
        return;
      this.matchBallDisplay.Show(score1 != num || score2 != num ? (score1 == num ? Team.Alpha : Team.Beta) : Team.None);
    }

    public void StartOvertimeDisplay() => this.matchBallDisplay.Show("OVERTIME");

    private void PlayGoalAnimation(GameObject prefab)
    {
      this.StopGoalAnimation();
      this.matchBallDisplay.Hide();
      this.currentGoalAnimation = Object.Instantiate<GameObject>(prefab, this.goalAnimationParent);
      GameContext game = Contexts.sharedInstance.game;
      GameEntity firstLocalEntity = game.GetFirstLocalEntity();
      Team lastTeamThatScored = game.score.lastTeamThatScored;
      Dictionary<Team, int> score = game.score.score;
      Vector3 size = MatchObjectsParent.Floor.Size;
      this.currentGoalAnimation.transform.localPosition = new Vector3(0.0f, 0.0f, lastTeamThatScored == Team.Alpha ? size.y * 0.5f : (float) (-(double) size.y * 0.5));
      this.currentGoalAnimation.transform.localEulerAngles = new Vector3(0.0f, lastTeamThatScored == Team.Alpha ? 0.0f : 180f, 0.0f);
      GoalAnimationBase component = this.currentGoalAnimation.GetComponent<GoalAnimationBase>();
      component.SetScore(score);
      component.SetScoringTeam(lastTeamThatScored);
      component.SetScoringPlayer(firstLocalEntity);
    }

    private void StopGoalAnimation()
    {
      if (!((Object) this.currentGoalAnimation != (Object) null))
        return;
      Object.Destroy((Object) this.currentGoalAnimation);
      this.currentGoalAnimation = (GameObject) null;
    }

    public void SetState(FloorStateManager.State newState)
    {
      switch (newState)
      {
        case FloorStateManager.State.IntroPart1:
          AudioController.Play("AnnouncerWelcome");
          if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Shenzhen"))
          {
            AudioController.Play("EstablishingShotCrowdShenzhen");
            AudioController.Play("EstablishingShot");
            AudioController.Play("EstablishingShotFireworks");
            AudioController.PlayMusic("MusicArenaIntroShenzhen");
          }
          else if (ImiServices.Instance.isInMatchService.CurrentArena.Contains("Arena_Mars"))
          {
            AudioController.Play("EstablishingShotCrowdMars");
            AudioController.Play("EstablishingShot", 0.5f);
            AudioController.PlayMusic("MusicArenaIntroMars");
          }
          this.fieldLines.SetActive(false);
          this.introVideoInstance = Object.Instantiate<GameObject>(this.introAnimationPrefab, this.introAnimationParent);
          this.centerDisplay.gameObject.SetActive(false);
          break;
        case FloorStateManager.State.PlayingField:
          this.centerDisplay.gameObject.SetActive(true);
          this.fieldLines.SetActive(true);
          if ((Object) this.introVideoInstance != (Object) null)
            Object.Destroy((Object) this.introVideoInstance);
          this.StopGoalAnimation();
          break;
        case FloorStateManager.State.Goal:
          this.fieldLines.SetActive(false);
          this.PlayGoalAnimation(this.goalAnimationPrefabs.RandomItem<GameObject>());
          break;
      }
    }

    public enum State
    {
      IntroPart1,
      IntroPart2,
      PlayingField,
      Goal,
    }
  }
}
