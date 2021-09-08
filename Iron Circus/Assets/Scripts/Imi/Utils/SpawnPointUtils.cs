// Decompiled with JetBrains decompiler
// Type: Imi.Utils.SpawnPointUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using System.Linq;

namespace Imi.Utils
{
  public static class SpawnPointUtils
  {
    public static void ResetPlayer(GameContext gameContext, GameEntity playerEntity)
    {
      foreach (GameEntity gameEntity in gameContext.GetGroup(GameMatcher.PlayerSpawnPoint))
      {
        if (gameEntity.playerSpawnPoint.matchType == gameContext.matchData.matchType && (long) gameEntity.playerSpawnPoint.playerId == (long) playerEntity.playerId.value && playerEntity.transform.position != gameEntity.transform.position)
        {
          playerEntity.ReplaceRespawnRigidbody(gameEntity.transform.position, gameEntity.transform.rotation);
          break;
        }
      }
    }

    public static GameEntity GetSpawnPointFor(GameContext gameContext, ulong playerId)
    {
      foreach (GameEntity gameEntity in gameContext.GetGroup(GameMatcher.PlayerSpawnPoint))
      {
        if (gameEntity.playerSpawnPoint.matchType == gameContext.matchData.matchType && (long) gameEntity.playerSpawnPoint.playerId == (long) playerId)
          return gameEntity;
      }
      return (GameEntity) null;
    }

    public static void ClearAllSpawnPoints(GameContext gameContext, IGroup<GameEntity> spawnPoints = null)
    {
      if (spawnPoints == null)
        spawnPoints = gameContext.GetGroup(GameMatcher.PlayerSpawnPoint);
      foreach (GameEntity spawnPoint in spawnPoints)
        spawnPoint.playerSpawnPoint.playerId = 0UL;
    }

    public static void AssignSpawnPoints(
      GameContext gameContext,
      Events events,
      IGroup<GameEntity> players = null)
    {
      if (players == null)
        players = gameContext.GetGroup(GameMatcher.Player);
      IGroup<GameEntity> group = gameContext.GetGroup(GameMatcher.PlayerSpawnPoint);
      MatchType matchType = gameContext.matchData.matchType;
      foreach (GameEntity player in players)
        player.isPlayerRespawning = true;
      foreach (GameEntity gameEntity in group)
        gameEntity.playerSpawnPoint.playerId = 0UL;
      foreach (GameEntity player in players)
      {
        foreach (GameEntity gameEntity in group)
        {
          if (gameEntity.playerSpawnPoint.matchType == matchType && player.playerTeam.value == gameEntity.playerSpawnPoint.team && gameEntity.playerSpawnPoint.playerId == 0UL)
          {
            gameEntity.playerSpawnPoint.playerId = player.playerId.value;
            Log.Debug(string.Format("Linked SpawnPoint: Team: {0} ID: {1}", (object) player.playerTeam.value, (object) player.playerId.value));
            events.FireEventSpawnPointLinked((int) matchType, player.playerId.value, player.playerTeam.value, gameEntity.uniqueId.id);
            break;
          }
        }
      }
    }

    public static void RotateSpawnpoints(GameContext gameContext)
    {
      IGroup<GameEntity> group = gameContext.GetGroup(GameMatcher.PlayerSpawnPoint);
      List<GameEntity> list1 = new List<GameEntity>();
      List<GameEntity> list2 = new List<GameEntity>();
      foreach (GameEntity gameEntity in group)
      {
        if (gameEntity.playerSpawnPoint.matchType == gameContext.matchData.matchType)
        {
          if (gameEntity.playerSpawnPoint.team == Team.Alpha)
            list1.Add(gameEntity);
          else if (gameEntity.playerSpawnPoint.team == Team.Beta)
            list2.Add(gameEntity);
        }
      }
      if (list1.Count > 1)
      {
        List<ulong> playerIdList = SpawnPointUtils.ConvertToPlayerIdList(list1.Rotate<GameEntity>(1));
        for (int index = 0; index < list1.Count; ++index)
          list1[index].playerSpawnPoint.playerId = playerIdList[index];
      }
      if (list2.Count <= 1)
        return;
      List<ulong> playerIdList1 = SpawnPointUtils.ConvertToPlayerIdList(list2.Rotate<GameEntity>(1));
      for (int index = 0; index < list2.Count; ++index)
        list2[index].playerSpawnPoint.playerId = playerIdList1[index];
    }

    public static List<T> Rotate<T>(this List<T> list, int offset) => list.Skip<T>(offset).Concat<T>(list.Take<T>(offset)).ToList<T>();

    public static List<ulong> ConvertToPlayerIdList(List<GameEntity> list)
    {
      List<ulong> ulongList = new List<ulong>();
      foreach (GameEntity gameEntity in list)
        ulongList.Add(gameEntity.playerSpawnPoint.playerId);
      return ulongList;
    }
  }
}
