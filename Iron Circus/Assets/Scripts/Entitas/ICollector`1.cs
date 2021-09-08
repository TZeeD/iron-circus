// Decompiled with JetBrains decompiler
// Type: Entitas.ICollector`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public interface ICollector<TEntity> : ICollector where TEntity : class, IEntity
  {
    HashSet<TEntity> collectedEntities { get; }
  }
}
