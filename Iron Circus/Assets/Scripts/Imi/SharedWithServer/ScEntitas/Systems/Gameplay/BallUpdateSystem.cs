// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Gameplay.BallUpdateSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.ScEntitas.Systems.Gameplay;
using SharedWithServer.ScEvents;
using System;

namespace Imi.SharedWithServer.ScEntitas.Systems.Gameplay
{
  public class BallUpdateSystem : ExecuteGameSystem
  {
    private readonly IGroup<GameEntity> balls;
    private readonly IGroup<GameEntity> players;
    private static BallConfig ballConfig;
    private readonly Events events;
    private static BumperConfig bumperConfig;
    private const bool IsServer = false;

    public BallUpdateSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.balls = this.gameContext.GetGroup(GameMatcher.Ball);
      this.players = this.gameContext.GetGroup(GameMatcher.Player);
      BallUpdateSystem.bumperConfig = entitasSetup.ConfigProvider.bumperConfig;
      BallUpdateSystem.ballConfig = entitasSetup.ConfigProvider.ballConfig;
      this.events = entitasSetup.Events;
    }

    protected override void GameExecute()
    {
      foreach (GameEntity ball in this.balls)
      {
        this.HandleBallOwnership(ball);
        if (!ball.hasBallOwner)
        {
          this.SimplifiedUpdateBallFlight(ball);
        }
        else
        {
          ball.ReplaceVelocityOverride(JVector.Zero);
          ball.rigidbody.value.LinearVelocity = JVector.Zero;
        }
      }
    }

    private void HandleBallOwnership(GameEntity ball)
    {
      if (this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress && this.gameContext.matchState.value != Imi.SharedWithServer.Game.MatchState.StartPoint)
      {
        if (!ball.hasBallOwner)
          return;
        this.gameContext.eventDispatcher.value.EnqueueBallDrop(ball.ballOwner.playerId);
        ball.RemoveBallOwner();
      }
      else
      {
        if (!ball.hasBallOwner && !ball.isBallHitDisabled)
        {
          foreach (GameEntity entity in this.players.GetEntities())
          {
            if (entity.isLocalEntity && this.IsBallInReach(entity) && !entity.CannotHoldBall())
            {
              BallUpdateSystem.SetBallOwner(this.gameContext, ball, entity);
              break;
            }
          }
        }
        else if (ball.hasBallOwner)
        {
          GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(ball.ballOwner.playerId);
          if (entityWithPlayerId == null || entityWithPlayerId.CannotHoldBall() || ball.isBallHitDisabled)
          {
            this.gameContext.eventDispatcher.value.EnqueueBallDrop(ball.ballOwner.playerId);
            ball.RemoveBallOwner();
          }
          else
            ball.ReplaceTransform(entityWithPlayerId.transform.position, entityWithPlayerId.transform.rotation);
        }
        if (ball.hasBallOwner)
        {
          ball.rigidbody.value.CollisionLayer = 0;
          ball.rigidbody.value.CollisionMask = 4096;
        }
        else
          BallCreateSystem.SetCollisionLayerAndMask(ball.rigidbody.value);
      }
    }

    private bool IsBallInReach(GameEntity player)
    {
      JVector position1 = player.transform.position;
      GameEntity ballEntity = this.gameContext.ballEntity;
      JVector position2 = ballEntity.transform.position;
      position1.Y = position2.Y = 0.0f;
      float ballPickupRadius = BallUpdateSystem.ballConfig.ballPickupRadius;
      float t = JMath.Clamp01((float) (((double) ballEntity.velocityOverride.value.Length() - (double) BallUpdateSystem.ballConfig.ballLowSpeedStartEffectThreshold) / ((double) BallUpdateSystem.ballConfig.ballLowSpeedFullEffectThreshold - (double) BallUpdateSystem.ballConfig.ballLowSpeedStartEffectThreshold)));
      float num1 = JMath.Lerp(ballPickupRadius, BallUpdateSystem.ballConfig.ballLowSpeedPickupRadius, t);
      float num2 = player.championConfig.value.ballPickupRange + num1;
      bool flag = BallUpdateSystem.PlayerJustThrewBall(this.gameContext, player);
      return (double) JVector.Subtract(position2, position1).Length() < (double) num2 && !flag;
    }

    private static bool PlayerJustThrewBall(GameContext gameContext, GameEntity player)
    {
      JVector position1 = player.transform.position;
      GameEntity ballEntity = gameContext.ballEntity;
      JVector position2 = ballEntity.transform.position;
      position1.Y = position2.Y = 0.0f;
      JVector vector2 = (position2 - position1).Normalized();
      bool flag1 = (double) JVector.Dot(ballEntity.velocityOverride.value.Normalized(), vector2) > 0.0;
      bool flag2 = ballEntity.hasBallFlightInfo && (double) ballEntity.ballFlightInfo.traveledDistance < 2.5;
      return ((!gameContext.hasLastBallContact ? 0 : ((long) gameContext.lastBallContact.playerId == (long) player.playerId.value ? 1 : 0)) & (flag1 ? 1 : 0) & (flag2 ? 1 : 0)) != 0;
    }

    public static void SetBallOwner(GameContext gameContext, GameEntity ball, GameEntity player)
    {
      ball.ReplaceBallOwner(player.playerId.value);
      gameContext.eventDispatcher.value.EnqueueBallPickup(player.playerId.value, player.playerTeam.value, ball.rigidbody.value.LinearVelocity.Length());
      ball.rigidbody.value.CollisionLayer = 0;
      ball.rigidbody.value.CollisionMask = 0;
      ball.rigidbody.value.LinearVelocity = JVector.Zero;
      if (ball.hasBallFlight)
        ball.RemoveBallFlight();
      ball.ReplaceBallFlightInfo(0.0f, 0.0f);
      gameContext.ReplaceLastBallContact(player.playerId.value);
    }

    private float GetRadius(GameEntity ballEntity) => ((SphereShape) ballEntity.rigidbody.value.Shape).Radius;

    public static void ThrowBall(
      Events events,
      GameContext gameContext,
      GameEntity owner,
      JVector velocity)
    {
      GameEntity ballEntity = gameContext.ballEntity;
      if (!gameContext.globalTime.isReprediction)
      {
        gameContext.ReplaceLastBallContact(owner.playerId.value);
        gameContext.eventDispatcher.value.EnqueueBallThrow(owner.playerId.value, owner.playerTeam.value);
      }
      float radius = ((SphereShape) ballEntity.rigidbody.value.Shape).Radius;
      float checkDistance = radius + owner.championConfig.value.ballPickupRange;
      JVector currentDir = velocity.Normalized();
      currentDir.Y = 0.0f;
      JVector position2D = owner.transform.Position2D;
      JVector resultPosition = BallUpdateSystem.CollisionCheck(events, gameContext, position2D, currentDir, checkDistance, radius, new BallUpdateSystem.CollisionCallback(BallUpdateSystem.BallCollisionCallback), owner.rigidbody.value).resultPosition;
      resultPosition.Y = 0.0f;
      ballEntity.TransformReplacePosition(resultPosition);
      ballEntity.RemoveBallOwner();
      ballEntity.ReplaceVelocityOverride(velocity);
      ballEntity.ReplaceBallFlightInfo(0.0f, 0.0f);
      owner.ReplaceLastBallThrow(gameContext.globalTime.currentTick, resultPosition, velocity);
    }

    private void SimplifiedUpdateBallFlight(GameEntity ballEntity)
    {
      float fixedSimTimeStep = this.gameContext.globalTime.fixedSimTimeStep;
      float newFlightDurationSeconds = ballEntity.ballFlightInfo.flightDurationSeconds + fixedSimTimeStep;
      this.HandleBallImpulse(ballEntity);
      JVector vector = ballEntity.velocityOverride.value;
      JVector position = ballEntity.transform.position;
      float radius = this.GetRadius(ballEntity);
      JVector newPosition = position;
      float num1 = vector.Length();
      JVector jvector;
      if ((double) num1 > (double) BallUpdateSystem.ballConfig.restThresholdVelocity)
      {
        JVector currentDir = vector.Normalized();
        float checkDistance = num1 * fixedSimTimeStep;
        SphereCastResult sphereCastResult = BallUpdateSystem.CollisionCheck(this.events, this.gameContext, position, currentDir, checkDistance, radius, new BallUpdateSystem.CollisionCallback(BallUpdateSystem.BallCollisionCallback));
        if (sphereCastResult.collided)
        {
          float num2 = fixedSimTimeStep * sphereCastResult.collisionFraction;
          this.gameContext.ballEntity.positionTimeline.value.Add(ScTime.TicksToMillis(this.gameContext.globalTime.currentTick, this.gameContext.globalTime.fixedSimTimeStep) + num2, sphereCastResult.contactPosition);
        }
        float t1 = JMath.Clamp01(newFlightDurationSeconds / BallUpdateSystem.ballConfig.dragAfterForceDuration);
        float t2 = BallUpdateSystem.ballConfig.dragAfterForceCurve.Evaluate(t1);
        float num3 = JMath.Lerp(BallUpdateSystem.ballConfig.dragAfterForce, BallUpdateSystem.ballConfig.defaultFlightDrag, t2);
        float num4 = num1 * (float) Math.Pow((double) num3, (double) fixedSimTimeStep);
        jvector = sphereCastResult.reflectedDirection * num4;
        newPosition = sphereCastResult.resultPosition;
        newPosition.Y = 0.0f;
      }
      else
        jvector = JVector.Zero;
      ballEntity.ReplaceVelocityOverride(jvector.IsNearlyZero() ? JVector.Zero : jvector);
      ballEntity.TransformReplacePosition(newPosition);
      ballEntity.positionTimeline.value.Add(ScTime.TicksToMillis(this.gameContext.globalTime.currentTick + 1, this.gameContext.globalTime.fixedSimTimeStep), newPosition);
      float newTraveledDistance = ballEntity.ballFlightInfo.traveledDistance + vector.Length() * fixedSimTimeStep;
      ballEntity.ReplaceBallFlightInfo(newTraveledDistance, newFlightDurationSeconds);
      if (ballEntity.isBallHitDisabled && (double) newTraveledDistance > (double) BallUpdateSystem.ballConfig.blockPickupTravelDistance)
        ballEntity.isBallHitDisabled = false;
      this.HandleBallImpulse(ballEntity);
    }

    private void HandleBallImpulse(GameEntity ballEntity)
    {
      if (!ballEntity.hasBallImpulse)
        return;
      if (!ballEntity.ballImpulse.value.IsNearlyZero())
      {
        JVector newValue = ballEntity.ballImpulse.value;
        ballEntity.ReplaceVelocityOverride(newValue);
        ballEntity.ReplaceBallFlightInfo(0.0f, 0.0f);
      }
      ballEntity.RemoveBallImpulse();
    }

    public static SphereCastResult CollisionCheck(
      Events events,
      GameContext gameContext,
      JVector currentPosition,
      JVector currentDir,
      float checkDistance,
      float ballRadius,
      BallUpdateSystem.CollisionCallback collisionCallback,
      params JRigidbody[] ignore)
    {
      Func<JRigidbody, bool> rigidbodyFilter = (Func<JRigidbody, bool>) (collider => BallUpdateSystem.DoCollisionResolve(gameContext, collider));
      int ballCollisionMask = CollisionLayerUtils.GetBallCollisionMask();
      int num = 10;
      SphereCastResult sphereCastResult;
      do
      {
        sphereCastResult = ContinuousPhysicsUtils.SphereCast(gameContext, currentPosition, currentDir, checkDistance, ballRadius, 512, ballCollisionMask, rigidbodyFilter, ignore: ignore);
        if (sphereCastResult.collided && collisionCallback != null)
          sphereCastResult = collisionCallback(events, gameContext, sphereCastResult);
        currentPosition = sphereCastResult.contactPosition;
        currentDir = sphereCastResult.reflectedDirection;
        checkDistance = sphereCastResult.reflectedLength;
        --num;
      }
      while (sphereCastResult.collided && (double) sphereCastResult.collisionFraction >= 1.0 && num > 0);
      return sphereCastResult;
    }

    private static bool DoCollisionResolve(GameContext gameContext, JRigidbody collider)
    {
      GameEntity entityWithRigidbody = gameContext.GetFirstEntityWithRigidbody(collider);
      GameEntity ballEntity = gameContext.ballEntity;
      bool flag1 = entityWithRigidbody != null && entityWithRigidbody.isPlayer;
      bool flag2 = !ballEntity.hasBallOwner && !ballEntity.isBallHitDisabled;
      int num1 = entityWithRigidbody.isLocalEntity ? 1 : 0;
      bool flag3 = false;
      int num2 = flag1 ? 1 : 0;
      if ((num1 & num2) != 0)
      {
        bool flag4 = BallUpdateSystem.PlayerJustThrewBall(gameContext, entityWithRigidbody);
        if (flag2 && !entityWithRigidbody.CannotHoldBall() && !flag4)
          BallUpdateSystem.SetBallOwner(gameContext, ballEntity, entityWithRigidbody);
        else if (flag4)
          flag3 = true;
      }
      return !collider.IsTrigger && !flag3;
    }

    private static SphereCastResult BallCollisionCallback(
      Events events,
      GameContext gameContext,
      SphereCastResult sphereCastResult)
    {
      SphereCastResult sphereCastResult1 = sphereCastResult;
      JRigidbody collRb = sphereCastResult.collRb;
      GameEntity ballEntity = gameContext.ballEntity;
      GameEntity entityWithRigidbody = gameContext.GetFirstEntityWithRigidbody(collRb);
      if (entityWithRigidbody != null && entityWithRigidbody.hasBumper)
      {
        JVector position = entityWithRigidbody.rigidbody.value.Position;
        JVector contactPosition = sphereCastResult.contactPosition;
        position.Y = 0.0f;
        contactPosition.Y = 0.0f;
        JVector jvector = contactPosition - position;
        jvector.Normalize();
        JVector inVector = ballEntity.velocityOverride.value;
        JVector vector = inVector.Reflect(jvector);
        JVector newValue = vector.Normalized() * inVector.Length() * BallUpdateSystem.bumperConfig.friction + jvector * BallUpdateSystem.bumperConfig.force;
        ballEntity.ReplaceBallImpulse(newValue);
        sphereCastResult1.reflectedDirection = vector.Normalized();
        sphereCastResult1.reflectedLength = (float) ((double) vector.Length() * (double) gameContext.globalTime.fixedSimTimeStep * (1.0 - (double) sphereCastResult.collisionFraction));
        sphereCastResult1.resultPosition = sphereCastResult1.contactPosition + sphereCastResult1.reflectedDirection * sphereCastResult1.reflectedLength;
        if (events != null)
        {
          events.FireEventBumperBallCollision(entityWithRigidbody.uniqueId.id, sphereCastResult.contactPosition, jvector);
          gameContext.eventDispatcher.value.EnqueueBallToBumperCollision(entityWithRigidbody.uniqueId.id, entityWithRigidbody.bumper.type);
        }
      }
      if (events != null)
      {
        if (entityWithRigidbody != null)
        {
          if (!entityWithRigidbody.hasBumper && !entityWithRigidbody.isPlayer && !gameContext.globalTime.isReprediction)
          {
            events.FireEventBallTerrainCollision(entityWithRigidbody.uniqueId.id, entityWithRigidbody.rigidbody.value.Position, sphereCastResult1.normal);
            gameContext.eventDispatcher.value.EnqueueBallToBoundsCollision();
          }
          else if (entityWithRigidbody.isPlayer && entityWithRigidbody.hasPlayerTeam)
            gameContext.eventDispatcher.value.EnqueueBallToPlayerCollision(entityWithRigidbody.playerId.value, entityWithRigidbody.playerTeam.value);
        }
        JVector contactPoint1 = sphereCastResult.contactPoint;
        JVector contactPoint2 = sphereCastResult.contactPoint;
        JVector normal = sphereCastResult.normal;
        float penetration = sphereCastResult.penetration;
        if (collRb.IsTrigger)
          CollisionUtils.CreateTriggerEvent(gameContext, ballEntity.rigidbody.value, collRb, contactPoint1, contactPoint2, normal, penetration);
        else
          CollisionUtils.CreateCollisionEvent(gameContext, ballEntity.rigidbody.value, collRb, contactPoint1, contactPoint2, normal, penetration);
      }
      return sphereCastResult1;
    }

    public delegate SphereCastResult CollisionCallback(
      Events events,
      GameContext gameContext,
      SphereCastResult sphereCastResult);
  }
}
