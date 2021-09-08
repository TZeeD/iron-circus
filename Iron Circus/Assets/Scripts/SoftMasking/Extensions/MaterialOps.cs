// Decompiled with JetBrains decompiler
// Type: SoftMasking.Extensions.MaterialOps
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SoftMasking.Extensions
{
  public static class MaterialOps
  {
    public static bool SupportsSoftMask(this Material mat) => mat.HasProperty("_SoftMask");

    public static bool HasDefaultUIShader(this Material mat) => (Object) mat.shader == (Object) Canvas.GetDefaultCanvasMaterial().shader;

    public static bool HasDefaultETC1UIShader(this Material mat) => (Object) mat.shader == (Object) Canvas.GetETC1SupportedCanvasMaterial().shader;

    public static void EnableKeyword(this Material mat, string keyword, bool enabled)
    {
      if (enabled)
        mat.EnableKeyword(keyword);
      else
        mat.DisableKeyword(keyword);
    }
  }
}
