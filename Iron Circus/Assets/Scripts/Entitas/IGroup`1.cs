// Decompiled with JetBrains decompiler
// Type: Entitas.IGroup`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public interface IGroup<TEntity> : IGroup where TEntity : class, IEntity
  {
    event GroupChanged<TEntity> OnEntityAdded;

    event GroupChanged<TEntity> OnEntityRemoved;

    event GroupUpdated<TEntity> OnEntityUpdated;

    IMatcher<TEntity> matcher { get; }

    void HandleEntitySilently(TEntity entity);

    void HandleEntity(TEntity entity, int index, IComponent component);

    GroupChanged<TEntity> HandleEntity(TEntity entity);

    void UpdateEntity(
      TEntity entity,
      int index,
      IComponent previousComponent,
      IComponent newComponent);

    bool ContainsEntity(TEntity entity);

    TEntity[] GetEntities();

    List<TEntity> GetEntities(List<TEntity> buffer);

    TEntity GetSingleEntity();

    HashSet<TEntity>.Enumerator GetEnumerator();
  }
}
