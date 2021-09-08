// Decompiled with JetBrains decompiler
// Type: Entitas.GroupSingleEntityException`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;
using System.Collections.Generic;
using System.Linq;

namespace Entitas
{
  public class GroupSingleEntityException<TEntity> : EntitasException where TEntity : class, IEntity
  {
    public GroupSingleEntityException(IGroup<TEntity> group)
      : base("Cannot get the single entity from " + (object) group + "!\nGroup contains " + (object) group.count + " entities:", string.Join("\n", ((IEnumerable<TEntity>) group.GetEntities()).Select<TEntity, string>((Func<TEntity, string>) (e => e.ToString())).ToArray<string>()))
    {
    }
  }
}
