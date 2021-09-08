// Decompiled with JetBrains decompiler
// Type: SoftMasking.MaterialReplacerChain
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace SoftMasking
{
  public class MaterialReplacerChain : IMaterialReplacer
  {
    private readonly List<IMaterialReplacer> _replacers;

    public MaterialReplacerChain(
      IEnumerable<IMaterialReplacer> replacers,
      IMaterialReplacer yetAnother)
    {
      this._replacers = replacers.ToList<IMaterialReplacer>();
      this._replacers.Add(yetAnother);
      this.Initialize();
    }

    public int order { get; private set; }

    public Material Replace(Material material)
    {
      for (int index = 0; index < this._replacers.Count; ++index)
      {
        Material material1 = this._replacers[index].Replace(material);
        if ((UnityEngine.Object) material1 != (UnityEngine.Object) null)
          return material1;
      }
      return (Material) null;
    }

    private void Initialize()
    {
      this._replacers.Sort((Comparison<IMaterialReplacer>) ((a, b) => a.order.CompareTo(b.order)));
      this.order = this._replacers[0].order;
    }
  }
}
