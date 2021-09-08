// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateBaseWithPositionEvaluator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.AI.States
{
  public abstract class AIStateBaseWithPositionEvaluator : AIStateBase
  {
    protected AIPositionEvaluator positionEvaluator;
    protected int numPositionSamples = 50;
    protected AIPositionWithScore currentTargetPos;
    protected int lastTargetPosEvalTick = -1;
    protected float originalTargetPosScore;
    protected float currentPosScore;
    protected float defaultTargetPosEvalIntervalInTicks = 15f;
    private List<AIPositionWithScore> evaluateSinglePosition_List = new List<AIPositionWithScore>(1);
    private List<AIPositionWithScore> checkSinglePositionForEarlyRejection_List = new List<AIPositionWithScore>(1);
    private List<AIPositionWithScore> checkPositionsForEarlyRejection_CopyList = new List<AIPositionWithScore>(200);
    private List<AIPositionWithScore> findTargetPos_Positions = new List<AIPositionWithScore>(100);

    protected AIStateBaseWithPositionEvaluator(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    protected override void Init()
    {
      this.positionEvaluator = new AIPositionEvaluator(this.GetPositionEvaluatorSettings(), (BaseAI) this.owner, this.cache);
      this.SetupDifficulty();
      this.SetupRole();
    }

    protected abstract AIPositionEvaluator.Settings GetPositionEvaluatorSettings();

    public override void Reset() => this.lastTargetPosEvalTick = -1;

    protected virtual void UpdateTargetPos()
    {
      this.currentPosScore = this.EvaluateSinglePosition(this.owner.OwnerEntity.transform.Position2D);
      this.currentTargetPos.score = this.EvaluateSinglePosition(this.currentTargetPos.pos);
      if (!this.ShouldReevaluateTargetPos())
        return;
      this.currentTargetPos = this.FindTargetPos();
      this.lastTargetPosEvalTick = this.context.globalTime.currentTick;
      this.originalTargetPosScore = this.currentTargetPos.score;
    }

    protected float EvaluateSinglePosition(JVector position)
    {
      this.evaluateSinglePosition_List.Clear();
      this.evaluateSinglePosition_List.Add(new AIPositionWithScore(position, 0.0f));
      this.EvaluatePositions(this.evaluateSinglePosition_List);
      this.SortTargetPositions(this.evaluateSinglePosition_List);
      return this.evaluateSinglePosition_List[0].score;
    }

    protected virtual void EvaluatePositions(List<AIPositionWithScore> positions) => this.positionEvaluator.Evaluate(positions);

    protected bool CheckSinglePositionForEarlyRejection(JVector position)
    {
      this.checkSinglePositionForEarlyRejection_List.Clear();
      this.checkSinglePositionForEarlyRejection_List.Add(new AIPositionWithScore(position, 0.0f));
      this.CheckPositionsForEarlyRejection(this.checkSinglePositionForEarlyRejection_List);
      return (uint) this.checkSinglePositionForEarlyRejection_List.Count > 0U;
    }

    protected void CheckPositionsForEarlyRejection(List<AIPositionWithScore> positions)
    {
      this.checkPositionsForEarlyRejection_CopyList.Clear();
      float num1 = this.cache.ArenaSizeX / 2f;
      float num2 = this.cache.ArenaSizeZ / 2f;
      JVector topCorner;
      JVector bottomCorner;
      this.cache.GetEnemyGoalCorners(this.owner.OwnerEntity, out topCorner, out bottomCorner, 0.5f);
      for (int index = 0; index < positions.Count; ++index)
      {
        AIPositionWithScore position = positions[index];
        JVector pos = position.pos;
        bool flag = (double) JMath.Abs(pos.Z) > (double) num2;
        if ((double) pos.X > (double) bottomCorner.X && (double) pos.X < (double) topCorner.X)
          flag = false;
        if (!((double) JMath.Abs(pos.X) > (double) num1 | flag))
          this.checkPositionsForEarlyRejection_CopyList.Add(position);
      }
      foreach (GameEntity bumper in this.cache.Bumpers)
      {
        JVector pos;
        float radius;
        this.cache.GetBumperVolume(bumper, out pos, out radius);
        float num3 = radius * radius;
        for (int index = this.checkPositionsForEarlyRejection_CopyList.Count - 1; index >= 0; --index)
        {
          if ((double) (this.checkPositionsForEarlyRejection_CopyList[index].pos - pos).LengthSquared() < (double) num3)
            this.checkPositionsForEarlyRejection_CopyList.RemoveAt(index);
        }
      }
      positions.Clear();
      positions.AddRange((IEnumerable<AIPositionWithScore>) this.checkPositionsForEarlyRejection_CopyList);
    }

    protected virtual bool ShouldReevaluateTargetPos()
    {
      JVector position2D = this.owner.OwnerEntity.transform.Position2D;
      return (double) (this.context.globalTime.currentTick - this.lastTargetPosEvalTick) >= (double) this.GetReevaluateTargetPosInterval() || (double) (position2D - this.currentTargetPos.pos).LengthSquared() < 1.0;
    }

    protected virtual float GetReevaluateTargetPosInterval()
    {
      float evalIntervalInTicks = this.defaultTargetPosEvalIntervalInTicks;
      if ((double) this.currentPosScore > (double) this.currentTargetPos.score)
        evalIntervalInTicks *= 0.5f;
      if ((double) this.currentTargetPos.score < (double) this.originalTargetPosScore - 0.5)
        evalIntervalInTicks *= 0.5f;
      return evalIntervalInTicks;
    }

    protected virtual void GenerateTargetPosSampleList(
      List<AIPositionWithScore> positions,
      float minSearchRadius = 2.5f,
      float maxSearchRadius = 8f)
    {
      positions.Clear();
      JVector position = this.owner.OwnerEntity.transform.position;
      for (int index = 0; index < this.numPositionSamples; ++index)
      {
        JVector jvector = this.owner.RandomUnitVector2();
        double num1 = (double) this.owner.RandomFloat();
        float num2 = (float) (num1 * ((double) maxSearchRadius - (double) minSearchRadius)) + minSearchRadius;
        float num3 = (float) (num1 * ((double) maxSearchRadius - (double) minSearchRadius)) + minSearchRadius;
        jvector.X *= num2;
        jvector.Z *= num3;
        JVector pos = position + jvector;
        float score = 0.0f;
        positions.Add(new AIPositionWithScore(pos, score));
      }
      this.CheckPositionsForEarlyRejection(positions);
    }

    protected virtual void SortTargetPositions(List<AIPositionWithScore> positions)
    {
      if (positions.Count == 0)
      {
        JVector position = this.owner.OwnerEntity.transform.position;
        positions.Add(new AIPositionWithScore(position, -100000f));
      }
      positions.Sort((Comparison<AIPositionWithScore>) ((x, y) => -1 * x.score.CompareTo(y.score)));
    }

    protected virtual AIPositionWithScore PickTargetPosFromSortedList(
      List<AIPositionWithScore> positions)
    {
      return positions[0];
    }

    protected AIPositionWithScore FindTargetPos(
      float minSearchRadius = 2.5f,
      float maxSearchRadius = 8f)
    {
      this.GenerateTargetPosSampleList(this.findTargetPos_Positions, minSearchRadius, maxSearchRadius);
      this.EvaluatePositions(this.findTargetPos_Positions);
      this.SortTargetPositions(this.findTargetPos_Positions);
      return this.PickTargetPosFromSortedList(this.findTargetPos_Positions);
    }
  }
}
