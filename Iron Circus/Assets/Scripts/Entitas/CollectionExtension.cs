// Decompiled with JetBrains decompiler
// Type: Entitas.CollectionExtension
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;
using System.Linq;

namespace Entitas
{
  public static class CollectionExtension
  {
    public static IEntity SingleEntity(this ICollection<IEntity> collection) => collection.Count == 1 ? collection.First<IEntity>() : throw new SingleEntityException(collection.Count);

    public static TEntity SingleEntity<TEntity>(this ICollection<TEntity> collection) where TEntity : class, IEntity => collection.Count == 1 ? collection.First<TEntity>() : throw new SingleEntityException(collection.Count);
  }
}
