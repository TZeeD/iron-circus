// Decompiled with JetBrains decompiler
// Type: SoftMasking.MaterialReplacements
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

namespace SoftMasking
{
  internal class MaterialReplacements
  {
    private readonly IMaterialReplacer _replacer;
    private readonly Action<Material> _applyParameters;
    private readonly List<MaterialReplacements.MaterialOverride> _overrides = new List<MaterialReplacements.MaterialOverride>();

    public MaterialReplacements(IMaterialReplacer replacer, Action<Material> applyParameters)
    {
      this._replacer = replacer;
      this._applyParameters = applyParameters;
    }

    public Material Get(Material original)
    {
      for (int index = 0; index < this._overrides.Count; ++index)
      {
        MaterialReplacements.MaterialOverride materialOverride = this._overrides[index];
        if (materialOverride.original == original)
        {
          Material material = materialOverride.Get();
          if ((bool) (UnityEngine.Object) material)
          {
            material.CopyPropertiesFromMaterial(original);
            this._applyParameters(material);
          }
          return material;
        }
      }
      Material replacement = this._replacer.Replace(original);
      if ((bool) (UnityEngine.Object) replacement)
      {
        replacement.hideFlags = HideFlags.HideAndDontSave;
        this._applyParameters(replacement);
      }
      this._overrides.Add(new MaterialReplacements.MaterialOverride(original, replacement));
      return replacement;
    }

    public void Release(Material replacement)
    {
      for (int index = 0; index < this._overrides.Count; ++index)
      {
        MaterialReplacements.MaterialOverride materialOverride = this._overrides[index];
        if ((UnityEngine.Object) materialOverride.replacement == (UnityEngine.Object) replacement && materialOverride.Release())
        {
          UnityEngine.Object.DestroyImmediate((UnityEngine.Object) replacement);
          this._overrides.RemoveAt(index);
          break;
        }
      }
    }

    public void ApplyAll()
    {
      for (int index = 0; index < this._overrides.Count; ++index)
      {
        Material replacement = this._overrides[index].replacement;
        if ((bool) (UnityEngine.Object) replacement)
          this._applyParameters(replacement);
      }
    }

    public void DestroyAllAndClear()
    {
      for (int index = 0; index < this._overrides.Count; ++index)
        UnityEngine.Object.DestroyImmediate((UnityEngine.Object) this._overrides[index].replacement);
      this._overrides.Clear();
    }

    private class MaterialOverride
    {
      private int _useCount;

      public MaterialOverride(Material original, Material replacement)
      {
        this.original = original;
        this.replacement = replacement;
        this._useCount = 1;
      }

      public Material original { get; private set; }

      public Material replacement { get; private set; }

      public Material Get()
      {
        ++this._useCount;
        return this.replacement;
      }

      public bool Release() => --this._useCount == 0;
    }
  }
}
