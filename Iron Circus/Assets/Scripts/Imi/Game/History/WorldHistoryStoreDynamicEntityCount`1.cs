// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryStoreDynamicEntityCount`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;

namespace Imi.Game.History
{
  public class WorldHistoryStoreDynamicEntityCount<T> : IWorldHistoryStore<T> where T : IHistoryObject, new()
  {
    private int lastWritten;
    private Dictionary<UniqueId, T>[] store;

    public WorldHistoryStoreDynamicEntityCount(int arraySize) => this.store = new Dictionary<UniqueId, T>[arraySize];

    public bool TryGetHistoryObject(int tick, UniqueId uid, out T t)
    {
      if (this.lastWritten < tick || this.store[tick] == null || !this.store[tick].ContainsKey(uid))
      {
        t = default (T);
        return false;
      }
      t = this.store[tick][uid];
      return true;
    }

    public void InitializeStorageFor(UniqueId uid)
    {
    }

    public T GetHistoryObject(int tick, UniqueId uid)
    {
      if (this.store[tick] == null || !this.store[tick].ContainsKey(uid))
        throw new KeyNotFoundException(string.Format("History does not have entry for given UniqueId [{0}].", (object) uid));
      return this.store[tick][uid];
    }

    public int AddHistoryObject(
      int tick,
      UniqueId uid,
      T obj,
      bool fromFuture = false,
      int copyFromReferenceTick = -1)
    {
      if (this.store[tick] == null)
        this.store[tick] = new Dictionary<UniqueId, T>();
      this.store[tick][uid] = obj;
      this.lastWritten = Math.Max(this.lastWritten, tick);
      return tick;
    }

    public int AddHistoryObject(
      int tick,
      GameEntity entity,
      bool fromFuture = false,
      int copyFromReferenceTick = -1)
    {
      UniqueId id = entity.uniqueId.id;
      if (this.store[tick] == null)
        this.store[tick] = new Dictionary<UniqueId, T>();
      IHistoryObject copyFromReference = (IHistoryObject) null;
      if (copyFromReferenceTick >= 0)
        copyFromReference = (IHistoryObject) this.GetHistoryObject(copyFromReferenceTick, id);
      T obj = new T();
      obj.CopyFrom(entity, copyFromReference);
      this.store[tick][id] = obj;
      this.lastWritten = Math.Max(this.lastWritten, tick);
      return tick;
    }
  }
}
