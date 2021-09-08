// Decompiled with JetBrains decompiler
// Type: Entitas.MultiReactiveSystem`2
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public abstract class MultiReactiveSystem<TEntity, TContexts> : 
    IReactiveSystem,
    IExecuteSystem,
    ISystem
    where TEntity : class, IEntity
    where TContexts : class, IContexts
  {
    private readonly ICollector[] _collectors;
    private readonly List<TEntity> _buffer;
    private string _toStringCache;

    protected MultiReactiveSystem(TContexts contexts)
    {
      this._collectors = this.GetTrigger(contexts);
      this._buffer = new List<TEntity>();
    }

    protected MultiReactiveSystem(ICollector[] collectors)
    {
      this._collectors = collectors;
      this._buffer = new List<TEntity>();
    }

    protected abstract ICollector[] GetTrigger(TContexts contexts);

    protected abstract bool Filter(TEntity entity);

    protected abstract void Execute(List<TEntity> entities);

    public void Activate()
    {
      for (int index = 0; index < this._collectors.Length; ++index)
        this._collectors[index].Activate();
    }

    public void Deactivate()
    {
      for (int index = 0; index < this._collectors.Length; ++index)
        this._collectors[index].Deactivate();
    }

    public void Clear()
    {
      for (int index = 0; index < this._collectors.Length; ++index)
        this._collectors[index].ClearCollectedEntities();
    }

    public void Execute()
    {
      for (int index = 0; index < this._collectors.Length; ++index)
      {
        ICollector collector = this._collectors[index];
        if (collector.count != 0)
        {
          foreach (TEntity collectedEntity in collector.GetCollectedEntities<TEntity>())
          {
            if (this.Filter(collectedEntity))
            {
              collectedEntity.Retain((object) this);
              this._buffer.Add(collectedEntity);
            }
          }
          collector.ClearCollectedEntities();
        }
      }
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
        this._toStringCache = "MultiReactiveSystem(" + this.GetType().Name + ")";
      return this._toStringCache;
    }

    ~MultiReactiveSystem() => this.Deactivate();
  }
}
