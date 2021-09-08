// Decompiled with JetBrains decompiler
// Type: SharedWithServer.AI.States.AIStateSetupPoint
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.AI.States;
using Imi.SharedWithServer.Game.AI;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace SharedWithServer.AI.States
{
  public class AIStateSetupPoint : AIStateBase
  {
    private int lastMockPositionTick;
    private int mockPositionUpdateInterval = 15;
    private JVector mockTargetPosition;

    public AIStateSetupPoint(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset()
    {
    }

    public override void Exit(AIStateBase nextState, ref Input input)
    {
      switch (this.context.matchState.value)
      {
        case Imi.SharedWithServer.Game.MatchState.GetReady:
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          this.owner.SetState(typeof (AIStateSetupPoint), ref input);
          break;
        default:
          this.owner.GetState(typeof (AIStateBallOwner)).Reset();
          this.owner.GetState(typeof (AIStateOpponentOwnsBall)).Reset();
          this.owner.GetState(typeof (AIStateBallMoving)).Reset();
          break;
      }
    }

    public override void Tick(ref Input input)
    {
      Imi.SharedWithServer.Game.MatchState matchState = this.context.matchState.value;
      int tick = this.cache.GetTick();
      GameEntity ownerEntity = this.owner.OwnerEntity;
      if (matchState != Imi.SharedWithServer.Game.MatchState.GetReady && matchState != Imi.SharedWithServer.Game.MatchState.StartPoint)
      {
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      else
      {
        JVector position2D1 = this.cache.Ball.transform.Position2D;
        JVector position2D2 = ownerEntity.transform.Position2D;
        float num1 = (position2D2 - position2D1).LengthSquared();
        GameEntity virtualBallOwner = ownerEntity;
        List<GameEntity> teamMates = this.cache.GetTeamMates(ownerEntity);
        for (int index = 0; index < teamMates.Count; ++index)
        {
          float num2 = (teamMates[index].transform.Position2D - position2D1).LengthSquared();
          if ((double) num2 < (double) num1)
          {
            virtualBallOwner = teamMates[index];
            num1 = num2;
          }
        }
        if (virtualBallOwner == ownerEntity)
        {
          (this.cache.BallOwner != ownerEntity ? (this.cache.BallOwner == null || !this.cache.GetOpponents(ownerEntity).Contains(this.cache.BallOwner) ? this.owner.GetState(typeof (AIStateBallMoving)) : this.owner.GetState(typeof (AIStateOpponentOwnsBall))) : this.owner.GetState(typeof (AIStateBallOwner))).Tick(ref input);
        }
        else
        {
          AIStateTeamMateOwnsBall state = (AIStateTeamMateOwnsBall) this.owner.GetState(typeof (AIStateTeamMateOwnsBall));
          if (tick >= this.lastMockPositionTick + this.mockPositionUpdateInterval)
          {
            this.lastMockPositionTick = tick;
            state.FindTargetPositionForVirtualBallOwner(virtualBallOwner, out this.mockTargetPosition, out bool _);
          }
          JVector jvector = (this.mockTargetPosition - position2D2).Normalized();
          input.moveDir = jvector;
        }
      }
    }
  }
}
