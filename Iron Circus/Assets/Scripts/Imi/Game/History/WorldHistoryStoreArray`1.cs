// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.WorldHistoryStoreArray`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using System;
using System.Collections.Generic;

namespace Imi.Game.History
{
  public class WorldHistoryStoreArray<T> : IWorldHistoryStore<T> where T : IHistoryObject, new()
  {
    private readonly int arraySize;
    private Dictionary<UniqueId, T[]> store;
    public int LastWritten;

    public WorldHistoryStoreArray(int capacity, int arraySize)
    {
      this.arraySize = arraySize;
      this.store = new Dictionary<UniqueId, T[]>(capacity);
    }

    public bool HasEntity(UniqueId uid) => this.store.ContainsKey(uid);

    public void InitializeStorageFor(UniqueId uid)
    {
      if (this.store.ContainsKey(uid))
        return;
      this.store[uid] = new T[this.arraySize];
      for (int index = 0; index < this.arraySize; ++index)
        this.store[uid][index] = new T();
    }

    public bool TryGetHistoryObject(int tick, UniqueId uid, out T t)
    {
      if (!this.store.ContainsKey(uid))
      {
        t = default (T);
        return false;
      }
      if (this.LastWritten >= tick)
      {
        t = this.store[uid][tick];
        return true;
      }
      t = default (T);
      return false;
    }

    public T GetHistoryObject(int tick, UniqueId uid)
    {
      if (!this.store.ContainsKey(uid))
        throw new KeyNotFoundException("The given key has not been added to the dictionary. Call RegisterUniqueId.");
      return this.store[uid][tick];
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
      this.store[uid][tick] = obj;
      this.LastWritten = Math.Max(this.LastWritten, tick);
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
      if (tick > this.LastWritten + 1)
        Console.WriteLine("Skip in World History detected.");
      IHistoryObject copyFromReference = (IHistoryObject) null;
      if (copyFromReferenceTick >= 0)
        copyFromReference = (IHistoryObject) this.GetHistoryObject(copyFromReferenceTick, id);
      this.store[id][tick].CopyFrom(entity, copyFromReference);
      this.LastWritten = Math.Max(this.LastWritten, tick);
      return tick;
    }
  }
}
