// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.IWorldHistoryStore`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;

namespace Imi.Game.History
{
  public interface IWorldHistoryStore<T> where T : new()
  {
    void InitializeStorageFor(UniqueId uid);

    T GetHistoryObject(int tick, UniqueId uid);

    bool TryGetHistoryObject(int tick, UniqueId uid, out T obj);

    int AddHistoryObject(
      int tick,
      UniqueId uid,
      T obj,
      bool fromFuture = false,
      int copyFromReferenceTick = -1);

    int AddHistoryObject(int tick, GameEntity entity, bool fromFuture = false, int copyFromReferenceTick = -1);
  }
}
