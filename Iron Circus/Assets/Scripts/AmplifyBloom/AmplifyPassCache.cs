// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.AmplifyPassCache
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace AmplifyBloom
{
  [Serializable]
  public class AmplifyPassCache
  {
    [SerializeField]
    internal Vector4[] Offsets;
    [SerializeField]
    internal Vector4[] Weights;

    public AmplifyPassCache()
    {
      this.Offsets = new Vector4[16];
      this.Weights = new Vector4[16];
    }

    public void Destroy()
    {
      this.Offsets = (Vector4[]) null;
      this.Weights = (Vector4[]) null;
    }
  }
}
