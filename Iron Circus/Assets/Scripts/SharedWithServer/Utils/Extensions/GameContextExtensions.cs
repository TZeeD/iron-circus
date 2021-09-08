// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Utils.Extensions.GameContextExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Jitter.Dynamics;
using System.Collections.Generic;

namespace SharedWithServer.Utils.Extensions
{
  public static class GameContextExtensions
  {
    public static HashSet<GameEntity> GetEntitiesWithPlayerIdCopy(
      this GameContext context,
      ulong value)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithPlayerId(value));
    }

    public static HashSet<GameEntity> GetEntitiesWithPlayerTeamCopy(
      this GameContext context,
      Team value)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithPlayerTeam(value));
    }

    public static HashSet<GameEntity> GetEntitiesWithRigidbodyCopy(
      this GameContext context,
      JRigidbody value)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithRigidbody(value));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerEnterEventFirstCopy(
      this GameContext context,
      JRigidbody first)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerEnterEventFirst(first));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerEnterEventSecondCopy(
      this GameContext context,
      JRigidbody second)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerEnterEventSecond(second));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerEventCopy(
      this GameContext context,
      JTriggerPair bodies)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerEvent(bodies));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerExitEventFirstCopy(
      this GameContext context,
      JRigidbody first)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerExitEventFirst(first));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerExitEventSecondCopy(
      this GameContext context,
      JRigidbody second)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerExitEventSecond(second));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerStayEventFirstCopy(
      this GameContext context,
      JRigidbody first)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerStayEventFirst(first));
    }

    public static HashSet<GameEntity> GetEntitiesWithTriggerStayEventSecondCopy(
      this GameContext context,
      JRigidbody second)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithTriggerStayEventSecond(second));
    }

    public static HashSet<GameEntity> GetEntitiesWithUniqueIdCopy(
      this GameContext context,
      UniqueId id)
    {
      return new HashSet<GameEntity>((IEnumerable<GameEntity>) context.GetEntitiesWithUniqueId(id));
    }
  }
}
