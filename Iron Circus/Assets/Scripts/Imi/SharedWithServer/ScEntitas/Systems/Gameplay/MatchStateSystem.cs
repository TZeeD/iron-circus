// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.MatchStateSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay.Pickup;
using Imi.SharedWithServer.ScEvents.StatEvents;
using SharedWithServer.ScEvents;
using Stateless;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class MatchStateSystem : ReactiveGameSystem
  {
    private readonly MatchConfig matchConfig;
    private readonly Events events;
    private readonly bool skipCutscenes;
    private readonly float endedCutsceneLength;
    private readonly float goalCutsceneLength;
    private readonly float introCutSceneLength;
    private readonly float firstStartPointCutsceneLength;
    private readonly float startPointCutsceneLength;
    private readonly float victoryScreenLength;
    private readonly float victoryPosesLength;
    private readonly float statsScreenLength;
    private readonly float overtimeScreenLength;
    private readonly int matchDuration;
    private bool isOvertime;
    private readonly StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent> machine;
    private IGroup<GameEntity> someoneScoredComponents;
    private MetaContext metaContext;
    private GameEntity matchTimeEntity;
    private CountdownAction countDownAction;

    public MatchStateSystem(EntitasSetup entitasSetup, MetaContext metaContext)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.skipCutscenes = entitasSetup.ConfigProvider.debugConfig.skipCutscenes;
      this.someoneScoredComponents = this.gameContext.GetGroup(GameMatcher.SomeoneScored);
      this.matchConfig = entitasSetup.ConfigProvider.matchConfig;
      this.metaContext = metaContext;
      this.matchDuration = metaContext.metaMatch.gameType.IsPlayground() || metaContext.metaMatch.gameType.IsBasicTraining() ? this.matchConfig.playgroundDurationInSeconds : this.matchConfig.durationInSeconds;
      this.introCutSceneLength = !metaContext.metaMatch.gameType.IsBasicTraining() ? this.matchConfig.introCutsceneLengthInSeconds : this.matchConfig.basicTrainingIntroCutsceneLengthInSeconds;
      this.endedCutsceneLength = this.matchConfig.gameEndedCutsceneLengthInSeconds;
      this.goalCutsceneLength = this.matchConfig.goalCutsceneLengthInSeconds;
      this.firstStartPointCutsceneLength = this.matchConfig.getReadyCutsceneLengthInSeconds;
      this.startPointCutsceneLength = this.matchConfig.startPointCutsceneLengthInSeconds;
      this.victoryScreenLength = this.matchConfig.victoryScreenLength;
      this.victoryPosesLength = this.matchConfig.victoryPosesLength;
      this.statsScreenLength = this.matchConfig.statsScreenLength;
      this.overtimeScreenLength = this.matchConfig.overtimeCutsceneLength;
      this.machine = new StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>((Func<Imi.SharedWithServer.Game.MatchState>) (() => this.gameContext.matchState.value), new Action<Imi.SharedWithServer.Game.MatchState>(this.SetStateCallback));
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.WaitingForPlayers).Permit(TransitionEvent.AllPlayersReady, Imi.SharedWithServer.Game.MatchState.Intro);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.Intro).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterIntro())).Permit(TransitionEvent.IntroDone, Imi.SharedWithServer.Game.MatchState.GetReady);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.GetReady).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterGetReady())).Permit(TransitionEvent.GetReadyDone, Imi.SharedWithServer.Game.MatchState.PointInProgress);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.StartPoint).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterStartPoint())).Permit(TransitionEvent.StartPointDone, Imi.SharedWithServer.Game.MatchState.PointInProgress);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.PointInProgress).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterPointInProgress())).Permit(TransitionEvent.GoalShot, Imi.SharedWithServer.Game.MatchState.Goal).Permit(TransitionEvent.Overtime, Imi.SharedWithServer.Game.MatchState.Overtime).Permit(TransitionEvent.MatchTimeOut, Imi.SharedWithServer.Game.MatchState.MatchOver);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.Goal).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterGoalShot())).Permit(TransitionEvent.GoalDone, Imi.SharedWithServer.Game.MatchState.StartPoint).Permit(TransitionEvent.OvertimeDone, Imi.SharedWithServer.Game.MatchState.MatchOver).Permit(TransitionEvent.MatchBallScored, Imi.SharedWithServer.Game.MatchState.MatchOver).Permit(TransitionEvent.BasicTrainingDone, Imi.SharedWithServer.Game.MatchState.MatchOver);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.MatchOver).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterMatchOver())).Permit(TransitionEvent.MatchOverDone, Imi.SharedWithServer.Game.MatchState.VictoryScreen);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.Overtime).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterOvertime())).Permit(TransitionEvent.OvertimeDone, Imi.SharedWithServer.Game.MatchState.StartPoint);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.VictoryScreen).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterVictoryScreen())).Permit(TransitionEvent.VictoryScreenDone, Imi.SharedWithServer.Game.MatchState.VictoryPose);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.VictoryPose).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterVictoryPose())).Permit(TransitionEvent.VictoryPoseDone, Imi.SharedWithServer.Game.MatchState.StatsScreens);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.StatsScreens).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterStatsScreens())).Permit(TransitionEvent.StatsScreensDone, Imi.SharedWithServer.Game.MatchState.CloseGame);
      this.machine.Configure(Imi.SharedWithServer.Game.MatchState.CloseGame).OnEntry((Action<StateMachine<Imi.SharedWithServer.Game.MatchState, TransitionEvent>.Transition>) (t => this.EnterCloseGame()));
      this.events.FireEventMatchStateChanged(Imi.SharedWithServer.Game.MatchState.WaitingForPlayers, this.GetCutsceneDuration(Imi.SharedWithServer.Game.MatchState.WaitingForPlayers), (float) this.matchDuration);
    }

    protected override ICollector<GameEntity> GetTrigger(
      IContext<GameEntity> context)
    {
      return context.CreateCollector<GameEntity>(GameMatcher.MatchStateTransitionEvent.Added<GameEntity>());
    }

    protected override bool Filter(GameEntity entity) => entity.hasMatchStateTransitionEvent;

    protected override void Execute(List<GameEntity> entities)
    {
      foreach (GameEntity entity in entities)
      {
        if (entity.hasMatchStateTransitionEvent)
        {
          this.Transition(new TransitionEvent?(entity.matchStateTransitionEvent.value));
          this.gameContext.RemoveMatchStateTransitionEvent();
        }
      }
    }

    private void Transition(TransitionEvent? transitionEvent)
    {
      if (!transitionEvent.HasValue)
        return;
      Log.Debug(string.Format("MatchState TriggerEvent: {0}", (object) transitionEvent));
      this.machine.Fire(transitionEvent.Value);
    }

    private void SetStateCallback(Imi.SharedWithServer.Game.MatchState newState)
    {
      Log.Debug(string.Format("Setting GameState: {0}", (object) newState));
      this.gameContext.ReplaceMatchState(newState);
      this.events.FireEventMatchStateChanged(newState, this.GetCutsceneDuration(newState), !this.gameContext.isRemainingMatchTime || !this.gameContext.remainingMatchTimeEntity.hasCountdownAction ? 0.0f : this.gameContext.remainingMatchTimeEntity.countdownAction.value.RemainingT);
    }

    private void PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState state, TransitionEvent? transitionEvent = null)
    {
      float cutsceneDuration = this.GetCutsceneDuration(state);
      this.gameContext.CreateEntity().AddCountdownAction(CountdownAction.WithDuration(cutsceneDuration).WithFinishedAction((Action) (() => this.Transition(transitionEvent))).DestoyEntityWhenDone().Create());
    }

    private void EnterIntro()
    {
      this.InitRemainingTime();
      this.events.FireEventMatchStarted((float) this.matchDuration - this.introCutSceneLength);
      this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Intro, new TransitionEvent?(TransitionEvent.IntroDone));
    }

    private void InitRemainingTime()
    {
      this.gameContext.isRemainingMatchTime = true;
      this.gameContext.remainingMatchTimeEntity.ReplaceCountdownAction(CountdownAction.WithDuration((float) this.matchDuration).WithFinishedAction((Action) (() =>
      {
        if (this.GetMatchOutcomeForTeam(Team.Alpha).IsDraw() && !this.isOvertime && this.matchConfig.overtimeEnabled && this.metaContext.hasMetaMatch && !this.metaContext.metaMatch.wasMatchAborted && !this.metaContext.metaMatch.gameType.IsBasicTraining() && !this.metaContext.metaMatch.gameType.IsPlayground())
        {
          this.countDownAction.currentT = this.countDownAction.duration - this.matchConfig.overtimeDuration;
          this.gameContext.ReplaceMatchStateTransitionEvent(TransitionEvent.Overtime);
          this.isOvertime = true;
          this.metaContext.metaMatch.isOvertime = true;
        }
        else
        {
          this.gameContext.ReplaceMatchStateTransitionEvent(TransitionEvent.MatchTimeOut);
          this.gameContext.isRemainingMatchTime = false;
        }
      })).WithPauseCondition((Func<bool>) (() => this.gameContext.hasMatchState && this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress || this.someoneScoredComponents.count > 0)).Create());
      this.matchTimeEntity = this.gameContext.remainingMatchTimeEntity;
      this.countDownAction = this.gameContext.remainingMatchTimeEntity.countdownAction.value;
    }

    private bool HasTeamForfeited(Team team)
    {
      HashSet<GameEntity> entitiesWithPlayerTeam = this.gameContext.GetEntitiesWithPlayerTeam(team);
      bool flag1 = true;
      bool flag2 = true;
      foreach (GameEntity gameEntity in entitiesWithPlayerTeam)
      {
        if (!gameEntity.isFakePlayer)
        {
          flag2 = false;
          if (!gameEntity.hasPlayerForfeit || gameEntity.hasPlayerForfeit && !gameEntity.playerForfeit.hasForfeit)
            flag1 = false;
        }
      }
      return flag1 && !flag2;
    }

    public MatchOutcome GetMatchOutcomeForTeam(Team team)
    {
      if (this.HasTeamForfeited(Team.Alpha))
        return team == Team.Alpha ? MatchOutcome.Loose : MatchOutcome.Win;
      if (this.HasTeamForfeited(Team.Beta))
        return team == Team.Beta ? MatchOutcome.Loose : MatchOutcome.Win;
      Team winningTeam = TeamExtensions.GetWinningTeam(this.gameContext.score.score);
      if (winningTeam == Team.None)
        return MatchOutcome.Draw;
      return team != winningTeam ? MatchOutcome.Loose : MatchOutcome.Win;
    }

    private void EnterGetReady() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.GetReady, new TransitionEvent?(TransitionEvent.GetReadyDone));

    private void EnterStartPoint() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.StartPoint, new TransitionEvent?(TransitionEvent.StartPointDone));

    private void EnterPointInProgress() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.PointInProgress);

    private void EnterGoalShot()
    {
      int num = this.matchConfig.matchPoint;
      if (this.metaContext.metaMatch.gameType.IsPlayground())
        num = this.matchConfig.matchPointInPlayground;
      Dictionary<Team, int> score = this.gameContext.score.score;
      if (!this.metaContext.metaMatch.gameType.IsBasicTraining() && (score[Team.Alpha] >= num || score[Team.Beta] >= num))
        this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Goal, new TransitionEvent?(TransitionEvent.MatchBallScored));
      else if (this.isOvertime)
        this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Goal, new TransitionEvent?(TransitionEvent.OvertimeDone));
      else if (this.gameContext.isBasicTrainingComplete)
        this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Goal, new TransitionEvent?(TransitionEvent.BasicTrainingDone));
      else
        this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Goal, new TransitionEvent?(TransitionEvent.GoalDone));
    }

    private void EnterMatchOver() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.MatchOver, new TransitionEvent?(TransitionEvent.MatchOverDone));

    private void EnterOvertime()
    {
      PickupBehaviourSystem.ResetAllPickups(this.gameContext, this.events);
      this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.Overtime, new TransitionEvent?(TransitionEvent.OvertimeDone));
    }

    private void EnterVictoryScreen() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.VictoryScreen, new TransitionEvent?(TransitionEvent.VictoryScreenDone));

    private void EnterVictoryPose() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.VictoryPose, new TransitionEvent?(TransitionEvent.VictoryPoseDone));

    private void EnterStatsScreens() => this.PlayCutsceneIfNecessary(Imi.SharedWithServer.Game.MatchState.StatsScreens, new TransitionEvent?(TransitionEvent.StatsScreensDone));

    private void EnterCloseGame()
    {
    }

    private float GetCutsceneDuration(Imi.SharedWithServer.Game.MatchState matchState)
    {
      if (this.skipCutscenes)
        return 1f;
      switch (matchState)
      {
        case Imi.SharedWithServer.Game.MatchState.Intro:
          return this.introCutSceneLength;
        case Imi.SharedWithServer.Game.MatchState.GetReady:
          return this.firstStartPointCutsceneLength;
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          return this.startPointCutsceneLength;
        case Imi.SharedWithServer.Game.MatchState.Goal:
          return this.goalCutsceneLength;
        case Imi.SharedWithServer.Game.MatchState.Overtime:
          return this.overtimeScreenLength;
        case Imi.SharedWithServer.Game.MatchState.MatchOver:
          return this.endedCutsceneLength;
        case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
          return this.victoryScreenLength;
        case Imi.SharedWithServer.Game.MatchState.VictoryPose:
          return this.gameContext.hasScore && this.gameContext.scoreEntity.score.score[Team.Alpha] == this.gameContext.scoreEntity.score.score[Team.Beta] ? 0.5f : this.victoryPosesLength;
        case Imi.SharedWithServer.Game.MatchState.StatsScreens:
          return this.statsScreenLength;
        default:
          return 0.0f;
      }
    }
  }
}
