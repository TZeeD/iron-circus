// Decompiled with JetBrains decompiler
// Type: SharedWithServer.AI.States.AIStateStunned
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.AI;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace SharedWithServer.AI.States
{
  public class AIStateStunned : AIStateBase
  {
    private int delayToReturnToNormalOperations;
    private int delayToReturnToNormalOperationsCounter;

    public AIStateStunned(AIStateMachine owner, AICache cache)
      : base(owner, cache)
    {
    }

    public override void Reset() => this.delayToReturnToNormalOperationsCounter = this.delayToReturnToNormalOperations;

    protected override void SetupDifficulty()
    {
      base.SetupDifficulty();
      if (this.owner.Difficulty <= AIDifficulty.Tutorial)
      {
        this.delayToReturnToNormalOperations = 30;
      }
      else
      {
        if (this.owner.Difficulty > AIDifficulty.Easy)
          return;
        this.delayToReturnToNormalOperations = 5;
      }
    }

    public override void Tick(ref Input input)
    {
      input.aimDir = input.moveDir = JVector.Zero;
      input.downButtons &= ~ButtonType.Tackle;
      input.downButtons &= ~ButtonType.ThrowBall;
      input.downButtons &= ~ButtonType.Sprint;
      if (this.owner.OwnerEntity.statusEffect.HasEffect(StatusEffectType.Stun) || this.owner.OwnerEntity.statusEffect.HasEffect(StatusEffectType.Push))
        return;
      --this.delayToReturnToNormalOperationsCounter;
      if (this.delayToReturnToNormalOperationsCounter > 0)
        return;
      this.owner.SetState(typeof (AIStateDefault), ref input);
    }
  }
}
