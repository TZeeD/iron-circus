// Decompiled with JetBrains decompiler
// Type: Entitas.Context`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using DesperateDevs.Utils;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Entitas
{
  public class Context<TEntity> : IContext<TEntity>, IContext where TEntity : class, IEntity
  {
    private readonly int _totalComponents;
    private readonly Stack<IComponent>[] _componentPools;
    private readonly ContextInfo _contextInfo;
    private readonly Func<IEntity, IAERC> _aercFactory;
    private readonly HashSet<TEntity> _entities = new HashSet<TEntity>(EntityEqualityComparer<TEntity>.comparer);
    private readonly Stack<TEntity> _reusableEntities = new Stack<TEntity>();
    private readonly HashSet<TEntity> _retainedEntities = new HashSet<TEntity>(EntityEqualityComparer<TEntity>.comparer);
    private readonly Dictionary<IMatcher<TEntity>, IGroup<TEntity>> _groups = new Dictionary<IMatcher<TEntity>, IGroup<TEntity>>();
    private readonly List<IGroup<TEntity>>[] _groupsForIndex;
    private readonly ObjectPool<List<GroupChanged<TEntity>>> _groupChangedListPool;
    private readonly Dictionary<string, IEntityIndex> _entityIndices;
    private int _creationIndex;
    private TEntity[] _entitiesCache;
    private readonly EntityComponentChanged _cachedEntityChanged;
    private readonly EntityComponentReplaced _cachedComponentReplaced;
    private readonly EntityEvent _cachedEntityReleased;
    private readonly EntityEvent _cachedDestroyEntity;

    public event ContextEntityChanged OnEntityCreated;

    public event ContextEntityChanged OnEntityWillBeDestroyed;

    public event ContextEntityChanged OnEntityDestroyed;

    public event ContextGroupChanged OnGroupCreated;

    public int totalComponents => this._totalComponents;

    public Stack<IComponent>[] componentPools => this._componentPools;

    public ContextInfo contextInfo => this._contextInfo;

    public int count => this._entities.Count;

    public int reusableEntitiesCount => this._reusableEntities.Count;

    public int retainedEntitiesCount => this._retainedEntities.Count;

    public Context(int totalComponents)
      : this(totalComponents, 0, (ContextInfo) null, (Func<IEntity, IAERC>) null)
    {
    }

    public Context(
      int totalComponents,
      int startCreationIndex,
      ContextInfo contextInfo,
      Func<IEntity, IAERC> aercFactory)
    {
      this._totalComponents = totalComponents;
      this._creationIndex = startCreationIndex;
      if (contextInfo != null)
      {
        this._contextInfo = contextInfo;
        if (contextInfo.componentNames.Length != totalComponents)
          throw new ContextInfoException((IContext) this, contextInfo);
      }
      else
        this._contextInfo = this.createDefaultContextInfo();
      this._aercFactory = aercFactory ?? (Func<IEntity, IAERC>) (entity => (IAERC) new SafeAERC(entity));
      this._groupsForIndex = new List<IGroup<TEntity>>[totalComponents];
      this._componentPools = new Stack<IComponent>[totalComponents];
      this._entityIndices = new Dictionary<string, IEntityIndex>();
      this._groupChangedListPool = new ObjectPool<List<GroupChanged<TEntity>>>((Func<List<GroupChanged<TEntity>>>) (() => new List<GroupChanged<TEntity>>()), (Action<List<GroupChanged<TEntity>>>) (list => list.Clear()));
      this._cachedEntityChanged = new EntityComponentChanged(this.updateGroupsComponentAddedOrRemoved);
      this._cachedComponentReplaced = new EntityComponentReplaced(this.updateGroupsComponentReplaced);
      this._cachedEntityReleased = new EntityEvent(this.onEntityReleased);
      this._cachedDestroyEntity = new EntityEvent(this.onDestroyEntity);
    }

    private ContextInfo createDefaultContextInfo()
    {
      string[] componentNames = new string[this._totalComponents];
      for (int index = 0; index < componentNames.Length; ++index)
        componentNames[index] = "Index " + (object) index;
      return new ContextInfo("Unnamed Context", componentNames, (Type[]) null);
    }

    public TEntity CreateEntity()
    {
      TEntity entity;
      if (this._reusableEntities.Count > 0)
      {
        entity = this._reusableEntities.Pop();
        entity.Reactivate(this._creationIndex++);
      }
      else
      {
        entity = (TEntity) Activator.CreateInstance(typeof (TEntity));
        entity.Initialize(this._creationIndex++, this._totalComponents, this._componentPools, this._contextInfo, this._aercFactory((IEntity) entity));
      }
      this._entities.Add(entity);
      entity.Retain((object) this);
      this._entitiesCache = (TEntity[]) null;
      entity.OnComponentAdded += this._cachedEntityChanged;
      entity.OnComponentRemoved += this._cachedEntityChanged;
      entity.OnComponentReplaced += this._cachedComponentReplaced;
      entity.OnEntityReleased += this._cachedEntityReleased;
      entity.OnDestroyEntity += this._cachedDestroyEntity;
      if (this.OnEntityCreated != null)
        this.OnEntityCreated((IContext) this, (IEntity) entity);
      return entity;
    }

    public void DestroyAllEntities()
    {
      foreach (TEntity entity in this.GetEntities())
        entity.Destroy();
      this._entities.Clear();
      if (this._retainedEntities.Count != 0)
        throw new ContextStillHasRetainedEntitiesException((IContext) this, (IEntity[]) this._retainedEntities.ToArray<TEntity>());
    }

    public bool HasEntity(TEntity entity) => this._entities.Contains(entity);

    public TEntity[] GetEntities()
    {
      if (this._entitiesCache == null)
      {
        this._entitiesCache = new TEntity[this._entities.Count];
        this._entities.CopyTo(this._entitiesCache);
      }
      return this._entitiesCache;
    }

    public IGroup<TEntity> GetGroup(IMatcher<TEntity> matcher)
    {
      IGroup<TEntity> group;
      if (!this._groups.TryGetValue(matcher, out group))
      {
        group = (IGroup<TEntity>) new Group<TEntity>(matcher);
        foreach (TEntity entity in this.GetEntities())
          group.HandleEntitySilently(entity);
        this._groups.Add(matcher, group);
        for (int index1 = 0; index1 < matcher.indices.Length; ++index1)
        {
          int index2 = matcher.indices[index1];
          if (this._groupsForIndex[index2] == null)
            this._groupsForIndex[index2] = new List<IGroup<TEntity>>();
          this._groupsForIndex[index2].Add(group);
        }
        if (this.OnGroupCreated != null)
          this.OnGroupCreated((IContext) this, (IGroup) group);
      }
      return group;
    }

    public void AddEntityIndex(IEntityIndex entityIndex)
    {
      if (this._entityIndices.ContainsKey(entityIndex.name))
        throw new ContextEntityIndexDoesAlreadyExistException((IContext) this, entityIndex.name);
      this._entityIndices.Add(entityIndex.name, entityIndex);
    }

    public IEntityIndex GetEntityIndex(string name)
    {
      IEntityIndex entityIndex;
      if (!this._entityIndices.TryGetValue(name, out entityIndex))
        throw new ContextEntityIndexDoesNotExistException((IContext) this, name);
      return entityIndex;
    }

    public void ResetCreationIndex() => this._creationIndex = 0;

    public void ClearComponentPool(int index) => this._componentPools[index]?.Clear();

    public void ClearComponentPools()
    {
      for (int index = 0; index < this._componentPools.Length; ++index)
        this.ClearComponentPool(index);
    }

    public void Reset()
    {
      this.DestroyAllEntities();
      this.ResetCreationIndex();
      this.OnEntityCreated = (ContextEntityChanged) null;
      this.OnEntityWillBeDestroyed = (ContextEntityChanged) null;
      this.OnEntityDestroyed = (ContextEntityChanged) null;
      this.OnGroupCreated = (ContextGroupChanged) null;
    }

    public override string ToString() => this._contextInfo.name;

    private void updateGroupsComponentAddedOrRemoved(
      IEntity entity,
      int index,
      IComponent component)
    {
      List<IGroup<TEntity>> groupList = this._groupsForIndex[index];
      if (groupList == null)
        return;
      List<GroupChanged<TEntity>> groupChangedList = this._groupChangedListPool.Get();
      TEntity entity1 = (TEntity) entity;
      for (int index1 = 0; index1 < groupList.Count; ++index1)
        groupChangedList.Add(groupList[index1].HandleEntity(entity1));
      for (int index2 = 0; index2 < groupChangedList.Count; ++index2)
      {
        GroupChanged<TEntity> groupChanged = groupChangedList[index2];
        if (groupChanged != null)
          groupChanged(groupList[index2], entity1, index, component);
      }
      this._groupChangedListPool.Push(groupChangedList);
    }

    private void updateGroupsComponentReplaced(
      IEntity entity,
      int index,
      IComponent previousComponent,
      IComponent newComponent)
    {
      List<IGroup<TEntity>> groupList = this._groupsForIndex[index];
      if (groupList == null)
        return;
      TEntity entity1 = (TEntity) entity;
      for (int index1 = 0; index1 < groupList.Count; ++index1)
        groupList[index1].UpdateEntity(entity1, index, previousComponent, newComponent);
    }

    private void onEntityReleased(IEntity entity)
    {
      TEntity entity1 = !entity.isEnabled ? (TEntity) entity : throw new EntityIsNotDestroyedException("Cannot release " + (object) entity + "!");
      entity.RemoveAllOnEntityReleasedHandlers();
      this._retainedEntities.Remove(entity1);
      this._reusableEntities.Push(entity1);
    }

    private void onDestroyEntity(IEntity entity)
    {
      TEntity entity1 = (TEntity) entity;
      if (!this._entities.Remove(entity1))
        throw new ContextDoesNotContainEntityException("'" + (object) this + "' cannot destroy " + (object) entity1 + "!", "This cannot happen!?!");
      this._entitiesCache = (TEntity[]) null;
      if (this.OnEntityWillBeDestroyed != null)
        this.OnEntityWillBeDestroyed((IContext) this, (IEntity) entity1);
      entity1.InternalDestroy();
      if (this.OnEntityDestroyed != null)
        this.OnEntityDestroyed((IContext) this, (IEntity) entity1);
      if (entity1.retainCount == 1)
      {
        entity1.OnEntityReleased -= this._cachedEntityReleased;
        this._reusableEntities.Push(entity1);
        entity1.Release((object) this);
        entity1.RemoveAllOnEntityReleasedHandlers();
      }
      else
      {
        this._retainedEntities.Add(entity1);
        entity1.Release((object) this);
      }
    }
  }
}
