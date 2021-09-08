// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateBallOwner
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI.States
{
  public class AIStateBallOwner : AIStateBaseWithPositionEvaluator
  {
    public bool debugDisableShooting;
    public bool debugDisableMovement;
    public bool debugDisableDodge;
    protected float currentThreat;
    protected bool ballLost;
    protected int ballLostStartTick;
    private bool shouldDodge;
    private int shouldDodgeStartTick;
    private int dodgeDelayMinNumTicks = 10;
    private int dodgeDelayMaxNumTicks = 35;
    private float dodgeDelayChanceOfNoDelay = 0.5f;
    private int currentDodgeDelay;
    private int dodgeStartTick;
    private int minTicksToHoldBallAfterDodge = 25;
    private bool isCharging;
    private bool shotReleased;
    private JVector shotReleasedAimDir;
    private JVector prevAimDir;
    private AIStateBallOwner.CurvePoint[] threatLevelToMinHoldBallDuration;
    private AIStateBallOwner.CurvePoint[] threatLevelToMinPassConfidence;
    private AIStateBallOwner.CurvePoint[] threatLevelToMinGoalConfidence;
    private AIStateBallOwner.CurvePoint[] timeToMinPassConfidence;
    private AIStateBallOwner.CurvePoint[] timeToMinGoalConfidence;
    private float minPassRelativePosScale;
    private AIStateBallOwner.CurvePoint[] timeToMinPassRelativePos;
    private AIStateBallOwner.CurvePoint[] threatToMinPassRelativePos;
    private List<GameEntity> handleBallThrow_ElligibleTeamMates = new List<GameEntity>(3);
    private List<AIPositionWithScore> pickTargetPosFromSortedList_Route = new List<AIPositionWithScore>(60);

    protected override void SetupDifficulty()
    {
      switch (this.owner.Difficulty)
      {
        case AIDifficulty.Tutorial:
          this.minTicksToHoldBallAfterDodge = 35;
          this.dodgeDelayChanceOfNoDelay = 0.0f;
          break;
        case AIDifficulty.Easy:
          this.minTicksToHoldBallAfterDodge = 25;
          this.dodgeDelayMinNumTicks = 5;
          this.dodgeDelayMaxNumTicks = 10;
          this.positionEvaluator.settings.passLinesToTeamMatesWeight = 3f;
          this.positionEvaluator.settings.horizontalPositionMainGradient.weightScale = 10f;
          break;
        case AIDifficulty.Intermediate:
          this.minTicksToHoldBallAfterDodge = 15;
          this.dodgeDelayMinNumTicks = 5;
          this.dodgeDelayMaxNumTicks = 10;
          break;
        case AIDifficulty.Expert:
          this.minTicksToHoldBallAfterDodge = 8;
          this.dodgeDelayMinNumTicks = 2;
          this.dodgeDelayMaxNumTicks = 8;
          break;
      }
      switch (this.owner.Difficulty)
      {
        case AIDifficulty.Tutorial:
          this.threatLevelToMinHoldBallDuration = new AIStateBallOwner.CurvePoint[2]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 45f),
            new AIStateBallOwner.CurvePoint(0.7f, 30f)
          };
          this.threatLevelToMinPassConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 0.9f),
            new AIStateBallOwner.CurvePoint(0.25f, 0.5f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.5f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.4f)
          };
          this.threatLevelToMinGoalConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 0.9f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.5f),
            new AIStateBallOwner.CurvePoint(1f, 0.5f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.4f)
          };
          this.timeToMinPassConfidence = new AIStateBallOwner.CurvePoint[5]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(30f, 1f),
            new AIStateBallOwner.CurvePoint(60f, 0.75f),
            new AIStateBallOwner.CurvePoint(120f, 0.75f),
            new AIStateBallOwner.CurvePoint(150f, 0.6f)
          };
          this.timeToMinGoalConfidence = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(150f, 1f),
            new AIStateBallOwner.CurvePoint(210f, 0.5f)
          };
          this.minPassRelativePosScale = 5f;
          this.timeToMinPassRelativePos = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.1f),
            new AIStateBallOwner.CurvePoint(90f, -0.1f),
            new AIStateBallOwner.CurvePoint(150f, -0.5f)
          };
          this.threatToMinPassRelativePos = new AIStateBallOwner.CurvePoint[6]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.1f),
            new AIStateBallOwner.CurvePoint(0.4f, -0.1f),
            new AIStateBallOwner.CurvePoint(0.7f, -1f),
            new AIStateBallOwner.CurvePoint(1f, -1f),
            new AIStateBallOwner.CurvePoint(1.5f, -5f),
            new AIStateBallOwner.CurvePoint(2.5f, -5f)
          };
          break;
        case AIDifficulty.Easy:
        case AIDifficulty.Intermediate:
          this.threatLevelToMinHoldBallDuration = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 45f),
            new AIStateBallOwner.CurvePoint(0.25f, 25f),
            new AIStateBallOwner.CurvePoint(0.7f, 15f),
            new AIStateBallOwner.CurvePoint(1.5f, 10f)
          };
          this.threatLevelToMinPassConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 0.95f),
            new AIStateBallOwner.CurvePoint(0.25f, 0.8f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.5f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.4f)
          };
          this.threatLevelToMinGoalConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.9f),
            new AIStateBallOwner.CurvePoint(1f, 0.5f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.4f)
          };
          this.timeToMinPassConfidence = new AIStateBallOwner.CurvePoint[5]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(30f, 1f),
            new AIStateBallOwner.CurvePoint(60f, 0.75f),
            new AIStateBallOwner.CurvePoint(120f, 0.75f),
            new AIStateBallOwner.CurvePoint(150f, 0.6f)
          };
          this.timeToMinGoalConfidence = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(150f, 1f),
            new AIStateBallOwner.CurvePoint(210f, 0.5f)
          };
          this.minPassRelativePosScale = 5f;
          this.timeToMinPassRelativePos = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.1f),
            new AIStateBallOwner.CurvePoint(90f, -0.1f),
            new AIStateBallOwner.CurvePoint(150f, -0.5f)
          };
          this.threatToMinPassRelativePos = new AIStateBallOwner.CurvePoint[6]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.1f),
            new AIStateBallOwner.CurvePoint(0.4f, -0.1f),
            new AIStateBallOwner.CurvePoint(0.7f, -1f),
            new AIStateBallOwner.CurvePoint(1f, -1f),
            new AIStateBallOwner.CurvePoint(1.5f, -7f),
            new AIStateBallOwner.CurvePoint(2.5f, -100f)
          };
          break;
        case AIDifficulty.Expert:
          this.threatLevelToMinHoldBallDuration = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 30f),
            new AIStateBallOwner.CurvePoint(0.25f, 15f),
            new AIStateBallOwner.CurvePoint(0.7f, 3f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.0f)
          };
          this.threatLevelToMinPassConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 0.95f),
            new AIStateBallOwner.CurvePoint(0.25f, 0.75f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.4f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.3f)
          };
          this.threatLevelToMinGoalConfidence = new AIStateBallOwner.CurvePoint[4]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(0.7f, 0.7f),
            new AIStateBallOwner.CurvePoint(1f, 0.5f),
            new AIStateBallOwner.CurvePoint(1.5f, 0.3f)
          };
          this.timeToMinPassConfidence = new AIStateBallOwner.CurvePoint[5]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(30f, 0.9f),
            new AIStateBallOwner.CurvePoint(60f, 0.7f),
            new AIStateBallOwner.CurvePoint(120f, 0.7f),
            new AIStateBallOwner.CurvePoint(150f, 0.6f)
          };
          this.timeToMinGoalConfidence = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, 1f),
            new AIStateBallOwner.CurvePoint(150f, 0.8f),
            new AIStateBallOwner.CurvePoint(210f, 0.5f)
          };
          this.minPassRelativePosScale = 5f;
          this.timeToMinPassRelativePos = new AIStateBallOwner.CurvePoint[3]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.1f),
            new AIStateBallOwner.CurvePoint(90f, -0.1f),
            new AIStateBallOwner.CurvePoint(150f, -0.5f)
          };
          this.threatToMinPassRelativePos = new AIStateBallOwner.CurvePoint[5]
          {
            new AIStateBallOwner.CurvePoint(0.0f, -0.2f),
            new AIStateBallOwner.CurvePoint(0.4f, -0.2f),
            new AIStateBallOwner.CurvePoint(0.7f, -4f),
            new AIStateBallOwner.CurvePoint(1f, -4f),
            new AIStateBallOwner.CurvePoint(1.5f, -100f)
          };
          break;
      }
    }

    protected override void SetupRole()
    {
    }

    protected override AIPositionEvaluator.Settings GetPositionEvaluatorSettings() => new AIPositionEvaluator.Settings()
    {
      bumperGradient = new AIPositionEvaluator.Gradient(minDistance: 1.5f, maxDistance: 2f),
      opponentGradient = new AIPositionEvaluator.Gradient(1.5f, 3f, 6.5f, weightPow: 3f),
      opponentGradientClose = new AIPositionEvaluator.Gradient(4f, 1.5f, 3f),
      teamMateGradient = new AIPositionEvaluator.Gradient(0.25f, 5f, 9f),
      teamMateFullPenaltyPos = 0.2f,
      teamMateZeroPenaltyPos = 0.1f,
      borderGradient = new AIPositionEvaluator.Gradient(0.2f, 1.5f, 2.2f),
      enemyGoalGradient = new AIPositionEvaluator.Gradient(4f, maxDistance: 20f, weightAtMinDistance: 1f, weightPow: 2f),
      enemyGoalGradientClose = new AIPositionEvaluator.Gradient(8f, maxDistance: 10f, weightAtMinDistance: 1f, weightPow: 2f),
      ownGoalGradient = new AIPositionEvaluator.Gradient(minDistance: 4f, maxDistance: 15f),
      horizontalPositionMainGradient = new AIPositionEvaluator.Gradient(15f, maxDistance: 3f, weightAtMinDistance: 0.0f, weightAtMaxDistance: 1f),
      horizontalPositionOwnGoal = new AIPositionEvaluator.Gradient(4f, 3f, 15f),
      horizontalPositionEndZone = new AIPositionEvaluator.Gradient(2f, 3f, 4f),
      passLinesToTeamMatesWeight = 0.5f
    };

    public AIStateBallOwner(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
      this.numPositionSamples = 25;
    }

    public override void Reset()
    {
      base.Reset();
      this.shouldDodge = false;
      this.shouldDodgeStartTick = 0;
      this.ResetDodgeDelay();
      this.isCharging = false;
      this.ballLost = false;
      this.shotReleased = false;
      this.prevAimDir = JVector.Zero;
    }

    public override void Enter(AIStateBase nextState, ref Input input)
    {
      base.Enter(nextState, ref input);
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
    }

    public override void Exit(AIStateBase nextState, ref Input input)
    {
      base.Exit(nextState, ref input);
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall;
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      if (this.cache.BallOwner != this.owner.OwnerEntity)
      {
        int tick = this.cache.GetTick();
        if (!this.ballLost)
        {
          this.ballLost = true;
          this.ballLostStartTick = tick;
        }
        if (tick > this.ballLostStartTick + 5)
        {
          this.owner.SetState(typeof (AIStateDefault), ref input);
          return;
        }
      }
      JVector position2D = this.owner.OwnerEntity.transform.Position2D;
      this.currentThreat = this.EvaluateThreat(this.owner.OwnerEntity.transform.Position2D);
      this.HandleBallThrow(ref input);
      this.UpdateTargetPos();
      if (!this.debugDisableMovement)
      {
        JVector jvector = (this.currentTargetPos.pos - position2D).Normalized();
        input.moveDir = jvector;
      }
      if (this.shotReleased)
        return;
      this.HandleDodge(ref input);
    }

    private void HandleBallThrow(ref Input input)
    {
      if (this.debugDisableShooting)
        return;
      JVector aimDir1 = JVector.Zero;
      JVector aimDir2 = JVector.Zero;
      float charge = 1f;
      float minimumCharge = 1f;
      float confidence1 = 0.0f;
      float confidence2 = 0.0f;
      GameEntity ownerEntity = this.owner.OwnerEntity;
      List<GameEntity> opponents = this.cache.GetOpponents(ownerEntity);
      List<GameEntity> teamMates = this.cache.GetTeamMates(ownerEntity);
      float currentThreat = this.currentThreat;
      int currentTick = this.context.globalTime.currentTick;
      float t = (float) (currentTick - this.startTick);
      float num1 = Evaluate(this.threatLevelToMinHoldBallDuration, currentThreat);
      bool flag1;
      bool flag2 = flag1 = (double) t >= (double) num1;
      if (this.isCharging)
        flag2 = flag1 = true;
      if (currentTick < this.dodgeStartTick + this.minTicksToHoldBallAfterDodge)
        flag2 = flag1 = false;
      float num2 = Evaluate(this.threatLevelToMinPassConfidence, currentThreat) * Evaluate(this.timeToMinPassConfidence, t);
      float num3 = JMath.Min(Evaluate(this.threatToMinPassRelativePos, currentThreat), Evaluate(this.timeToMinPassRelativePos, t)) * this.minPassRelativePosScale;
      this.handleBallThrow_ElligibleTeamMates.Clear();
      if (flag2)
      {
        for (int index = 0; index < teamMates.Count; ++index)
        {
          if ((double) this.EvaluateSinglePosition(teamMates[index].transform.Position2D) - (double) this.currentPosScore >= (double) num3)
            this.handleBallThrow_ElligibleTeamMates.Add(teamMates[index]);
        }
        flag2 = (uint) this.handleBallThrow_ElligibleTeamMates.Count > 0U;
      }
      if (flag2)
      {
        this.owner.FindBestPass(ownerEntity, out GameEntity _, opponents, this.handleBallThrow_ElligibleTeamMates, this.owner.penalizePassingToBots, out aimDir1, out charge, out confidence1);
        flag2 = (double) confidence1 >= (double) num2;
      }
      float num4 = Evaluate(this.threatLevelToMinGoalConfidence, currentThreat) * Evaluate(this.timeToMinGoalConfidence, t);
      if (flag1)
      {
        this.owner.FindGoalShot(ownerEntity, opponents, out aimDir2, out minimumCharge, out confidence2);
        flag1 = (double) confidence2 >= (double) num4;
      }
      if (this.isCharging)
        input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall;
      JVector jvector = JVector.Zero;
      float num5 = 1f;
      if (flag2)
      {
        jvector = aimDir1;
        num5 = charge;
      }
      if (this.owner.Difficulty >= AIDifficulty.Expert)
      {
        if (!flag2 || flag1 && (double) confidence2 >= (double) confidence1)
        {
          jvector = aimDir2;
          num5 = minimumCharge;
        }
      }
      else if (!flag2 || flag1 && (double) confidence2 > (double) confidence1)
      {
        jvector = aimDir2;
        num5 = minimumCharge;
      }
      if (!this.shotReleased)
      {
        if (jvector == JVector.Zero)
          jvector = this.prevAimDir;
        input.aimDir = jvector;
      }
      else
        input.aimDir = this.shotReleasedAimDir;
      if (flag2 | flag1)
      {
        if (!this.isCharging)
        {
          if (!this.shotReleased)
          {
            this.isCharging = true;
            input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall;
          }
        }
        else if ((double) this.cache.GetCharge(ownerEntity) >= (double) num5)
        {
          this.isCharging = false;
          input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.ThrowBall;
          this.shotReleasedAimDir = jvector;
          this.shotReleased = true;
        }
      }
      this.prevAimDir = input.aimDir;

      static float Evaluate(AIStateBallOwner.CurvePoint[] curve, float t)
      {
        if ((double) t >= (double) curve[curve.Length - 1].Item1)
          return curve[curve.Length - 1].Item2;
        if ((double) t <= (double) curve[0].Item1)
          return curve[0].Item2;
        for (int index = curve.Length - 2; index >= 0; --index)
        {
          if ((double) t >= (double) curve[index].Item1)
          {
            float num = (float) (((double) t - (double) curve[index].Item1) / ((double) curve[index + 1].Item1 - (double) curve[index].Item1));
            return (curve[index + 1].Item2 - curve[index].Item2) * num + curve[index].Item2;
          }
        }
        return 0.0f;
      }
    }

    private void HandleDodge(ref Input input)
    {
      if (this.debugDisableDodge)
        return;
      if (!this.cache.CanTackleOrDodge(this.owner.OwnerEntity))
      {
        this.shouldDodge = false;
        input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
      }
      else if ((double) this.currentThreat > 0.75)
      {
        int currentTick = this.context.globalTime.currentTick;
        if (!this.shouldDodge)
        {
          this.shouldDodge = true;
          this.shouldDodgeStartTick = currentTick;
          this.ResetDodgeDelay();
        }
        if (currentTick <= this.shouldDodgeStartTick + this.currentDodgeDelay && ((double) this.currentThreat < 2.0 || (double) currentTick <= (double) this.shouldDodgeStartTick + (double) this.currentDodgeDelay * 0.5))
          return;
        JVector dodgeDirection = this.FindDodgeDirection();
        input.aimDir = dodgeDirection;
        input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
        this.dodgeStartTick = currentTick;
      }
      else
        this.shouldDodge = false;
    }

    private void ResetDodgeDelay()
    {
      this.currentDodgeDelay = (int) this.owner.RandomFloat((float) this.dodgeDelayMinNumTicks, (float) this.dodgeDelayMaxNumTicks);
      if ((double) this.owner.RandomFloat() >= (double) this.dodgeDelayChanceOfNoDelay)
        return;
      this.currentDodgeDelay = 0;
    }

    private JVector FindDodgeDirection()
    {
      float dodgeDistance = this.cache.GetDodgeDistance(this.owner.OwnerEntity);
      JVector position2D = this.owner.OwnerEntity.transform.Position2D;
      JVector dir = JitterUtils.Rotate2D(JVector.Right, this.owner.RandomFloat(max: 360f));
      float num1 = 12f;
      float num2 = -100000f;
      JVector jvector = this.owner.OwnerEntity.transform.Forward;
      jvector.Y = 0.0f;
      for (int index = 0; (double) index < (double) num1; ++index)
      {
        dir = JitterUtils.Rotate2D(dir, 360f / num1);
        JVector position = position2D + dir * dodgeDistance;
        if (!this.CheckSinglePositionForEarlyRejection(position))
        {
          float singlePosition = this.EvaluateSinglePosition(position);
          if ((double) singlePosition > (double) num2 && !this.CheckSinglePositionForEarlyRejection(position2D + dir * 0.5f))
          {
            num2 = singlePosition;
            jvector = dir;
          }
        }
      }
      return jvector;
    }

    protected override AIPositionWithScore PickTargetPosFromSortedList(
      List<AIPositionWithScore> positions)
    {
      if (positions.Count > 3)
        positions.RemoveRange(3, positions.Count - 3);
      JVector position1 = this.owner.OwnerEntity.transform.position;
      AIPositionWithScore positionWithScore = positions[0];
      float num1 = -100000f;
      for (int index1 = 0; index1 < positions.Count; ++index1)
      {
        this.pickTargetPosFromSortedList_Route.Clear();
        AIPositionWithScore position2 = positions[index1];
        JVector jvector1 = position2.pos - position1;
        float num2 = JMath.Max(jvector1.Length(), 1f / 1000f);
        float num3 = (float) (int) num2;
        JVector jvector2 = jvector1 * (1f / num2);
        JVector pos = position1;
        for (int index2 = 0; (double) index2 < (double) num3; ++index2)
        {
          pos += jvector2;
          this.pickTargetPosFromSortedList_Route.Add(new AIPositionWithScore(pos, 0.0f));
        }
        this.EvaluatePositions(this.pickTargetPosFromSortedList_Route);
        float num4 = 0.0f;
        for (int index3 = this.pickTargetPosFromSortedList_Route.Count - 1; index3 >= 0; --index3)
          num4 += this.pickTargetPosFromSortedList_Route[index3].score;
        float num5 = (num4 + position2.score) / (num3 + 1f);
        if ((double) num5 > (double) num1)
        {
          num1 = num5;
          positionWithScore = position2;
        }
      }
      return positionWithScore;
    }

    private float EvaluateThreat(JVector pos)
    {
      float num1 = 0.0f;
      float num2 = 1f;
      float num3 = 0.5f;
      float tackleDistance = this.cache.GetTackleDistance(this.owner.OwnerEntity);
      float num4 = tackleDistance * 0.5f;
      float num5 = 5f;
      float num6 = 8f;
      List<GameEntity> opponents = this.cache.GetOpponents(this.owner.OwnerEntity);
      for (int index = 0; index < opponents.Count; ++index)
      {
        GameEntity player = opponents[index];
        bool flag = this.cache.CanTackleOrDodge(player);
        float num7 = (player.transform.Position2D - pos).Length();
        if ((double) num7 <= (double) tackleDistance & flag)
          num1 += JMath.Clamp01((float) (1.0 - ((double) num7 - (double) num4) / ((double) tackleDistance - (double) num4))) * num2;
        if ((double) num7 < (double) num6)
          num1 += JMath.Clamp01((float) (1.0 - ((double) num7 - (double) num5) / ((double) num6 - (double) num5))) * num3;
      }
      return num1;
    }

    protected override float GetReevaluateTargetPosInterval()
    {
      float targetPosInterval = base.GetReevaluateTargetPosInterval();
      if ((double) this.currentThreat >= 1.0)
        targetPosInterval *= 0.5f;
      return targetPosInterval;
    }

    protected struct CurvePoint
    {
      public float Item1;
      public float Item2;

      public CurvePoint(float i1, float i2)
      {
        this.Item1 = i1;
        this.Item2 = i2;
      }
    }
  }
}
