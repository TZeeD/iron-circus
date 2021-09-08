// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.BarrierAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class BarrierAoePreview : AimableAoePreviewBase
  {
    private JVector barrierDimensions;
    private float barrierOffset = 1f;

    public override void SetAoe(AreaOfEffect aoe)
    {
      base.SetAoe(aoe);
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = new Vector3(aoe.rectWidth, 1f, aoe.rectLength);
      this.SetPropertyIfExists(FloorEffectBase._ColorBuildupBG, SingletonScriptableObject<ColorsConfig>.Instance.aoeColorNeutral);
    }

    public override void SetSkillGraph(SkillGraph graph)
    {
      base.SetSkillGraph(graph);
      BarrierConfig config = (BarrierConfig) graph.GetConfig();
      this.barrierOffset = config.barrierOffset;
      this.barrierDimensions = config.barrierDimensions;
    }

    protected override float GetAimOffset() => this.barrierOffset + this.barrierDimensions.Z / 2f;
  }
}
