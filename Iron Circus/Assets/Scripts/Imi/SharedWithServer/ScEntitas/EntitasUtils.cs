// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.EntitasUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Jitter.Dynamics;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEntitas
{
  public static class EntitasUtils
  {
    public static GameEntity GetFirstEntityWithRigidbody(
      this GameContext context,
      JRigidbody body)
    {
      HashSet<GameEntity> entitiesWithRigidbody = context.GetEntitiesWithRigidbody(body);
      if (entitiesWithRigidbody.Count == 0)
        return (GameEntity) null;
      using (HashSet<GameEntity>.Enumerator enumerator = entitiesWithRigidbody.GetEnumerator())
      {
        enumerator.MoveNext();
        return enumerator.Current;
      }
    }

    public static GameEntity GetFirstEntityWithPlayerId(
      this GameContext context,
      ulong idx)
    {
      HashSet<GameEntity> entitiesWithPlayerId = context.GetEntitiesWithPlayerId(idx);
      if (entitiesWithPlayerId.Count == 0)
        return (GameEntity) null;
      using (HashSet<GameEntity>.Enumerator enumerator = entitiesWithPlayerId.GetEnumerator())
      {
        enumerator.MoveNext();
        return enumerator.Current;
      }
    }

    public static GameEntity GetFirstLocalEntity(this GameContext gameContext) => gameContext.GetGroup(GameMatcher.LocalEntity).GetSingleEntity();

    public static bool HasLocalEntity(this GameContext gameContext) => gameContext.GetGroup(GameMatcher.LocalEntity).count > 0;

    public static GameEntity GetFirstEntityWithUniqueId(
      this GameContext context,
      UniqueId id)
    {
      HashSet<GameEntity> entitiesWithUniqueId = context.GetEntitiesWithUniqueId(id);
      if (entitiesWithUniqueId.Count == 0)
        return (GameEntity) null;
      using (HashSet<GameEntity>.Enumerator enumerator = entitiesWithUniqueId.GetEnumerator())
      {
        enumerator.MoveNext();
        return enumerator.Current;
      }
    }
  }
}
