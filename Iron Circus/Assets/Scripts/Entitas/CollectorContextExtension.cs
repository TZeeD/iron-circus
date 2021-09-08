// Decompiled with JetBrains decompiler
// Type: Entitas.CollectorContextExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public static class CollectorContextExtension
  {
    public static ICollector<TEntity> CreateCollector<TEntity>(
      this IContext<TEntity> context,
      IMatcher<TEntity> matcher)
      where TEntity : class, IEntity
    {
      return context.CreateCollector<TEntity>(new TriggerOnEvent<TEntity>(matcher, GroupEvent.Added));
    }

    public static ICollector<TEntity> CreateCollector<TEntity>(
      this IContext<TEntity> context,
      params TriggerOnEvent<TEntity>[] triggers)
      where TEntity : class, IEntity
    {
      IGroup<TEntity>[] groups = new IGroup<TEntity>[triggers.Length];
      GroupEvent[] groupEvents = new GroupEvent[triggers.Length];
      for (int index = 0; index < triggers.Length; ++index)
      {
        groups[index] = context.GetGroup(triggers[index].matcher);
        groupEvents[index] = triggers[index].groupEvent;
      }
      return (ICollector<TEntity>) new Collector<TEntity>(groups, groupEvents);
    }
  }
}
