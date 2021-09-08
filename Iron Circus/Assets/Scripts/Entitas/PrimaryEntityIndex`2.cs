// Decompiled with JetBrains decompiler
// Type: Entitas.PrimaryEntityIndex`2
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;
using System.Collections.Generic;

namespace Entitas
{
  public class PrimaryEntityIndex<TEntity, TKey> : AbstractEntityIndex<TEntity, TKey>
    where TEntity : class, IEntity
  {
    private readonly Dictionary<TKey, TEntity> _index;

    public PrimaryEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey> getKey)
      : base(name, group, getKey)
    {
      this._index = new Dictionary<TKey, TEntity>();
      this.Activate();
    }

    public PrimaryEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey[]> getKeys)
      : base(name, group, getKeys)
    {
      this._index = new Dictionary<TKey, TEntity>();
      this.Activate();
    }

    public PrimaryEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey> getKey,
      IEqualityComparer<TKey> comparer)
      : base(name, group, getKey)
    {
      this._index = new Dictionary<TKey, TEntity>(comparer);
      this.Activate();
    }

    public PrimaryEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey[]> getKeys,
      IEqualityComparer<TKey> comparer)
      : base(name, group, getKeys)
    {
      this._index = new Dictionary<TKey, TEntity>(comparer);
      this.Activate();
    }

    public override void Activate()
    {
      base.Activate();
      this.indexEntities(this._group);
    }

    public TEntity GetEntity(TKey key)
    {
      TEntity entity;
      this._index.TryGetValue(key, out entity);
      return entity;
    }

    public override string ToString() => "PrimaryEntityIndex(" + this.name + ")";

    protected override void clear()
    {
      foreach (TEntity entity in this._index.Values)
      {
        if (entity.aerc is SafeAERC aerc1)
        {
          if (aerc1.owners.Contains((object) this))
            entity.Release((object) this);
        }
        else
          entity.Release((object) this);
      }
      this._index.Clear();
    }

    protected override void addEntity(TKey key, TEntity entity)
    {
      if (this._index.ContainsKey(key))
        throw new EntityIndexException("Entity for key '" + (object) key + "' already exists!", "Only one entity for a primary key is allowed.");
      this._index.Add(key, entity);
      if (entity.aerc is SafeAERC aerc)
      {
        if (aerc.owners.Contains((object) this))
          return;
        entity.Retain((object) this);
      }
      else
        entity.Retain((object) this);
    }

    protected override void removeEntity(TKey key, TEntity entity)
    {
      this._index.Remove(key);
      if (entity.aerc is SafeAERC aerc)
      {
        if (!aerc.owners.Contains((object) this))
          return;
        entity.Release((object) this);
      }
      else
        entity.Release((object) this);
    }
  }
}
