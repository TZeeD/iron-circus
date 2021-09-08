// Decompiled with JetBrains decompiler
// Type: Entitas.SafeAERC
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System.Collections.Generic;

namespace Entitas
{
  public sealed class SafeAERC : IAERC
  {
    private readonly IEntity _entity;
    private readonly HashSet<object> _owners = new HashSet<object>();

    public int retainCount => this._owners.Count;

    public HashSet<object> owners => this._owners;

    public SafeAERC(IEntity entity) => this._entity = entity;

    public void Retain(object owner)
    {
      if (!this.owners.Add(owner))
        throw new EntityIsAlreadyRetainedByOwnerException(this._entity, owner);
    }

    public void Release(object owner)
    {
      if (!this.owners.Remove(owner))
        throw new EntityIsNotRetainedByOwnerException(this._entity, owner);
    }
  }
}
