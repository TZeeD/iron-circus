// Decompiled with JetBrains decompiler
// Type: TutorialListener
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.Networking.Messages;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.UI;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.Tutorial;
using System;
using System.Collections;
using UnityEngine;

public class TutorialListener : MonoBehaviour
{
  private GameContext gameContext;
  private GameEntity player;
  private GameEntity ball;
  [SerializeField]
  private GameObject tutorialTextBoxPrefab;
  [SerializeField]
  private GameObject tutorialPreloaderPrefab;
  private TutorialTextBox tutorialText;
  private TutorialTextBoxPositioner tutorialTextBoxPositioner;
  private Imi.SharedWithServer.Game.MatchState prevMatchState = Imi.SharedWithServer.Game.MatchState.Intro;
  private bool pickupConsumed;
  private bool pickupStepShown;
  [SerializeField]
  private Sprite imgSprint;
  [SerializeField]
  private Sprite imgBall;
  [SerializeField]
  private Sprite imgEnemyGoal;
  [SerializeField]
  private Sprite imgPass;
  [SerializeField]
  private Sprite imgTeamMate;
  [SerializeField]
  private Sprite imgOpponent;
  [SerializeField]
  private Sprite imgTackle;
  [SerializeField]
  private Sprite imgDodge;
  [SerializeField]
  private Sprite imgPickup;
  [SerializeField]
  private Sprite imgWall;
  [SerializeField]
  private Sprite imgTurret1;
  [SerializeField]
  private Sprite imgLogo;
  private float boxAnchoredToPlayerOffset = -150f;
  private float boxAnchoredToBottomOffset = 150f;

  private void Start()
  {
    this.gameContext = Contexts.sharedInstance.game;
    if (Contexts.sharedInstance.meta.metaMatch.gameType != GameType.BasicTraining)
    {
      UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
    }
    else
    {
      this.StartCoroutine(this.TutorialCR());
      Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);
      Events.Global.OnEventPickupConsumed += new Events.EventPickupConsumed(this.OnPickupConsumed);
    }
  }

  private void OnPickupConsumed(UniqueId id, UniqueId playeruniqueid) => this.pickupConsumed = true;

  private void OnDestroy()
  {
    if ((UnityEngine.Object) this.tutorialText != (UnityEngine.Object) null)
      UnityEngine.Object.Destroy((UnityEngine.Object) this.tutorialText.gameObject);
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);
    Events.Global.OnEventPickupConsumed -= new Events.EventPickupConsumed(this.OnPickupConsumed);
  }

  private void OnMatchStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchstate,
    float cutsceneduration,
    float remainingmatchtime)
  {
    Imi.SharedWithServer.Game.MatchState matchState = matchstate;
    if ((UnityEngine.Object) this.gameObject != (UnityEngine.Object) null && (UnityEngine.Object) this.tutorialText != (UnityEngine.Object) null)
    {
      if (matchState == Imi.SharedWithServer.Game.MatchState.Goal)
        this.tutorialText.Hide(false);
      else if (this.prevMatchState == Imi.SharedWithServer.Game.MatchState.Goal)
        this.tutorialText.ShowPreviousMessage();
    }
    this.prevMatchState = matchState;
  }

  private IEnumerator TutorialCR()
  {
    yield return (object) this.WaitForMatchStart();
    AnalyticsService analytics = ImiServices.Instance.Analytics;
    this.InitializeMembers();
    analytics.OnTutorialStep(0);
    this.SetupTutorialTextBox();
    this.TextInitializing();
    yield return (object) this.WaitForPointInProgress();
    this.TextSprinting();
    yield return (object) this.WaitForSprint();
    analytics.OnTutorialStep(1);
    this.TextPickupBall();
    yield return (object) this.WaitForPickupBall();
    analytics.OnTutorialStep(2);
    this.TextThrow();
    yield return (object) this.WaitForShootFirstGoal();
    analytics.OnTutorialStep(3);
    this.TextSpawnTeamMate();
    yield return (object) new WaitForSeconds(4.5f);
    this.tutorialText.Hide();
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new BeginBasicTrainingStepMessage((byte) 0));
    yield return (object) new WaitForSeconds(1f);
    analytics.OnTutorialStep(4);
    this.TextPassToTeamMate();
    yield return (object) this.WaitForPass();
    analytics.OnTutorialStep(5);
    this.TextSpawnOpponent();
    yield return (object) new WaitForSeconds(4.5f);
    this.tutorialText.Hide();
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new BeginBasicTrainingStepMessage((byte) 1));
    yield return (object) this.WaitForOpponentTackle();
    yield return (object) new WaitForSeconds(1.5f);
    analytics.OnTutorialStep(6);
    if (this.OpponentHasBall())
    {
      this.TextTackle();
      yield return (object) this.WaitForTackle();
    }
    analytics.OnTutorialStep(7);
    this.TextDodge();
    yield return (object) this.WaitForDodge();
    analytics.OnTutorialStep(8);
    this.TextSkillIntro();
    yield return (object) this.WaitForThrowBall();
    analytics.OnTutorialStep(9);
    SkillGraph skillGraph1 = (SkillGraph) null;
    foreach (SkillGraph skillGraph2 in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph2.GetConfig() is BarrierConfig)
        skillGraph1 = skillGraph2;
    }
    if (skillGraph1.GetVar<bool>("IsOnCooldown").Get())
    {
      this.pickupStepShown = true;
      this.TextPickup();
      this.pickupConsumed = false;
      yield return (object) this.WaitForPickup();
      analytics.OnTutorialStep(12);
    }
    this.TextBarrier();
    yield return (object) this.WaitForBarrier();
    this.tutorialText.Hide();
    analytics.OnTutorialStep(10);
    yield return (object) new WaitForSeconds(0.5f);
    this.TextGreatJob();
    yield return (object) new WaitForSeconds(3f);
    SkillGraph skillGraph3 = (SkillGraph) null;
    foreach (SkillGraph skillGraph4 in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph4.GetConfig() is TurretConfig)
        skillGraph3 = skillGraph4;
    }
    if (!skillGraph3.GetVar<bool>("CooldownOver").Get())
    {
      this.pickupStepShown = true;
      this.TextPickup();
      this.pickupConsumed = false;
      yield return (object) this.WaitForPickup();
      analytics.OnTutorialStep(12);
    }
    this.TextTurret();
    yield return (object) this.WaitForTurret();
    analytics.OnTutorialStep(11);
    this.tutorialText.Hide();
    yield return (object) new WaitForSeconds(3f);
    if (!this.pickupStepShown)
    {
      this.pickupStepShown = true;
      this.TextPickup();
      this.pickupConsumed = false;
      yield return (object) this.WaitForPickup();
      analytics.OnTutorialStep(12);
    }
    this.TextEnd();
    Events.Global.FireEventDisableLeaveButton();
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new BeginBasicTrainingStepMessage((byte) 2));
    yield return (object) this.WaitForGoal();
    analytics.OnTutorialCompleted();
    UnityEngine.Object.Destroy((UnityEngine.Object) this.tutorialText.gameObject);
  }

  private void TextInitializing()
  {
    this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
    this.tutorialText.Show("@TutorialV2WelcomeHeadline", "@TutorialV2WelcomeMessage", illustration: this.imgLogo);
  }

  private void TextSprinting()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2SprintHeadline", "@TutorialV2SprintMessage", DigitalInput.Sprint, this.imgSprint);
  }

  private void TextSprintingWithBall()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2SprintHeadline", "@TutorialV2CantSprintWhileHoldingBallMessage", DigitalInput.ThrowBall, msgType: TutorialTextBox.MessageType.Error);
  }

  private void TextPickupBall()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2PickupBallHeadline", "@TutorialV2PickupBallMessage", illustration: this.imgBall);
  }

  private void TextThrow()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2ShootGoalHeadline", "@TutorialV2ShootGoalMessage", DigitalInput.ThrowBall, this.imgEnemyGoal);
  }

  private void TextWrongGoal()
  {
    this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
    this.tutorialText.Show("@TutorialV2WrongGoalHeadline", "@TutorialV2WrongGoalMessage", illustration: this.imgEnemyGoal, msgType: TutorialTextBox.MessageType.Error);
  }

  private void TextSpawnTeamMate()
  {
    this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
    this.tutorialText.Show("@TutorialV2SpawningTeamMateHeadline", "@TutorialV2SpawningTeamMateMessage", illustration: this.imgTeamMate);
  }

  private void TextPassToTeamMate()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2PassingHeadline", "@TutorialV2PassingMessage", DigitalInput.ThrowBall, this.imgPass);
  }

  private void TextSpawnOpponent()
  {
    this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
    this.tutorialText.Show("@TutorialV2SpawningOpponentHeadline", "@TutorialV2SpawningOpponentMessage", illustration: this.imgOpponent);
  }

  private void TextTackle()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2TacklingHeadline", "@TutorialV2TacklingMessage", DigitalInput.Tackle, this.imgTackle);
  }

  private void TextDodge()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2DodgingHeadline", "@TutorialV2DodgingMessage", DigitalInput.Tackle, this.imgDodge);
  }

  private void TextDodgeWithoutBall()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2DodgingHeadline", "@TutorialV2DodgeWithoutBallMessage", illustration: this.imgBall, msgType: TutorialTextBox.MessageType.Error);
  }

  private void TextSkillIntro()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2SkillsHeadline", "@TutorialV2SkillsMessage", DigitalInput.ThrowBall);
  }

  private void TextBarrier()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2BarrierHeadline", "@TutorialV2BarrierMessage", DigitalInput.PrimarySkill, this.imgWall);
  }

  private void TextGreatJob()
  {
    this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
    this.tutorialText.Show("@TutorialV2BarrierCompleteHeadline", "");
  }

  private void TextTurret()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2TurretHeadline", "@TutorialV2TurretMessage", DigitalInput.SecondarySkill, this.imgTurret1);
  }

  private void TextPickup()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2PickupsHeadline", "@TutorialV2PickupsMessage", illustration: this.imgPickup);
  }

  private void TextEnd()
  {
    this.tutorialText.onShow = (Action) (() =>
    {
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToPlayer, Vector3.up * this.boxAnchoredToPlayerOffset, false);
      this.tutorialTextBoxPositioner.SetMode(TutorialTextBoxPositioner.Mode.AnchoredToBottom, Vector3.up * this.boxAnchoredToBottomOffset, delay: 4f);
      this.tutorialText.onShow = (Action) null;
    });
    this.tutorialText.Show("@TutorialV2EndHeadline", "@TutorialV2EndMessage", illustration: this.imgEnemyGoal);
  }

  private IEnumerator WaitForMatchStart()
  {
    while (!this.gameContext.hasMatchState || this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.GetReady)
      yield return (object) null;
  }

  private void InitializeMembers()
  {
    this.player = this.gameContext.GetFirstLocalEntity();
    this.Log(string.Format("Player found! id {0}", (object) this.player.playerId.value));
    this.gameContext.GetGroup(GameMatcher.Player);
    this.ball = this.gameContext.ballEntity;
  }

  private IEnumerator WaitForSprint()
  {
    SkillGraph sprintGraph = (SkillGraph) null;
    foreach (SkillGraph skillGraph in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph.GetConfig() is SprintConfig)
      {
        sprintGraph = skillGraph;
        SprintConfig config = (SprintConfig) skillGraph.GetConfig();
        this.Log("found sprint graph");
      }
    }
    float sprintDuration = 0.0f;
    while ((double) sprintDuration < 2.0 && (double) sprintGraph.GetVar<float>("Stamina").Get() != 0.0)
    {
      if (this.PlayerHasBall())
      {
        this.TextSprintingWithBall();
        while (this.PlayerHasBall())
          yield return (object) null;
        this.TextSprinting();
      }
      else if (sprintGraph.GetVar<bool>("IsActive").Get())
        sprintDuration += Time.deltaTime;
      yield return (object) null;
    }
  }

  private IEnumerator WaitForPickupBall()
  {
    while (!this.PlayerHasBall())
      yield return (object) null;
  }

  private IEnumerator WaitForShootFirstGoal()
  {
    while (true)
    {
      do
      {
        while (!this.gameContext.hasMatchState || this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.Goal)
          yield return (object) null;
        while (this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.StartPoint)
          yield return (object) null;
        if (this.gameContext.scoreEntity.score.lastTeamThatScored == Team.Beta)
        {
          this.TextWrongGoal();
          yield return (object) new WaitForSeconds(7f);
        }
        else
          goto label_3;
      }
      while (this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress);
      this.TextThrow();
    }
label_3:;
  }

  private IEnumerator WaitForPass()
  {
    while (!this.TeamMateHasBall())
      yield return (object) null;
  }

  private IEnumerator WaitForOpponentTackle()
  {
    while (!this.OpponentHasBall())
      yield return (object) null;
  }

  private IEnumerator WaitForTackle()
  {
    while (!this.PlayerHasBall())
      yield return (object) null;
  }

  private IEnumerator WaitForDodge()
  {
    SkillGraph dodgeGraph = (SkillGraph) null;
    foreach (SkillGraph skillGraph in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph.GetConfig() is TackleDodgeConfig)
      {
        dodgeGraph = skillGraph;
        this.Log("found dodge graph");
      }
    }
    while (dodgeGraph.GetVar<bool>("NotDodging").Get())
    {
      if (!this.PlayerHasBall())
      {
        this.TextDodgeWithoutBall();
        while (!this.PlayerHasBall())
          yield return (object) null;
        this.TextDodge();
      }
      yield return (object) null;
    }
  }

  private IEnumerator WaitForThrowBall()
  {
    while (this.PlayerHasBall())
      yield return (object) null;
  }

  private IEnumerator WaitForBarrier()
  {
    SkillGraph skillGraph1 = (SkillGraph) null;
    foreach (SkillGraph skillGraph2 in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph2.GetConfig() is BarrierConfig)
        skillGraph1 = skillGraph2;
    }
    SkillVar<bool> activeVar = skillGraph1.GetVar<bool>("IsBarrierActive");
    while (!activeVar.Get())
    {
      if (this.PlayerHasBall())
      {
        this.TextSkillIntro();
        yield return (object) this.WaitForThrowBall();
        this.TextBarrier();
      }
      yield return (object) null;
    }
  }

  private IEnumerator WaitForTurret()
  {
    SkillGraph skillGraph1 = (SkillGraph) null;
    foreach (SkillGraph skillGraph2 in this.player.skillGraph.skillGraphs)
    {
      if (skillGraph2.GetConfig() is TurretConfig)
        skillGraph1 = skillGraph2;
    }
    SkillVar<bool> activeVar = skillGraph1.GetVar<bool>("IsFiring");
    while (!activeVar.Get())
    {
      if (this.PlayerHasBall())
      {
        this.TextSkillIntro();
        yield return (object) this.WaitForThrowBall();
        this.TextTurret();
      }
      yield return (object) null;
    }
  }

  private IEnumerator WaitForPickup()
  {
    while (!this.pickupConsumed)
      yield return (object) null;
  }

  private IEnumerator WaitForGoal()
  {
    while (!this.gameContext.hasMatchState || this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.Goal)
      yield return (object) null;
  }

  private IEnumerator WaitForMatchOver()
  {
    while (!this.gameContext.hasMatchState || this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.MatchOver)
      yield return (object) null;
  }

  private IEnumerator WaitForPointInProgress()
  {
    while (!this.gameContext.hasMatchState || this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)
      yield return (object) null;
  }

  private bool PlayerHasBall() => this.ball.hasBallOwner && this.ball.ballOwner.IsOwner(this.player);

  private bool OpponentHasBall() => this.ball.hasBallOwner && this.gameContext.GetFirstEntityWithPlayerId(this.ball.ballOwner.playerId).playerTeam.value == Team.Beta;

  private bool TeamMateHasBall() => this.ball.hasBallOwner && this.gameContext.GetFirstEntityWithPlayerId(this.ball.ballOwner.playerId).playerTeam.value == Team.Alpha && !this.ball.ballOwner.IsOwner(this.player);

  private void SetupTutorialTextBox()
  {
    GameObject gameObject1 = UnityEngine.Object.Instantiate<GameObject>(this.tutorialTextBoxPrefab);
    MatchUi matchUi = SingletonManager<MatchViewController>.Instance.MatchUI;
    gameObject1.transform.parent = matchUi.Canvas;
    gameObject1.transform.localPosition = Vector3.zero;
    gameObject1.transform.localEulerAngles = Vector3.zero;
    gameObject1.transform.localScale = Vector3.one;
    this.tutorialText = gameObject1.GetComponent<TutorialTextBox>();
    this.tutorialTextBoxPositioner = gameObject1.GetComponent<TutorialTextBoxPositioner>();
    GameObject gameObject2 = UnityEngine.Object.Instantiate<GameObject>(this.tutorialPreloaderPrefab);
    gameObject2.transform.parent = matchUi.Canvas;
    gameObject2.transform.localPosition = Vector3.zero;
    gameObject2.transform.localEulerAngles = Vector3.zero;
    gameObject2.transform.localScale = Vector3.one * 0.01f;
  }

  private void Log(string msg) => Imi.Diagnostics.Log.Debug("######## Tutorial: " + msg);
}
