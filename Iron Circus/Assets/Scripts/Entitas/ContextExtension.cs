// Decompiled with JetBrains decompiler
// Type: Entitas.ContextExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public static class ContextExtension
  {
    public static TEntity[] GetEntities<TEntity>(
      this IContext<TEntity> context,
      IMatcher<TEntity> matcher)
      where TEntity : class, IEntity
    {
      return context.GetGroup(matcher).GetEntities();
    }

    public static TEntity CloneEntity<TEntity>(
      this IContext<TEntity> context,
      IEntity entity,
      bool replaceExisting = false,
      params int[] indices)
      where TEntity : class, IEntity
    {
      TEntity entity1 = context.CreateEntity();
      entity.CopyTo((IEntity) entity1, replaceExisting, indices);
      return entity1;
    }
  }
}
