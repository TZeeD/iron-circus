// Decompiled with JetBrains decompiler
// Type: Entitas.TriggerOnEventMatcherExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public static class TriggerOnEventMatcherExtension
  {
    public static TriggerOnEvent<TEntity> Added<TEntity>(
      this IMatcher<TEntity> matcher)
      where TEntity : class, IEntity
    {
      return new TriggerOnEvent<TEntity>(matcher, GroupEvent.Added);
    }

    public static TriggerOnEvent<TEntity> Removed<TEntity>(
      this IMatcher<TEntity> matcher)
      where TEntity : class, IEntity
    {
      return new TriggerOnEvent<TEntity>(matcher, GroupEvent.Removed);
    }

    public static TriggerOnEvent<TEntity> AddedOrRemoved<TEntity>(
      this IMatcher<TEntity> matcher)
      where TEntity : class, IEntity
    {
      return new TriggerOnEvent<TEntity>(matcher, GroupEvent.AddedOrRemoved);
    }
  }
}
