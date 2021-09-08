// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.SlamAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class SlamAoePreview : AimableAoePreviewBase
  {
    protected static readonly int _MinRadius = Shader.PropertyToID(nameof (_MinRadius));
    protected static readonly int _MaxRadius = Shader.PropertyToID(nameof (_MaxRadius));
    protected static readonly int _Angle = Shader.PropertyToID(nameof (_Angle));
    protected float offset;
    protected SkillVar<bool> isParented;
    protected SkillVar<JVector> jumpDir;
    protected SkillVar<JVector> jumpStartPos;

    protected override float GetAimOffset() => this.offset;

    public override void SetAoe(AreaOfEffect aoe)
    {
      this.SetPropertyIfExists(SlamAoePreview._MinRadius, aoe.deadZone);
      this.SetPropertyIfExists(SlamAoePreview._MaxRadius, aoe.radius);
      this.SetPropertyIfExists(SlamAoePreview._Angle, aoe.angle);
    }

    public override void SetSkillGraph(SkillGraph graph)
    {
      base.SetSkillGraph(graph);
      this.offset = ((SlamConfig) graph.GetConfig()).aoeOffset;
      this.isParented = graph.GetVar<bool>("ParentAoE");
      this.jumpDir = this.skillGraph.GetVar<JVector>("AimDir");
      this.jumpStartPos = this.skillGraph.GetVar<JVector>("JumpStartPos");
    }

    protected override void Update()
    {
      base.Update();
      if (this.isParented.Get())
      {
        this.UpdateTransform();
      }
      else
      {
        Vector3 vector3 = this.jumpDir.Get().ToVector3();
        this.transform.position = this.jumpStartPos.Get().ToVector3() + vector3 * this.GetAimOffset();
        this.transform.rotation = Quaternion.LookRotation(vector3);
      }
    }
  }
}
