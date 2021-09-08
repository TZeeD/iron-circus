// Decompiled with JetBrains decompiler
// Type: Entitas.EntityEqualityComparer`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public class EntityEqualityComparer<TEntity> : IEqualityComparer<TEntity> where TEntity : class, IEntity
  {
    public static readonly IEqualityComparer<TEntity> comparer = (IEqualityComparer<TEntity>) new EntityEqualityComparer<TEntity>();

    public bool Equals(TEntity x, TEntity y) => (object) x == (object) y;

    public int GetHashCode(TEntity obj) => obj.creationIndex;
  }
}
