// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryStoreDynamicEntityCountRing`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.Utils;
using System;
using System.Collections.Generic;

namespace Imi.Game.History
{
  public class WorldHistoryStoreDynamicEntityCountRing<T> : IWorldHistoryStore<T> where T : IHistoryObject, new()
  {
    private int lastWritten;
    private RingBuffer<Dictionary<UniqueId, T>> store;

    public WorldHistoryStoreDynamicEntityCountRing(int arraySize)
    {
      this.store = new RingBuffer<Dictionary<UniqueId, T>>(arraySize);
      for (int tick = 0; tick < arraySize; ++tick)
        this.store.SetObject(tick, new Dictionary<UniqueId, T>(32));
    }

    public bool TryGetHistoryObject(int tick, UniqueId uid, out T t)
    {
      if (this.lastWritten < tick || this.store.GetObject(tick) == null || !this.store.GetObject(tick).ContainsKey(uid))
      {
        t = default (T);
        return false;
      }
      t = this.store.GetObject(tick)[uid];
      return true;
    }

    public void InitializeStorageFor(UniqueId uid)
    {
    }

    public T GetHistoryObject(int tick, UniqueId uid)
    {
      if (this.store.GetObject(tick) == null || !this.store.GetObject(tick).ContainsKey(uid))
        throw new KeyNotFoundException(string.Format("History does not have entry for given UniqueId [{0}].", (object) uid));
      return this.store.GetObject(tick)[uid];
    }

    public int AddHistoryObject(
      int tick,
      UniqueId uid,
      T obj,
      bool fromFuture = false,
      int copyFromReferenceTick = -1)
    {
      if (this.store.GetWritten(tick) != tick)
        this.store.GetObject(tick).Clear();
      this.store.GetObject(tick)[uid] = obj;
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
      if (this.store.GetWritten(tick) != tick)
        this.store.GetObject(tick).Clear();
      IHistoryObject copyFromReference = (IHistoryObject) null;
      if (copyFromReferenceTick >= 0)
        copyFromReference = (IHistoryObject) this.GetHistoryObject(copyFromReferenceTick, id);
      T obj = new T();
      obj.CopyFrom(entity, copyFromReference);
      this.store.GetObject(tick)[id] = obj;
      this.lastWritten = Math.Max(this.lastWritten, tick);
      return tick;
    }
  }
}
