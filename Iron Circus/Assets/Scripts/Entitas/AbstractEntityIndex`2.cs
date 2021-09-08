// Decompiled with JetBrains decompiler
// Type: Entitas.AbstractEntityIndex`2
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;

namespace Entitas
{
  public abstract class AbstractEntityIndex<TEntity, TKey> : IEntityIndex where TEntity : class, IEntity
  {
    protected readonly string _name;
    protected readonly IGroup<TEntity> _group;
    protected readonly Func<TEntity, IComponent, TKey> _getKey;
    protected readonly Func<TEntity, IComponent, TKey[]> _getKeys;
    protected readonly bool _isSingleKey;

    public string name => this._name;

    protected AbstractEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey> getKey)
    {
      this._name = name;
      this._group = group;
      this._getKey = getKey;
      this._isSingleKey = true;
    }

    protected AbstractEntityIndex(
      string name,
      IGroup<TEntity> group,
      Func<TEntity, IComponent, TKey[]> getKeys)
    {
      this._name = name;
      this._group = group;
      this._getKeys = getKeys;
      this._isSingleKey = false;
    }

    public virtual void Activate()
    {
      this._group.OnEntityAdded += new GroupChanged<TEntity>(this.onEntityAdded);
      this._group.OnEntityRemoved += new GroupChanged<TEntity>(this.onEntityRemoved);
    }

    public virtual void Deactivate()
    {
      this._group.OnEntityAdded -= new GroupChanged<TEntity>(this.onEntityAdded);
      this._group.OnEntityRemoved -= new GroupChanged<TEntity>(this.onEntityRemoved);
      this.clear();
    }

    public override string ToString() => this.name;

    protected void indexEntities(IGroup<TEntity> group)
    {
      foreach (TEntity entity in group)
      {
        if (this._isSingleKey)
        {
          this.addEntity(this._getKey(entity, (IComponent) null), entity);
        }
        else
        {
          foreach (TKey key in this._getKeys(entity, (IComponent) null))
            this.addEntity(key, entity);
        }
      }
    }

    protected void onEntityAdded(
      IGroup<TEntity> group,
      TEntity entity,
      int index,
      IComponent component)
    {
      if (this._isSingleKey)
      {
        this.addEntity(this._getKey(entity, component), entity);
      }
      else
      {
        foreach (TKey key in this._getKeys(entity, component))
          this.addEntity(key, entity);
      }
    }

    protected void onEntityRemoved(
      IGroup<TEntity> group,
      TEntity entity,
      int index,
      IComponent component)
    {
      if (this._isSingleKey)
      {
        this.removeEntity(this._getKey(entity, component), entity);
      }
      else
      {
        foreach (TKey key in this._getKeys(entity, component))
          this.removeEntity(key, entity);
      }
    }

    protected abstract void addEntity(TKey key, TEntity entity);

    protected abstract void removeEntity(TKey key, TEntity entity);

    protected abstract void clear();

    ~AbstractEntityIndex() => this.Deactivate();
  }
}
