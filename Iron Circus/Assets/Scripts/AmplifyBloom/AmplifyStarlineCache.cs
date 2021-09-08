// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.AmplifyStarlineCache
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace AmplifyBloom
{
  [Serializable]
  public class AmplifyStarlineCache
  {
    [SerializeField]
    internal AmplifyPassCache[] Passes;

    public AmplifyStarlineCache()
    {
      this.Passes = new AmplifyPassCache[4];
      for (int index = 0; index < 4; ++index)
        this.Passes[index] = new AmplifyPassCache();
    }

    public void Destroy()
    {
      for (int index = 0; index < 4; ++index)
        this.Passes[index].Destroy();
      this.Passes = (AmplifyPassCache[]) null;
    }
  }
}
