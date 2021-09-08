// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Tutorial.AIBasicTrainingOpponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.AI.States;

namespace Imi.SharedWithServer.Game.AI.Tutorial
{
  public class AIBasicTrainingOpponent : AIStateMachine
  {
    public AIBasicTrainingOpponent(
      GameEntity playerEntity,
      AIDifficulty difficulty,
      AIRole role,
      AICache cache)
      : base(playerEntity, difficulty, role, cache)
    {
      this.AddState((AIStateBase) new AIBasicTrainingStateDefault((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIStateOpponentOwnsBall((AIStateMachine) this, cache));
      this.AddState((AIStateBase) new AIBasicTrainingStateBallOwner((AIStateMachine) this, cache));
      this.SetState(typeof (AIBasicTrainingStateDefault));
    }
  }
}
