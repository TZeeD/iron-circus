// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.Player.PlayerHealthSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;

namespace Imi.SharedWithServer.ScEntitas.Systems.Player
{
  public class PlayerHealthSystem : ExecuteGameSystem
  {
    private readonly Events events;
    private readonly MatchConfig matchConfig;
    private IGroup<GameEntity> healthGroup;
    private IGroup<GameEntity> respawningGroup;

    public PlayerHealthSystem(EntitasSetup entitasSetup)
      : base(entitasSetup)
    {
      this.events = entitasSetup.Events;
      this.matchConfig = entitasSetup.ConfigProvider.matchConfig;
      this.healthGroup = this.gameContext.GetGroup(GameMatcher.PlayerHealth);
      this.respawningGroup = this.gameContext.GetGroup(GameMatcher.PlayerRespawning);
    }

    protected override void GameExecute()
    {
      foreach (GameEntity playerE in this.healthGroup)
      {
        int oldHealth = playerE.playerHealth.value;
        for (int index = 0; index < playerE.playerHealth.modifyHealthEvents.Count; ++index)
        {
          ModifyHealth modifyHealthEvent = playerE.playerHealth.modifyHealthEvents[index];
          playerE.playerHealth.value += modifyHealthEvent.value;
          Log.Debug(string.Format("health {0}", (object) modifyHealthEvent.value));
          if (playerE.playerHealth.value > playerE.championConfig.value.maxHealth)
            playerE.playerHealth.value = playerE.championConfig.value.maxHealth;
          if (modifyHealthEvent.value < 0 && modifyHealthEvent.instigatorPlayerId != 0UL)
            this.gameContext.eventDispatcher.value.EnqueueDamageDone(modifyHealthEvent.instigatorPlayerId, playerE.playerId.value, modifyHealthEvent.value);
          this.HandlePlayerDeath(playerE, modifyHealthEvent.instigatorPlayerId);
          this.UpdateHealthMessage(playerE, oldHealth);
        }
        playerE.playerHealth.modifyHealthEvents.Clear();
      }
      foreach (GameEntity entity in this.respawningGroup.GetEntities())
        this.ResetPlayer(entity);
    }

    private void UpdateHealthMessage(GameEntity playerE, int oldHealth) => this.events.FireEventPlayerHealthChanged(playerE.playerId.value, oldHealth, playerE.playerHealth.value, playerE.championConfig.value.maxHealth, playerE.playerHealth.value <= 0);

    private void HandlePlayerDeath(GameEntity playerE, ulong instigatorId)
    {
      if (playerE.IsDead() || playerE.playerHealth.value > 0)
        return;
      float num = this.matchConfig.respawnTime + this.matchConfig.addedRespawnTime * (float) this.GetTeamDeaths(playerE);
      if ((double) num > (double) this.matchConfig.respawnTimeCap)
        num = this.matchConfig.respawnTimeCap;
      playerE.AddStatusEffect(this.gameContext, StatusEffect.Dead(instigatorId, num));
      this.gameContext.gamePhysics.world.RemoveBody(playerE.rigidbody.value);
      this.events.FireEventPlayerDeath(playerE.playerId.value, instigatorId, num);
      GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(instigatorId);
      this.UpdatePlayerStatisticsDeath(playerE, entityWithPlayerId);
    }

    private void UpdatePlayerStatisticsDeath(GameEntity playerEntity, GameEntity instigatorEntity)
    {
      if (playerEntity != null && instigatorEntity != null)
      {
        this.gameContext.eventDispatcher.value.EnqueueDeathKillEvent(playerEntity.playerId.value, instigatorEntity.playerId.value);
        playerEntity.playerStatistics.koedByPlayer.Add(instigatorEntity.playerId.value);
        instigatorEntity.playerStatistics.koedPlayers.Add(playerEntity.playerId.value);
      }
      else
        Log.Error("instigatorEntity of PlayerDeath was null!");
    }

    private void ResetPlayer(GameEntity playerE)
    {
      int oldHealth = playerE.playerHealth.value;
      playerE.ReplacePlayerHealth(playerE.championConfig.value.maxHealth, playerE.playerHealth.modifyHealthEvents);
      playerE.playerHealth.modifyHealthEvents.Clear();
      this.UpdateHealthMessage(playerE, oldHealth);
    }

    private int GetTeamDeaths(GameEntity playerE)
    {
      Team team = playerE.playerTeam.value;
      int num = 0;
      foreach (GameEntity entity in this.gameContext.GetGroup(GameMatcher.Player).GetEntities())
      {
        if (entity.hasPlayerTeam && entity.playerTeam.value == team)
          num += entity.playerStatistics.koedByPlayer.Count;
      }
      return num;
    }
  }
}
