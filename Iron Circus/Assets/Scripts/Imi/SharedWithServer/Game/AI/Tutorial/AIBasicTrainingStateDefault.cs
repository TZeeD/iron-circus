// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Tutorial.AIBasicTrainingStateDefault
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Tutorial
{
  public class AIBasicTrainingStateDefault : AIStateDefault
  {
    private bool justEntered;

    public AIBasicTrainingStateDefault(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset()
    {
    }

    public override void Enter(AIStateBase prevState, ref Input input)
    {
      this.justEntered = true;
      base.Enter(prevState, ref input);
    }

    public override void Tick(ref Input input)
    {
      if (this.justEntered)
      {
        this.justEntered = false;
      }
      else
      {
        this.debugStringBuilder.Clear();
        GameEntity ownerEntity = this.owner.OwnerEntity;
        if (ownerEntity.playerTeam.value == Team.Alpha)
        {
          input = new Input(JVector.Zero, Imi.SharedWithServer.ScEntitas.Components.ButtonType.None);
        }
        else
        {
          GameEntity ballOwner = this.cache.BallOwner;
          if (ballOwner != null)
          {
            if (this.owner.IsBot(ballOwner) && this.cache.GetOpponents(ownerEntity).Contains(ballOwner))
              this.owner.SetState(typeof (AIStateOpponentOwnsBall), ref input);
            else if (ballOwner == ownerEntity)
              this.owner.SetState(typeof (AIBasicTrainingStateBallOwner), ref input);
          }
          input = new Input(JVector.Zero, Imi.SharedWithServer.ScEntitas.Components.ButtonType.None);
        }
      }
    }
  }
}
