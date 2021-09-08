// Decompiled with JetBrains decompiler
// Type: Entitas.IContext
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public interface IContext
  {
    event ContextEntityChanged OnEntityCreated;

    event ContextEntityChanged OnEntityWillBeDestroyed;

    event ContextEntityChanged OnEntityDestroyed;

    event ContextGroupChanged OnGroupCreated;

    int totalComponents { get; }

    Stack<IComponent>[] componentPools { get; }

    ContextInfo contextInfo { get; }

    int count { get; }

    int reusableEntitiesCount { get; }

    int retainedEntitiesCount { get; }

    void DestroyAllEntities();

    void AddEntityIndex(IEntityIndex entityIndex);

    IEntityIndex GetEntityIndex(string name);

    void ResetCreationIndex();

    void ClearComponentPool(int index);

    void ClearComponentPools();

    void Reset();
  }
}
