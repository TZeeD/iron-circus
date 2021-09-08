// Decompiled with JetBrains decompiler
// Type: Entitas.PublicMemberInfoEntityExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using DesperateDevs.Utils;

namespace Entitas
{
  public static class PublicMemberInfoEntityExtension
  {
    public static void CopyTo(
      this IEntity entity,
      IEntity target,
      bool replaceExisting = false,
      params int[] indices)
    {
      foreach (int index in indices.Length == 0 ? entity.GetComponentIndices() : indices)
      {
        IComponent component1 = entity.GetComponent(index);
        IComponent component2 = target.CreateComponent(index, component1.GetType());
        component1.CopyPublicMemberValues((object) component2);
        if (replaceExisting)
          target.ReplaceComponent(index, component2);
        else
          target.AddComponent(index, component2);
      }
    }
  }
}
