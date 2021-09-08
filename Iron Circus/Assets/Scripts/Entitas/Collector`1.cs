// Decompiled with JetBrains decompiler
// Type: Entitas.Collector`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entitas
{
  public class Collector<TEntity> : ICollector<TEntity>, ICollector where TEntity : class, IEntity
  {
    private readonly HashSet<TEntity> _collectedEntities;
    private readonly IGroup<TEntity>[] _groups;
    private readonly GroupEvent[] _groupEvents;
    private GroupChanged<TEntity> _addEntityCache;
    private string _toStringCache;
    private StringBuilder _toStringBuilder;

    public HashSet<TEntity> collectedEntities => this._collectedEntities;

    public int count => this._collectedEntities.Count;

    public Collector(IGroup<TEntity> group, GroupEvent groupEvent)
      : this(new IGroup<TEntity>[1]{ group }, new GroupEvent[1]
      {
        groupEvent
      })
    {
    }

    public Collector(IGroup<TEntity>[] groups, GroupEvent[] groupEvents)
    {
      this._groups = groups;
      this._collectedEntities = new HashSet<TEntity>(EntityEqualityComparer<TEntity>.comparer);
      this._groupEvents = groupEvents;
      if (groups.Length != groupEvents.Length)
        throw new CollectorException("Unbalanced count with groups (" + (object) groups.Length + ") and group events (" + (object) groupEvents.Length + ").", "Group and group events count must be equal.");
      this._addEntityCache = new GroupChanged<TEntity>(this.addEntity);
      this.Activate();
    }

    public void Activate()
    {
      for (int index = 0; index < this._groups.Length; ++index)
      {
        IGroup<TEntity> group = this._groups[index];
        switch (this._groupEvents[index])
        {
          case GroupEvent.Added:
            group.OnEntityAdded -= this._addEntityCache;
            group.OnEntityAdded += this._addEntityCache;
            break;
          case GroupEvent.Removed:
            group.OnEntityRemoved -= this._addEntityCache;
            group.OnEntityRemoved += this._addEntityCache;
            break;
          case GroupEvent.AddedOrRemoved:
            group.OnEntityAdded -= this._addEntityCache;
            group.OnEntityAdded += this._addEntityCache;
            group.OnEntityRemoved -= this._addEntityCache;
            group.OnEntityRemoved += this._addEntityCache;
            break;
        }
      }
    }

    public void Deactivate()
    {
      for (int index = 0; index < this._groups.Length; ++index)
      {
        IGroup<TEntity> group = this._groups[index];
        group.OnEntityAdded -= this._addEntityCache;
        group.OnEntityRemoved -= this._addEntityCache;
      }
      this.ClearCollectedEntities();
    }

    public IEnumerable<TCast> GetCollectedEntities<TCast>() where TCast : class, IEntity => this._collectedEntities.Cast<TCast>();

    public void ClearCollectedEntities()
    {
      foreach (TEntity collectedEntity in this._collectedEntities)
        collectedEntity.Release((object) this);
      this._collectedEntities.Clear();
    }

    private void addEntity(IGroup<TEntity> group, TEntity entity, int index, IComponent component)
    {
      if (!this._collectedEntities.Add(entity))
        return;
      entity.Retain((object) this);
    }

    public override string ToString()
    {
      if (this._toStringCache == null)
      {
        if (this._toStringBuilder == null)
          this._toStringBuilder = new StringBuilder();
        this._toStringBuilder.Length = 0;
        this._toStringBuilder.Append("Collector(");
        int num = this._groups.Length - 1;
        for (int index = 0; index < this._groups.Length; ++index)
        {
          this._toStringBuilder.Append((object) this._groups[index]);
          if (index < num)
            this._toStringBuilder.Append(", ");
        }
        this._toStringBuilder.Append(")");
        this._toStringCache = this._toStringBuilder.ToString();
      }
      return this._toStringCache;
    }

    ~Collector() => this.Deactivate();
  }
}
