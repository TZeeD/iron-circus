// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateOpponentOwnsBall
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI.States
{
  public class AIStateOpponentOwnsBall : AIStateBaseWithPositionEvaluator
  {
    protected GameEntity overrideBallOwner;
    protected AIPositionEvaluator.Gradient ownGoalDistanceZGradient = new AIPositionEvaluator.Gradient(15f, 2f, 10f, 1f, weightPow: 2f);
    protected AIPositionEvaluator.Gradient ownGoalDistanceRelativeXGradient = new AIPositionEvaluator.Gradient(weightAtMinDistance: 1f, weightAtMaxDistance: 0.5f);
    protected AIPositionEvaluator.Gradient tackleGradient = new AIPositionEvaluator.Gradient(20f, 2.5f, 3.5f, 1f);
    protected AIPositionEvaluator.Gradient goalShotLineGradient = new AIPositionEvaluator.Gradient(18f, 1f, 1.5f, 1f);
    protected AIPositionEvaluator.Gradient passLineGradient = new AIPositionEvaluator.Gradient(12f, 1f, 1.5f, 1f);
    protected AIPositionEvaluator.Gradient ballOwnerDistanceGradient = new AIPositionEvaluator.Gradient(15f, 15f, 25f, 1f);
    protected AIPositionEvaluator.Gradient distToTargetPosGradient = new AIPositionEvaluator.Gradient(5f, 25f, 35f, 1f);
    protected AIPositionEvaluator.Gradient ballOwnerCloseRangePenaltyGradient = new AIPositionEvaluator.Gradient(7f, 2.5f, 5f);
    protected float sprintScoreDifferenceThreshold = 5f;
    protected float sampleTacklePosMinTeamMateSqrDist = 64f;
    protected bool disableSprint;
    protected int disableSprintDuration = 150;
    private bool shouldTackle;
    private int shouldTackleStartTick;
    private int tackleAimDelayNumTicks;
    private int tackleDelayMinNumTicks = 7;
    private int tackleDelayMaxNumTicks = 20;
    private float tackleDelayScaleAtCloseRange;
    private int currentTackleDelay;
    private int ticksInRangeUntilCanTackle;
    private int ticksInRangeUntilCanTackleCounter;
    private RingBuffer<JVector> ballOwnerDirections = new RingBuffer<JVector>(200);
    private List<JVector> evaluatePositions_OffsetBallOwnerPositions = new List<JVector>();

    public AIStateOpponentOwnsBall(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
      this.numPositionSamples = 25;
    }

    protected override void SetupDifficulty()
    {
      this.disableSprint = false;
      switch (this.owner.Difficulty)
      {
        case AIDifficulty.BasicTrainingTeamMate:
        case AIDifficulty.BasicTrainingOpponent:
        case AIDifficulty.Tutorial:
          this.tackleDelayMinNumTicks = 15;
          this.tackleDelayMaxNumTicks = 15;
          this.ownGoalDistanceZGradient.weightScale = 0.0f;
          this.tackleDelayScaleAtCloseRange = 1f;
          this.ticksInRangeUntilCanTackle = 1;
          this.tackleAimDelayNumTicks = 10;
          this.disableSprint = true;
          break;
        case AIDifficulty.Easy:
          this.tackleDelayMinNumTicks = 7;
          this.tackleDelayMaxNumTicks = 20;
          this.tackleAimDelayNumTicks = 10;
          this.tackleDelayScaleAtCloseRange = 0.5f;
          break;
        case AIDifficulty.Intermediate:
          this.tackleDelayMinNumTicks = 2;
          this.tackleDelayMaxNumTicks = 20;
          this.tackleAimDelayNumTicks = 8;
          this.tackleDelayScaleAtCloseRange = 0.4f;
          break;
        case AIDifficulty.Expert:
          this.tackleDelayMinNumTicks = 2;
          this.tackleDelayMaxNumTicks = 25;
          this.tackleAimDelayNumTicks = 3;
          this.tackleDelayScaleAtCloseRange = 0.4f;
          break;
      }
    }

    protected override void SetupRole()
    {
      this.defaultTargetPosEvalIntervalInTicks = 5f;
      if (this.owner.Role != AIRole.Defense)
        return;
      this.ballOwnerDistanceGradient.weightScale = 0.0f;
      this.distToTargetPosGradient.weightScale = 0.0f;
      this.ownGoalDistanceZGradient.weightScale = 22f;
      this.goalShotLineGradient.weightScale = 25f;
      this.defaultTargetPosEvalIntervalInTicks = 10f;
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      this.overrideBallOwner = (GameEntity) null;
      if (this.cache.BallOwner == null || !this.cache.GetOpponents(this.owner.OwnerEntity).Contains(this.cache.BallOwner))
      {
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      else
      {
        JVector position2D = this.owner.OwnerEntity.transform.Position2D;
        JVector t = this.cache.BallOwner.transform.Position2D - position2D;
        double num = (double) t.Length();
        t.Normalize();
        this.ballOwnerDirections.SetObject(this.cache.GetTick(), t);
        this.UpdateTargetPos();
        JVector jvector = (this.currentTargetPos.pos - position2D).Normalized();
        input.moveDir = jvector;
        bool flag = (double) this.currentTargetPos.score > (double) this.currentPosScore + (double) this.sprintScoreDifferenceThreshold;
        input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
        if (this.disableSprint && this.cache.GetTick() < this.startTick + this.disableSprintDuration)
          flag = false;
        if (!this.cache.CanTackleOrDodge(this.owner.OwnerEntity))
          flag = false;
        if (num < 3.0)
          flag = false;
        if (flag)
          input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
        this.HandleTackle(ref input);
      }
    }

    public override void Exit(AIStateBase nextState, ref Input input)
    {
      base.Exit(nextState, ref input);
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
    }

    public override void Enter(AIStateBase prevState, ref Input input)
    {
      base.Enter(prevState, ref input);
      JVector t = this.cache.BallOwner.transform.Position2D - this.owner.OwnerEntity.transform.Position2D;
      this.ballOwnerDirections.Fill(this.cache.GetTick(), t);
    }

    public override void Reset()
    {
      base.Reset();
      this.shouldTackle = false;
      this.shouldTackleStartTick = 0;
      this.ResetTackleDelay();
    }

    protected override AIPositionEvaluator.Settings GetPositionEvaluatorSettings() => new AIPositionEvaluator.Settings()
    {
      bumperGradient = new AIPositionEvaluator.Gradient(minDistance: 1.5f, maxDistance: 2f),
      opponentGradient = new AIPositionEvaluator.Gradient(0.0f, 3f, 6.5f, weightPow: 3f),
      opponentGradientClose = new AIPositionEvaluator.Gradient(-1f, 1.5f, 4f),
      teamMateGradient = new AIPositionEvaluator.Gradient(7f, 2f, 4f),
      teamMateFullPenaltyPos = 0.25f,
      teamMateZeroPenaltyPos = 0.1f,
      borderGradient = new AIPositionEvaluator.Gradient(0.2f, 1.5f, 2.2f),
      enemyGoalGradient = new AIPositionEvaluator.Gradient(0.0f, maxDistance: 20f, weightAtMinDistance: 1f, weightPow: 2f),
      enemyGoalGradientClose = new AIPositionEvaluator.Gradient(0.0f, maxDistance: 10f, weightAtMinDistance: 1f, weightPow: 2f),
      ownGoalGradient = new AIPositionEvaluator.Gradient(0.0f, 4f, 15f),
      horizontalPositionMainGradient = new AIPositionEvaluator.Gradient(15f, 15f, 0.0f, 0.0f, -1f),
      horizontalPositionOwnGoal = new AIPositionEvaluator.Gradient(0.0f, 3f, 15f),
      horizontalPositionEndZone = new AIPositionEvaluator.Gradient(0.0f, 3f, 4f),
      passLinesToTeamMatesWeight = 0.0f
    };

    private void HandleTackle(ref Input input)
    {
      if (!this.cache.CanTackleOrDodge(this.owner.OwnerEntity))
      {
        this.ticksInRangeUntilCanTackleCounter = this.ticksInRangeUntilCanTackle;
        this.shouldTackle = false;
        input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
      }
      else
      {
        if (this.shouldTackle)
          input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
        JVector vector = this.cache.BallOwner.transform.Position2D - this.owner.OwnerEntity.transform.Position2D;
        float num = vector.Length();
        if ((double) num < 3.0)
        {
          JVector jvector1 = vector.Normalized();
          JVector jvector2 = this.ballOwnerDirections.GetObject(this.cache.GetTick() - this.tackleAimDelayNumTicks);
          input.aimDir = jvector2;
          input.moveDir = jvector1;
          --this.ticksInRangeUntilCanTackleCounter;
          if (this.ticksInRangeUntilCanTackleCounter > 0)
            return;
          int currentTick = this.context.globalTime.currentTick;
          if (!this.shouldTackle)
          {
            this.shouldTackle = true;
            this.shouldTackleStartTick = currentTick;
            input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
            this.ResetTackleDelay();
          }
          if (currentTick <= this.shouldTackleStartTick + this.currentTackleDelay && ((double) num >= 1.5 || (double) currentTick <= (double) this.shouldTackleStartTick + (double) this.currentTackleDelay * (double) this.tackleDelayScaleAtCloseRange))
            return;
          input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
        }
        else
        {
          if ((double) num <= 4.5)
            return;
          this.ticksInRangeUntilCanTackleCounter = this.ticksInRangeUntilCanTackle;
          this.shouldTackle = false;
          input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle;
        }
      }
    }

    private void ResetTackleDelay() => this.currentTackleDelay = (int) ((double) JMath.Pow(this.owner.RandomFloat(), 2f) * (double) (this.tackleDelayMaxNumTicks - this.tackleDelayMinNumTicks) + (double) this.tackleDelayMinNumTicks);

    protected override void EvaluatePositions(List<AIPositionWithScore> positions)
    {
      base.EvaluatePositions(positions);
      GameEntity ownerEntity = this.owner.OwnerEntity;
      GameEntity player = this.cache.BallOwner;
      JVector position2D1 = ownerEntity.transform.Position2D;
      if (this.overrideBallOwner != null)
        player = this.overrideBallOwner;
      JVector position2D2 = player.transform.Position2D;
      List<GameEntity> teamMates1 = this.cache.GetTeamMates(ownerEntity);
      List<GameEntity> teamMates2 = this.cache.GetTeamMates(player);
      JVector topCorner1;
      JVector bottomCorner1;
      this.cache.GetOwnGoalCorners(ownerEntity, out topCorner1, out bottomCorner1);
      JVector start = (topCorner1 + bottomCorner1) * 0.5f;
      bool flag = true;
      for (int index = 0; index < teamMates1.Count; ++index)
      {
        float num = (teamMates1[index].transform.Position2D - position2D2).LengthSquared();
        if ((double) num < (double) (position2D1 - position2D2).LengthSquared() && (double) num < (double) this.sampleTacklePosMinTeamMateSqrDist)
        {
          flag = false;
          break;
        }
      }
      JVector topCorner2;
      JVector bottomCorner2;
      this.cache.GetOwnGoalCorners(ownerEntity, out topCorner2, out bottomCorner2);
      float num1 = (float) (((double) topCorner2.X + (double) bottomCorner2.X) * 0.5);
      double num2 = (double) JMath.Abs(topCorner2.X - bottomCorner2.X);
      float z = topCorner2.Z;
      float num3 = JMath.Sign(-z);
      float num4 = z + num3 * 1.5f;
      float num5 = (float) (num2 * 0.5);
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position = positions[index];
        JVector pos = position.pos;
        float distance1 = (position2D2 - pos).Length();
        if (flag)
          position.score += this.positionEvaluator.EvaluateDistance(distance1, this.tackleGradient);
        else
          position.score += this.positionEvaluator.EvaluateDistance(distance1, this.ballOwnerCloseRangePenaltyGradient);
        position.score += this.positionEvaluator.EvaluateDistance(distance1, this.ballOwnerDistanceGradient);
        position.score += this.positionEvaluator.EvaluateDistance((pos - position2D1).Length(), this.distToTargetPosGradient);
        double num6 = (double) JMath.Abs(pos.X - num1);
        float distance2 = (pos.Z - num4) * num3;
        double num7 = (double) num5;
        float distance3 = (float) (num6 / num7);
        float num8 = this.positionEvaluator.EvaluateDistance(distance2, this.ownGoalDistanceZGradient) * this.positionEvaluator.EvaluateDistance(distance3, this.ownGoalDistanceRelativeXGradient);
        if ((double) distance3 > 1.0)
          num8 = 0.0f;
        else if ((double) distance2 < 0.0)
          num8 = -10000f;
        position.score += num8;
        positions[index] = position;
      }
      float resultDistance;
      this.owner.CalcBallTravelDistance(this.cache.GetThrowBallConfig(player).ballHitVelocityMax, 2f, out resultDistance, out float _);
      if ((double) (start - position2D2).Length() <= (double) resultDistance)
      {
        JVector end = position2D2 + (start - position2D2).Normalized() * 2f;
        for (int index = positions.Count - 1; index >= 0; --index)
        {
          AIPositionWithScore position = positions[index];
          float segment = JitterUtils.DistanceToSegment(position.pos, start, end);
          position.score += this.positionEvaluator.EvaluateDistance(segment, this.goalShotLineGradient);
          positions[index] = position;
        }
      }
      float num9 = 0.0f;
      this.evaluatePositions_OffsetBallOwnerPositions.Clear();
      for (int index = 0; index < teamMates2.Count; ++index)
      {
        JVector position2D3 = teamMates2[index].transform.Position2D;
        this.evaluatePositions_OffsetBallOwnerPositions.Add(position2D2 + (position2D3 - position2D2) * 0.3f);
      }
      for (int index1 = positions.Count - 1; index1 >= 0; --index1)
      {
        AIPositionWithScore position = positions[index1];
        JVector pos = position.pos;
        for (int index2 = teamMates2.Count - 1; index2 >= 0; --index2)
        {
          JVector position2D4 = teamMates2[index2].transform.Position2D;
          float fract;
          JVector jvector = JitterUtils.NearestPointOnSegment(pos, this.evaluatePositions_OffsetBallOwnerPositions[index2], position2D4, out fract);
          if ((double) fract > 0.0)
          {
            float num10 = this.positionEvaluator.EvaluateDistance((jvector - pos).Length(), this.passLineGradient) * fract;
            if ((double) num10 > (double) num9)
              num9 = num10;
          }
        }
        position.score += num9;
        positions[index1] = position;
      }
    }

    protected override void GenerateTargetPosSampleList(
      List<AIPositionWithScore> positions,
      float minSearchRadius = 2.5f,
      float maxSearchRadius = 8f)
    {
      int numPositionSamples = this.numPositionSamples;
      positions.Clear();
      JVector runningAvg = JVector.Zero;
      GameEntity ownerEntity = this.owner.OwnerEntity;
      JVector position2D1 = ownerEntity.transform.Position2D;
      GameEntity player = this.cache.BallOwner;
      if (this.overrideBallOwner != null)
        player = this.overrideBallOwner;
      JVector position2D2 = player.transform.Position2D;
      JVector jvector1 = position2D2 - position2D1;
      float number = jvector1.LengthSquared();
      float num1 = JMath.Max(JMath.Sqrt(number), 0.01f);
      List<GameEntity> teamMates1 = this.cache.GetTeamMates(ownerEntity);
      List<GameEntity> teamMates2 = this.cache.GetTeamMates(player);
      JVector topCorner;
      JVector bottomCorner;
      this.cache.GetOwnGoalCorners(ownerEntity, out topCorner, out bottomCorner);
      JVector jvector2 = (topCorner + bottomCorner) * 0.5f;
      bool flag = true;
      for (int index = 0; index < teamMates1.Count; ++index)
      {
        float num2 = (teamMates1[index].transform.Position2D - position2D2).LengthSquared();
        if ((double) num2 < (double) number && (double) num2 < (double) this.sampleTacklePosMinTeamMateSqrDist)
        {
          flag = false;
          break;
        }
      }
      if (flag)
      {
        float num3 = 1.2f;
        AddSample(position2D2 + jvector1 * (-num3 / num1));
        AddSample(position2D2 + (jvector2 - position2D2).Normalized() * num3);
      }
      int num4 = (int) JMath.Max((float) numPositionSamples * 0.3f, 1f);
      float resultDistance;
      this.owner.CalcBallTravelDistance(this.cache.GetThrowBallConfig(player).ballHitVelocityMax, 2f, out resultDistance, out float _);
      JVector jvector3 = position2D2 + (jvector2 - position2D2).Normalized() * 2f;
      JVector jvector4 = jvector2 - jvector3;
      if ((double) jvector4.Length() <= (double) resultDistance)
      {
        for (int index = 0; index < num4; ++index)
          AddSample(jvector3 + ((float) index + 0.5f) / (float) num4 * jvector4);
      }
      int num5 = numPositionSamples - positions.Count;
      int num6 = (int) ((double) num5 * 0.300000011920929);
      float max = topCorner.X - bottomCorner.X;
      float range = this.ownGoalDistanceZGradient.Range;
      for (int index = 0; index < num6; ++index)
        AddSample(new JVector(bottomCorner.X + this.owner.RandomFloat(max: max), 0.0f, bottomCorner.Z + (float) (((double) this.ownGoalDistanceZGradient.MinDistance + (double) this.owner.RandomFloat(max: range)) * -(double) JMath.Sign(bottomCorner.Z))));
      int num7 = (int) ((double) num5 * 0.600000023841858);
      int count = teamMates2.Count;
      if (count != 0)
      {
        int num8 = num7 / count;
        for (int index1 = 0; index1 < count; ++index1)
        {
          JVector position2D3 = teamMates2[index1].transform.Position2D;
          JVector vector = position2D3 - position2D2;
          JVector jvector5 = vector.Normalized();
          JVector jvector6 = position2D2 + vector * 0.3f + vector.Normalized() * 1f;
          JVector jvector7 = position2D3 + jvector5 * -1f;
          JVector jvector8 = jvector6 - jvector7;
          float num9 = (float) JMath.Max(num8 - 1, 1);
          for (int index2 = 0; index2 < num8; ++index2)
            AddSample(jvector6 + jvector8 * ((float) index2 / num9));
        }
      }
      int num10 = num5 - positions.Count;
      JVector jvector9 = runningAvg * (1f / (float) JMath.Max(positions.Count, 1));
      for (int index = 0; index < num10; ++index)
      {
        JVector jvector10 = this.owner.RandomUnitVector2();
        double num11 = (double) this.owner.RandomFloat();
        float num12 = (float) (num11 * ((double) maxSearchRadius - (double) minSearchRadius)) + minSearchRadius;
        float num13 = (float) (num11 * ((double) maxSearchRadius - (double) minSearchRadius)) + minSearchRadius;
        jvector10.X *= num12;
        jvector10.Z *= num13;
        AddSample(jvector9 + jvector10);
      }
      this.CheckPositionsForEarlyRejection(positions);

      void AddSample(JVector sample)
      {
        positions.Add(new AIPositionWithScore(sample, 0.0f));
        runningAvg += sample;
      }
    }

    public void FindTargetPositionForVirtualBallOwner(
      GameEntity virtualBallOwner,
      out JVector targetPos,
      out bool shouldSprint)
    {
      this.overrideBallOwner = virtualBallOwner;
      AIPositionWithScore targetPos1 = this.FindTargetPos();
      targetPos = targetPos1.pos;
      float singlePosition = this.EvaluateSinglePosition(this.owner.OwnerEntity.transform.Position2D);
      shouldSprint = (double) targetPos1.score > (double) singlePosition + (double) this.sprintScoreDifferenceThreshold;
      this.overrideBallOwner = (GameEntity) null;
    }

    public bool ShouldSprintToTargetPos(GameEntity virtualBallOwner, JVector targetPos)
    {
      this.overrideBallOwner = virtualBallOwner;
      double singlePosition1 = (double) this.EvaluateSinglePosition(targetPos);
      float singlePosition2 = this.EvaluateSinglePosition(this.owner.OwnerEntity.transform.Position2D);
      this.overrideBallOwner = (GameEntity) null;
      double num = (double) singlePosition2 + (double) this.sprintScoreDifferenceThreshold;
      return singlePosition1 > num;
    }
  }
}
