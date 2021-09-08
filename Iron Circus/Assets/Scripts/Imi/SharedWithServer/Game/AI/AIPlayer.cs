// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.AIPlayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.AI.States;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.AI.States;

namespace Imi.SharedWithServer.Game.AI
{
  public class AIPlayer : AIStateMachine
  {
    public AIPlayer(GameEntity playerEntity, AIDifficulty difficulty, AIRole role, AICache cache)
      : base(playerEntity, difficulty, role, cache)
    {
      this.AddState((AIStateBase) new AIStateDefault((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateBallOwner((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateTeamMateOwnsBall((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateOpponentOwnsBall((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateBallMoving((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateGoalCutScene((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateSetupPoint((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateStunned((AIStateMachine) this, cache));
      this.SetState(typeof (AIStateDefault));
    }

    public override void Tick(ref Input input)
    {
      base.Tick(ref input);
      if (this.ownerEntity.IsDead())
        return;
      switch (this.context.matchState.value)
      {
        case Imi.SharedWithServer.Game.MatchState.GetReady:
        case Imi.SharedWithServer.Game.MatchState.StartPoint:
          this.SetState(typeof (AIStateSetupPoint), ref input);
          break;
        case Imi.SharedWithServer.Game.MatchState.Goal:
          this.SetState(typeof (AIStateGoalCutScene), ref input);
          break;
      }
      if (this.OwnerEntity.statusEffect.HasEffect(StatusEffectType.Stun) || this.OwnerEntity.statusEffect.HasEffect(StatusEffectType.Push))
        this.SetState(typeof (AIStateStunned), ref input);
      if (this.difficulty > AIDifficulty.Tutorial)
        return;
      input.moveDir *= 0.65f;
    }

    protected override void SetupDifficulty()
    {
      if (this.difficulty <= AIDifficulty.Tutorial)
        this.scaleGoalPredictionTime = 0.65f;
      if (this.difficulty <= AIDifficulty.Easy)
        this.canSampleGeometryGoals = false;
      if (this.difficulty < AIDifficulty.Expert)
        return;
      this.penalizePassingToBots = false;
    }

    protected override void SetupRole()
    {
    }
  }
}
