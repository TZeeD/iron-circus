// Decompiled with JetBrains decompiler
// Type: Entitas.IContext`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public interface IContext<TEntity> : IContext where TEntity : class, IEntity
  {
    TEntity CreateEntity();

    bool HasEntity(TEntity entity);

    TEntity[] GetEntities();

    IGroup<TEntity> GetGroup(IMatcher<TEntity> matcher);
  }
}
