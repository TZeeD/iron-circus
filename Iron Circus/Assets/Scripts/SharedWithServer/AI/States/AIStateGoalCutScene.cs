// Decompiled with JetBrains decompiler
// Type: SharedWithServer.AI.States.AIStateGoalCutScene
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.AI;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace SharedWithServer.AI.States
{
  public class AIStateGoalCutScene : AIStateBase
  {
    public AIStateGoalCutScene(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset()
    {
    }

    public override void Tick(ref Input input)
    {
      if (this.context.matchState.value != Imi.SharedWithServer.Game.MatchState.Goal)
      {
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      else
      {
        JVector position2D = this.owner.OwnerEntity.transform.Position2D;
        JVector zero = JVector.Zero;
        JVector moveDir = (zero - position2D).Normalized();
        if ((double) (zero - position2D).Length() < 10.0)
          moveDir = JVector.Zero;
        input = new Input(moveDir, JVector.Zero, Imi.SharedWithServer.ScEntitas.Components.ButtonType.None);
      }
    }
  }
}
