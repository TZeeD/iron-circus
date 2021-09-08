// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.AI.States.AIStateBallMoving
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game.AI;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.SharedWithServer.AI.States
{
  public class AIStateBallMoving : AIStateBase
  {
    private int lastMockPositionTick;
    private int mockPositionUpdateInterval = 15;
    private JVector mockTargetPosition;
    private List<GameEntity> evaluateIntercept_BallHitTriggers = new List<GameEntity>(8);

    public AIStateBallMoving(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset()
    {
    }

    public override void Exit(AIStateBase nextState, ref Input input)
    {
      base.Exit(nextState, ref input);
      input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      if (this.cache.BallOwner != null)
      {
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      else
      {
        GameEntity ownerEntity = this.owner.OwnerEntity;
        JVector position2D = ownerEntity.transform.Position2D;
        int tick = this.cache.GetTick();
        bool shouldIntercept;
        bool shouldSprint;
        JVector interceptMoveDir;
        GameEntity interceptingPlayer;
        this.EvaluateIntercept(out shouldIntercept, out shouldSprint, out interceptMoveDir, out interceptingPlayer);
        input.downButtons &= ~Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
        if (shouldIntercept)
          input.moveDir = interceptMoveDir;
        else if (interceptingPlayer != null)
        {
          if (this.cache.GetTeamMates(ownerEntity).Contains(interceptingPlayer))
          {
            AIStateTeamMateOwnsBall state = (AIStateTeamMateOwnsBall) this.owner.GetState(typeof (AIStateTeamMateOwnsBall));
            if (tick >= this.lastMockPositionTick + this.mockPositionUpdateInterval)
            {
              this.lastMockPositionTick = tick;
              state.FindTargetPositionForVirtualBallOwner(interceptingPlayer, out this.mockTargetPosition, out shouldSprint);
            }
            else
              shouldSprint = state.ShouldSprintToTargetPos(interceptingPlayer, this.mockTargetPosition);
            input.moveDir = (this.mockTargetPosition - position2D).Normalized();
          }
          else if (this.cache.GetOpponents(ownerEntity).Contains(interceptingPlayer))
          {
            AIStateOpponentOwnsBall state = (AIStateOpponentOwnsBall) this.owner.GetState(typeof (AIStateOpponentOwnsBall));
            if (tick >= this.lastMockPositionTick + this.mockPositionUpdateInterval)
            {
              this.lastMockPositionTick = tick;
              state.FindTargetPositionForVirtualBallOwner(interceptingPlayer, out this.mockTargetPosition, out shouldSprint);
            }
            else
              shouldSprint = state.ShouldSprintToTargetPos(interceptingPlayer, this.mockTargetPosition);
            input.moveDir = (this.mockTargetPosition - position2D).Normalized();
          }
          else
          {
            Log.Error(string.Format("interceptor is neither team mate nor opponent (and shouldn't be our own player). ID: {0}", (object) ownerEntity.playerId.value));
            input.moveDir = interceptMoveDir;
          }
        }
        else
          input.moveDir = interceptMoveDir;
        if (!shouldSprint)
          return;
        input.downButtons |= Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint;
      }
    }

    private void EvaluateIntercept(
      out bool shouldIntercept,
      out bool shouldSprint,
      out JVector interceptMoveDir,
      out GameEntity interceptingPlayer)
    {
      interceptingPlayer = (GameEntity) null;
      shouldIntercept = false;
      shouldSprint = false;
      GameEntity ownerEntity = this.owner.OwnerEntity;
      bool canIntercept1;
      JVector moveDir1;
      float timeToReach1;
      this.cache.GetBallInterceptData(ownerEntity, false, out canIntercept1, out moveDir1, out timeToReach1);
      bool canIntercept2;
      JVector moveDir2;
      float timeToReach2;
      this.cache.GetBallInterceptData(ownerEntity, true, out canIntercept2, out moveDir2, out timeToReach2);
      GameEntity ball = this.cache.Ball;
      JVector position = ball.transform.Position2D;
      JVector velocity = ball.velocityOverride.value;
      this.owner.PredictBallPosition(position, velocity, 1f, out position, out velocity, this.evaluateIntercept_BallHitTriggers);
      if (this.evaluateIntercept_BallHitTriggers.Count != 0 && this.evaluateIntercept_BallHitTriggers.Contains(this.cache.GetOwnGoal(ownerEntity)))
      {
        shouldIntercept = true;
        shouldSprint = true;
        if (this.cache.CanSprint(ownerEntity))
          interceptMoveDir = moveDir2;
        else
          interceptMoveDir = moveDir1;
      }
      else
      {
        interceptMoveDir = moveDir1;
        bool flag1 = false;
        float num1 = 1000f;
        GameEntity gameEntity1 = (GameEntity) null;
        bool canIntercept3;
        JVector moveDir3;
        float timeToReach3;
        foreach (GameEntity teamMate in this.cache.GetTeamMates(ownerEntity))
        {
          this.cache.GetBallInterceptData(teamMate, false, out canIntercept3, out moveDir3, out timeToReach3);
          if (canIntercept3 && (double) timeToReach3 < (double) num1)
          {
            flag1 = canIntercept3;
            num1 = timeToReach3;
            gameEntity1 = teamMate;
          }
        }
        bool flag2 = false;
        bool flag3 = false;
        float num2 = 1000f;
        float num3 = 1000f;
        List<GameEntity> opponents = this.cache.GetOpponents(ownerEntity);
        GameEntity gameEntity2 = (GameEntity) null;
        GameEntity gameEntity3 = (GameEntity) null;
        foreach (GameEntity player in opponents)
        {
          this.cache.GetBallInterceptData(player, false, out canIntercept3, out moveDir3, out timeToReach3);
          if (canIntercept3 && (double) timeToReach3 < (double) num2)
          {
            flag2 = canIntercept3;
            num2 = timeToReach3;
            gameEntity2 = player;
          }
          this.cache.GetBallInterceptData(player, true, out canIntercept3, out moveDir3, out timeToReach3);
          canIntercept3 &= this.cache.CanSprint(player);
          if (canIntercept3 && (double) timeToReach3 < (double) num3)
          {
            flag3 = canIntercept3;
            num3 = timeToReach3;
            gameEntity3 = player;
          }
        }
        bool flag4 = canIntercept2 & this.cache.CanSprint(ownerEntity);
        float val2 = num2 - 0.2f;
        float val1 = num3 - 0.2f;
        float num4 = timeToReach1 - 0.3f;
        float num5 = timeToReach2 - 0.3f;
        bool flag5 = flag1 && (!flag2 && !flag3 || (double) num1 < (double) val2 && !flag3 || (double) num1 < (double) val1 & flag3);
        if (canIntercept1)
        {
          if (flag5)
          {
            if ((double) num1 < (double) num4)
            {
              shouldIntercept = false;
              shouldSprint = false;
              interceptingPlayer = gameEntity1;
            }
            else
            {
              shouldIntercept = true;
              shouldSprint = false;
              interceptingPlayer = (GameEntity) null;
            }
          }
          else if (!flag2 && !flag3 || (double) num4 < (double) val2 && !flag3 || (double) num4 < (double) val1 & flag3)
          {
            shouldIntercept = true;
            shouldSprint = false;
            interceptingPlayer = (GameEntity) null;
          }
          else if (flag4 && ((double) num5 < (double) val2 && !flag3 || (double) num5 < (double) val1 & flag3))
          {
            shouldIntercept = true;
            shouldSprint = true;
            interceptingPlayer = (GameEntity) null;
            interceptMoveDir = moveDir2;
          }
          else
          {
            shouldIntercept = false;
            shouldSprint = false;
            interceptingPlayer = (double) val1 < (double) val2 ? gameEntity3 : gameEntity2;
          }
        }
        else if (flag4)
        {
          if (!flag5 && ((double) num5 < (double) val2 && !flag3 || (double) num5 < (double) val1 & flag3))
          {
            shouldIntercept = true;
            shouldSprint = true;
            interceptingPlayer = (GameEntity) null;
            interceptMoveDir = moveDir2;
          }
          else
          {
            shouldIntercept = false;
            shouldSprint = false;
            interceptingPlayer = (double) JMath.Min(val1, val2) > (double) num1 ? gameEntity1 : ((double) val1 < (double) val2 ? gameEntity3 : gameEntity2);
          }
        }
        else if (!flag5 && !(flag2 | flag3))
        {
          shouldIntercept = true;
          shouldSprint = false;
          interceptingPlayer = (GameEntity) null;
        }
        else
        {
          shouldIntercept = false;
          shouldSprint = false;
          interceptingPlayer = (double) JMath.Min(val1, val2) > (double) num1 ? gameEntity1 : ((double) val1 < (double) val2 ? gameEntity3 : gameEntity2);
        }
      }
    }
  }
}
