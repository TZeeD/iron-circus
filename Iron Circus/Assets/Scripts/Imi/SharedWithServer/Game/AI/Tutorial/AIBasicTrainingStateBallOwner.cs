// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Tutorial.AIBasicTrainingStateBallOwner
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Tutorial
{
  public class AIBasicTrainingStateBallOwner : AIStateBase
  {
    public JVector targetPos = new JVector(-6f, 0.0f, -14f);
    public float innerRange = 1.5f;
    public float outerRange = 2.5f;

    public AIBasicTrainingStateBallOwner(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Enter(AIStateBase prevState, ref Input input)
    {
      base.Enter(prevState, ref input);
      if ((double) (this.targetPos - this.owner.OwnerEntity.transform.Position2D).Length() >= (double) this.outerRange)
        return;
      this.owner.SetState(typeof (AIStateDefault), ref input);
    }

    public override void Reset()
    {
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      JVector vector = this.targetPos - this.owner.OwnerEntity.transform.Position2D;
      if ((double) vector.Length() > (double) this.innerRange)
      {
        input.moveDir = vector.Normalized();
      }
      else
      {
        input.moveDir = JVector.Backward;
        this.owner.SetState(typeof (AIStateDefault), ref input);
      }
      if (this.cache.BallOwner == this.owner.OwnerEntity)
        return;
      this.owner.SetState(typeof (AIStateDefault), ref input);
    }
  }
}
