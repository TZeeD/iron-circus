// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateTeamMateOwnsBall
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI.States
{
  public class AIStateTeamMateOwnsBall : AIStateBaseWithPositionEvaluator
  {
    protected GameEntity overrideBallOwner;
    protected AIPositionEvaluator.Gradient ballOwnerDistanceGradient = new AIPositionEvaluator.Gradient(10f, 15f, 25f, 0.0f, -1f, 2f);
    protected float sprintScoreDifferenceThreshold = 6f;

    protected override AIPositionEvaluator.Settings GetPositionEvaluatorSettings() => new AIPositionEvaluator.Settings()
    {
      bumperGradient = new AIPositionEvaluator.Gradient(minDistance: 1.5f, maxDistance: 2f),
      opponentGradient = new AIPositionEvaluator.Gradient(1.5f, 3f, 6.5f, weightPow: 3f),
      opponentGradientClose = new AIPositionEvaluator.Gradient(4f, 1.5f, 3f),
      teamMateGradient = new AIPositionEvaluator.Gradient(4f, 6f, 8f),
      teamMateFullPenaltyPos = 0.35f,
      teamMateZeroPenaltyPos = 0.08f,
      borderGradient = new AIPositionEvaluator.Gradient(0.2f, 1.5f, 2.2f),
      enemyGoalGradient = new AIPositionEvaluator.Gradient(0.0f, maxDistance: 20f, weightAtMinDistance: 1f, weightPow: 2f),
      enemyGoalGradientClose = new AIPositionEvaluator.Gradient(0.0f, maxDistance: 10f, weightAtMinDistance: 1f, weightPow: 2f),
      ownGoalGradient = new AIPositionEvaluator.Gradient(minDistance: 4f, maxDistance: 15f),
      horizontalPositionMainGradient = new AIPositionEvaluator.Gradient(15f, maxDistance: 3f, weightAtMinDistance: 0.0f, weightAtMaxDistance: 1f),
      horizontalPositionOwnGoal = new AIPositionEvaluator.Gradient(4f, 3f, 15f),
      horizontalPositionEndZone = new AIPositionEvaluator.Gradient(2f, 3f, 4f),
      passLinesToTeamMatesWeight = 2f
    };

    public AIStateTeamMateOwnsBall(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
      this.numPositionSamples = 35;
    }

    protected override void SetupRole()
    {
      if (this.owner.Role != AIRole.Defense)
        return;
      this.ballOwnerDistanceGradient.weightScale *= 0.5f;
      this.positionEvaluator.settings.horizontalPositionMainGradient.weightScale = 0.0f;
    }

    public override void Reset() => base.Reset();

    public override void Exit(AIStateBase nextState, ref Input input)
    {
      base.Exit(nextState, ref input);
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      this.overrideBallOwner = (GameEntity) null;
      if (this.cache.BallOwner == null || !this.cache.GetTeamMates(this.owner.OwnerEntity).Contains(this.cache.BallOwner))
      {
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      else
      {
        JVector position2D = this.owner.OwnerEntity.transform.Position2D;
        this.UpdateTargetPos();
        JVector jvector = (this.currentTargetPos.pos - position2D).Normalized();
        input.moveDir = jvector;
        int num = (double) this.currentTargetPos.score > (double) this.currentPosScore + (double) this.sprintScoreDifferenceThreshold ? 1 : 0;
        input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
        if (num == 0)
          return;
        input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
      }
    }

    protected override void EvaluatePositions(List<AIPositionWithScore> positions)
    {
      base.EvaluatePositions(positions);
      GameEntity gameEntity = this.cache.BallOwner;
      if (this.overrideBallOwner != null)
        gameEntity = this.overrideBallOwner;
      if (gameEntity == null)
        return;
      float z = gameEntity.transform.Position2D.Z;
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position = positions[index];
        float distance = this.positionEvaluator.EvaluateDistance(JMath.Abs(position.pos.Z - z), this.ballOwnerDistanceGradient);
        position.score += distance;
        positions[index] = position;
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
