// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.WarsongAoePreview
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class WarsongAoePreview : CustomAoePreviewBase
  {
    private static readonly int _OutlineWidth = Shader.PropertyToID(nameof (_OutlineWidth));

    public override void SetAoe(AreaOfEffect aoe)
    {
      foreach (Transform scaleNode in this.scaleNodes)
        scaleNode.localScale = Vector3.one * aoe.radius;
      this.SetPropertyIfExists(WarsongAoePreview._OutlineWidth, 0.07f / aoe.radius);
      this.SetPropertyIfExists(FloorEffectBase._ColorBuildupBG, SingletonScriptableObject<ColorsConfig>.Instance.aoeColorNeutral);
    }
  }
}
