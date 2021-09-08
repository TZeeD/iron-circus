// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.OverrideCameraTargetState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.Skills
{
  public class OverrideCameraTargetState : SkillState
  {
    public SkillVar<JVector> cameraTarget;

    protected override void EnterDerived() => this.skillGraph.GetContext().cameraTarget.overrideInProgress = true;

    protected override void TickDerived()
    {
      this.skillGraph.GetContext().cameraTarget.overrideInProgress = true;
      this.skillGraph.GetContext().cameraTarget.position = (JVector) this.cameraTarget;
    }

    protected override void ExitDerived() => this.skillGraph.GetContext().cameraTarget.overrideInProgress = false;
  }
}
