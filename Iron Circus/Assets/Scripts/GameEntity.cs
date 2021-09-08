// Decompiled with JetBrains decompiler
// Type: GameEntity
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.ScEntitas.Components;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.EntitasShared.Components.Bumper;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.reliable;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.Systems.Player;
using Imi.SharedWithServer.Utils;
using Imi.SteelCircus.ScEntitas.Components;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.Utils.Smoothing;
using Jitter;
using Jitter.Dynamics;
using Jitter.LinearMath;
using server.ScEntitas.Components;
using SharedWithServer.Game;
using SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.ScEntitas.Components;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;

public sealed class GameEntity : Entity
{
  private static readonly AlignViewToBottom alignViewToBottomComponent = new AlignViewToBottom();
  private static readonly BallComponent ballComponent = new BallComponent();
  private static readonly BallHitDisabledComponent ballHitDisabledComponent = new BallHitDisabledComponent();
  private static readonly BasicTrainingCompleteComponent basicTrainingCompleteComponent = new BasicTrainingCompleteComponent();
  private static readonly ConstrainedTo2DComponent constrainedTo2DComponent = new ConstrainedTo2DComponent();
  private static readonly Destroyed destroyedComponent = new Destroyed();
  private static readonly FakePlayerComponent fakePlayerComponent = new FakePlayerComponent();
  private static readonly ImiComponent imiComponent = new ImiComponent();
  private static readonly LocalEntityComponent localEntityComponent = new LocalEntityComponent();
  private static readonly PlayerComponent playerComponent = new PlayerComponent();
  private static readonly PlayerRespawningComponent playerRespawningComponent = new PlayerRespawningComponent();
  private static readonly RemainingMatchTimeComponent remainingMatchTimeComponent = new RemainingMatchTimeComponent();
  private static readonly ReplicateComponent replicateComponent = new ReplicateComponent();

  public void TransformReplacePosition(JVector newPosition)
  {
    TransformComponent transform = this.transform;
    int index = 71;
    TransformComponent component = this.CreateComponent<TransformComponent>(index);
    component.position = newPosition.QuantizeVectorMM();
    component.rotation = transform.rotation;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void TransformReplaceRotation(JQuaternion newRotation)
  {
    TransformComponent transform = this.transform;
    int index = 71;
    TransformComponent component = this.CreateComponent<TransformComponent>(index);
    component.position = transform.position;
    component.rotation = newRotation;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void TransformSetLookDir(JVector lookDir) => this.TransformReplaceRotation(JQuaternion.LookRotation(lookDir, JVector.Up));

  public void TransformRotateTowards(JVector lookDir, float maxAngle = 360f)
  {
    if (lookDir.IsNearlyZero())
      Imi.Diagnostics.Log.Warning("Trying to rotate transform with a look vector of zero length.");
    else
      this.TransformReplaceRotation(this.transform.Forward.LookRotation(lookDir, maxAngle));
  }

  [Conditional("IS_SERVER")]
  public void ModifyHealth(ulong instigatorId, int healthMod)
  {
    if (healthMod == 0)
      return;
    this.playerHealth.modifyHealthEvents.Add(new Imi.SharedWithServer.ScEntitas.Components.ModifyHealth(instigatorId, healthMod));
  }

  public void AddStatusEffect(GameContext gameContext, StatusEffect effect)
  {
    if (this.HasCounteringEffect(effect.type.Get()))
      return;
    StatusEffectSystem.Initialize(this, ref effect, gameContext.globalTime.currentTick);
    List<StatusEffect> effects = this.statusEffect.effects;
    effects.Add(effect);
    int index = 70;
    StatusEffectComponent component = this.CreateComponent<StatusEffectComponent>(index);
    component.effects = effects;
    component.UpdateModifierStack();
    this.ReplaceComponent(index, (IComponent) component);
  }

  public bool HasCounteringEffect(StatusEffectType effectType) => effectType == StatusEffectType.Stun && this.HasModifier(StatusModifier.ImmuneToBlockMove);

  public bool HasModifier(StatusModifier modifier) => this.hasStatusEffect && this.statusEffect.HasModifier(modifier);

  public bool HasEffect(StatusEffectType effectType) => this.hasStatusEffect && this.statusEffect.HasEffect(effectType);

  public bool IsDead() => this.HasEffect(StatusEffectType.Dead);

  public bool IsStunned() => this.HasEffect(StatusEffectType.Stun);

  public bool HasModifiedMoveSpeed() => this.HasEffect(StatusEffectType.ModMoveSpeed);

  public float SpeedScale()
  {
    float val1_1 = 0.0f;
    float val1_2 = 0.0f;
    foreach (StatusEffect effect in this.statusEffect.effects)
    {
      if (effect.modifierStack.Get().HasFlag((Enum) StatusModifier.SpeedMod))
      {
        if ((double) effect.floatValue.Get() > 0.0)
          val1_1 = Math.Max(val1_1, effect.floatValue.Get());
        if ((double) effect.floatValue.Get() < 0.0)
          val1_2 = Math.Min(val1_2, effect.floatValue.Get());
      }
    }
    return 1f + val1_1 + val1_2;
  }

  public bool IsPushed() => this.HasEffect(StatusEffectType.Push);

  public JVector PushForce()
  {
    foreach (StatusEffect effect in this.statusEffect.effects)
    {
      if (effect.type == (SyncableValue<StatusEffectType>) StatusEffectType.Push)
        return effect.floatValue.Get() * effect.vectorValue.Get();
    }
    return JVector.Zero;
  }

  public bool CannotHoldBall() => this.HasModifier(StatusModifier.BlockHoldBall) || (this.rigidbody.value.CollisionMask & 512) == 0;

  public bool IsMoveBlocked() => this.HasModifier(StatusModifier.BlockMove);

  public bool IsSkillUseBlocked() => this.HasModifier(StatusModifier.BlockSkills);

  public bool IsScrambled() => this.HasEffect(StatusEffectType.Scrambled);

  public bool isAlignViewToBottom
  {
    get => this.HasComponent(80);
    set
    {
      if (value == this.isAlignViewToBottom)
        return;
      int index = 80;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.alignViewToBottomComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public AnimationStateComponent animationState => (AnimationStateComponent) this.GetComponent(5);

  public bool hasAnimationState => this.HasComponent(5);

  public void AddAnimationState(
    Dictionary<AnimationStateType, Imi.SharedWithServer.ScEntitas.Components.AnimationState> newAnimationStateData)
  {
    int index = 5;
    AnimationStateComponent component = this.CreateComponent<AnimationStateComponent>(index);
    component.animationStateData = newAnimationStateData;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceAnimationState(
    Dictionary<AnimationStateType, Imi.SharedWithServer.ScEntitas.Components.AnimationState> newAnimationStateData)
  {
    int index = 5;
    AnimationStateComponent component = this.CreateComponent<AnimationStateComponent>(index);
    component.animationStateData = newAnimationStateData;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveAnimationState() => this.RemoveComponent(5);

  public AreaOfEffectComponent areaOfEffect => (AreaOfEffectComponent) this.GetComponent(6);

  public bool hasAreaOfEffect => this.HasComponent(6);

  public void AddAreaOfEffect(AreaOfEffect newAreaOfEffect, Team newTeam)
  {
    int index = 6;
    AreaOfEffectComponent component = this.CreateComponent<AreaOfEffectComponent>(index);
    component.areaOfEffect = newAreaOfEffect;
    component.team = newTeam;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceAreaOfEffect(AreaOfEffect newAreaOfEffect, Team newTeam)
  {
    int index = 6;
    AreaOfEffectComponent component = this.CreateComponent<AreaOfEffectComponent>(index);
    component.areaOfEffect = newAreaOfEffect;
    component.team = newTeam;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveAreaOfEffect() => this.RemoveComponent(6);

  public ArenaLoadedComponent arenaLoaded => (ArenaLoadedComponent) this.GetComponent(7);

  public bool hasArenaLoaded => this.HasComponent(7);

  public void AddArenaLoaded(bool newArenaLoadingFinished)
  {
    int index = 7;
    ArenaLoadedComponent component = this.CreateComponent<ArenaLoadedComponent>(index);
    component.arenaLoadingFinished = newArenaLoadingFinished;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceArenaLoaded(bool newArenaLoadingFinished)
  {
    int index = 7;
    ArenaLoadedComponent component = this.CreateComponent<ArenaLoadedComponent>(index);
    component.arenaLoadingFinished = newArenaLoadingFinished;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveArenaLoaded() => this.RemoveComponent(7);

  public bool isBall
  {
    get => this.HasComponent(8);
    set
    {
      if (value == this.isBall)
        return;
      int index = 8;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.ballComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public BallFlightComponent ballFlight => (BallFlightComponent) this.GetComponent(9);

  public bool hasBallFlight => this.HasComponent(9);

  public void AddBallFlight(
    JVector newVelocity,
    float newFlightCounterSeconds,
    float newBounceCounterSeconds,
    float newBounceIntervalSeconds,
    float newCurrentParabolaXStart,
    float newCurrentParabolaXRange,
    float newCurrentParabolaHeight,
    float newTravelledDistance)
  {
    int index = 9;
    BallFlightComponent component = this.CreateComponent<BallFlightComponent>(index);
    component.velocity = newVelocity;
    component.flightCounterSeconds = newFlightCounterSeconds;
    component.bounceCounterSeconds = newBounceCounterSeconds;
    component.bounceIntervalSeconds = newBounceIntervalSeconds;
    component.currentParabolaXStart = newCurrentParabolaXStart;
    component.currentParabolaXRange = newCurrentParabolaXRange;
    component.currentParabolaHeight = newCurrentParabolaHeight;
    component.travelledDistance = newTravelledDistance;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBallFlight(
    JVector newVelocity,
    float newFlightCounterSeconds,
    float newBounceCounterSeconds,
    float newBounceIntervalSeconds,
    float newCurrentParabolaXStart,
    float newCurrentParabolaXRange,
    float newCurrentParabolaHeight,
    float newTravelledDistance)
  {
    int index = 9;
    BallFlightComponent component = this.CreateComponent<BallFlightComponent>(index);
    component.velocity = newVelocity;
    component.flightCounterSeconds = newFlightCounterSeconds;
    component.bounceCounterSeconds = newBounceCounterSeconds;
    component.bounceIntervalSeconds = newBounceIntervalSeconds;
    component.currentParabolaXStart = newCurrentParabolaXStart;
    component.currentParabolaXRange = newCurrentParabolaXRange;
    component.currentParabolaHeight = newCurrentParabolaHeight;
    component.travelledDistance = newTravelledDistance;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBallFlight() => this.RemoveComponent(9);

  public BallFlightInfoComponent ballFlightInfo => (BallFlightInfoComponent) this.GetComponent(10);

  public bool hasBallFlightInfo => this.HasComponent(10);

  public void AddBallFlightInfo(float newTraveledDistance, float newFlightDurationSeconds)
  {
    int index = 10;
    BallFlightInfoComponent component = this.CreateComponent<BallFlightInfoComponent>(index);
    component.traveledDistance = newTraveledDistance;
    component.flightDurationSeconds = newFlightDurationSeconds;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBallFlightInfo(float newTraveledDistance, float newFlightDurationSeconds)
  {
    int index = 10;
    BallFlightInfoComponent component = this.CreateComponent<BallFlightInfoComponent>(index);
    component.traveledDistance = newTraveledDistance;
    component.flightDurationSeconds = newFlightDurationSeconds;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBallFlightInfo() => this.RemoveComponent(10);

  public bool isBallHitDisabled
  {
    get => this.HasComponent(11);
    set
    {
      if (value == this.isBallHitDisabled)
        return;
      int index = 11;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.ballHitDisabledComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public BallHoverComponent ballHover => (BallHoverComponent) this.GetComponent(12);

  public bool hasBallHover => this.HasComponent(12);

  public void AddBallHover(float newHoverCounterSeconds)
  {
    int index = 12;
    BallHoverComponent component = this.CreateComponent<BallHoverComponent>(index);
    component.hoverCounterSeconds = newHoverCounterSeconds;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBallHover(float newHoverCounterSeconds)
  {
    int index = 12;
    BallHoverComponent component = this.CreateComponent<BallHoverComponent>(index);
    component.hoverCounterSeconds = newHoverCounterSeconds;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBallHover() => this.RemoveComponent(12);

  public BallImpulseComponent ballImpulse => (BallImpulseComponent) this.GetComponent(13);

  public bool hasBallImpulse => this.HasComponent(13);

  public void AddBallImpulse(JVector newValue)
  {
    int index = 13;
    BallImpulseComponent component = this.CreateComponent<BallImpulseComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBallImpulse(JVector newValue)
  {
    int index = 13;
    BallImpulseComponent component = this.CreateComponent<BallImpulseComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBallImpulse() => this.RemoveComponent(13);

  public BallOwnerComponent ballOwner => (BallOwnerComponent) this.GetComponent(14);

  public bool hasBallOwner => this.HasComponent(14);

  public void AddBallOwner(ulong newPlayerId)
  {
    int index = 14;
    BallOwnerComponent component = this.CreateComponent<BallOwnerComponent>(index);
    component.playerId = newPlayerId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBallOwner(ulong newPlayerId)
  {
    int index = 14;
    BallOwnerComponent component = this.CreateComponent<BallOwnerComponent>(index);
    component.playerId = newPlayerId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBallOwner() => this.RemoveComponent(14);

  public bool isBasicTrainingComplete
  {
    get => this.HasComponent(15);
    set
    {
      if (value == this.isBasicTrainingComplete)
        return;
      int index = 15;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.basicTrainingCompleteComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public BumperComponent bumper => (BumperComponent) this.GetComponent(1);

  public bool hasBumper => this.HasComponent(1);

  public void AddBumper(BumperType newType)
  {
    int index = 1;
    BumperComponent component = this.CreateComponent<BumperComponent>(index);
    component.type = newType;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceBumper(BumperType newType)
  {
    int index = 1;
    BumperComponent component = this.CreateComponent<BumperComponent>(index);
    component.type = newType;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveBumper() => this.RemoveComponent(1);

  public CameraTargetComponent cameraTarget => (CameraTargetComponent) this.GetComponent(16);

  public bool hasCameraTarget => this.HasComponent(16);

  public void AddCameraTarget(JVector newPosition, bool newOverrideInProgress)
  {
    int index = 16;
    CameraTargetComponent component = this.CreateComponent<CameraTargetComponent>(index);
    component.position = newPosition;
    component.overrideInProgress = newOverrideInProgress;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceCameraTarget(JVector newPosition, bool newOverrideInProgress)
  {
    int index = 16;
    CameraTargetComponent component = this.CreateComponent<CameraTargetComponent>(index);
    component.position = newPosition;
    component.overrideInProgress = newOverrideInProgress;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveCameraTarget() => this.RemoveComponent(16);

  public ChampionConfigComponent championConfig => (ChampionConfigComponent) this.GetComponent(17);

  public bool hasChampionConfig => this.HasComponent(17);

  public void AddChampionConfig(ChampionConfig newValue)
  {
    int index = 17;
    ChampionConfigComponent component = this.CreateComponent<ChampionConfigComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceChampionConfig(ChampionConfig newValue)
  {
    int index = 17;
    ChampionConfigComponent component = this.CreateComponent<ChampionConfigComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveChampionConfig() => this.RemoveComponent(17);

  public CollisionEventComponent collisionEvent => (CollisionEventComponent) this.GetComponent(18);

  public bool hasCollisionEvent => this.HasComponent(18);

  public void AddCollisionEvent(JCollision newCollision)
  {
    int index = 18;
    CollisionEventComponent component = this.CreateComponent<CollisionEventComponent>(index);
    component.collision = newCollision;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceCollisionEvent(JCollision newCollision)
  {
    int index = 18;
    CollisionEventComponent component = this.CreateComponent<CollisionEventComponent>(index);
    component.collision = newCollision;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveCollisionEvent() => this.RemoveComponent(18);

  public CollisionEventsComponent collisionEvents => (CollisionEventsComponent) this.GetComponent(19);

  public bool hasCollisionEvents => this.HasComponent(19);

  public void AddCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    int index = 19;
    CollisionEventsComponent component = this.CreateComponent<CollisionEventsComponent>(index);
    component.collisions = newCollisions;
    component.triggerEnter = newTriggerEnter;
    component.triggerStay = newTriggerStay;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    int index = 19;
    CollisionEventsComponent component = this.CreateComponent<CollisionEventsComponent>(index);
    component.collisions = newCollisions;
    component.triggerEnter = newTriggerEnter;
    component.triggerStay = newTriggerStay;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveCollisionEvents() => this.RemoveComponent(19);

  public ConnectionInfoComponent connectionInfo => (ConnectionInfoComponent) this.GetComponent(20);

  public bool hasConnectionInfo => this.HasComponent(20);

  public void AddConnectionInfo(
    float newRttMillis,
    int newLastReceivedRemoteTick,
    float newLoss,
    float newRecvBandwidthKbps,
    float newSentBandwidthKbps,
    float newAckBandwidthKbps,
    float newCurrentTickRateMillis,
    int newOffset,
    int newConnectedTicks,
    int newLateMessages)
  {
    int index = 20;
    ConnectionInfoComponent component = this.CreateComponent<ConnectionInfoComponent>(index);
    component.rttMillis = newRttMillis;
    component.lastReceivedRemoteTick = newLastReceivedRemoteTick;
    component.loss = newLoss;
    component.recvBandwidthKbps = newRecvBandwidthKbps;
    component.sentBandwidthKbps = newSentBandwidthKbps;
    component.ackBandwidthKbps = newAckBandwidthKbps;
    component.currentTickRateMillis = newCurrentTickRateMillis;
    component.offset = newOffset;
    component.connectedTicks = newConnectedTicks;
    component.lateMessages = newLateMessages;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceConnectionInfo(
    float newRttMillis,
    int newLastReceivedRemoteTick,
    float newLoss,
    float newRecvBandwidthKbps,
    float newSentBandwidthKbps,
    float newAckBandwidthKbps,
    float newCurrentTickRateMillis,
    int newOffset,
    int newConnectedTicks,
    int newLateMessages)
  {
    int index = 20;
    ConnectionInfoComponent component = this.CreateComponent<ConnectionInfoComponent>(index);
    component.rttMillis = newRttMillis;
    component.lastReceivedRemoteTick = newLastReceivedRemoteTick;
    component.loss = newLoss;
    component.recvBandwidthKbps = newRecvBandwidthKbps;
    component.sentBandwidthKbps = newSentBandwidthKbps;
    component.ackBandwidthKbps = newAckBandwidthKbps;
    component.currentTickRateMillis = newCurrentTickRateMillis;
    component.offset = newOffset;
    component.connectedTicks = newConnectedTicks;
    component.lateMessages = newLateMessages;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveConnectionInfo() => this.RemoveComponent(20);

  public bool isConstrainedTo2D
  {
    get => this.HasComponent(21);
    set
    {
      if (value == this.isConstrainedTo2D)
        return;
      int index = 21;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.constrainedTo2DComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public CountdownActionComponent countdownAction => (CountdownActionComponent) this.GetComponent(22);

  public bool hasCountdownAction => this.HasComponent(22);

  public void AddCountdownAction(CountdownAction newValue)
  {
    int index = 22;
    CountdownActionComponent component = this.CreateComponent<CountdownActionComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceCountdownAction(CountdownAction newValue)
  {
    int index = 22;
    CountdownActionComponent component = this.CreateComponent<CountdownActionComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveCountdownAction() => this.RemoveComponent(22);

  public DeathComponent death => (DeathComponent) this.GetComponent(23);

  public bool hasDeath => this.HasComponent(23);

  public void AddDeath(
    JVector newPlayerSpawnPoint,
    JVector newLastPlayerPosition,
    float newRespawnDuration,
    float newLerpFactor)
  {
    int index = 23;
    DeathComponent component = this.CreateComponent<DeathComponent>(index);
    component.playerSpawnPoint = newPlayerSpawnPoint;
    component.lastPlayerPosition = newLastPlayerPosition;
    component.respawnDuration = newRespawnDuration;
    component.lerpFactor = newLerpFactor;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceDeath(
    JVector newPlayerSpawnPoint,
    JVector newLastPlayerPosition,
    float newRespawnDuration,
    float newLerpFactor)
  {
    int index = 23;
    DeathComponent component = this.CreateComponent<DeathComponent>(index);
    component.playerSpawnPoint = newPlayerSpawnPoint;
    component.lastPlayerPosition = newLastPlayerPosition;
    component.respawnDuration = newRespawnDuration;
    component.lerpFactor = newLerpFactor;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveDeath() => this.RemoveComponent(23);

  public DebugFlagComponent debugFlag => (DebugFlagComponent) this.GetComponent(24);

  public bool hasDebugFlag => this.HasComponent(24);

  public void AddDebugFlag(string newValue)
  {
    int index = 24;
    DebugFlagComponent component = this.CreateComponent<DebugFlagComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceDebugFlag(string newValue)
  {
    int index = 24;
    DebugFlagComponent component = this.CreateComponent<DebugFlagComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveDebugFlag() => this.RemoveComponent(24);

  public DeferredCollisionEventsComponent deferredCollisionEvents => (DeferredCollisionEventsComponent) this.GetComponent(25);

  public bool hasDeferredCollisionEvents => this.HasComponent(25);

  public void AddDeferredCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    int index = 25;
    DeferredCollisionEventsComponent component = this.CreateComponent<DeferredCollisionEventsComponent>(index);
    component.collisions = newCollisions;
    component.triggerEnter = newTriggerEnter;
    component.triggerStay = newTriggerStay;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceDeferredCollisionEvents(
    List<JCollision> newCollisions,
    List<JCollision> newTriggerEnter,
    List<JCollision> newTriggerStay)
  {
    int index = 25;
    DeferredCollisionEventsComponent component = this.CreateComponent<DeferredCollisionEventsComponent>(index);
    component.collisions = newCollisions;
    component.triggerEnter = newTriggerEnter;
    component.triggerStay = newTriggerStay;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveDeferredCollisionEvents() => this.RemoveComponent(25);

  public bool isDestroyed
  {
    get => this.HasComponent(26);
    set
    {
      if (value == this.isDestroyed)
        return;
      int index = 26;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.destroyedComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public EventDispatcherComponent eventDispatcher => (EventDispatcherComponent) this.GetComponent(0);

  public bool hasEventDispatcher => this.HasComponent(0);

  public void AddEventDispatcher(AEventDispatcher newValue)
  {
    int index = 0;
    EventDispatcherComponent component = this.CreateComponent<EventDispatcherComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceEventDispatcher(AEventDispatcher newValue)
  {
    int index = 0;
    EventDispatcherComponent component = this.CreateComponent<EventDispatcherComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveEventDispatcher() => this.RemoveComponent(0);

  public bool isFakePlayer
  {
    get => this.HasComponent(27);
    set
    {
      if (value == this.isFakePlayer)
        return;
      int index = 27;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.fakePlayerComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public ForcefieldComponent forcefield => (ForcefieldComponent) this.GetComponent(28);

  public bool hasForcefield => this.HasComponent(28);

  public void AddForcefield(bool newDeactivateDuringPoint)
  {
    int index = 28;
    ForcefieldComponent component = this.CreateComponent<ForcefieldComponent>(index);
    component.deactivateDuringPoint = newDeactivateDuringPoint;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceForcefield(bool newDeactivateDuringPoint)
  {
    int index = 28;
    ForcefieldComponent component = this.CreateComponent<ForcefieldComponent>(index);
    component.deactivateDuringPoint = newDeactivateDuringPoint;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveForcefield() => this.RemoveComponent(28);

  public GamePhysicsComponent gamePhysics => (GamePhysicsComponent) this.GetComponent(29);

  public bool hasGamePhysics => this.HasComponent(29);

  public void AddGamePhysics(
    World newWorld,
    Action<int, int, GameEntity, Action> newCheckPastPhysicsState)
  {
    int index = 29;
    GamePhysicsComponent component = this.CreateComponent<GamePhysicsComponent>(index);
    component.world = newWorld;
    component.checkPastPhysicsState = newCheckPastPhysicsState;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceGamePhysics(
    World newWorld,
    Action<int, int, GameEntity, Action> newCheckPastPhysicsState)
  {
    int index = 29;
    GamePhysicsComponent component = this.CreateComponent<GamePhysicsComponent>(index);
    component.world = newWorld;
    component.checkPastPhysicsState = newCheckPastPhysicsState;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveGamePhysics() => this.RemoveComponent(29);

  public GlobalTimeComponent globalTime => (GlobalTimeComponent) this.GetComponent(30);

  public bool hasGlobalTime => this.HasComponent(30);

  public void AddGlobalTime(
    float newFixedSimTimeStep,
    float newTimeSinceMatchStart,
    int newCurrentTick,
    int newLastServerTick,
    float newTimeSinceStartOfTick,
    bool newIsReprediction)
  {
    int index = 30;
    GlobalTimeComponent component = this.CreateComponent<GlobalTimeComponent>(index);
    component.fixedSimTimeStep = newFixedSimTimeStep;
    component.timeSinceMatchStart = newTimeSinceMatchStart;
    component.currentTick = newCurrentTick;
    component.lastServerTick = newLastServerTick;
    component.timeSinceStartOfTick = newTimeSinceStartOfTick;
    component.isReprediction = newIsReprediction;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceGlobalTime(
    float newFixedSimTimeStep,
    float newTimeSinceMatchStart,
    int newCurrentTick,
    int newLastServerTick,
    float newTimeSinceStartOfTick,
    bool newIsReprediction)
  {
    int index = 30;
    GlobalTimeComponent component = this.CreateComponent<GlobalTimeComponent>(index);
    component.fixedSimTimeStep = newFixedSimTimeStep;
    component.timeSinceMatchStart = newTimeSinceMatchStart;
    component.currentTick = newCurrentTick;
    component.lastServerTick = newLastServerTick;
    component.timeSinceStartOfTick = newTimeSinceStartOfTick;
    component.isReprediction = newIsReprediction;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveGlobalTime() => this.RemoveComponent(30);

  public GoalComponent goal => (GoalComponent) this.GetComponent(31);

  public bool hasGoal => this.HasComponent(31);

  public void AddGoal(Team newTeam)
  {
    int index = 31;
    GoalComponent component = this.CreateComponent<GoalComponent>(index);
    component.team = newTeam;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceGoal(Team newTeam)
  {
    int index = 31;
    GoalComponent component = this.CreateComponent<GoalComponent>(index);
    component.team = newTeam;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveGoal() => this.RemoveComponent(31);

  public bool isImi
  {
    get => this.HasComponent(32);
    set
    {
      if (value == this.isImi)
        return;
      int index = 32;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.imiComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public InputComponent input => (InputComponent) this.GetComponent(33);

  public bool hasInput => this.HasComponent(33);

  public void AddInput(SequenceBuffer32<Imi.SharedWithServer.ScEntitas.Components.Input> newValue)
  {
    int index = 33;
    InputComponent component = this.CreateComponent<InputComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceInput(SequenceBuffer32<Imi.SharedWithServer.ScEntitas.Components.Input> newValue)
  {
    int index = 33;
    InputComponent component = this.CreateComponent<InputComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveInput() => this.RemoveComponent(33);

  public LastBallContactComponent lastBallContact => (LastBallContactComponent) this.GetComponent(34);

  public bool hasLastBallContact => this.HasComponent(34);

  public void AddLastBallContact(ulong newPlayerId)
  {
    int index = 34;
    LastBallContactComponent component = this.CreateComponent<LastBallContactComponent>(index);
    component.playerId = newPlayerId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLastBallContact(ulong newPlayerId)
  {
    int index = 34;
    LastBallContactComponent component = this.CreateComponent<LastBallContactComponent>(index);
    component.playerId = newPlayerId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLastBallContact() => this.RemoveComponent(34);

  public LastBallThrowComponent lastBallThrow => (LastBallThrowComponent) this.GetComponent(35);

  public bool hasLastBallThrow => this.HasComponent(35);

  public void AddLastBallThrow(int newTick, JVector newPosition, JVector newVelocity)
  {
    int index = 35;
    LastBallThrowComponent component = this.CreateComponent<LastBallThrowComponent>(index);
    component.tick = newTick;
    component.position = newPosition;
    component.velocity = newVelocity;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLastBallThrow(int newTick, JVector newPosition, JVector newVelocity)
  {
    int index = 35;
    LastBallThrowComponent component = this.CreateComponent<LastBallThrowComponent>(index);
    component.tick = newTick;
    component.position = newPosition;
    component.velocity = newVelocity;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLastBallThrow() => this.RemoveComponent(35);

  public LastGoalScoredComponent lastGoalScored => (LastGoalScoredComponent) this.GetComponent(36);

  public bool hasLastGoalScored => this.HasComponent(36);

  public void AddLastGoalScored(ulong newPlayerId, Team newTeam)
  {
    int index = 36;
    LastGoalScoredComponent component = this.CreateComponent<LastGoalScoredComponent>(index);
    component.playerId = newPlayerId;
    component.team = newTeam;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLastGoalScored(ulong newPlayerId, Team newTeam)
  {
    int index = 36;
    LastGoalScoredComponent component = this.CreateComponent<LastGoalScoredComponent>(index);
    component.playerId = newPlayerId;
    component.team = newTeam;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLastGoalScored() => this.RemoveComponent(36);

  public LastKnownRemoteTickComponent lastKnownRemoteTick => (LastKnownRemoteTickComponent) this.GetComponent(37);

  public bool hasLastKnownRemoteTick => this.HasComponent(37);

  public void AddLastKnownRemoteTick(int newValue)
  {
    int index = 37;
    LastKnownRemoteTickComponent component = this.CreateComponent<LastKnownRemoteTickComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLastKnownRemoteTick(int newValue)
  {
    int index = 37;
    LastKnownRemoteTickComponent component = this.CreateComponent<LastKnownRemoteTickComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLastKnownRemoteTick() => this.RemoveComponent(37);

  public LoadArenaInfoComponent loadArenaInfo => (LoadArenaInfoComponent) this.GetComponent(38);

  public bool hasLoadArenaInfo => this.HasComponent(38);

  public void AddLoadArenaInfo(string newArenaName, string newArenaPath)
  {
    int index = 38;
    LoadArenaInfoComponent component = this.CreateComponent<LoadArenaInfoComponent>(index);
    component.arenaName = newArenaName;
    component.arenaPath = newArenaPath;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLoadArenaInfo(string newArenaName, string newArenaPath)
  {
    int index = 38;
    LoadArenaInfoComponent component = this.CreateComponent<LoadArenaInfoComponent>(index);
    component.arenaName = newArenaName;
    component.arenaPath = newArenaPath;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLoadArenaInfo() => this.RemoveComponent(38);

  public bool isLocalEntity
  {
    get => this.HasComponent(39);
    set
    {
      if (value == this.isLocalEntity)
        return;
      int index = 39;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.localEntityComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public LocalPlayerVisualSmoothing localPlayerVisualSmoothing => (LocalPlayerVisualSmoothing) this.GetComponent(40);

  public bool hasLocalPlayerVisualSmoothing => this.HasComponent(40);

  public void AddLocalPlayerVisualSmoothing(
    float newCurrentLerpFactor,
    float newCurrentLerpDuration,
    float newTickStartTime,
    float newFrameDtOffset,
    TransformState newInterpolationStartTransform,
    TransformState newInterpolationEndTransform,
    TransformState newSmoothedTransform,
    TimelineVector newPositionTimeline)
  {
    int index = 40;
    LocalPlayerVisualSmoothing component = this.CreateComponent<LocalPlayerVisualSmoothing>(index);
    component.currentLerpFactor = newCurrentLerpFactor;
    component.currentLerpDuration = newCurrentLerpDuration;
    component.tickStartTime = newTickStartTime;
    component.frameDtOffset = newFrameDtOffset;
    component.interpolationStartTransform = newInterpolationStartTransform;
    component.interpolationEndTransform = newInterpolationEndTransform;
    component.smoothedTransform = newSmoothedTransform;
    component.positionTimeline = newPositionTimeline;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceLocalPlayerVisualSmoothing(
    float newCurrentLerpFactor,
    float newCurrentLerpDuration,
    float newTickStartTime,
    float newFrameDtOffset,
    TransformState newInterpolationStartTransform,
    TransformState newInterpolationEndTransform,
    TransformState newSmoothedTransform,
    TimelineVector newPositionTimeline)
  {
    int index = 40;
    LocalPlayerVisualSmoothing component = this.CreateComponent<LocalPlayerVisualSmoothing>(index);
    component.currentLerpFactor = newCurrentLerpFactor;
    component.currentLerpDuration = newCurrentLerpDuration;
    component.tickStartTime = newTickStartTime;
    component.frameDtOffset = newFrameDtOffset;
    component.interpolationStartTransform = newInterpolationStartTransform;
    component.interpolationEndTransform = newInterpolationEndTransform;
    component.smoothedTransform = newSmoothedTransform;
    component.positionTimeline = newPositionTimeline;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveLocalPlayerVisualSmoothing() => this.RemoveComponent(40);

  public MatchConfigComponent matchConfig => (MatchConfigComponent) this.GetComponent(41);

  public bool hasMatchConfig => this.HasComponent(41);

  public void AddMatchConfig(MatchConfig newMatchConfig)
  {
    int index = 41;
    MatchConfigComponent component = this.CreateComponent<MatchConfigComponent>(index);
    component.matchConfig = newMatchConfig;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMatchConfig(MatchConfig newMatchConfig)
  {
    int index = 41;
    MatchConfigComponent component = this.CreateComponent<MatchConfigComponent>(index);
    component.matchConfig = newMatchConfig;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMatchConfig() => this.RemoveComponent(41);

  public MatchDataComponent matchData => (MatchDataComponent) this.GetComponent(42);

  public bool hasMatchData => this.HasComponent(42);

  public void AddMatchData(MatchType newMatchType, int newNumPlayers)
  {
    int index = 42;
    MatchDataComponent component = this.CreateComponent<MatchDataComponent>(index);
    component.matchType = newMatchType;
    component.numPlayers = newNumPlayers;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMatchData(MatchType newMatchType, int newNumPlayers)
  {
    int index = 42;
    MatchDataComponent component = this.CreateComponent<MatchDataComponent>(index);
    component.matchType = newMatchType;
    component.numPlayers = newNumPlayers;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMatchData() => this.RemoveComponent(42);

  public MatchStateComponent matchState => (MatchStateComponent) this.GetComponent(43);

  public bool hasMatchState => this.HasComponent(43);

  public void AddMatchState(Imi.SharedWithServer.Game.MatchState newValue)
  {
    int index = 43;
    MatchStateComponent component = this.CreateComponent<MatchStateComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMatchState(Imi.SharedWithServer.Game.MatchState newValue)
  {
    int index = 43;
    MatchStateComponent component = this.CreateComponent<MatchStateComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMatchState() => this.RemoveComponent(43);

  public MatchStateTransitionEventComponent matchStateTransitionEvent => (MatchStateTransitionEventComponent) this.GetComponent(44);

  public bool hasMatchStateTransitionEvent => this.HasComponent(44);

  public void AddMatchStateTransitionEvent(TransitionEvent newValue)
  {
    int index = 44;
    MatchStateTransitionEventComponent component = this.CreateComponent<MatchStateTransitionEventComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMatchStateTransitionEvent(TransitionEvent newValue)
  {
    int index = 44;
    MatchStateTransitionEventComponent component = this.CreateComponent<MatchStateTransitionEventComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMatchStateTransitionEvent() => this.RemoveComponent(44);

  public MovementComponent movement => (MovementComponent) this.GetComponent(45);

  public bool hasMovement => this.HasComponent(45);

  public void AddMovement(List<MovementModifier> newModifier)
  {
    int index = 45;
    MovementComponent component = this.CreateComponent<MovementComponent>(index);
    component.modifier = newModifier;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceMovement(List<MovementModifier> newModifier)
  {
    int index = 45;
    MovementComponent component = this.CreateComponent<MovementComponent>(index);
    component.modifier = newModifier;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveMovement() => this.RemoveComponent(45);

  public PickupComponent pickup => (PickupComponent) this.GetComponent(2);

  public bool hasPickup => this.HasComponent(2);

  public void AddPickup(
    List<PickupData> newPickupsToSpawn,
    PickupType newActiveType,
    PickupSize newPickupSize,
    PickupType newNextActiveType,
    bool newIsActive,
    bool newIsActiveOnStart,
    float newRespawnDuration,
    float newCurrentDuration)
  {
    int index = 2;
    PickupComponent component = this.CreateComponent<PickupComponent>(index);
    component.pickupsToSpawn = newPickupsToSpawn;
    component.activeType = newActiveType;
    component.pickupSize = newPickupSize;
    component.nextActiveType = newNextActiveType;
    component.isActive = newIsActive;
    component.isActiveOnStart = newIsActiveOnStart;
    component.respawnDuration = newRespawnDuration;
    component.currentDuration = newCurrentDuration;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePickup(
    List<PickupData> newPickupsToSpawn,
    PickupType newActiveType,
    PickupSize newPickupSize,
    PickupType newNextActiveType,
    bool newIsActive,
    bool newIsActiveOnStart,
    float newRespawnDuration,
    float newCurrentDuration)
  {
    int index = 2;
    PickupComponent component = this.CreateComponent<PickupComponent>(index);
    component.pickupsToSpawn = newPickupsToSpawn;
    component.activeType = newActiveType;
    component.pickupSize = newPickupSize;
    component.nextActiveType = newNextActiveType;
    component.isActive = newIsActive;
    component.isActiveOnStart = newIsActiveOnStart;
    component.respawnDuration = newRespawnDuration;
    component.currentDuration = newCurrentDuration;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePickup() => this.RemoveComponent(2);

  public PickupConsumedComponent pickupConsumed => (PickupConsumedComponent) this.GetComponent(3);

  public bool hasPickupConsumed => this.HasComponent(3);

  public void AddPickupConsumed(PickupType newType)
  {
    int index = 3;
    PickupConsumedComponent component = this.CreateComponent<PickupConsumedComponent>(index);
    component.type = newType;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePickupConsumed(PickupType newType)
  {
    int index = 3;
    PickupConsumedComponent component = this.CreateComponent<PickupConsumedComponent>(index);
    component.type = newType;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePickupConsumed() => this.RemoveComponent(3);

  public PlayerChampionDataComponent playerChampionData => (PlayerChampionDataComponent) this.GetComponent(46);

  public bool hasPlayerChampionData => this.HasComponent(46);

  public void AddPlayerChampionData(PlayerChampionData newValue)
  {
    int index = 46;
    PlayerChampionDataComponent component = this.CreateComponent<PlayerChampionDataComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerChampionData(PlayerChampionData newValue)
  {
    int index = 46;
    PlayerChampionDataComponent component = this.CreateComponent<PlayerChampionDataComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerChampionData() => this.RemoveComponent(46);

  public bool isPlayer
  {
    get => this.HasComponent(47);
    set
    {
      if (value == this.isPlayer)
        return;
      int index = 47;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.playerComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public PlayerForfeitComponent playerForfeit => (PlayerForfeitComponent) this.GetComponent(48);

  public bool hasPlayerForfeit => this.HasComponent(48);

  public void AddPlayerForfeit(bool newHasForfeit)
  {
    int index = 48;
    PlayerForfeitComponent component = this.CreateComponent<PlayerForfeitComponent>(index);
    component.hasForfeit = newHasForfeit;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerForfeit(bool newHasForfeit)
  {
    int index = 48;
    PlayerForfeitComponent component = this.CreateComponent<PlayerForfeitComponent>(index);
    component.hasForfeit = newHasForfeit;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerForfeit() => this.RemoveComponent(48);

  public PlayerHealthComponent playerHealth => (PlayerHealthComponent) this.GetComponent(49);

  public bool hasPlayerHealth => this.HasComponent(49);

  public void AddPlayerHealth(int newValue, List<Imi.SharedWithServer.ScEntitas.Components.ModifyHealth> newModifyHealthEvents)
  {
    int index = 49;
    PlayerHealthComponent component = this.CreateComponent<PlayerHealthComponent>(index);
    component.value = newValue;
    component.modifyHealthEvents = newModifyHealthEvents;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerHealth(int newValue, List<Imi.SharedWithServer.ScEntitas.Components.ModifyHealth> newModifyHealthEvents)
  {
    int index = 49;
    PlayerHealthComponent component = this.CreateComponent<PlayerHealthComponent>(index);
    component.value = newValue;
    component.modifyHealthEvents = newModifyHealthEvents;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerHealth() => this.RemoveComponent(49);

  public PlayerIdComponent playerId => (PlayerIdComponent) this.GetComponent(50);

  public bool hasPlayerId => this.HasComponent(50);

  public void AddPlayerId(ulong newValue)
  {
    int index = 50;
    PlayerIdComponent component = this.CreateComponent<PlayerIdComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerId(ulong newValue)
  {
    int index = 50;
    PlayerIdComponent component = this.CreateComponent<PlayerIdComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerId() => this.RemoveComponent(50);

  public PlayerLoadoutComponent playerLoadout => (PlayerLoadoutComponent) this.GetComponent(51);

  public bool hasPlayerLoadout => this.HasComponent(51);

  public void AddPlayerLoadout(
    bool newPlayerLoadoutFetched,
    int newPlayerAvatar,
    Sprite newPlayerAvatarSprite,
    Dictionary<ChampionType, ChampionLoadout> newItemLoadouts)
  {
    int index = 51;
    PlayerLoadoutComponent component = this.CreateComponent<PlayerLoadoutComponent>(index);
    component.playerLoadoutFetched = newPlayerLoadoutFetched;
    component.playerAvatar = newPlayerAvatar;
    component.PlayerAvatarSprite = newPlayerAvatarSprite;
    component.itemLoadouts = newItemLoadouts;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerLoadout(
    bool newPlayerLoadoutFetched,
    int newPlayerAvatar,
    Sprite newPlayerAvatarSprite,
    Dictionary<ChampionType, ChampionLoadout> newItemLoadouts)
  {
    int index = 51;
    PlayerLoadoutComponent component = this.CreateComponent<PlayerLoadoutComponent>(index);
    component.playerLoadoutFetched = newPlayerLoadoutFetched;
    component.playerAvatar = newPlayerAvatar;
    component.PlayerAvatarSprite = newPlayerAvatarSprite;
    component.itemLoadouts = newItemLoadouts;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerLoadout() => this.RemoveComponent(51);

  public PlayerPickOrderComponent playerPickOrder => (PlayerPickOrderComponent) this.GetComponent(52);

  public bool hasPlayerPickOrder => this.HasComponent(52);

  public void AddPlayerPickOrder(int newPlayerPickOrder, int newStartTick, int newEndTick)
  {
    int index = 52;
    PlayerPickOrderComponent component = this.CreateComponent<PlayerPickOrderComponent>(index);
    component.playerPickOrder = newPlayerPickOrder;
    component.startTick = newStartTick;
    component.endTick = newEndTick;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerPickOrder(int newPlayerPickOrder, int newStartTick, int newEndTick)
  {
    int index = 52;
    PlayerPickOrderComponent component = this.CreateComponent<PlayerPickOrderComponent>(index);
    component.playerPickOrder = newPlayerPickOrder;
    component.startTick = newStartTick;
    component.endTick = newEndTick;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerPickOrder() => this.RemoveComponent(52);

  public bool isPlayerRespawning
  {
    get => this.HasComponent(53);
    set
    {
      if (value == this.isPlayerRespawning)
        return;
      int index = 53;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.playerRespawningComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public PlayerSpawnPointComponent playerSpawnPoint => (PlayerSpawnPointComponent) this.GetComponent(54);

  public bool hasPlayerSpawnPoint => this.HasComponent(54);

  public void AddPlayerSpawnPoint(Team newTeam, MatchType newMatchType, ulong newPlayerId)
  {
    int index = 54;
    PlayerSpawnPointComponent component = this.CreateComponent<PlayerSpawnPointComponent>(index);
    component.team = newTeam;
    component.matchType = newMatchType;
    component.playerId = newPlayerId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerSpawnPoint(Team newTeam, MatchType newMatchType, ulong newPlayerId)
  {
    int index = 54;
    PlayerSpawnPointComponent component = this.CreateComponent<PlayerSpawnPointComponent>(index);
    component.team = newTeam;
    component.matchType = newMatchType;
    component.playerId = newPlayerId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerSpawnPoint() => this.RemoveComponent(54);

  public PlayerStatisticsComponent playerStatistics => (PlayerStatisticsComponent) this.GetComponent(55);

  public bool hasPlayerStatistics => this.HasComponent(55);

  public void AddPlayerStatistics(
    ulong newPlayerId,
    List<ulong> newKoedPlayers,
    List<ulong> newKoedByPlayer,
    int newDamageDone,
    int newHealingDone,
    int newDamageReceived,
    int newHealingReceived,
    int newSuccessfulPasses,
    int newAssists,
    int newShotsOnGoal,
    int newTrickShots,
    int newSuccessfulTackles,
    int newUnsuccessfulTackles)
  {
    int index = 55;
    PlayerStatisticsComponent component = this.CreateComponent<PlayerStatisticsComponent>(index);
    component.playerId = newPlayerId;
    component.koedPlayers = newKoedPlayers;
    component.koedByPlayer = newKoedByPlayer;
    component.damageDone = newDamageDone;
    component.healingDone = newHealingDone;
    component.damageReceived = newDamageReceived;
    component.healingReceived = newHealingReceived;
    component.successfulPasses = newSuccessfulPasses;
    component.assists = newAssists;
    component.shotsOnGoal = newShotsOnGoal;
    component.trickShots = newTrickShots;
    component.successfulTackles = newSuccessfulTackles;
    component.unsuccessfulTackles = newUnsuccessfulTackles;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerStatistics(
    ulong newPlayerId,
    List<ulong> newKoedPlayers,
    List<ulong> newKoedByPlayer,
    int newDamageDone,
    int newHealingDone,
    int newDamageReceived,
    int newHealingReceived,
    int newSuccessfulPasses,
    int newAssists,
    int newShotsOnGoal,
    int newTrickShots,
    int newSuccessfulTackles,
    int newUnsuccessfulTackles)
  {
    int index = 55;
    PlayerStatisticsComponent component = this.CreateComponent<PlayerStatisticsComponent>(index);
    component.playerId = newPlayerId;
    component.koedPlayers = newKoedPlayers;
    component.koedByPlayer = newKoedByPlayer;
    component.damageDone = newDamageDone;
    component.healingDone = newHealingDone;
    component.damageReceived = newDamageReceived;
    component.healingReceived = newHealingReceived;
    component.successfulPasses = newSuccessfulPasses;
    component.assists = newAssists;
    component.shotsOnGoal = newShotsOnGoal;
    component.trickShots = newTrickShots;
    component.successfulTackles = newSuccessfulTackles;
    component.unsuccessfulTackles = newUnsuccessfulTackles;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerStatistics() => this.RemoveComponent(55);

  public PlayerTeamComponent playerTeam => (PlayerTeamComponent) this.GetComponent(56);

  public bool hasPlayerTeam => this.HasComponent(56);

  public void AddPlayerTeam(Team newValue)
  {
    int index = 56;
    PlayerTeamComponent component = this.CreateComponent<PlayerTeamComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerTeam(Team newValue)
  {
    int index = 56;
    PlayerTeamComponent component = this.CreateComponent<PlayerTeamComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerTeam() => this.RemoveComponent(56);

  public PlayerUsernameComponent playerUsername => (PlayerUsernameComponent) this.GetComponent(57);

  public bool hasPlayerUsername => this.HasComponent(57);

  public void AddPlayerUsername(
    bool newPlayerUsernameFetched,
    string newUsername,
    bool newIsTwitchUser,
    string newTwitchUsername,
    int newTwitchViewerCount,
    int newPlayerLevel)
  {
    int index = 57;
    PlayerUsernameComponent component = this.CreateComponent<PlayerUsernameComponent>(index);
    component.playerUsernameFetched = newPlayerUsernameFetched;
    component.username = newUsername;
    component.isTwitchUser = newIsTwitchUser;
    component.twitchUsername = newTwitchUsername;
    component.twitchViewerCount = newTwitchViewerCount;
    component.playerLevel = newPlayerLevel;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePlayerUsername(
    bool newPlayerUsernameFetched,
    string newUsername,
    bool newIsTwitchUser,
    string newTwitchUsername,
    int newTwitchViewerCount,
    int newPlayerLevel)
  {
    int index = 57;
    PlayerUsernameComponent component = this.CreateComponent<PlayerUsernameComponent>(index);
    component.playerUsernameFetched = newPlayerUsernameFetched;
    component.username = newUsername;
    component.isTwitchUser = newIsTwitchUser;
    component.twitchUsername = newTwitchUsername;
    component.twitchViewerCount = newTwitchViewerCount;
    component.playerLevel = newPlayerLevel;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePlayerUsername() => this.RemoveComponent(57);

  public PositionTimelineComponent positionTimeline => (PositionTimelineComponent) this.GetComponent(58);

  public bool hasPositionTimeline => this.HasComponent(58);

  public void AddPositionTimeline(TimelineVector newValue)
  {
    int index = 58;
    PositionTimelineComponent component = this.CreateComponent<PositionTimelineComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplacePositionTimeline(TimelineVector newValue)
  {
    int index = 58;
    PositionTimelineComponent component = this.CreateComponent<PositionTimelineComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemovePositionTimeline() => this.RemoveComponent(58);

  public ProjectileComponent projectile => (ProjectileComponent) this.GetComponent(59);

  public bool hasProjectile => this.HasComponent(59);

  public void AddProjectile(
    ProjectileType newProjectileType,
    ulong newOwner,
    ProjectileImpactEffect newProjectileImpactEffect,
    float newSpinSpeed,
    int newBounceOnImpact,
    int newBounces,
    float newLifeTimeLimit,
    float newTimeAlive,
    float newMaxTravelDistance,
    float newTraveledDistance,
    Action<ImpactParameters> newOnImpact,
    Action newOnDestroy)
  {
    int index = 59;
    ProjectileComponent component = this.CreateComponent<ProjectileComponent>(index);
    component.projectileType = newProjectileType;
    component.owner = newOwner;
    component.projectileImpactEffect = newProjectileImpactEffect;
    component.spinSpeed = newSpinSpeed;
    component.bounceOnImpact = newBounceOnImpact;
    component.bounces = newBounces;
    component.lifeTimeLimit = newLifeTimeLimit;
    component.timeAlive = newTimeAlive;
    component.maxTravelDistance = newMaxTravelDistance;
    component.traveledDistance = newTraveledDistance;
    component.onImpact = newOnImpact;
    component.onDestroy = newOnDestroy;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceProjectile(
    ProjectileType newProjectileType,
    ulong newOwner,
    ProjectileImpactEffect newProjectileImpactEffect,
    float newSpinSpeed,
    int newBounceOnImpact,
    int newBounces,
    float newLifeTimeLimit,
    float newTimeAlive,
    float newMaxTravelDistance,
    float newTraveledDistance,
    Action<ImpactParameters> newOnImpact,
    Action newOnDestroy)
  {
    int index = 59;
    ProjectileComponent component = this.CreateComponent<ProjectileComponent>(index);
    component.projectileType = newProjectileType;
    component.owner = newOwner;
    component.projectileImpactEffect = newProjectileImpactEffect;
    component.spinSpeed = newSpinSpeed;
    component.bounceOnImpact = newBounceOnImpact;
    component.bounces = newBounces;
    component.lifeTimeLimit = newLifeTimeLimit;
    component.timeAlive = newTimeAlive;
    component.maxTravelDistance = newMaxTravelDistance;
    component.traveledDistance = newTraveledDistance;
    component.onImpact = newOnImpact;
    component.onDestroy = newOnDestroy;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveProjectile() => this.RemoveComponent(59);

  public bool isRemainingMatchTime
  {
    get => this.HasComponent(60);
    set
    {
      if (value == this.isRemainingMatchTime)
        return;
      int index = 60;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.remainingMatchTimeComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public RemoteEntityLerpStateComponent remoteEntityLerpState => (RemoteEntityLerpStateComponent) this.GetComponent(84);

  public bool hasRemoteEntityLerpState => this.HasComponent(84);

  public void AddRemoteEntityLerpState(
    List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> newHistoryBuffer,
    List<RemoteEntityLerpSystem.RemoteStateLerpPair> newActiveLerpPairs,
    float newCurrentLerpTimestamp,
    FilteredFloat newSmoothedRTT)
  {
    int index = 84;
    RemoteEntityLerpStateComponent component = this.CreateComponent<RemoteEntityLerpStateComponent>(index);
    component.historyBuffer = newHistoryBuffer;
    component.activeLerpPairs = newActiveLerpPairs;
    component.currentLerpTimestamp = newCurrentLerpTimestamp;
    component.smoothedRTT = newSmoothedRTT;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceRemoteEntityLerpState(
    List<RemoteEntityLerpSystem.RemoteStateHistoryEntry> newHistoryBuffer,
    List<RemoteEntityLerpSystem.RemoteStateLerpPair> newActiveLerpPairs,
    float newCurrentLerpTimestamp,
    FilteredFloat newSmoothedRTT)
  {
    int index = 84;
    RemoteEntityLerpStateComponent component = this.CreateComponent<RemoteEntityLerpStateComponent>(index);
    component.historyBuffer = newHistoryBuffer;
    component.activeLerpPairs = newActiveLerpPairs;
    component.currentLerpTimestamp = newCurrentLerpTimestamp;
    component.smoothedRTT = newSmoothedRTT;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveRemoteEntityLerpState() => this.RemoveComponent(84);

  public RemoteTransformComponent remoteTransform => (RemoteTransformComponent) this.GetComponent(83);

  public bool hasRemoteTransform => this.HasComponent(83);

  public void AddRemoteTransform(TransformState newValue)
  {
    int index = 83;
    RemoteTransformComponent component = this.CreateComponent<RemoteTransformComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceRemoteTransform(TransformState newValue)
  {
    int index = 83;
    RemoteTransformComponent component = this.CreateComponent<RemoteTransformComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveRemoteTransform() => this.RemoveComponent(83);

  public bool isReplicate
  {
    get => this.HasComponent(61);
    set
    {
      if (value == this.isReplicate)
        return;
      int index = 61;
      if (value)
      {
        Stack<IComponent> componentPool = this.GetComponentPool(index);
        IComponent component = componentPool.Count > 0 ? componentPool.Pop() : (IComponent) GameEntity.replicateComponent;
        this.AddComponent(index, component);
      }
      else
        this.RemoveComponent(index);
    }
  }

  public RespawnRigidbodyComponent respawnRigidbody => (RespawnRigidbodyComponent) this.GetComponent(62);

  public bool hasRespawnRigidbody => this.HasComponent(62);

  public void AddRespawnRigidbody(JVector newPosition, JQuaternion newRotation)
  {
    int index = 62;
    RespawnRigidbodyComponent component = this.CreateComponent<RespawnRigidbodyComponent>(index);
    component.position = newPosition;
    component.rotation = newRotation;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceRespawnRigidbody(JVector newPosition, JQuaternion newRotation)
  {
    int index = 62;
    RespawnRigidbodyComponent component = this.CreateComponent<RespawnRigidbodyComponent>(index);
    component.position = newPosition;
    component.rotation = newRotation;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveRespawnRigidbody() => this.RemoveComponent(62);

  public RigidbodyComponent rigidbody => (RigidbodyComponent) this.GetComponent(63);

  public bool hasRigidbody => this.HasComponent(63);

  public void AddRigidbody(JRigidbody newValue, JVector newOffset)
  {
    int index = 63;
    RigidbodyComponent component = this.CreateComponent<RigidbodyComponent>(index);
    component.value = newValue;
    component.offset = newOffset;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceRigidbody(JRigidbody newValue, JVector newOffset)
  {
    int index = 63;
    RigidbodyComponent component = this.CreateComponent<RigidbodyComponent>(index);
    component.value = newValue;
    component.offset = newOffset;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveRigidbody() => this.RemoveComponent(63);

  public ScoreComponent score => (ScoreComponent) this.GetComponent(64);

  public bool hasScore => this.HasComponent(64);

  public void AddScore(
    Team newLastTeamThatScored,
    ulong newPlayerScored,
    Dictionary<Team, int> newScore)
  {
    int index = 64;
    ScoreComponent component = this.CreateComponent<ScoreComponent>(index);
    component.lastTeamThatScored = newLastTeamThatScored;
    component.playerScored = newPlayerScored;
    component.score = newScore;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceScore(
    Team newLastTeamThatScored,
    ulong newPlayerScored,
    Dictionary<Team, int> newScore)
  {
    int index = 64;
    ScoreComponent component = this.CreateComponent<ScoreComponent>(index);
    component.lastTeamThatScored = newLastTeamThatScored;
    component.playerScored = newPlayerScored;
    component.score = newScore;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveScore() => this.RemoveComponent(64);

  public SkillGraphComponent skillGraph => (SkillGraphComponent) this.GetComponent(65);

  public bool hasSkillGraph => this.HasComponent(65);

  public void AddSkillGraph(
    SkillGraphConfig[] newSkillGraphConfigs,
    SerializedSkillGraphInfo[] newSerializationLayout,
    SkillGraph[] newSkillGraphs,
    int newLockingGraph,
    GraphVarList newOwnerVars)
  {
    int index = 65;
    SkillGraphComponent component = this.CreateComponent<SkillGraphComponent>(index);
    component.skillGraphConfigs = newSkillGraphConfigs;
    component.serializationLayout = newSerializationLayout;
    component.skillGraphs = newSkillGraphs;
    component.lockingGraph = newLockingGraph;
    component.ownerVars = newOwnerVars;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSkillGraph(
    SkillGraphConfig[] newSkillGraphConfigs,
    SerializedSkillGraphInfo[] newSerializationLayout,
    SkillGraph[] newSkillGraphs,
    int newLockingGraph,
    GraphVarList newOwnerVars)
  {
    int index = 65;
    SkillGraphComponent component = this.CreateComponent<SkillGraphComponent>(index);
    component.skillGraphConfigs = newSkillGraphConfigs;
    component.serializationLayout = newSerializationLayout;
    component.skillGraphs = newSkillGraphs;
    component.lockingGraph = newLockingGraph;
    component.ownerVars = newOwnerVars;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSkillGraph() => this.RemoveComponent(65);

  public SkillUiComponent skillUi => (SkillUiComponent) this.GetComponent(66);

  public bool hasSkillUi => this.HasComponent(66);

  public void AddSkillUi(List<SkillUiStateData> newSkillUiStates, bool newShow)
  {
    int index = 66;
    SkillUiComponent component = this.CreateComponent<SkillUiComponent>(index);
    component.skillUiStates = newSkillUiStates;
    component.show = newShow;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSkillUi(List<SkillUiStateData> newSkillUiStates, bool newShow)
  {
    int index = 66;
    SkillUiComponent component = this.CreateComponent<SkillUiComponent>(index);
    component.skillUiStates = newSkillUiStates;
    component.show = newShow;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSkillUi() => this.RemoveComponent(66);

  public SomeoneScoredComponent someoneScored => (SomeoneScoredComponent) this.GetComponent(67);

  public bool hasSomeoneScored => this.HasComponent(67);

  public void AddSomeoneScored(ulong newPlayerScored, Team newTeam)
  {
    int index = 67;
    SomeoneScoredComponent component = this.CreateComponent<SomeoneScoredComponent>(index);
    component.playerScored = newPlayerScored;
    component.team = newTeam;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSomeoneScored(ulong newPlayerScored, Team newTeam)
  {
    int index = 67;
    SomeoneScoredComponent component = this.CreateComponent<SomeoneScoredComponent>(index);
    component.playerScored = newPlayerScored;
    component.team = newTeam;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSomeoneScored() => this.RemoveComponent(67);

  public SpawnPickupComponent spawnPickup => (SpawnPickupComponent) this.GetComponent(4);

  public bool hasSpawnPickup => this.HasComponent(4);

  public void AddSpawnPickup(
    JVector newPosition,
    PickupType newType,
    UniqueId newIdOfSpawnedPickup)
  {
    int index = 4;
    SpawnPickupComponent component = this.CreateComponent<SpawnPickupComponent>(index);
    component.position = newPosition;
    component.type = newType;
    component.idOfSpawnedPickup = newIdOfSpawnedPickup;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSpawnPickup(
    JVector newPosition,
    PickupType newType,
    UniqueId newIdOfSpawnedPickup)
  {
    int index = 4;
    SpawnPickupComponent component = this.CreateComponent<SpawnPickupComponent>(index);
    component.position = newPosition;
    component.type = newType;
    component.idOfSpawnedPickup = newIdOfSpawnedPickup;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSpawnPickup() => this.RemoveComponent(4);

  public SpawnPlayerComponent spawnPlayer => (SpawnPlayerComponent) this.GetComponent(68);

  public bool hasSpawnPlayer => this.HasComponent(68);

  public void AddSpawnPlayer(ulong newIndex, int newTeam)
  {
    int index = 68;
    SpawnPlayerComponent component = this.CreateComponent<SpawnPlayerComponent>(index);
    component.index = newIndex;
    component.team = newTeam;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSpawnPlayer(ulong newIndex, int newTeam)
  {
    int index = 68;
    SpawnPlayerComponent component = this.CreateComponent<SpawnPlayerComponent>(index);
    component.index = newIndex;
    component.team = newTeam;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSpawnPlayer() => this.RemoveComponent(68);

  public SpraytagComponent spraytag => (SpraytagComponent) this.GetComponent(69);

  public bool hasSpraytag => this.HasComponent(69);

  public void AddSpraytag(
    string newSpriteName,
    bool newIsActive,
    float newCooldown,
    float newElapsedCooldown,
    int newSpraytagIndex)
  {
    int index = 69;
    SpraytagComponent component = this.CreateComponent<SpraytagComponent>(index);
    component.spriteName = newSpriteName;
    component.isActive = newIsActive;
    component.cooldown = newCooldown;
    component.elapsedCooldown = newElapsedCooldown;
    component.spraytagIndex = newSpraytagIndex;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceSpraytag(
    string newSpriteName,
    bool newIsActive,
    float newCooldown,
    float newElapsedCooldown,
    int newSpraytagIndex)
  {
    int index = 69;
    SpraytagComponent component = this.CreateComponent<SpraytagComponent>(index);
    component.spriteName = newSpriteName;
    component.isActive = newIsActive;
    component.cooldown = newCooldown;
    component.elapsedCooldown = newElapsedCooldown;
    component.spraytagIndex = newSpraytagIndex;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveSpraytag() => this.RemoveComponent(69);

  public StatusEffectComponent statusEffect => (StatusEffectComponent) this.GetComponent(70);

  public bool hasStatusEffect => this.HasComponent(70);

  public void AddStatusEffect(
    List<StatusEffect> newEffects,
    StatusModifier newModifierStack,
    StatusEffectType newEffectStack)
  {
    int index = 70;
    StatusEffectComponent component = this.CreateComponent<StatusEffectComponent>(index);
    component.effects = newEffects;
    component.modifierStack = newModifierStack;
    component.effectStack = newEffectStack;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceStatusEffect(
    List<StatusEffect> newEffects,
    StatusModifier newModifierStack,
    StatusEffectType newEffectStack)
  {
    int index = 70;
    StatusEffectComponent component = this.CreateComponent<StatusEffectComponent>(index);
    component.effects = newEffects;
    component.modifierStack = newModifierStack;
    component.effectStack = newEffectStack;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveStatusEffect() => this.RemoveComponent(70);

  public TransformComponent transform => (TransformComponent) this.GetComponent(71);

  public bool hasTransform => this.HasComponent(71);

  public void AddTransform(JVector newPosition, JQuaternion newRotation)
  {
    int index = 71;
    TransformComponent component = this.CreateComponent<TransformComponent>(index);
    component.position = newPosition;
    component.rotation = newRotation;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceTransform(JVector newPosition, JQuaternion newRotation)
  {
    int index = 71;
    TransformComponent component = this.CreateComponent<TransformComponent>(index);
    component.position = newPosition;
    component.rotation = newRotation;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveTransform() => this.RemoveComponent(71);

  public TriggerEnterEventComponent triggerEnterEvent => (TriggerEnterEventComponent) this.GetComponent(72);

  public bool hasTriggerEnterEvent => this.HasComponent(72);

  public void AddTriggerEnterEvent(
    JRigidbody newFirst,
    JRigidbody newSecond,
    JVector newNormal,
    float newPenetration)
  {
    int index = 72;
    TriggerEnterEventComponent component = this.CreateComponent<TriggerEnterEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    component.normal = newNormal;
    component.penetration = newPenetration;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceTriggerEnterEvent(
    JRigidbody newFirst,
    JRigidbody newSecond,
    JVector newNormal,
    float newPenetration)
  {
    int index = 72;
    TriggerEnterEventComponent component = this.CreateComponent<TriggerEnterEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    component.normal = newNormal;
    component.penetration = newPenetration;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveTriggerEnterEvent() => this.RemoveComponent(72);

  public TriggerEventComponent triggerEvent => (TriggerEventComponent) this.GetComponent(73);

  public bool hasTriggerEvent => this.HasComponent(73);

  public void AddTriggerEvent(
    JTriggerPair newBodies,
    int newFirstCollisionFrame,
    int newLastCollisionFrame)
  {
    int index = 73;
    TriggerEventComponent component = this.CreateComponent<TriggerEventComponent>(index);
    component.bodies = newBodies;
    component.firstCollisionFrame = newFirstCollisionFrame;
    component.lastCollisionFrame = newLastCollisionFrame;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceTriggerEvent(
    JTriggerPair newBodies,
    int newFirstCollisionFrame,
    int newLastCollisionFrame)
  {
    int index = 73;
    TriggerEventComponent component = this.CreateComponent<TriggerEventComponent>(index);
    component.bodies = newBodies;
    component.firstCollisionFrame = newFirstCollisionFrame;
    component.lastCollisionFrame = newLastCollisionFrame;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveTriggerEvent() => this.RemoveComponent(73);

  public TriggerExitEventComponent triggerExitEvent => (TriggerExitEventComponent) this.GetComponent(74);

  public bool hasTriggerExitEvent => this.HasComponent(74);

  public void AddTriggerExitEvent(JRigidbody newFirst, JRigidbody newSecond)
  {
    int index = 74;
    TriggerExitEventComponent component = this.CreateComponent<TriggerExitEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceTriggerExitEvent(JRigidbody newFirst, JRigidbody newSecond)
  {
    int index = 74;
    TriggerExitEventComponent component = this.CreateComponent<TriggerExitEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveTriggerExitEvent() => this.RemoveComponent(74);

  public TriggerStayEventComponent triggerStayEvent => (TriggerStayEventComponent) this.GetComponent(75);

  public bool hasTriggerStayEvent => this.HasComponent(75);

  public void AddTriggerStayEvent(JRigidbody newFirst, JRigidbody newSecond)
  {
    int index = 75;
    TriggerStayEventComponent component = this.CreateComponent<TriggerStayEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceTriggerStayEvent(JRigidbody newFirst, JRigidbody newSecond)
  {
    int index = 75;
    TriggerStayEventComponent component = this.CreateComponent<TriggerStayEventComponent>(index);
    component.first = newFirst;
    component.second = newSecond;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveTriggerStayEvent() => this.RemoveComponent(75);

  public UniqueIdComponent uniqueId => (UniqueIdComponent) this.GetComponent(82);

  public bool hasUniqueId => this.HasComponent(82);

  public void AddUniqueId(UniqueId newId)
  {
    int index = 82;
    UniqueIdComponent component = this.CreateComponent<UniqueIdComponent>(index);
    component.id = newId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceUniqueId(UniqueId newId)
  {
    int index = 82;
    UniqueIdComponent component = this.CreateComponent<UniqueIdComponent>(index);
    component.id = newId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveUniqueId() => this.RemoveComponent(82);

  public UnityViewComponent unityView => (UnityViewComponent) this.GetComponent(81);

  public bool hasUnityView => this.HasComponent(81);

  public void AddUnityView(GameObject newGameObject)
  {
    int index = 81;
    UnityViewComponent component = this.CreateComponent<UnityViewComponent>(index);
    component.gameObject = newGameObject;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceUnityView(GameObject newGameObject)
  {
    int index = 81;
    UnityViewComponent component = this.CreateComponent<UnityViewComponent>(index);
    component.gameObject = newGameObject;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveUnityView() => this.RemoveComponent(81);

  public VelocityOverrideComponent velocityOverride => (VelocityOverrideComponent) this.GetComponent(76);

  public bool hasVelocityOverride => this.HasComponent(76);

  public void AddVelocityOverride(JVector newValue)
  {
    int index = 76;
    VelocityOverrideComponent component = this.CreateComponent<VelocityOverrideComponent>(index);
    component.value = newValue;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceVelocityOverride(JVector newValue)
  {
    int index = 76;
    VelocityOverrideComponent component = this.CreateComponent<VelocityOverrideComponent>(index);
    component.value = newValue;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveVelocityOverride() => this.RemoveComponent(76);

  public VfxComponent vfx => (VfxComponent) this.GetComponent(77);

  public bool hasVfx => this.HasComponent(77);

  public void AddVfx(ushort newId)
  {
    int index = 77;
    VfxComponent component = this.CreateComponent<VfxComponent>(index);
    component.id = newId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceVfx(ushort newId)
  {
    int index = 77;
    VfxComponent component = this.CreateComponent<VfxComponent>(index);
    component.id = newId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveVfx() => this.RemoveComponent(77);

  public VictorySpawnPointComponent victorySpawnPoint => (VictorySpawnPointComponent) this.GetComponent(78);

  public bool hasVictorySpawnPoint => this.HasComponent(78);

  public void AddVictorySpawnPoint(
    Team newTeam,
    SpawnPositionType newSpawnPosition,
    ulong newPlayerId)
  {
    int index = 78;
    VictorySpawnPointComponent component = this.CreateComponent<VictorySpawnPointComponent>(index);
    component.team = newTeam;
    component.spawnPosition = newSpawnPosition;
    component.playerId = newPlayerId;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceVictorySpawnPoint(
    Team newTeam,
    SpawnPositionType newSpawnPosition,
    ulong newPlayerId)
  {
    int index = 78;
    VictorySpawnPointComponent component = this.CreateComponent<VictorySpawnPointComponent>(index);
    component.team = newTeam;
    component.spawnPosition = newSpawnPosition;
    component.playerId = newPlayerId;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveVictorySpawnPoint() => this.RemoveComponent(78);

  public VisualSmoothingComponent visualSmoothing => (VisualSmoothingComponent) this.GetComponent(79);

  public bool hasVisualSmoothing => this.HasComponent(79);

  public void AddVisualSmoothing(float newLerpFactor)
  {
    int index = 79;
    VisualSmoothingComponent component = this.CreateComponent<VisualSmoothingComponent>(index);
    component.lerpFactor = newLerpFactor;
    this.AddComponent(index, (IComponent) component);
  }

  public void ReplaceVisualSmoothing(float newLerpFactor)
  {
    int index = 79;
    VisualSmoothingComponent component = this.CreateComponent<VisualSmoothingComponent>(index);
    component.lerpFactor = newLerpFactor;
    this.ReplaceComponent(index, (IComponent) component);
  }

  public void RemoveVisualSmoothing() => this.RemoveComponent(79);
}
