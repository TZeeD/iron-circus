// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.AmplifyBokehData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace AmplifyBloom
{
  [Serializable]
  public class AmplifyBokehData
  {
    internal RenderTexture BokehRenderTexture;
    internal Vector4[] Offsets;

    public AmplifyBokehData(Vector4[] offsets) => this.Offsets = offsets;

    public void Destroy()
    {
      if ((UnityEngine.Object) this.BokehRenderTexture != (UnityEngine.Object) null)
      {
        AmplifyUtils.ReleaseTempRenderTarget(this.BokehRenderTexture);
        this.BokehRenderTexture = (RenderTexture) null;
      }
      this.Offsets = (Vector4[]) null;
    }
  }
}
