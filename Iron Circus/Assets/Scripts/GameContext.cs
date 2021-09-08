// Decompiled with JetBrains decompiler
// Type: GameContext
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.ScEntitas.Components;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.Utils.Smoothing;
using Jitter;
using Jitter.LinearMath;
using SharedWithServer.ScEvents;
using SteelCircus.ScEntitas.Components;
using System;
using System.Collections.Generic;

public sealed class GameContext : Context<GameEntity>
{
  public GameEntity ballEntity => this.GetGroup(GameMatcher.Ball).GetSingleEntity();

  public bool isBall
  {
    get => this.ballEntity != null;
    set
    {
      GameEntity ballEntity = this.ballEntity;
      if (value == (ballEntity != null))
        return;
      if (value)
        this.CreateEntity().isBall = true;
      else
        ballEntity.Destroy();
    }
  }

  public GameEntity basicTrainingCompleteEntity => this.GetGroup(GameMatcher.BasicTrainingComplete).GetSingleEntity();

  public bool isBasicTrainingComplete
  {
    get => this.basicTrainingCompleteEntity != null;
    set
    {
      GameEntity trainingCompleteEntity = this.basicTrainingCompleteEntity;
      if (value == (trainingCompleteEntity != null))
        return;
      if (value)
        this.CreateEntity().isBasicTrainingComplete = true;
      else
        trainingCompleteEntity.Destroy();
    }
  }

  public GameEntity cameraTargetEntity => this.GetGroup(GameMatcher.CameraTarget).GetSingleEntity();

  public CameraTargetComponent cameraTarget => this.cameraTargetEntity.cameraTarget;

  public bool hasCameraTarget => this.cameraTargetEntity != null;

  public GameEntity SetCameraTarget(JVector newPosition, bool newOverrideInProgress)
  {
    if (this.hasCameraTarget)
      throw new EntitasException("Could not set CameraTarget!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.CameraTargetComponent!", "You should check if the context already has a cameraTargetEntity before setting it or use context.ReplaceCameraTarget().");
    GameEntity entity = this.CreateEntity();
    entity.AddCameraTarget(newPosition, newOverrideInProgress);
    return entity;
  }

  public void ReplaceCameraTarget(JVector newPosition, bool newOverrideInProgress)
  {
    GameEntity cameraTargetEntity = this.cameraTargetEntity;
    if (cameraTargetEntity == null)
      this.SetCameraTarget(newPosition, newOverrideInProgress);
    else
      cameraTargetEntity.ReplaceCameraTarget(newPosition, newOverrideInProgress);
  }

  public void RemoveCameraTarget() => this.cameraTargetEntity.Destroy();

  public GameEntity collisionEventsEntity => this.GetGroup(GameMatcher.CollisionEvents).GetSingleEntity();

  public CollisionEventsComponent collisionEvents => this.collisionEventsEntity.collisionEvents;

  public bool hasCollisionEvents => this.collisionEventsEntity != null;

  public GameEntity SetCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    if (this.hasCollisionEvents)
      throw new EntitasException("Could not set CollisionEvents!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.CollisionEventsComponent!", "You should check if the context already has a collisionEventsEntity before setting it or use context.ReplaceCollisionEvents().");
    GameEntity entity = this.CreateEntity();
    entity.AddCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
    return entity;
  }

  public void ReplaceCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    GameEntity collisionEventsEntity = this.collisionEventsEntity;
    if (collisionEventsEntity == null)
      this.SetCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
    else
      collisionEventsEntity.ReplaceCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
  }

  public void RemoveCollisionEvents() => this.collisionEventsEntity.Destroy();

  public GameEntity deferredCollisionEventsEntity => this.GetGroup(GameMatcher.DeferredCollisionEvents).GetSingleEntity();

  public DeferredCollisionEventsComponent deferredCollisionEvents => this.deferredCollisionEventsEntity.deferredCollisionEvents;

  public bool hasDeferredCollisionEvents => this.deferredCollisionEventsEntity != null;

  public GameEntity SetDeferredCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    if (this.hasDeferredCollisionEvents)
      throw new EntitasException("Could not set DeferredCollisionEvents!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.DeferredCollisionEventsComponent!", "You should check if the context already has a deferredCollisionEventsEntity before setting it or use context.ReplaceDeferredCollisionEvents().");
    GameEntity entity = this.CreateEntity();
    entity.AddDeferredCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
    return entity;
  }

  public void ReplaceDeferredCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    GameEntity collisionEventsEntity = this.deferredCollisionEventsEntity;
    if (collisionEventsEntity == null)
      this.SetDeferredCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
    else
      collisionEventsEntity.ReplaceDeferredCollisionEvents(newCollisions, newTriggerEnter, newTriggerStay);
  }

  public void RemoveDeferredCollisionEvents() => this.deferredCollisionEventsEntity.Destroy();

  public GameEntity eventDispatcherEntity => this.GetGroup(GameMatcher.EventDispatcher).GetSingleEntity();

  public EventDispatcherComponent eventDispatcher => this.eventDispatcherEntity.eventDispatcher;

  public bool hasEventDispatcher => this.eventDispatcherEntity != null;

  public GameEntity SetEventDispatcher(AEventDispatcher newValue)
  {
    if (this.hasEventDispatcher)
      throw new EntitasException("Could not set EventDispatcher!\n" + (object) this + " already has an entity with Imi.ScEntitas.Components.EventDispatcherComponent!", "You should check if the context already has a eventDispatcherEntity before setting it or use context.ReplaceEventDispatcher().");
    GameEntity entity = this.CreateEntity();
    entity.AddEventDispatcher(newValue);
    return entity;
  }

  public void ReplaceEventDispatcher(AEventDispatcher newValue)
  {
    GameEntity dispatcherEntity = this.eventDispatcherEntity;
    if (dispatcherEntity == null)
      this.SetEventDispatcher(newValue);
    else
      dispatcherEntity.ReplaceEventDispatcher(newValue);
  }

  public void RemoveEventDispatcher() => this.eventDispatcherEntity.Destroy();

  public GameEntity gamePhysicsEntity => this.GetGroup(GameMatcher.GamePhysics).GetSingleEntity();

  public GamePhysicsComponent gamePhysics => this.gamePhysicsEntity.gamePhysics;

  public bool hasGamePhysics => this.gamePhysicsEntity != null;

  public GameEntity SetGamePhysics(
    World newWorld,
    Action<int, int, GameEntity, Action> newCheckPastPhysicsState)
  {
    if (this.hasGamePhysics)
      throw new EntitasException("Could not set GamePhysics!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.GamePhysicsComponent!", "You should check if the context already has a gamePhysicsEntity before setting it or use context.ReplaceGamePhysics().");
    GameEntity entity = this.CreateEntity();
    entity.AddGamePhysics(newWorld, newCheckPastPhysicsState);
    return entity;
  }

  public void ReplaceGamePhysics(
    World newWorld,
    Action<int, int, GameEntity, Action> newCheckPastPhysicsState)
  {
    GameEntity gamePhysicsEntity = this.gamePhysicsEntity;
    if (gamePhysicsEntity == null)
      this.SetGamePhysics(newWorld, newCheckPastPhysicsState);
    else
      gamePhysicsEntity.ReplaceGamePhysics(newWorld, newCheckPastPhysicsState);
  }

  public void RemoveGamePhysics() => this.gamePhysicsEntity.Destroy();

  public GameEntity globalTimeEntity => this.GetGroup(GameMatcher.GlobalTime).GetSingleEntity();

  public GlobalTimeComponent globalTime => this.globalTimeEntity.globalTime;

  public bool hasGlobalTime => this.globalTimeEntity != null;

  public GameEntity SetGlobalTime(
    float newFixedSimTimeStep,
    float newTimeSinceMatchStart,
    int newCurrentTick,
    int newLastServerTick,
    float newTimeSinceStartOfTick,
    bool newIsReprediction)
  {
    if (this.hasGlobalTime)
      throw new EntitasException("Could not set GlobalTime!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.GlobalTimeComponent!", "You should check if the context already has a globalTimeEntity before setting it or use context.ReplaceGlobalTime().");
    GameEntity entity = this.CreateEntity();
    entity.AddGlobalTime(newFixedSimTimeStep, newTimeSinceMatchStart, newCurrentTick, newLastServerTick, newTimeSinceStartOfTick, newIsReprediction);
    return entity;
  }

  public void ReplaceGlobalTime(
    float newFixedSimTimeStep,
    float newTimeSinceMatchStart,
    int newCurrentTick,
    int newLastServerTick,
    float newTimeSinceStartOfTick,
    bool newIsReprediction)
  {
    GameEntity globalTimeEntity = this.globalTimeEntity;
    if (globalTimeEntity == null)
      this.SetGlobalTime(newFixedSimTimeStep, newTimeSinceMatchStart, newCurrentTick, newLastServerTick, newTimeSinceStartOfTick, newIsReprediction);
    else
      globalTimeEntity.ReplaceGlobalTime(newFixedSimTimeStep, newTimeSinceMatchStart, newCurrentTick, newLastServerTick, newTimeSinceStartOfTick, newIsReprediction);
  }

  public void RemoveGlobalTime() => this.globalTimeEntity.Destroy();

  public GameEntity lastBallContactEntity => this.GetGroup(GameMatcher.LastBallContact).GetSingleEntity();

  public LastBallContactComponent lastBallContact => this.lastBallContactEntity.lastBallContact;

  public bool hasLastBallContact => this.lastBallContactEntity != null;

  public GameEntity SetLastBallContact(ulong newPlayerId)
  {
    if (this.hasLastBallContact)
      throw new EntitasException("Could not set LastBallContact!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.LastBallContactComponent!", "You should check if the context already has a lastBallContactEntity before setting it or use context.ReplaceLastBallContact().");
    GameEntity entity = this.CreateEntity();
    entity.AddLastBallContact(newPlayerId);
    return entity;
  }

  public void ReplaceLastBallContact(ulong newPlayerId)
  {
    GameEntity ballContactEntity = this.lastBallContactEntity;
    if (ballContactEntity == null)
      this.SetLastBallContact(newPlayerId);
    else
      ballContactEntity.ReplaceLastBallContact(newPlayerId);
  }

  public void RemoveLastBallContact() => this.lastBallContactEntity.Destroy();

  public GameEntity lastGoalScoredEntity => this.GetGroup(GameMatcher.LastGoalScored).GetSingleEntity();

  public LastGoalScoredComponent lastGoalScored => this.lastGoalScoredEntity.lastGoalScored;

  public bool hasLastGoalScored => this.lastGoalScoredEntity != null;

  public GameEntity SetLastGoalScored(ulong newPlayerId, Team newTeam)
  {
    if (this.hasLastGoalScored)
      throw new EntitasException("Could not set LastGoalScored!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.LastGoalScoredComponent!", "You should check if the context already has a lastGoalScoredEntity before setting it or use context.ReplaceLastGoalScored().");
    GameEntity entity = this.CreateEntity();
    entity.AddLastGoalScored(newPlayerId, newTeam);
    return entity;
  }

  public void ReplaceLastGoalScored(ulong newPlayerId, Team newTeam)
  {
    GameEntity goalScoredEntity = this.lastGoalScoredEntity;
    if (goalScoredEntity == null)
      this.SetLastGoalScored(newPlayerId, newTeam);
    else
      goalScoredEntity.ReplaceLastGoalScored(newPlayerId, newTeam);
  }

  public void RemoveLastGoalScored() => this.lastGoalScoredEntity.Destroy();

  public GameEntity loadArenaInfoEntity => this.GetGroup(GameMatcher.LoadArenaInfo).GetSingleEntity();

  public LoadArenaInfoComponent loadArenaInfo => this.loadArenaInfoEntity.loadArenaInfo;

  public bool hasLoadArenaInfo => this.loadArenaInfoEntity != null;

  public GameEntity SetLoadArenaInfo(string newArenaName, string newArenaPath)
  {
    if (this.hasLoadArenaInfo)
      throw new EntitasException("Could not set LoadArenaInfo!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.LoadArenaInfoComponent!", "You should check if the context already has a loadArenaInfoEntity before setting it or use context.ReplaceLoadArenaInfo().");
    GameEntity entity = this.CreateEntity();
    entity.AddLoadArenaInfo(newArenaName, newArenaPath);
    return entity;
  }

  public void ReplaceLoadArenaInfo(string newArenaName, string newArenaPath)
  {
    GameEntity loadArenaInfoEntity = this.loadArenaInfoEntity;
    if (loadArenaInfoEntity == null)
      this.SetLoadArenaInfo(newArenaName, newArenaPath);
    else
      loadArenaInfoEntity.ReplaceLoadArenaInfo(newArenaName, newArenaPath);
  }

  public void RemoveLoadArenaInfo() => this.loadArenaInfoEntity.Destroy();

  public GameEntity matchConfigEntity => this.GetGroup(GameMatcher.MatchConfig).GetSingleEntity();

  public MatchConfigComponent matchConfig => this.matchConfigEntity.matchConfig;

  public bool hasMatchConfig => this.matchConfigEntity != null;

  public GameEntity SetMatchConfig(MatchConfig newMatchConfig)
  {
    if (this.hasMatchConfig)
      throw new EntitasException("Could not set MatchConfig!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.MatchConfigComponent!", "You should check if the context already has a matchConfigEntity before setting it or use context.ReplaceMatchConfig().");
    GameEntity entity = this.CreateEntity();
    entity.AddMatchConfig(newMatchConfig);
    return entity;
  }

  public void ReplaceMatchConfig(MatchConfig newMatchConfig)
  {
    GameEntity matchConfigEntity = this.matchConfigEntity;
    if (matchConfigEntity == null)
      this.SetMatchConfig(newMatchConfig);
    else
      matchConfigEntity.ReplaceMatchConfig(newMatchConfig);
  }

  public void RemoveMatchConfig() => this.matchConfigEntity.Destroy();

  public GameEntity matchDataEntity => this.GetGroup(GameMatcher.MatchData).GetSingleEntity();

  public MatchDataComponent matchData => this.matchDataEntity.matchData;

  public bool hasMatchData => this.matchDataEntity != null;

  public GameEntity SetMatchData(MatchType newMatchType, int newNumPlayers)
  {
    if (this.hasMatchData)
      throw new EntitasException("Could not set MatchData!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.MatchDataComponent!", "You should check if the context already has a matchDataEntity before setting it or use context.ReplaceMatchData().");
    GameEntity entity = this.CreateEntity();
    entity.AddMatchData(newMatchType, newNumPlayers);
    return entity;
  }

  public void ReplaceMatchData(MatchType newMatchType, int newNumPlayers)
  {
    GameEntity matchDataEntity = this.matchDataEntity;
    if (matchDataEntity == null)
      this.SetMatchData(newMatchType, newNumPlayers);
    else
      matchDataEntity.ReplaceMatchData(newMatchType, newNumPlayers);
  }

  public void RemoveMatchData() => this.matchDataEntity.Destroy();

  public GameEntity matchStateEntity => this.GetGroup(GameMatcher.MatchState).GetSingleEntity();

  public MatchStateComponent matchState => this.matchStateEntity.matchState;

  public bool hasMatchState => this.matchStateEntity != null;

  public GameEntity SetMatchState(Imi.SharedWithServer.Game.MatchState newValue)
  {
    if (this.hasMatchState)
      throw new EntitasException("Could not set MatchState!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.MatchStateComponent!", "You should check if the context already has a matchStateEntity before setting it or use context.ReplaceMatchState().");
    GameEntity entity = this.CreateEntity();
    entity.AddMatchState(newValue);
    return entity;
  }

  public void ReplaceMatchState(Imi.SharedWithServer.Game.MatchState newValue)
  {
    GameEntity matchStateEntity = this.matchStateEntity;
    if (matchStateEntity == null)
      this.SetMatchState(newValue);
    else
      matchStateEntity.ReplaceMatchState(newValue);
  }

  public void RemoveMatchState() => this.matchStateEntity.Destroy();

  public GameEntity matchStateTransitionEventEntity => this.GetGroup(GameMatcher.MatchStateTransitionEvent).GetSingleEntity();

  public MatchStateTransitionEventComponent matchStateTransitionEvent => this.matchStateTransitionEventEntity.matchStateTransitionEvent;

  public bool hasMatchStateTransitionEvent => this.matchStateTransitionEventEntity != null;

  public GameEntity SetMatchStateTransitionEvent(TransitionEvent newValue)
  {
    if (this.hasMatchStateTransitionEvent)
      throw new EntitasException("Could not set MatchStateTransitionEvent!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.MatchStateTransitionEventComponent!", "You should check if the context already has a matchStateTransitionEventEntity before setting it or use context.ReplaceMatchStateTransitionEvent().");
    GameEntity entity = this.CreateEntity();
    entity.AddMatchStateTransitionEvent(newValue);
    return entity;
  }

  public void ReplaceMatchStateTransitionEvent(TransitionEvent newValue)
  {
    GameEntity transitionEventEntity = this.matchStateTransitionEventEntity;
    if (transitionEventEntity == null)
      this.SetMatchStateTransitionEvent(newValue);
    else
      transitionEventEntity.ReplaceMatchStateTransitionEvent(newValue);
  }

  public void RemoveMatchStateTransitionEvent() => this.matchStateTransitionEventEntity.Destroy();

  public GameEntity remainingMatchTimeEntity => this.GetGroup(GameMatcher.RemainingMatchTime).GetSingleEntity();

  public bool isRemainingMatchTime
  {
    get => this.remainingMatchTimeEntity != null;
    set
    {
      GameEntity remainingMatchTimeEntity = this.remainingMatchTimeEntity;
      if (value == (remainingMatchTimeEntity != null))
        return;
      if (value)
        this.CreateEntity().isRemainingMatchTime = true;
      else
        remainingMatchTimeEntity.Destroy();
    }
  }

  public GameEntity remoteEntityLerpStateEntity => this.GetGroup(GameMatcher.RemoteEntityLerpState).GetSingleEntity();

  public RemoteEntityLerpStateComponent remoteEntityLerpState => this.remoteEntityLerpStateEntity.remoteEntityLerpState;

  public bool hasRemoteEntityLerpState => this.remoteEntityLerpStateEntity != null;

  public GameEntity SetRemoteEntityLerpState(
    List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> newHistoryBuffer,
    List<RemoteEntityLerpSystem.RemoteStateLerpPair> newActiveLerpPairs,
    float newCurrentLerpTimestamp,
    FilteredFloat newSmoothedRTT)
  {
    if (this.hasRemoteEntityLerpState)
      throw new EntitasException("Could not set RemoteEntityLerpState!\n" + (object) this + " already has an entity with SteelCircus.ScEntitas.Components.RemoteEntityLerpStateComponent!", "You should check if the context already has a remoteEntityLerpStateEntity before setting it or use context.ReplaceRemoteEntityLerpState().");
    GameEntity entity = this.CreateEntity();
    entity.AddRemoteEntityLerpState(newHistoryBuffer, newActiveLerpPairs, newCurrentLerpTimestamp, newSmoothedRTT);
    return entity;
  }

  public void ReplaceRemoteEntityLerpState(
    List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> newHistoryBuffer,
    List<RemoteEntityLerpSystem.RemoteStateLerpPair> newActiveLerpPairs,
    float newCurrentLerpTimestamp,
    FilteredFloat newSmoothedRTT)
  {
    GameEntity entityLerpStateEntity = this.remoteEntityLerpStateEntity;
    if (entityLerpStateEntity == null)
      this.SetRemoteEntityLerpState(newHistoryBuffer, newActiveLerpPairs, newCurrentLerpTimestamp, newSmoothedRTT);
    else
      entityLerpStateEntity.ReplaceRemoteEntityLerpState(newHistoryBuffer, newActiveLerpPairs, newCurrentLerpTimestamp, newSmoothedRTT);
  }

  public void RemoveRemoteEntityLerpState() => this.remoteEntityLerpStateEntity.Destroy();

  public GameEntity scoreEntity => this.GetGroup(GameMatcher.Score).GetSingleEntity();

  public ScoreComponent score => this.scoreEntity.score;

  public bool hasScore => this.scoreEntity != null;

  public GameEntity SetScore(
    Team newLastTeamThatScored,
    ulong newPlayerScored,
    Dictionary<Team, int> newScore)
  {
    if (this.hasScore)
      throw new EntitasException("Could not set Score!\n" + (object) this + " already has an entity with Imi.SharedWithServer.ScEntitas.Components.ScoreComponent!", "You should check if the context already has a scoreEntity before setting it or use context.ReplaceScore().");
    GameEntity entity = this.CreateEntity();
    entity.AddScore(newLastTeamThatScored, newPlayerScored, newScore);
    return entity;
  }

  public void ReplaceScore(
    Team newLastTeamThatScored,
    ulong newPlayerScored,
    Dictionary<Team, int> newScore)
  {
    GameEntity scoreEntity = this.scoreEntity;
    if (scoreEntity == null)
      this.SetScore(newLastTeamThatScored, newPlayerScored, newScore);
    else
      scoreEntity.ReplaceScore(newLastTeamThatScored, newPlayerScored, newScore);
  }

  public void RemoveScore() => this.scoreEntity.Destroy();

  public GameContext()
    : base(85, 0, new ContextInfo("Game", GameComponentsLookup.componentNames, GameComponentsLookup.componentTypes), (Func<IEntity, IAERC>) (entity => (IAERC) new SafeAERC(entity)))
  {
  }
}
