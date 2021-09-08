// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.BaseAI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.Collision;
using Jitter.Dynamics;
using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI
{
  public class BaseAI
  {
    protected Random random = new Random();
    protected GameEntity ownerEntity;
    protected AICache cache;
    protected GameContext context;
    protected BallConfig ballConfig;
    protected AIDifficulty difficulty;
    protected AIRole role;
    public bool penalizePassingToBots = true;
    public bool canSampleGeometryGoals = true;
    public float scaleGoalPredictionTime = 1f;
    private float scaleMinChargeLevels = 1.1f;
    private float backPassAttenuationStartDistance = 7f;
    private float backPassAttenuationFullDistance = 25f;
    private float backPassMaxAttenuation = 0.25f;
    private float backPassAttenuationPow = 2f;
    private float passTargetCloseToEnemyAttenuation = 0.5f;
    private float passTargetCloseToEnemyAttenuationFullDistance = 2f;
    private float passTargetCloseToEnemyAttenuationStartDistance = 4f;
    private List<float> samplePass_enemyProbabilities = new List<float>();
    private List<float> samplePass_friendProbabilities = new List<float>();
    private List<JVector> samplePass_OpponentPositions = new List<JVector>(3);
    private List<float> samplePass_OpponentMoveSpeeds = new List<float>(3);
    private List<JVector> samplePass_TMPositions = new List<JVector>(3);
    private List<float> samplePass_TMMoveSpeeds = new List<float>(3);
    private List<GameEntity> samplePass_CollidedTriggers = new List<GameEntity>(2);
    private List<float> sampleGoalShot_InterceptProbabilities = new List<float>(6);
    private List<JVector> sampleGoalShot_OpponentPositions = new List<JVector>(3);
    private List<float> sampleGoalShot_OpponentMoveSpeeds = new List<float>(3);
    private List<GameEntity> predictBallPosition_Triggers = new List<GameEntity>();

    public GameEntity OwnerEntity => this.ownerEntity;

    public AIDifficulty Difficulty => this.difficulty;

    public AIRole Role => this.role;

    public BaseAI(GameEntity playerEntity, AIDifficulty difficulty, AIRole role, AICache cache)
    {
      this.ownerEntity = playerEntity;
      this.difficulty = difficulty;
      this.role = role;
      this.cache = cache;
      cache.RegisterUser(this);
      this.context = cache.Context;
      this.ballConfig = cache.BallConfig;
      this.SetupDifficulty();
      this.SetupRole();
    }

    protected virtual void SetupDifficulty()
    {
    }

    protected virtual void SetupRole()
    {
    }

    public virtual void ShutDown() => this.cache.UnregisterUser(this);

    public virtual void Tick(ref Input input) => this.cache.Validate();

    public bool InterceptBall(
      GameEntity player,
      JVector ballPos,
      JVector ballVelocity,
      bool sprint,
      out JVector moveDir,
      out float timeToReach,
      float sampleInterval = 0.4f,
      float maxSearchTime = 2.5f)
    {
      JVector position2D = player.transform.Position2D;
      float num1 = sprint ? this.cache.GetSprintSpeed(player) : player.championConfig.value.maxSpeed;
      if ((double) ballVelocity.Length() < 1.0)
      {
        JVector vector = ballPos - position2D;
        float num2 = vector.Length();
        timeToReach = num2 / num1;
        moveDir = vector.Normalized();
        return true;
      }
      for (float num3 = 0.0f; (double) num3 <= (double) maxSearchTime; num3 += sampleInterval)
      {
        JVector jvector1 = ballPos;
        JVector startVelocity = ballVelocity;
        this.PredictBallPosition(jvector1, startVelocity, sampleInterval, out ballPos, out ballVelocity);
        float fract;
        JVector jvector2 = JitterUtils.NearestPointOnSegment(position2D, jvector1, ballPos, out fract);
        float num4 = num3 + sampleInterval * fract;
        JVector jvector3 = position2D;
        JVector jvector4 = jvector2 - jvector3;
        float num5 = JMath.Max(jvector4.Length(), 1f / 1000f);
        float num6 = num5 / num1;
        if ((double) num6 <= (double) num4)
        {
          moveDir = jvector4 * (1f / num5);
          timeToReach = num6;
          return true;
        }
      }
      moveDir = (ballPos - position2D).Normalized();
      timeToReach = maxSearchTime;
      return false;
    }

    public void FindBestPass(
      GameEntity instigator,
      out GameEntity target,
      List<GameEntity> opponents,
      List<GameEntity> teamMates,
      bool penalizeBots,
      out JVector aimDir,
      out float charge,
      out float confidence)
    {
      target = (GameEntity) null;
      aimDir = JVector.Forward;
      charge = 0.0f;
      confidence = 0.0f;
      float num1 = 0.8f;
      float z1 = instigator.playerTeam.value == Team.Alpha ? 1f : -1f;
      float z2 = instigator.transform.Position2D.Z;
      float num2 = this.backPassAttenuationFullDistance - this.backPassAttenuationStartDistance;
      float[] numArray = new float[3]{ 0.0f, 0.5f, 1f };
      foreach (float charge1 in numArray)
      {
        for (int index = 0; index < teamMates.Count; ++index)
        {
          GameEntity teamMate = teamMates[index];
          JVector aimDir1;
          float confidence1;
          this.FindBestPassForTarget(instigator, teamMate, opponents, teamMates, charge1, out aimDir1, out confidence1);
          if (penalizeBots && this.IsBot(teamMate))
            confidence1 *= num1;
          float num3 = this.backPassMaxAttenuation + JMath.Pow(JMath.Clamp01((float) (1.0 - ((double) ((float) -((double) teamMate.transform.Position2D.Z - (double) z2) * z1) - (double) this.backPassAttenuationStartDistance) / (double) num2)), this.backPassAttenuationPow) * (1f - this.backPassMaxAttenuation);
          confidence1 *= num3;
          if ((double) confidence1 > (double) confidence)
          {
            confidence = confidence1;
            charge = JMath.Min(charge1 * this.scaleMinChargeLevels, 1f);
            aimDir = aimDir1;
            if ((double) confidence == 1.0)
              return;
          }
        }
      }
      if ((double) confidence >= 0.600000023841858)
        return;
      int num4 = 4;
      JVector dir = new JVector(0.0f, 0.0f, z1);
      float num5 = -JMath.Sign(instigator.transform.position.X) * z1;
      float min = 40f;
      float max = 70f;
      float ballHitVelocityMax = this.cache.GetThrowBallConfig(instigator).ballHitVelocityMax;
      float shotDuration = 2f;
      for (int index = 0; index < num4; ++index)
      {
        JVector aimDir2 = JitterUtils.Rotate2D(dir, this.RandomFloat(min, max) * num5);
        float confidence2;
        this.SamplePass(instigator, opponents, teamMates, ballHitVelocityMax, shotDuration, 0.4f, aimDir2, out confidence2);
        if ((double) confidence2 > (double) confidence)
        {
          confidence = confidence2;
          charge = 1f;
          aimDir = aimDir2;
          if ((double) confidence == 1.0)
            break;
        }
      }
    }

    public void FindBestPassForTarget(
      GameEntity instigator,
      GameEntity target,
      List<GameEntity> opponents,
      List<GameEntity> teamMates,
      float charge,
      out JVector aimDir,
      out float confidence)
    {
      float shotDuration = 2f;
      aimDir = JVector.Forward;
      confidence = 0.0f;
      if (instigator == target)
        return;
      JVector position2D1 = instigator.transform.Position2D;
      JVector position2D2 = target.transform.Position2D;
      float distance = (position2D2 - position2D1).Length();
      ThrowBallConfig throwBallConfig = this.cache.GetThrowBallConfig(instigator);
      float num1 = JMath.Lerp(throwBallConfig.ballHitVelocityMin, throwBallConfig.ballHitVelocityMax, charge);
      bool reachesDistance;
      float result;
      this.CalcBallTravelTime(num1, distance, out reachesDistance, out result);
      if (!reachesDistance)
        return;
      float max1 = (float) ((double) target.championConfig.value.maxSpeed * (double) result * 0.75);
      int num2 = 4;
      JVector forward = target.transform.Forward;
      float max2 = 60f;
      float num3 = this.passTargetCloseToEnemyAttenuationFullDistance - this.passTargetCloseToEnemyAttenuationStartDistance;
      float num4 = 1f;
      for (int index = 0; index < opponents.Count; ++index)
      {
        float num5 = JMath.Lerp(1f, this.passTargetCloseToEnemyAttenuation, JMath.Clamp01(((opponents[index].transform.Position2D - position2D2).Length() - this.passTargetCloseToEnemyAttenuationStartDistance) / num3));
        num4 *= num5;
      }
      for (int index = 0; index < num2; ++index)
      {
        JVector b1 = JitterUtils.Rotate2D(forward * this.RandomFloat(max: max1), this.RandomFloat(-max2, max2));
        float num6 = JVector.Angle(forward, b1);
        float b2 = 0.75f;
        float num7 = 30f;
        float num8 = 90f;
        float num9 = JMath.Lerp(1f, b2, JMath.Clamp01((float) (((double) num6 - (double) num7) / ((double) num8 - (double) num7))));
        JVector b3 = b1 * num9;
        float num10 = JVector.Angle(new JVector(0.0f, 0.0f, instigator.playerTeam.value == Team.Alpha ? 1f : -1f), b3);
        float b4 = 0.5f;
        float num11 = 90f;
        float num12 = 180f;
        float num13 = JMath.Lerp(1f, b4, JMath.Clamp01((float) (((double) num10 - (double) num11) / ((double) num12 - (double) num11))));
        JVector jvector = b3 * num13;
        JVector aimDir1 = (position2D2 + jvector - position2D1).Normalized();
        if (!aimDir1.IsNearlyZero())
        {
          float confidence1;
          this.SamplePass(instigator, opponents, teamMates, num1, shotDuration, 0.4f, aimDir1, out confidence1);
          confidence1 *= num4;
          if ((double) confidence1 > (double) confidence)
          {
            confidence = confidence1;
            aimDir = aimDir1;
            if ((double) confidence == 1.0)
              break;
          }
        }
      }
    }

    public void SamplePass(
      GameEntity instigator,
      List<GameEntity> opponents,
      List<GameEntity> teamMates,
      float throwSpeed,
      float shotDuration,
      float sampleInterval,
      JVector aimDir,
      out float confidence)
    {
      float num1 = instigator.championConfig.value.ballPickupRange + this.ballConfig.ballPickupRadius;
      float pickupRadiusSquared = num1 * num1;
      GameEntity ownGoal = this.cache.GetOwnGoal(instigator);
      confidence = 0.0f;
      float num2 = 0.2f;
      float num3 = 0.7f;
      float a = 10f;
      JVector jvector = instigator.transform.Position2D;
      JVector startVelocity = aimDir * throwSpeed;
      int num4 = (int) ((double) shotDuration / (double) sampleInterval);
      this.samplePass_enemyProbabilities.Clear();
      this.samplePass_friendProbabilities.Clear();
      this.samplePass_OpponentPositions.Clear();
      this.samplePass_OpponentMoveSpeeds.Clear();
      this.samplePass_TMPositions.Clear();
      this.samplePass_TMMoveSpeeds.Clear();
      for (int index = 0; index < opponents.Count; ++index)
      {
        GameEntity opponent = opponents[index];
        this.samplePass_enemyProbabilities.Add(0.0f);
        this.samplePass_OpponentPositions.Add(opponent.transform.Position2D);
        this.samplePass_OpponentMoveSpeeds.Add(this.cache.GetSprintSpeed(opponent));
      }
      for (int index = 0; index < teamMates.Count; ++index)
      {
        GameEntity teamMate = teamMates[index];
        this.samplePass_friendProbabilities.Add(0.0f);
        this.samplePass_TMPositions.Add(teamMate.transform.Position2D);
        this.samplePass_TMMoveSpeeds.Add(teamMate.championConfig.value.maxSpeed);
      }
      for (int index1 = 0; index1 < num4; ++index1)
      {
        JVector position;
        JVector velocity;
        this.PredictBallPosition(jvector, startVelocity, sampleInterval, out position, out velocity, this.samplePass_CollidedTriggers);
        if (this.samplePass_CollidedTriggers.Contains(ownGoal))
        {
          confidence = -1000f;
          break;
        }
        float num5 = 0.0f;
        float num6 = 1f;
        float timeOffsetToBallFlightStart = (float) index1 * sampleInterval;
        for (int index2 = this.samplePass_OpponentPositions.Count - 1; index2 >= 0; --index2)
        {
          float val2 = this.CalcProbabilityOfPlayerBallIntercept(this.samplePass_OpponentPositions[index2], this.samplePass_OpponentMoveSpeeds[index2], jvector, position, sampleInterval, pickupRadiusSquared, timeOffsetToBallFlightStart);
          float num7 = JMath.Max(this.samplePass_enemyProbabilities[index2], val2);
          this.samplePass_enemyProbabilities[index2] = num7;
          num6 *= 1f - num7;
        }
        float t = JMath.Clamp01((float) (((double) timeOffsetToBallFlightStart - (double) num2) / ((double) num3 - (double) num2)));
        float exp = JMath.Lerp(a, 1f, t);
        for (int index3 = this.samplePass_TMPositions.Count - 1; index3 >= 0; --index3)
        {
          float val2_1 = this.CalcProbabilityOfPlayerBallIntercept(this.samplePass_TMPositions[index3], this.samplePass_TMMoveSpeeds[index3], jvector, position, sampleInterval, pickupRadiusSquared, timeOffsetToBallFlightStart);
          float val2_2 = JMath.Max(this.samplePass_friendProbabilities[index3], val2_1);
          this.samplePass_friendProbabilities[index3] = val2_2;
          num5 = JMath.Max(num5, val2_2);
        }
        float val2_3 = JMath.Pow(num5, exp) * num6;
        confidence = JMath.Max(confidence, val2_3);
        jvector = position;
        startVelocity = velocity;
        if ((double) confidence == 1.0)
        {
          this.PredictBallPosition(jvector, startVelocity, 2f, out position, out velocity, this.samplePass_CollidedTriggers);
          if (!this.samplePass_CollidedTriggers.Contains(ownGoal))
            break;
          confidence = -1000f;
          break;
        }
      }
    }

    public void FindGoalShot(
      GameEntity instigator,
      List<GameEntity> opponents,
      out JVector aimDir,
      out float minimumCharge,
      out float confidence)
    {
      aimDir = instigator.transform.Forward;
      minimumCharge = 0.0f;
      confidence = 0.0f;
      float num1 = 1.5f * this.scaleGoalPredictionTime;
      JVector position2D = instigator.transform.Position2D;
      JRigidbody goalRB = this.cache.GetEnemyGoal(instigator).rigidbody.value;
      ThrowBallConfig throwBallConfig = this.cache.GetThrowBallConfig(instigator);
      float ballHitVelocityMax = throwBallConfig.ballHitVelocityMax;
      float ballHitVelocityMin = throwBallConfig.ballHitVelocityMin;
      float resultDistance;
      this.CalcBallTravelDistance(ballHitVelocityMax, num1, out resultDistance, out float _);
      JVector topCorner;
      JVector bottomCorner;
      this.cache.GetEnemyGoalCorners(instigator, out topCorner, out bottomCorner, this.ballConfig.ballColliderRadius);
      if ((double) ((topCorner + bottomCorner) * 0.5f - position2D).Length() > (double) resultDistance)
        return;
      int num2 = 5;
      JVector jvector1 = topCorner;
      JVector jvector2 = bottomCorner - topCorner;
      float num3 = 0.0f;
      for (float num4 = 0.0f; (double) num4 < (double) num2; ++num4)
      {
        JVector aimDir1 = (jvector1 + jvector2 * (num4 / (float) JMath.Max(num2 - 1, 1)) - position2D).Normalized();
        float confidence1 = 0.0f;
        float minimumCharge1 = 0.0f;
        this.SampleGoalShot(instigator, opponents, ballHitVelocityMin, ballHitVelocityMax, num1, 0.4f, goalRB, aimDir1, out minimumCharge1, out confidence1);
        if ((double) confidence1 >= (double) confidence)
          ++num3;
        if ((double) confidence1 > (double) confidence)
        {
          confidence = confidence1;
          minimumCharge = JMath.Min(minimumCharge1 * this.scaleMinChargeLevels, 1f);
          aimDir = aimDir1;
          num3 = 1f;
        }
        else if ((double) confidence1 == (double) confidence && (double) this.RandomFloat() < 1.0 / (double) num3)
        {
          confidence = confidence1;
          minimumCharge = JMath.Min(minimumCharge1 * this.scaleMinChargeLevels, 1f);
          aimDir = aimDir1;
        }
      }
      if ((double) confidence >= 0.25 || !this.canSampleGeometryGoals)
        return;
      int num5 = 5;
      JVector dir = new JVector(0.0f, 0.0f, JMath.Sign(goalRB.Position.Z));
      float num6 = -JMath.Sign(position2D.X) * JMath.Sign(goalRB.Position.Z);
      float min = 40f;
      float max = 70f;
      for (int index = 0; index < num5; ++index)
      {
        float confidence2 = 0.0f;
        float minimumCharge2 = 0.0f;
        JVector aimDir2 = JitterUtils.Rotate2D(dir, this.RandomFloat(min, max) * num6);
        this.SampleGoalShot(instigator, opponents, ballHitVelocityMin, ballHitVelocityMax, num1, 0.4f, goalRB, aimDir2, out minimumCharge2, out confidence2);
        if ((double) confidence2 > (double) confidence)
        {
          confidence = confidence2;
          minimumCharge = JMath.Min(minimumCharge2 * this.scaleMinChargeLevels, 1f);
          aimDir = aimDir2;
          if ((double) confidence == 1.0)
            break;
        }
      }
    }

    public void SampleGoalShot(
      GameEntity instigator,
      List<GameEntity> opponents,
      float minThrowSpeed,
      float maxThrowSpeed,
      float shotDuration,
      float sampleInterval,
      JRigidbody goalRB,
      JVector aimDir,
      out float minimumCharge,
      out float confidence)
    {
      this.sampleGoalShot_InterceptProbabilities.Clear();
      this.sampleGoalShot_OpponentPositions.Clear();
      this.sampleGoalShot_OpponentMoveSpeeds.Clear();
      for (int index = 0; index < opponents.Count; ++index)
      {
        this.sampleGoalShot_InterceptProbabilities.Add(0.0f);
        GameEntity opponent = opponents[index];
        this.sampleGoalShot_OpponentPositions.Add(opponent.transform.Position2D);
        this.sampleGoalShot_OpponentMoveSpeeds.Add(this.cache.GetSprintSpeed(opponent));
      }
      float num1 = instigator.championConfig.value.ballPickupRange + this.ballConfig.ballPickupRadius;
      float pickupRadiusSquared = num1 * num1;
      CollisionSystem collisionSystem = this.context.gamePhysics.world.CollisionSystem;
      minimumCharge = 0.0f;
      confidence = 0.0f;
      JVector jvector = instigator.transform.Position2D;
      JVector startVelocity = aimDir * maxThrowSpeed;
      int num2 = (int) ((double) shotDuration / (double) sampleInterval);
      float num3 = 0.0f;
      for (int index1 = 0; index1 < num2; ++index1)
      {
        JVector position;
        JVector velocity;
        this.PredictBallPosition(jvector, startVelocity, sampleInterval, out position, out velocity);
        float num4 = (position - jvector).Length();
        num3 += num4;
        float timeOffsetToBallFlightStart = (float) index1 * sampleInterval;
        for (int index2 = this.sampleGoalShot_OpponentPositions.Count - 1; index2 >= 0; --index2)
        {
          float val2 = this.CalcProbabilityOfPlayerBallIntercept(this.sampleGoalShot_OpponentPositions[index2], this.sampleGoalShot_OpponentMoveSpeeds[index2], jvector, position, sampleInterval, pickupRadiusSquared, timeOffsetToBallFlightStart);
          this.sampleGoalShot_InterceptProbabilities[index2] = JMath.Max(this.sampleGoalShot_InterceptProbabilities[index2], val2);
        }
        float fraction;
        if (collisionSystem.RaycastSingleBody2D(goalRB, jvector, position - jvector, out JVector _, out fraction) && (double) fraction >= 0.0 && (double) fraction <= 1.0)
        {
          float resultDistance1;
          this.CalcBallTravelDistance(maxThrowSpeed, (float) num2 * sampleInterval, out resultDistance1, out float _);
          float resultDistance2;
          this.CalcBallTravelDistance(minThrowSpeed, (float) num2 * sampleInterval, out resultDistance2, out float _);
          minimumCharge = (float) (((double) num3 - (double) resultDistance2) / ((double) resultDistance1 - (double) resultDistance2));
          minimumCharge *= 1.3f;
          minimumCharge = JMath.Clamp01(minimumCharge);
          confidence = 1f;
          for (int index3 = this.sampleGoalShot_InterceptProbabilities.Count - 1; index3 >= 0; --index3)
            confidence *= 1f - this.sampleGoalShot_InterceptProbabilities[index3];
          break;
        }
        jvector = position;
        startVelocity = velocity;
      }
    }

    public float CalcProbabilityOfPlayerBallIntercept(
      JVector playerPos,
      float playerSpeed,
      JVector ballStartPos,
      JVector ballEndPos,
      float ballFlightDuration,
      float pickupRadiusSquared,
      float timeOffsetToBallFlightStart = 0.0f)
    {
      float fract;
      JVector jvector = JitterUtils.NearestPointOnSegment(playerPos, ballStartPos, ballEndPos, out fract);
      float num1 = (playerPos - jvector).LengthSquared();
      if ((double) num1 <= (double) pickupRadiusSquared)
        return 1f;
      float num2 = fract * ballFlightDuration + timeOffsetToBallFlightStart;
      float num3 = num1 - pickupRadiusSquared;
      float num4 = (float) ((double) playerSpeed * (double) num2 + 9.99999974737875E-06);
      float num5 = num4 * num4;
      return JMath.Clamp01((float) (1.0 - (double) num3 / (double) num5));
    }

    public void PredictBallPosition(
      JVector startPos,
      JVector startVelocity,
      float time,
      out JVector position,
      out JVector velocity,
      List<GameEntity> collidedTriggers = null)
    {
      float initialSpeed = startVelocity.Length();
      if ((double) initialSpeed < 1.0 / 1000.0)
      {
        position = startPos;
        velocity = startVelocity;
      }
      else
      {
        JVector jvector = startVelocity * (1f / initialSpeed);
        float resultDistance;
        float resultSpeed;
        this.CalcBallTravelDistance(initialSpeed, time, out resultDistance, out resultSpeed);
        JVector rayDirAfterBounces;
        position = this.cache.CollisionSystem.BounceRay(startPos, jvector * resultDistance, out rayDirAfterBounces, out JVector _, out float _, out JVector _, this.predictBallPosition_Triggers);
        velocity = rayDirAfterBounces.Normalized() * resultSpeed;
        if (collidedTriggers == null)
          return;
        collidedTriggers.Clear();
        for (int index = 0; index < this.predictBallPosition_Triggers.Count; ++index)
          collidedTriggers.Add(this.predictBallPosition_Triggers[index]);
      }
    }

    public void CalcBallTravelDistance(
      float initialSpeed,
      float time,
      out float resultDistance,
      out float resultSpeed)
    {
      float dragAfterForce = this.ballConfig.dragAfterForce;
      float fixedSimTimeStep = this.context.globalTime.fixedSimTimeStep;
      float num1 = (float) Math.Pow((double) dragAfterForce, (double) fixedSimTimeStep);
      int num2 = (int) ((double) time / (double) fixedSimTimeStep);
      resultSpeed = initialSpeed * (float) Math.Pow((double) dragAfterForce, (double) time);
      float num3 = (float) ((double) initialSpeed * (double) fixedSimTimeStep * (Math.Pow((double) num1, (double) (num2 + 1)) - 1.0) / ((double) num1 - 1.0));
      resultDistance = num3;
    }

    public void CalcBallTravelTime(
      float initialSpeed,
      float distance,
      out bool reachesDistance,
      out float result)
    {
      double dragAfterForce = (double) this.ballConfig.dragAfterForce;
      float fixedSimTimeStep = this.context.globalTime.fixedSimTimeStep;
      float num1 = (float) Math.Pow(dragAfterForce, (double) fixedSimTimeStep);
      double d = Math.Log10((double) distance * ((double) num1 - 1.0) / ((double) initialSpeed * (double) fixedSimTimeStep) + 1.0) / Math.Log10((double) num1) - 1.0;
      if (double.IsNaN(d) || double.IsInfinity(d))
      {
        result = -1f;
        reachesDistance = false;
      }
      else
      {
        float num2 = (float) d * fixedSimTimeStep;
        result = num2;
        reachesDistance = true;
      }
    }

    public bool IsBot(GameEntity player) => player.isFakePlayer;

    public void GetBumpersAlongWay(
      JVector startPos,
      JVector endPos,
      float radius,
      List<GameEntity> bumpers,
      List<GameEntity> results)
    {
      results.Clear();
      foreach (GameEntity bumper in bumpers)
      {
        JVector pos;
        float radius1;
        this.cache.GetBumperVolume(bumper, out pos, out radius1);
        if ((double) JitterUtils.DistanceToSegment(pos, startPos, endPos) <= (double) radius1 + (double) radius)
          results.Add(bumper);
      }
    }

    public void GetNearbyPlayersAlongWay(
      JVector startPos,
      JVector endPos,
      float ballPickupRadius,
      List<GameEntity> players,
      List<GameEntity> results)
    {
      results.Clear();
      foreach (GameEntity player in players)
      {
        JVector position2D = player.transform.Position2D;
        float num = player.championConfig.value.ballPickupRange + ballPickupRadius;
        JVector start = startPos;
        JVector end = endPos;
        if ((double) JitterUtils.DistanceToSegment(position2D, start, end) <= (double) num)
          results.Add(player);
      }
    }

    public float RandomFloat(float min = 0.0f, float max = 1f) => (float) (this.random.NextDouble() * ((double) max - (double) min)) + min;

    public JVector RandomVector2() => this.RandomUnitVector2() * this.RandomFloat();

    public JVector RandomUnitVector2()
    {
      JVector jvector = new JVector(this.RandomFloat(-1f), 0.0f, this.RandomFloat(-1f));
      jvector.Normalize();
      return jvector;
    }
  }
}
