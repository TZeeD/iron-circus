﻿// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.AmplifyGlareCache
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

namespace AmplifyBloom
{
  [Serializable]
  public class AmplifyGlareCache
  {
    [SerializeField]
    internal AmplifyStarlineCache[] Starlines;
    [SerializeField]
    internal Vector4 AverageWeight;
    [SerializeField]
    internal Vector4[,] CromaticAberrationMat;
    [SerializeField]
    internal int TotalRT;
    [SerializeField]
    internal GlareDefData GlareDef;
    [SerializeField]
    internal StarDefData StarDef;
    [SerializeField]
    internal int CurrentPassCount;

    public AmplifyGlareCache()
    {
      this.Starlines = new AmplifyStarlineCache[4];
      this.CromaticAberrationMat = new Vector4[4, 8];
      for (int index = 0; index < 4; ++index)
        this.Starlines[index] = new AmplifyStarlineCache();
    }

    public void Destroy()
    {
      for (int index = 0; index < 4; ++index)
        this.Starlines[index].Destroy();
      this.Starlines = (AmplifyStarlineCache[]) null;
      this.CromaticAberrationMat = (Vector4[,]) null;
    }
  }
}
