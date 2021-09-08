// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PlayRazerAnimation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Utils;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PlayRazerAnimation : SkillAction
  {
    public RazerAnimType razerAnimType;
    public int animationIndex;

    protected override void PerformActionInternal()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      switch (this.razerAnimType)
      {
        case RazerAnimType.Champion:
          RazerChampionSkillAnimations.ShowChampionEffect(owner, this.animationIndex);
          break;
        case RazerAnimType.Ball:
          RazerChampionSkillAnimations.ShowBallEffect(owner, this.animationIndex);
          break;
        case RazerAnimType.Team:
          RazerChampionSkillAnimations.ShowTeamEffect(owner);
          break;
      }
    }
  }
}
