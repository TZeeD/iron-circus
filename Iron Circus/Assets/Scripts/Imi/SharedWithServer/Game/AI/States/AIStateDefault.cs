// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateDefault
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.AI.States;

namespace Imi.SharedWithServer.Game.AI.States
{
  public class AIStateDefault : AIStateBase
  {
    public AIStateDefault(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset()
    {
    }

    public override void Enter(AIStateBase prevState, ref Input input)
    {
      base.Enter(prevState, ref input);
      if (prevState is AIStateSetupPoint)
        return;
      this.Tick(ref input);
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      GameEntity ownerEntity = this.owner.OwnerEntity;
      GameEntity ballOwner = this.cache.BallOwner;
      if (ballOwner != null)
      {
        if (ballOwner == ownerEntity)
          this.owner.SetState(typeof (AIStateBallOwner), ref input);
        else if (this.cache.GetTeamMates(ownerEntity).Contains(ballOwner))
        {
          this.owner.SetState(typeof (AIStateTeamMateOwnsBall), ref input);
        }
        else
        {
          if (!this.cache.GetOpponents(ownerEntity).Contains(ballOwner))
            return;
          this.owner.SetState(typeof (AIStateOpponentOwnsBall), ref input);
        }
      }
      else
        this.owner.SetState(typeof (AIStateBallMoving), ref input);
    }
  }
}
