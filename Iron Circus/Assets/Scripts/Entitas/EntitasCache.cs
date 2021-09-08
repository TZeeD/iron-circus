// Decompiled with JetBrains decompiler
// Type: Entitas.EntitasCache
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using DesperateDevs.Utils;
using System.Collections.Generic;

namespace Entitas
{
  public static class EntitasCache
  {
    private static readonly ObjectCache _cache = new ObjectCache();

    public static List<IComponent> GetIComponentList() => EntitasCache._cache.Get<List<IComponent>>();

    public static void PushIComponentList(List<IComponent> list)
    {
      list.Clear();
      EntitasCache._cache.Push<List<IComponent>>(list);
    }

    public static List<int> GetIntList() => EntitasCache._cache.Get<List<int>>();

    public static void PushIntList(List<int> list)
    {
      list.Clear();
      EntitasCache._cache.Push<List<int>>(list);
    }

    public static HashSet<int> GetIntHashSet() => EntitasCache._cache.Get<HashSet<int>>();

    public static void PushIntHashSet(HashSet<int> hashSet)
    {
      hashSet.Clear();
      EntitasCache._cache.Push<HashSet<int>>(hashSet);
    }

    public static void Reset() => EntitasCache._cache.Reset();
  }
}
