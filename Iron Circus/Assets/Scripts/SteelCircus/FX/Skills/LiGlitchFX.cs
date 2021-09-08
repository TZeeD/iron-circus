// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.LiGlitchFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX.Skills
{
  [ExecuteInEditMode]
  public class LiGlitchFX : MonoBehaviour
  {
    public float glitchRange = 1f;
    public float glitchFalloff = 0.2f;
    public Renderer liRenderer;
    private Material[] glitchMaterials;

    private void Awake()
    {
      if (!Application.isPlaying)
        return;
      this.glitchMaterials = this.liRenderer.GetComponent<Renderer>().materials;
    }

    private void Update()
    {
      if ((Object) this.liRenderer == (Object) null)
        return;
      Material[] materialArray = this.glitchMaterials;
      if (!Application.isPlaying)
        materialArray = this.liRenderer.GetComponent<Renderer>().sharedMaterials;
      Vector3 position = this.transform.position;
      float x = this.liRenderer.transform.lossyScale.x;
      for (int index = 0; index < materialArray.Length; ++index)
      {
        Material material = materialArray[index];
        material.SetVector("_GlitchCenter", new Vector4(position.x, position.y, position.z, 0.0f));
        material.SetFloat("_GlitchFull", this.glitchRange);
        material.SetFloat("_GlitchFalloffSize", this.glitchFalloff);
        material.SetFloat("_WorldSpaceScale", x);
      }
    }
  }
}
