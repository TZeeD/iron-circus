// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.PutridDischargePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class PutridDischargePreview : AimableAoePreviewBase
  {
    protected static readonly int _MinRadius = Shader.PropertyToID(nameof (_MinRadius));
    protected static readonly int _MaxRadius = Shader.PropertyToID(nameof (_MaxRadius));
    protected static readonly int _Angle = Shader.PropertyToID(nameof (_Angle));
    protected float offset;
    [SerializeField]
    private MeshFilter mesh;

    protected override void Start()
    {
      base.Start();
      this.mesh.mesh.bounds = new Bounds(Vector3.zero, Vector3.one * 500f);
    }

    protected override float GetAimOffset() => this.offset;

    public override void SetAoe(AreaOfEffect aoe)
    {
      this.SetPropertyIfExists(PutridDischargePreview._MinRadius, aoe.deadZone);
      this.SetPropertyIfExists(PutridDischargePreview._MaxRadius, aoe.radius);
      this.SetPropertyIfExists(PutridDischargePreview._Angle, aoe.angle);
    }

    public override void SetSkillGraph(SkillGraph graph)
    {
      base.SetSkillGraph(graph);
      this.offset = ((PutridDischargeConfig) graph.GetConfig()).aoeOffset;
    }

    protected override void Update()
    {
      base.Update();
      this.UpdateTransform();
    }
  }
}
