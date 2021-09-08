// Decompiled with JetBrains decompiler
// Type: TFHC_Shader_Samples.highlightAnimated
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace TFHC_Shader_Samples
{
  public class highlightAnimated : MonoBehaviour
  {
    private Material mat;

    private void Start() => this.mat = this.GetComponent<Renderer>().material;

    private void OnMouseEnter() => this.switchhighlighted(true);

    private void OnMouseExit() => this.switchhighlighted(false);

    private void switchhighlighted(bool highlighted) => this.mat.SetFloat("_Highlighted", highlighted ? 1f : 0.0f);
  }
}
