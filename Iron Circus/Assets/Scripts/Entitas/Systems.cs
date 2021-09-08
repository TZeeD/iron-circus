// Decompiled with JetBrains decompiler
// Type: Entitas.Systems
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public class Systems : IInitializeSystem, ISystem, IExecuteSystem, ICleanupSystem, ITearDownSystem
  {
    protected readonly List<IInitializeSystem> _initializeSystems;
    protected readonly List<IExecuteSystem> _executeSystems;
    protected readonly List<ICleanupSystem> _cleanupSystems;
    protected readonly List<ITearDownSystem> _tearDownSystems;

    public Systems()
    {
      this._initializeSystems = new List<IInitializeSystem>();
      this._executeSystems = new List<IExecuteSystem>();
      this._cleanupSystems = new List<ICleanupSystem>();
      this._tearDownSystems = new List<ITearDownSystem>();
    }

    public virtual Systems Add(ISystem system)
    {
      if (system is IInitializeSystem initializeSystem)
        this._initializeSystems.Add(initializeSystem);
      if (system is IExecuteSystem executeSystem)
        this._executeSystems.Add(executeSystem);
      if (system is ICleanupSystem cleanupSystem)
        this._cleanupSystems.Add(cleanupSystem);
      if (system is ITearDownSystem tearDownSystem)
        this._tearDownSystems.Add(tearDownSystem);
      return this;
    }

    public virtual void Initialize()
    {
      for (int index = 0; index < this._initializeSystems.Count; ++index)
        this._initializeSystems[index].Initialize();
    }

    public virtual void Execute()
    {
      for (int index = 0; index < this._executeSystems.Count; ++index)
        this._executeSystems[index].Execute();
    }

    public virtual void Cleanup()
    {
      for (int index = 0; index < this._cleanupSystems.Count; ++index)
        this._cleanupSystems[index].Cleanup();
    }

    public virtual void TearDown()
    {
      for (int index = 0; index < this._tearDownSystems.Count; ++index)
        this._tearDownSystems[index].TearDown();
    }

    public void ActivateReactiveSystems()
    {
      for (int index = 0; index < this._executeSystems.Count; ++index)
      {
        IExecuteSystem executeSystem = this._executeSystems[index];
        if (executeSystem is IReactiveSystem reactiveSystem2)
          reactiveSystem2.Activate();
        if (executeSystem is Systems systems2)
          systems2.ActivateReactiveSystems();
      }
    }

    public void DeactivateReactiveSystems()
    {
      for (int index = 0; index < this._executeSystems.Count; ++index)
      {
        IExecuteSystem executeSystem = this._executeSystems[index];
        if (executeSystem is IReactiveSystem reactiveSystem2)
          reactiveSystem2.Deactivate();
        if (executeSystem is Systems systems2)
          systems2.DeactivateReactiveSystems();
      }
    }

    public void ClearReactiveSystems()
    {
      for (int index = 0; index < this._executeSystems.Count; ++index)
      {
        IExecuteSystem executeSystem = this._executeSystems[index];
        if (executeSystem is IReactiveSystem reactiveSystem2)
          reactiveSystem2.Clear();
        if (executeSystem is Systems systems2)
          systems2.ClearReactiveSystems();
      }
    }
  }
}
