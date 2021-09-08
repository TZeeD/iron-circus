// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.InvisibleState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Game.Skills
{
  public class InvisibleState : SkillState
  {
    private SkillVar<bool> exit;

    public override void Initialize() => this.exit = this.skillGraph.AddVar<bool>("[InvisibleState][" + this.name + "]Internal");

    protected override void EnterDerived()
    {
      this.exit.Set(false);
      this.skillGraph.GetOwner().AddStatusEffect(this.skillGraph.GetContext(), StatusEffect.Invisible(1000f, this.exit));
    }

    protected override void ExitDerived() => this.exit.Set(true);
  }
}
