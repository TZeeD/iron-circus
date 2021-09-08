// Decompiled with JetBrains decompiler
// Type: Coffee.UIExtensions.MaterialCache
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Coffee.UIExtensions
{
  public class MaterialCache
  {
    public static List<MaterialCache> materialCaches = new List<MaterialCache>();

    public ulong hash { get; private set; }

    public int referenceCount { get; private set; }

    public Texture texture { get; private set; }

    public Material material { get; private set; }

    public static MaterialCache Register(
      ulong hash,
      Texture texture,
      Func<Material> onCreateMaterial)
    {
      MaterialCache materialCache = MaterialCache.materialCaches.FirstOrDefault<MaterialCache>((Func<MaterialCache, bool>) (x => (long) x.hash == (long) hash));
      if (materialCache != null && (bool) (UnityEngine.Object) materialCache.material)
      {
        if ((bool) (UnityEngine.Object) materialCache.material)
        {
          ++materialCache.referenceCount;
        }
        else
        {
          MaterialCache.materialCaches.Remove(materialCache);
          materialCache = (MaterialCache) null;
        }
      }
      if (materialCache == null)
      {
        materialCache = new MaterialCache()
        {
          hash = hash,
          material = onCreateMaterial(),
          referenceCount = 1
        };
        MaterialCache.materialCaches.Add(materialCache);
      }
      return materialCache;
    }

    public static MaterialCache Register(ulong hash, Func<Material> onCreateMaterial)
    {
      MaterialCache materialCache = MaterialCache.materialCaches.FirstOrDefault<MaterialCache>((Func<MaterialCache, bool>) (x => (long) x.hash == (long) hash));
      if (materialCache != null)
        ++materialCache.referenceCount;
      if (materialCache == null)
      {
        materialCache = new MaterialCache()
        {
          hash = hash,
          material = onCreateMaterial(),
          referenceCount = 1
        };
        MaterialCache.materialCaches.Add(materialCache);
      }
      return materialCache;
    }

    public static void Unregister(MaterialCache cache)
    {
      if (cache == null)
        return;
      --cache.referenceCount;
      if (cache.referenceCount > 0)
        return;
      MaterialCache.materialCaches.Remove(cache);
      cache.material = (Material) null;
    }
  }
}
