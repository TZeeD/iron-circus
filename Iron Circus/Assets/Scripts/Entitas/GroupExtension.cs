// Decompiled with JetBrains decompiler
// Type: Entitas.GroupExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public static class GroupExtension
  {
    public static ICollector<TEntity> CreateCollector<TEntity>(
      this IGroup<TEntity> group,
      GroupEvent groupEvent = GroupEvent.Added)
      where TEntity : class, IEntity
    {
      return (ICollector<TEntity>) new Collector<TEntity>(group, groupEvent);
    }
  }
}
