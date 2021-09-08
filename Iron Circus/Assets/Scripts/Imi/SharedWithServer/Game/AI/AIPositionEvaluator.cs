// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.AIPositionEvaluator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Jitter.LinearMath;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.AI
{
  public class AIPositionEvaluator
  {
    private BaseAI owner;
    private AICache cache;
    public AIPositionEvaluator.Settings settings;
    private List<GameEntity> evaluatePassLinesToTeamMates_Results = new List<GameEntity>(3);

    public AIPositionEvaluator(AIPositionEvaluator.Settings settings, BaseAI owner, AICache cache)
    {
      this.settings = settings;
      this.owner = owner;
      this.cache = cache;
    }

    public virtual void Evaluate(List<AIPositionWithScore> positions)
    {
      this.BeginEvaluation(positions);
      this.EvaluateBumpers(positions);
      this.EvaluateOpponents(positions);
      this.EvaluateTeamMembers(positions);
      this.EvaluateArenaBorders(positions);
      this.EvaluateEnemyGoal(positions);
      this.EvaluateOwnGoal(positions);
      this.EvaluateHorizontalPosition(positions);
      this.EvaluatePassLinesToTeamMates(positions);
    }

    protected virtual void BeginEvaluation(List<AIPositionWithScore> positions)
    {
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position = positions[index];
        position.score = 0.0f;
        position.pos.Y = 0.0f;
        positions[index] = position;
      }
    }

    protected virtual void EvaluateBumpers(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.bumperGradient.weightScale == 0.0)
        return;
      List<GameEntity> bumpers = this.cache.Bumpers;
      for (int index1 = 0; index1 < bumpers.Count; ++index1)
      {
        JVector pos;
        float radius;
        this.cache.GetBumperVolume(bumpers[index1], out pos, out radius);
        AIPositionEvaluator.Gradient bumperGradient = this.settings.bumperGradient;
        bumperGradient.MinDistance += radius;
        bumperGradient.MaxDistance += radius;
        for (int index2 = positions.Count - 1; index2 >= 0; --index2)
        {
          AIPositionWithScore position = positions[index2];
          float distance = (pos - position.pos).Length();
          position.score += this.EvaluateDistance(distance, bumperGradient);
          positions[index2] = position;
        }
      }
    }

    protected virtual void EvaluateOpponents(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.opponentGradient.weightScale == 0.0 && (double) this.settings.opponentGradientClose.weightScale == 0.0)
        return;
      List<GameEntity> opponents = this.cache.GetOpponents(this.owner.OwnerEntity);
      for (int index1 = 0; index1 < opponents.Count; ++index1)
      {
        JVector position2D = opponents[index1].transform.Position2D;
        for (int index2 = positions.Count - 1; index2 >= 0; --index2)
        {
          AIPositionWithScore position = positions[index2];
          float distance = (position2D - position.pos).Length();
          position.score += this.EvaluateDistance(distance, this.settings.opponentGradient);
          position.score += this.EvaluateDistance(distance, this.settings.opponentGradientClose);
          positions[index2] = position;
        }
      }
    }

    protected virtual void EvaluateTeamMembers(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.teamMateGradient.weightScale == 0.0)
        return;
      float arenaSizeZ = this.cache.ArenaSizeZ;
      List<GameEntity> teamMates = this.cache.GetTeamMates(this.owner.OwnerEntity);
      Team team = this.owner.OwnerEntity.playerTeam.value;
      float halfArenaSizeZ = this.cache.ArenaSizeZ / 2f;
      for (int index1 = 0; index1 < teamMates.Count; ++index1)
      {
        JVector position2D = teamMates[index1].transform.Position2D;
        float positionAlongField = this.GetHorizontalPositionAlongField(position2D.Z, halfArenaSizeZ, team);
        float num = JMath.Clamp01((float) (((double) JMath.Min(positionAlongField / arenaSizeZ, (arenaSizeZ - positionAlongField) / arenaSizeZ) - (double) this.settings.teamMateZeroPenaltyPos) / ((double) this.settings.teamMateFullPenaltyPos - (double) this.settings.teamMateZeroPenaltyPos)));
        AIPositionEvaluator.Gradient teamMateGradient = this.settings.teamMateGradient;
        teamMateGradient.weightScale *= num;
        for (int index2 = positions.Count - 1; index2 >= 0; --index2)
        {
          AIPositionWithScore position = positions[index2];
          float distance = (position2D - position.pos).Length();
          position.score += this.EvaluateDistance(distance, teamMateGradient);
          positions[index2] = position;
        }
      }
    }

    protected virtual void EvaluateEnemyGoal(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.enemyGoalGradient.weightScale == 0.0 && (double) this.settings.enemyGoalGradientClose.weightScale == 0.0)
        return;
      JVector position1 = this.cache.GetEnemyGoal(this.owner.OwnerEntity).rigidbody.value.Position;
      position1.Y = 0.0f;
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position2 = positions[index];
        float distance = (position1 - position2.pos).Length();
        position2.score += this.EvaluateDistance(distance, this.settings.enemyGoalGradient) + this.EvaluateDistance(distance, this.settings.enemyGoalGradientClose);
        positions[index] = position2;
      }
    }

    protected virtual void EvaluateOwnGoal(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.ownGoalGradient.weightScale == 0.0)
        return;
      JVector position1 = this.cache.GetOwnGoal(this.owner.OwnerEntity).rigidbody.value.Position;
      position1.Y = 0.0f;
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position2 = positions[index];
        float distance = (position1 - position2.pos).Length();
        position2.score += this.EvaluateDistance(distance, this.settings.ownGoalGradient);
        positions[index] = position2;
      }
    }

    protected virtual void EvaluateArenaBorders(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.borderGradient.weightScale == 0.0)
        return;
      float num1 = this.cache.ArenaSizeX / 2f;
      float num2 = this.cache.ArenaSizeZ / 2f;
      JVector topCorner;
      JVector bottomCorner;
      this.cache.GetEnemyGoalCorners(this.owner.OwnerEntity, out topCorner, out bottomCorner, 0.5f);
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position = positions[index];
        JVector pos = position.pos;
        float num3 = JMath.Abs(pos.X);
        float distance1 = JMath.Abs(num1 - num3);
        float num4 = JMath.Abs(pos.Z);
        float distance2 = JMath.Abs(num2 - num4);
        float num5 = (double) pos.X <= (double) bottomCorner.X || (double) pos.X >= (double) topCorner.X ? 1f : 0.0f;
        position.score += this.EvaluateDistance(distance1, this.settings.borderGradient) + this.EvaluateDistance(distance2, this.settings.borderGradient) * num5;
        positions[index] = position;
      }
    }

    protected virtual void EvaluateHorizontalPosition(List<AIPositionWithScore> positions)
    {
      float arenaSizeZ = this.cache.ArenaSizeZ;
      Team team = this.owner.OwnerEntity.playerTeam.value;
      float halfArenaSizeZ = this.cache.ArenaSizeZ / 2f;
      JVector topCorner;
      JVector bottomCorner;
      this.cache.GetEnemyGoalCorners(this.owner.OwnerEntity, out topCorner, out bottomCorner, 0.5f);
      AIPositionEvaluator.Gradient gradient = new AIPositionEvaluator.Gradient(this.settings.horizontalPositionMainGradient.weightScale, this.settings.horizontalPositionMainGradient.MinDistance, arenaSizeZ - this.settings.horizontalPositionMainGradient.MaxDistance, this.settings.horizontalPositionMainGradient.WeightAtMinDistance, this.settings.horizontalPositionMainGradient.WeightAtMaxDistance, this.settings.horizontalPositionMainGradient.weightPow);
      for (int index = positions.Count - 1; index >= 0; --index)
      {
        AIPositionWithScore position = positions[index];
        JVector pos = position.pos;
        float positionAlongField = this.GetHorizontalPositionAlongField(pos.Z, halfArenaSizeZ, team);
        float num = (double) pos.X <= (double) bottomCorner.X || (double) pos.X >= (double) topCorner.X ? 1f : 0.0f;
        position.score += this.EvaluateDistance(positionAlongField, this.settings.horizontalPositionOwnGoal);
        position.score += this.EvaluateDistance(arenaSizeZ - positionAlongField, this.settings.horizontalPositionEndZone) * num;
        position.score += this.EvaluateDistance(positionAlongField, gradient);
        positions[index] = position;
      }
    }

    protected virtual void EvaluatePassLinesToTeamMates(List<AIPositionWithScore> positions)
    {
      if ((double) this.settings.passLinesToTeamMatesWeight == 0.0)
        return;
      float num = 1f;
      List<GameEntity> teamMates = this.cache.GetTeamMates(this.owner.OwnerEntity);
      List<GameEntity> opponents = this.cache.GetOpponents(this.owner.OwnerEntity);
      List<GameEntity> bumpers = this.cache.Bumpers;
      float toTeamMatesWeight = this.settings.passLinesToTeamMatesWeight;
      for (int index1 = 0; index1 < teamMates.Count; ++index1)
      {
        JVector position2D = teamMates[index1].transform.Position2D;
        for (int index2 = positions.Count - 1; index2 >= 0; --index2)
        {
          AIPositionWithScore position = positions[index2];
          JVector pos = position.pos;
          this.owner.GetNearbyPlayersAlongWay(pos, position2D, num, opponents, this.evaluatePassLinesToTeamMates_Results);
          int count = this.evaluatePassLinesToTeamMates_Results.Count;
          this.owner.GetBumpersAlongWay(pos, position2D, num, bumpers, this.evaluatePassLinesToTeamMates_Results);
          if (this.evaluatePassLinesToTeamMates_Results.Count + count == 0)
          {
            position.score += toTeamMatesWeight;
            positions[index2] = position;
          }
        }
      }
    }

    [MethodImpl((MethodImplOptions) 256)]
    public float EvaluateDistance(float distance, AIPositionEvaluator.Gradient gradient)
    {
      float number = JMath.Clamp01((distance - gradient.MinDistance) / gradient.Range);
      float num = (double) gradient.weightPow != 1.0 ? JMath.Pow(number, gradient.weightPow) : number;
      return (gradient.WeightAtMinDistance + num * gradient.WeightRange) * gradient.weightScale;
    }

    [MethodImpl((MethodImplOptions) 256)]
    protected float GetHorizontalPositionAlongField(
      float positionZ,
      float halfArenaSizeZ,
      Team team)
    {
      float num = positionZ;
      if (team == Team.Beta)
        num *= -1f;
      return num + halfArenaSizeZ;
    }

    public struct Gradient
    {
      private float minDistance;
      private float maxDistance;
      private float range;
      private float weightAtMinDistance;
      private float weightAtMaxDistance;
      private float weightRange;
      public float weightScale;
      public float weightPow;

      public float Range => this.range;

      public float MinDistance
      {
        get => this.minDistance;
        set
        {
          this.minDistance = value;
          this.range = this.maxDistance - this.minDistance;
        }
      }

      public float MaxDistance
      {
        get => this.maxDistance;
        set
        {
          this.maxDistance = value;
          this.range = this.maxDistance - this.minDistance;
        }
      }

      public float WeightRange => this.weightRange;

      public float WeightAtMinDistance
      {
        get => this.weightAtMinDistance;
        set
        {
          this.weightAtMinDistance = value;
          this.weightRange = this.weightAtMaxDistance - this.weightAtMinDistance;
        }
      }

      public float WeightAtMaxDistance
      {
        get => this.weightAtMaxDistance;
        set
        {
          this.weightAtMaxDistance = value;
          this.weightRange = this.weightAtMaxDistance - this.weightAtMinDistance;
        }
      }

      public Gradient(
        float weightScale = 1f,
        float minDistance = 0.0f,
        float maxDistance = 1f,
        float weightAtMinDistance = -1f,
        float weightAtMaxDistance = 0.0f,
        float weightPow = 1f)
      {
        this.weightScale = weightScale;
        this.minDistance = minDistance;
        this.maxDistance = maxDistance;
        this.range = maxDistance - minDistance;
        this.weightAtMinDistance = weightAtMinDistance;
        this.weightAtMaxDistance = weightAtMaxDistance;
        this.weightRange = weightAtMaxDistance - weightAtMinDistance;
        this.weightPow = weightPow;
      }
    }

    public class Settings
    {
      public AIPositionEvaluator.Gradient bumperGradient = new AIPositionEvaluator.Gradient(minDistance: 1.5f, maxDistance: 2f);
      public AIPositionEvaluator.Gradient opponentGradient = new AIPositionEvaluator.Gradient(1.5f, 3f, 6.5f, weightPow: 3f);
      public AIPositionEvaluator.Gradient opponentGradientClose = new AIPositionEvaluator.Gradient(4f, 1.5f, 3f);
      public AIPositionEvaluator.Gradient teamMateGradient = new AIPositionEvaluator.Gradient(0.25f, 5f, 9f);
      public float teamMateFullPenaltyPos = 0.2f;
      public float teamMateZeroPenaltyPos = 0.1f;
      public AIPositionEvaluator.Gradient borderGradient = new AIPositionEvaluator.Gradient(0.2f, 1.5f, 2.2f);
      public AIPositionEvaluator.Gradient enemyGoalGradient = new AIPositionEvaluator.Gradient(4f, maxDistance: 20f, weightAtMinDistance: 1f, weightPow: 2f);
      public AIPositionEvaluator.Gradient enemyGoalGradientClose = new AIPositionEvaluator.Gradient(8f, maxDistance: 10f, weightAtMinDistance: 1f, weightPow: 2f);
      public AIPositionEvaluator.Gradient ownGoalGradient = new AIPositionEvaluator.Gradient(minDistance: 4f, maxDistance: 15f);
      public AIPositionEvaluator.Gradient horizontalPositionMainGradient = new AIPositionEvaluator.Gradient(15f, maxDistance: 3f, weightAtMinDistance: 0.0f, weightAtMaxDistance: 1f);
      public AIPositionEvaluator.Gradient horizontalPositionOwnGoal = new AIPositionEvaluator.Gradient(4f, 3f, 15f);
      public AIPositionEvaluator.Gradient horizontalPositionEndZone = new AIPositionEvaluator.Gradient(2f, 3f, 4f);
      public float passLinesToTeamMatesWeight = 0.5f;
    }
  }
}
