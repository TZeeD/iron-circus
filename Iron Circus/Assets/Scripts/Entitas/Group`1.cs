// Decompiled with JetBrains decompiler
// Type: Entitas.Group`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public class Group<TEntity> : IGroup<TEntity>, IGroup where TEntity : class, IEntity
  {
    private readonly IMatcher<TEntity> _matcher;
    private readonly HashSet<TEntity> _entities = new HashSet<TEntity>(EntityEqualityComparer<TEntity>.comparer);
    private TEntity[] _entitiesCache;
    private TEntity _singleEntityCache;
    private string _toStringCache;

    public event GroupChanged<TEntity> OnEntityAdded;

    public event GroupChanged<TEntity> OnEntityRemoved;

    public event GroupUpdated<TEntity> OnEntityUpdated;

    public int count => this._entities.Count;

    public IMatcher<TEntity> matcher => this._matcher;

    public Group(IMatcher<TEntity> matcher) => this._matcher = matcher;

    public void HandleEntitySilently(TEntity entity)
    {
      if (this._matcher.Matches(entity))
        this.addEntitySilently(entity);
      else
        this.removeEntitySilently(entity);
    }

    public void HandleEntity(TEntity entity, int index, IComponent component)
    {
      if (this._matcher.Matches(entity))
        this.addEntity(entity, index, component);
      else
        this.removeEntity(entity, index, component);
    }

    public void UpdateEntity(
      TEntity entity,
      int index,
      IComponent previousComponent,
      IComponent newComponent)
    {
      if (!this._entities.Contains(entity))
        return;
      if (this.OnEntityRemoved != null)
        this.OnEntityRemoved((IGroup<TEntity>) this, entity, index, previousComponent);
      if (this.OnEntityAdded != null)
        this.OnEntityAdded((IGroup<TEntity>) this, entity, index, newComponent);
      if (this.OnEntityUpdated == null)
        return;
      this.OnEntityUpdated((IGroup<TEntity>) this, entity, index, previousComponent, newComponent);
    }

    public void RemoveAllEventHandlers()
    {
      this.OnEntityAdded = (GroupChanged<TEntity>) null;
      this.OnEntityRemoved = (GroupChanged<TEntity>) null;
      this.OnEntityUpdated = (GroupUpdated<TEntity>) null;
    }

    public GroupChanged<TEntity> HandleEntity(TEntity entity) => !this._matcher.Matches(entity) ? (!this.removeEntitySilently(entity) ? (GroupChanged<TEntity>) null : this.OnEntityRemoved) : (!this.addEntitySilently(entity) ? (GroupChanged<TEntity>) null : this.OnEntityAdded);

    private bool addEntitySilently(TEntity entity)
    {
      if (!entity.isEnabled)
        return false;
      int num = this._entities.Add(entity) ? 1 : 0;
      if (num == 0)
        return num != 0;
      this._entitiesCache = (TEntity[]) null;
      this._singleEntityCache = default (TEntity);
      entity.Retain((object) this);
      return num != 0;
    }

    private void addEntity(TEntity entity, int index, IComponent component)
    {
      if (!this.addEntitySilently(entity) || this.OnEntityAdded == null)
        return;
      this.OnEntityAdded((IGroup<TEntity>) this, entity, index, component);
    }

    private bool removeEntitySilently(TEntity entity)
    {
      int num = this._entities.Remove(entity) ? 1 : 0;
      if (num == 0)
        return num != 0;
      this._entitiesCache = (TEntity[]) null;
      this._singleEntityCache = default (TEntity);
      entity.Release((object) this);
      return num != 0;
    }

    private void removeEntity(TEntity entity, int index, IComponent component)
    {
      if (!this._entities.Remove(entity))
        return;
      this._entitiesCache = (TEntity[]) null;
      this._singleEntityCache = default (TEntity);
      if (this.OnEntityRemoved != null)
        this.OnEntityRemoved((IGroup<TEntity>) this, entity, index, component);
      entity.Release((object) this);
    }

    public bool ContainsEntity(TEntity entity) => this._entities.Contains(entity);

    public TEntity[] GetEntities()
    {
      if (this._entitiesCache == null)
      {
        this._entitiesCache = new TEntity[this._entities.Count];
        this._entities.CopyTo(this._entitiesCache);
      }
      return this._entitiesCache;
    }

    public List<TEntity> GetEntities(List<TEntity> buffer)
    {
      buffer.Clear();
      buffer.AddRange((IEnumerable<TEntity>) this._entities);
      return buffer;
    }

    public HashSet<TEntity>.Enumerator GetEnumerator() => this._entities.GetEnumerator();

    public TEntity GetSingleEntity()
    {
      if ((object) this._singleEntityCache == null)
      {
        switch (this._entities.Count)
        {
          case 0:
            return default (TEntity);
          case 1:
            using (HashSet<TEntity>.Enumerator enumerator = this._entities.GetEnumerator())
            {
              enumerator.MoveNext();
              this._singleEntityCache = enumerator.Current;
              break;
            }
          default:
            throw new GroupSingleEntityException<TEntity>((IGroup<TEntity>) this);
        }
      }
      return this._singleEntityCache;
    }

    public override string ToString()
    {
      if (this._toStringCache == null)
        this._toStringCache = "Group(" + (object) this._matcher + ")";
      return this._toStringCache;
    }
  }
}
