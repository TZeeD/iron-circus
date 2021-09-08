// Decompiled with JetBrains decompiler
// Type: ContextsExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Jitter.Dynamics;
using System.Collections.Generic;

public static class ContextsExtensions
{
  public static MetaEntity GetEntityWithMetaPlayerId(
    this MetaContext context,
    ulong value)
  {
    return ((PrimaryEntityIndex<MetaEntity, ulong>) context.GetEntityIndex("MetaPlayerId")).GetEntity(value);
  }

  public static HashSet<GameEntity> GetEntitiesWithPlayerId(
    this GameContext context,
    ulong value)
  {
    return ((EntityIndex<GameEntity, ulong>) context.GetEntityIndex("PlayerId")).GetEntities(value);
  }

  public static HashSet<GameEntity> GetEntitiesWithPlayerTeam(
    this GameContext context,
    Team value)
  {
    return ((EntityIndex<GameEntity, Team>) context.GetEntityIndex("PlayerTeam")).GetEntities(value);
  }

  public static HashSet<GameEntity> GetEntitiesWithRigidbody(
    this GameContext context,
    JRigidbody value)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("Rigidbody")).GetEntities(value);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerEnterEventFirst(
    this GameContext context,
    JRigidbody first)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerEnterEventFirst")).GetEntities(first);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerEnterEventSecond(
    this GameContext context,
    JRigidbody second)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerEnterEventSecond")).GetEntities(second);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerEvent(
    this GameContext context,
    JTriggerPair bodies)
  {
    return ((EntityIndex<GameEntity, JTriggerPair>) context.GetEntityIndex("TriggerEvent")).GetEntities(bodies);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerExitEventFirst(
    this GameContext context,
    JRigidbody first)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerExitEventFirst")).GetEntities(first);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerExitEventSecond(
    this GameContext context,
    JRigidbody second)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerExitEventSecond")).GetEntities(second);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerStayEventFirst(
    this GameContext context,
    JRigidbody first)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerStayEventFirst")).GetEntities(first);
  }

  public static HashSet<GameEntity> GetEntitiesWithTriggerStayEventSecond(
    this GameContext context,
    JRigidbody second)
  {
    return ((EntityIndex<GameEntity, JRigidbody>) context.GetEntityIndex("TriggerStayEventSecond")).GetEntities(second);
  }

  public static HashSet<GameEntity> GetEntitiesWithUniqueId(
    this GameContext context,
    UniqueId id)
  {
    return ((EntityIndex<GameEntity, UniqueId>) context.GetEntityIndex("UniqueId")).GetEntities(id);
  }
}
