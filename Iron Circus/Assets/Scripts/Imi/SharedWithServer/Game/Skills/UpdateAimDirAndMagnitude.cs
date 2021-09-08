// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.UpdateAimDirAndMagnitude
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.Skills
{
  public class UpdateAimDirAndMagnitude : SkillState
  {
    public SkillVar<JVector> aimDir;
    public SkillVar<float> aimMagnitude;
    public bool dontCacheLastAim;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void EnterDerived()
    {
      this.skillGraph.ResetLastAimDir();
      this.aimDir?.Set(this.skillGraph.GetLookDir());
      this.aimMagnitude?.Set(1f);
    }

    protected override void TickDerived()
    {
      if (this.dontCacheLastAim)
      {
        JVector aimInputOrLookDir = this.skillGraph.GetAimInputOrLookDir();
        this.aimDir?.Set(aimInputOrLookDir.Normalized());
        this.aimMagnitude?.Set(aimInputOrLookDir.Length());
      }
      else
      {
        JVector lastNonZeroAimDir = this.skillGraph.GetLastNonZeroAimDir();
        float num = lastNonZeroAimDir.Length();
        JVector jvector = lastNonZeroAimDir;
        jvector.X /= num;
        jvector.Y = 0.0f;
        jvector.Z /= num;
        this.aimDir?.Set(jvector);
        this.aimMagnitude?.Set(num);
      }
    }
  }
}
