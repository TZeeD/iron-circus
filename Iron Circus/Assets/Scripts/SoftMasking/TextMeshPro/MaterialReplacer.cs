// Decompiled with JetBrains decompiler
// Type: SoftMasking.TextMeshPro.MaterialReplacer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SoftMasking.TextMeshPro
{
  [GlobalMaterialReplacer]
  public class MaterialReplacer : IMaterialReplacer
  {
    public int order => 10;

    public Material Replace(Material material)
    {
      if ((bool) (Object) material && (bool) (Object) material.shader && material.shader.name.StartsWith("TextMeshPro/"))
      {
        Shader shader = Shader.Find("Soft Mask/" + material.shader.name);
        if ((bool) (Object) shader)
        {
          Material material1 = new Material(shader);
          material1.CopyPropertiesFromMaterial(material);
          return material1;
        }
      }
      return (Material) null;
    }
  }
}
