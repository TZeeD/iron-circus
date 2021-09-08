// Decompiled with JetBrains decompiler
// Type: Entitas.Unity.EntityLink
// Assembly: Entitas.Unity, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: F2BCDAAE-92ED-418E-9A81-A1CC48630C6D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.Unity.dll

using System;
using UnityEngine;

namespace Entitas.Unity
{
  public class EntityLink : MonoBehaviour
  {
    private IEntity _entity;
    private IContext _context;
    private bool _applicationIsQuitting;

    public IEntity entity => this._entity;

    public IContext context => this._context;

    public void Link(IEntity entity, IContext context)
    {
      this._entity = this._entity == null ? entity : throw new Exception("EntityLink is already linked to " + (object) this._entity + "!");
      this._context = context;
      this._entity.Retain((object) this);
    }

    public void Unlink()
    {
      if (this._entity == null)
        throw new Exception("EntityLink is already unlinked!");
      this._entity.Release((object) this);
      this._entity = (IEntity) null;
      this._context = (IContext) null;
    }

    private void OnDestroy()
    {
      if (!this._applicationIsQuitting && this._entity != null)
        throw new EntitasException("EntityLink got destroyed but is still linked to " + (object) this._entity + "!", "Please call gameObject.Unlink() before it is destroyed.");
    }

    private void OnApplicationQuit() => this._applicationIsQuitting = true;

    public override string ToString() => "EntityLink(" + this.gameObject.name + ")";
  }
}
