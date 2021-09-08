// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryStoreRing`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.Utils;
using System;
using System.Collections.Generic;

namespace Imi.Game.History
{
  public class WorldHistoryStoreRing<T> : IWorldHistoryStore<T> where T : IHistoryObject, new()
  {
    private Dictionary<UniqueId, RingBuffer<T>> store;
    private readonly int arraySize;
    private int lastWritten;

    public WorldHistoryStoreRing(int capacity, int arraySize)
    {
      this.arraySize = arraySize;
      this.store = new Dictionary<UniqueId, RingBuffer<T>>(capacity);
    }

    public void InitializeStorageFor(UniqueId uid)
    {
      if (this.store.ContainsKey(uid))
        return;
      this.store[uid] = new RingBuffer<T>(this.arraySize);
    }

    public T GetHistoryObject(int tick, UniqueId uid)
    {
      if (!this.store.ContainsKey(uid))
        throw new KeyNotFoundException("The given key has not been added to the dictionary. Call RegisterUniqueId.");
      return this.store[uid].GetObject(tick);
    }

    public bool TryGetHistoryObject(int tick, UniqueId uid, out T t)
    {
      if (!this.store.ContainsKey(uid) || this.store[uid].GetWritten(tick) < tick)
      {
        t = default (T);
        return false;
      }
      if (this.lastWritten >= tick)
      {
        t = this.store[uid].GetObject(tick);
        return true;
      }
      t = default (T);
      return false;
    }

    public int AddHistoryObject(
      int tick,
      UniqueId uid,
      T obj,
      bool fromFuture = false,
      int copyFromReferenceTick = -1)
    {
      if (!this.store.ContainsKey(uid))
        throw new KeyNotFoundException("The given key has not been added to the dictionary. Call RegisterUniqueId.");
      this.store[uid].SetObject(tick, obj);
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
      if (!this.store.ContainsKey(id))
        throw new KeyNotFoundException("The given key has not been added to the dictionary. Call RegisterUniqueId.");
      if (tick > this.lastWritten + 1)
        Console.WriteLine("Skip in World History detected.");
      IHistoryObject copyFromReference = (IHistoryObject) null;
      if (copyFromReferenceTick >= 0)
        copyFromReference = (IHistoryObject) this.GetHistoryObject(copyFromReferenceTick, id);
      T t = this.store[id].GetObject(tick);
      t.CopyFrom(entity, copyFromReference);
      this.store[id].SetObject(tick, t);
      this.lastWritten = Math.Max(this.lastWritten, tick);
      return tick;
    }
  }
}
