// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.MoveCameraToTargetState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.Skills
{
  public class MoveCameraToTargetState : SkillState
  {
    public ConfigValue<float> cameraSpeed;
    public SkillVar<JVector> cameraTarget;

    protected override void EnterDerived() => this.skillGraph.GetContext().cameraTarget.overrideInProgress = true;

    protected override void TickDerived()
    {
      this.skillGraph.GetContext().cameraTarget.overrideInProgress = true;
      JVector position = this.skillGraph.GetContext().cameraTarget.position;
      JVector cameraTarget = (JVector) this.cameraTarget;
      JVector jvector1 = cameraTarget - position;
      float num1 = jvector1.Length();
      if ((double) num1 > 1.0 / 1000.0)
      {
        float num2 = this.cameraSpeed.Get() * this.skillGraph.GetFixedTimeStep();
        float num3 = (double) num2 > (double) num1 ? num1 : num2;
        jvector1.Normalize();
        JVector jvector2 = position + jvector1 * num3;
        this.skillGraph.GetContext().cameraTarget.position = jvector2;
      }
      else
      {
        this.skillGraph.GetContext().cameraTarget.position = cameraTarget;
        this.Exit_();
      }
    }

    protected override void ExitDerived() => this.skillGraph.GetContext().cameraTarget.overrideInProgress = false;
  }
}
