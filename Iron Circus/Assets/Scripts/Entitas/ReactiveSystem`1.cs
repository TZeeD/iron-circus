// Decompiled with JetBrains decompiler
// Type: Entitas.ReactiveSystem`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public abstract class ReactiveSystem<TEntity> : IReactiveSystem, IExecuteSystem, ISystem
    where TEntity : class, IEntity
  {
    private readonly ICollector<TEntity> _collector;
    private readonly List<TEntity> _buffer;
    private string _toStringCache;

    protected ReactiveSystem(IContext<TEntity> context)
    {
      this._collector = this.GetTrigger(context);
      this._buffer = new List<TEntity>();
    }

    protected ReactiveSystem(ICollector<TEntity> collector)
    {
      this._collector = collector;
      this._buffer = new List<TEntity>();
    }

    protected abstract ICollector<TEntity> GetTrigger(IContext<TEntity> context);

    protected abstract bool Filter(TEntity entity);

    protected abstract void Execute(List<TEntity> entities);

    public void Activate() => this._collector.Activate();

    public void Deactivate() => this._collector.Deactivate();

    public void Clear() => this._collector.ClearCollectedEntities();

    public void Execute()
    {
      if (this._collector.count == 0)
        return;
      foreach (TEntity collectedEntity in this._collector.collectedEntities)
      {
        if (this.Filter(collectedEntity))
        {
          collectedEntity.Retain((object) this);
          this._buffer.Add(collectedEntity);
        }
      }
      this._collector.ClearCollectedEntities();
      if (this._buffer.Count == 0)
        return;
      this.Execute(this._buffer);
      for (int index = 0; index < this._buffer.Count; ++index)
        this._buffer[index].Release((object) this);
      this._buffer.Clear();
    }

    public override string ToString()
    {
      if (this._toStringCache == null)
        this._toStringCache = "ReactiveSystem(" + this.GetType().Name + ")";
      return this._toStringCache;
    }

    ~ReactiveSystem() => this.Deactivate();
  }
}
