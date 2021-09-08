// Decompiled with JetBrains decompiler
// Type: Entitas.EntityIndex`2
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;
using System.Collections.Generic;

namespace Entitas
{
  public class EntityIndex<TEntity, TKey> : AbstractEntityIndex<TEntity, TKey> where TEntity : class, IEntity
  {
    private readonly Dictionary<TKey, HashSet<TEntity>> _index;

    public EntityIndex(string name, IGroup<TEntity> group, Func<TEntity, IComponent, TKey> getKey)
      : base(name, group, getKey)
    {
      this._index = new Dictionary<TKey, HashSet<TEntity>>();
      this.Activate();
    }

    public EntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey[]> getKeys)
      : base(name, group, getKeys)
    {
      this._index = new Dictionary<TKey, HashSet<TEntity>>();
      this.Activate();
    }

    public EntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey> getKey,
      IEqualityComparer<TKey> comparer)
      : base(name, group, getKey)
    {
      this._index = new Dictionary<TKey, HashSet<TEntity>>(comparer);
      this.Activate();
    }

    public EntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey[]> getKeys,
      IEqualityComparer<TKey> comparer)
      : base(name, group, getKeys)
    {
      this._index = new Dictionary<TKey, HashSet<TEntity>>(comparer);
      this.Activate();
    }

    public override void Activate()
    {
      base.Activate();
      this.indexEntities(this._group);
    }

    public HashSet<TEntity> GetEntities(TKey key)
    {
      HashSet<TEntity> entitySet;
      if (!this._index.TryGetValue(key, out entitySet))
      {
        entitySet = new HashSet<TEntity>(EntityEqualityComparer<TEntity>.comparer);
        this._index.Add(key, entitySet);
      }
      return entitySet;
    }

    public override string ToString() => "EntityIndex(" + this.name + ")";

    protected override void clear()
    {
      foreach (HashSet<TEntity> entitySet in this._index.Values)
      {
        foreach (TEntity entity in entitySet)
        {
          if (entity.aerc is SafeAERC aerc2)
          {
            if (aerc2.owners.Contains((object) this))
              entity.Release((object) this);
          }
          else
            entity.Release((object) this);
        }
      }
      this._index.Clear();
    }

    protected override void addEntity(TKey key, TEntity entity)
    {
      this.GetEntities(key).Add(entity);
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
      this.GetEntities(key).Remove(entity);
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
