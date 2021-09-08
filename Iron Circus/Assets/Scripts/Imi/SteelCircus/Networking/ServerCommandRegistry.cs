// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.ServerCommandRegistry
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.Diagnostics;
using Imi.Game;
using Imi.Networking.Messages;
using Imi.ScEvents;
using Imi.ScGameStats;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using SharedWithServer.Game;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.GameElements;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Imi.SteelCircus.Networking
{
  public class ServerCommandRegistry
  {
    private readonly MetaController metaController;
    private readonly Events events;
    private readonly GameContext gameContext;

    public ServerCommandRegistry(
      MetaController metaController,
      Events events,
      GameContext gameContext,
      ConfigProvider configProvider)
    {
      this.metaController = metaController;
      this.events = events;
      this.gameContext = gameContext;
      Events.Global.OnNetEventPickupConsumedMessage += new Events.NetEventPickupConsumedMessage(this.OnPickupConsumed);
      Events.Global.OnNetEventSpawnPickupMessage += new Events.NetEventSpawnPickupMessage(this.OnSpawnPickup);
      Events.Global.OnNetEventResetPickupMessage += new Events.NetEventResetPickupMessage(this.OnResetPickup);
      Events.Global.OnNetEventPickupWillSpawnMessage += new Events.NetEventPickupWillSpawnMessage(this.OnWillSpawnPickup);
      Events.Global.OnNetEventScoreMessage += new Events.EventNetworkEvent<ScoreMessage>(this.OnScoreEvent);
      Events.Global.OnNetEventLoadArenaMessage += new Events.EventNetworkEvent<LoadArenaMessage>(this.OnLoadLocalArena);
      Events.Global.OnNetEventSpawnSpraytagMessage += new Events.NetEventSpawnSpraytagMessage(this.OnSpawnSpraytag);
      Events.Global.OnNetEventGameStatMatchFinishedMessage += new Events.EventNetworkEvent<GameStatMatchFinishedMessage>(this.OnMatchFinished);
      Events.Global.OnNetEventPlayerHealthChangedMessage += new Events.NetEventPlayerHealthChangedMessage(this.OnPlayerHealthChangedMsg);
      Events.Global.OnNetEventPlayerDeathMessage += new Events.NetEventPlayerDeathMessage(this.OnPlayerDeath);
      Events.Global.OnNetEventSpawnPointLinkedMessage += new Events.NetEventSpawnPointLinkedMessage(this.OnSpawnPointLinked);
      Events.Global.OnNetEventTransitionPlayerToLobbyMessage += new Events.NetEventTransitionPlayerToLobbyMessage(this.OnTransitionPlayerToLobby);
      Events.Global.OnNetEventQuickChatMessage += new Events.NetEventQuickChatMessage(this.OnQuickChatMessage);
      Events.Global.OnNetEventLobbyPickOrderMessage += new Events.EventNetworkEvent<LobbyPickOrderMessage>(this.OnLobbyPickOrderMessage);
      Events.Global.OnNetEventLobbyPickTimesMessage += new Events.EventNetworkEvent<LobbyPickTimesMessage>(this.OnLobbyPickTimesMessage);
      Events.Global.OnNetEventTrackingEventMessage += new Events.NetEventTrackingEventMessage(this.OnTrackingEvent);
      Events.Global.OnNetEventMetaStateChangedMessage += new Events.NetEventMetaStateChanged(this.OnMetaStateChanged);
      Events.Global.OnNetEventBumperCollisionEnableMessage += new Events.EventNetworkEvent<BumperCollisionEnableMessage>(this.OnBumperCollisionEnable);
      Events.Global.OnNetEventBumperCollisionDisableMessage += new Events.EventNetworkEvent<BumperCollisionDisableMessage>(this.OnBumperCollisionDisable);
      Events.Global.OnNetEventPlayerFinishedPickingMessage += new Events.NetEventPlayerFinishedPickingMessage(this.OnPlayerFinishedPicking);
      Events.Global.OnNetEventMatchInfoMessage += new Events.EventNetworkEvent<MatchInfoMessage>(this.OnMatchInfo);
      Events.Global.OnNetEventPlayerForfeitMatchMessage += new Events.NetEventPlayerForfeitMatchMessage(this.OnPlayerForfeitMatch);
      Events.Global.OnNetEventForfeitMatchOverMessage += new Events.NetEventForfeitMatchOverMessage(this.OnForfeitMatch);
      Events.Global.OnNetEventPlayersVoteUpdateMessage += new Events.EventNetworkEvent<PlayersVoteUpdateMessage>(this.OnPlayersVoteUpdate);
    }

    public void TearDown()
    {
      Events.Global.OnNetEventPickupConsumedMessage -= new Events.NetEventPickupConsumedMessage(this.OnPickupConsumed);
      Events.Global.OnNetEventSpawnPickupMessage -= new Events.NetEventSpawnPickupMessage(this.OnSpawnPickup);
      Events.Global.OnNetEventPickupWillSpawnMessage -= new Events.NetEventPickupWillSpawnMessage(this.OnWillSpawnPickup);
      Events.Global.OnNetEventScoreMessage -= new Events.EventNetworkEvent<ScoreMessage>(this.OnScoreEvent);
      Events.Global.OnNetEventLoadArenaMessage -= new Events.EventNetworkEvent<LoadArenaMessage>(this.OnLoadLocalArena);
      Events.Global.OnNetEventSpawnSpraytagMessage -= new Events.NetEventSpawnSpraytagMessage(this.OnSpawnSpraytag);
      Events.Global.OnNetEventGameStatMatchFinishedMessage -= new Events.EventNetworkEvent<GameStatMatchFinishedMessage>(this.OnMatchFinished);
      Events.Global.OnNetEventPlayerHealthChangedMessage -= new Events.NetEventPlayerHealthChangedMessage(this.OnPlayerHealthChangedMsg);
      Events.Global.OnNetEventPlayerDeathMessage -= new Events.NetEventPlayerDeathMessage(this.OnPlayerDeath);
      Events.Global.OnNetEventSpawnPointLinkedMessage -= new Events.NetEventSpawnPointLinkedMessage(this.OnSpawnPointLinked);
      Events.Global.OnNetEventTransitionPlayerToLobbyMessage -= new Events.NetEventTransitionPlayerToLobbyMessage(this.OnTransitionPlayerToLobby);
      Events.Global.OnNetEventQuickChatMessage -= new Events.NetEventQuickChatMessage(this.OnQuickChatMessage);
      Events.Global.OnNetEventLobbyPickOrderMessage -= new Events.EventNetworkEvent<LobbyPickOrderMessage>(this.OnLobbyPickOrderMessage);
      Events.Global.OnNetEventLobbyPickTimesMessage -= new Events.EventNetworkEvent<LobbyPickTimesMessage>(this.OnLobbyPickTimesMessage);
      Events.Global.OnNetEventTrackingEventMessage -= new Events.NetEventTrackingEventMessage(this.OnTrackingEvent);
      Events.Global.OnNetEventMetaStateChangedMessage -= new Events.NetEventMetaStateChanged(this.OnMetaStateChanged);
      Events.Global.OnNetEventBumperCollisionEnableMessage -= new Events.EventNetworkEvent<BumperCollisionEnableMessage>(this.OnBumperCollisionEnable);
      Events.Global.OnNetEventBumperCollisionDisableMessage -= new Events.EventNetworkEvent<BumperCollisionDisableMessage>(this.OnBumperCollisionDisable);
      Events.Global.OnNetEventPlayerFinishedPickingMessage -= new Events.NetEventPlayerFinishedPickingMessage(this.OnPlayerFinishedPicking);
      Events.Global.OnNetEventMatchInfoMessage -= new Events.EventNetworkEvent<MatchInfoMessage>(this.OnMatchInfo);
      Events.Global.OnNetEventPlayerForfeitMatchMessage -= new Events.NetEventPlayerForfeitMatchMessage(this.OnPlayerForfeitMatch);
      Events.Global.OnNetEventForfeitMatchOverMessage -= new Events.NetEventForfeitMatchOverMessage(this.OnForfeitMatch);
      Events.Global.OnNetEventPlayersVoteUpdateMessage -= new Events.EventNetworkEvent<PlayersVoteUpdateMessage>(this.OnPlayersVoteUpdate);
    }

    public void OnMetaStateChanged(MetaState state) => Events.Global.FireEventMetaStateChanged(in state);

    private void OnSpawnPointLinked(int matchType, ulong playerId, Team team, UniqueId uniqueId)
    {
      GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(uniqueId);
      if (entityWithUniqueId == null || entityWithUniqueId.playerSpawnPoint.matchType != (MatchType) matchType || entityWithUniqueId.playerSpawnPoint.team != team)
        return;
      entityWithUniqueId.playerSpawnPoint.playerId = playerId;
      Log.Debug(string.Format("Linked SpawnPoint: Team: {0} ID: {1}", (object) team, (object) playerId));
    }

    private void OnTrackingEvent(ulong playerId, Statistics statistics, float value)
    {
      Debug.Log((object) string.Format("{0} - {1}", (object) playerId, (object) statistics.ToString()));
      this.events.FireEventTrackingEvent(new TrackingEvent(playerId, statistics, value, (StatisticsMode) 2));
    }

    private void OnMatchFinished(NetworkEvent<GameStatMatchFinishedMessage> e) => this.events.FireEventGameStatMatchFinished(new GameStatMatchFinishedEvent(e.msg.arena, e.msg.matchId, e.msg.matchResults));

    private void OnSpawnSpraytag(ulong playerId, float x, float z, int spraySlot)
    {
      bool flag = false;
      int spraytagIndex = this.GetSpraytagIndex();
      JVector jvector = new JVector(x, (float) (1.0 / 1000.0 * (double) spraytagIndex - 3.0), z);
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
      if (entityWithPlayerId == null)
      {
        Log.Error("The required player id for this spawn spraytag message does not exist.");
        flag = true;
      }
      ChampionType type = entityWithPlayerId.playerChampionData.value.type;
      switch (type)
      {
        case ChampionType.Invalid:
        case ChampionType.Random:
          Log.Error("The required championtype for this spawn spraytag message is invalid.");
          flag = true;
          break;
      }
      if (!entityWithPlayerId.hasPlayerLoadout)
      {
        Log.Debug("Error: SpraytagSpawnMessage playerEntity had no PlayerLoadout Component");
        flag = true;
      }
      else if (!entityWithPlayerId.playerLoadout.itemLoadouts.ContainsKey(type))
      {
        Log.Debug("Error: SpraytagSpawnMessage item loadout not found");
        flag = true;
      }
      if (flag)
        return;
      GameObject sprayPrefab = entityWithPlayerId.playerLoadout.itemLoadouts[type].sprayPrefabs[spraySlot - 1];
      GameEntity spraytagEntity = this.gameContext.CreateEntity();
      spraytagEntity.AddSpraytag(sprayPrefab.name, true, 9f, 0.0f, spraytagIndex);
      spraytagEntity.AddTransform(jvector, JQuaternion.LookForward);
      spraytagEntity.AddCountdownAction(CountdownAction.WithDuration(9f).WithFinishedAction((Action) (() =>
      {
        if (!spraytagEntity.hasUnityView)
          return;
        spraytagEntity.unityView.gameObject.Unlink();
        UnityEngine.Object.Destroy((UnityEngine.Object) spraytagEntity.unityView.gameObject);
        spraytagEntity.RemoveUnityView();
      })).DestoyEntityWhenDone().Create());
      if (spraytagEntity.hasUnityView)
        return;
      GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(sprayPrefab, jvector.ToVector3(), Quaternion.identity);
      spraytagEntity.AddUnityView(gameObject);
      gameObject.Link((IEntity) spraytagEntity, (IContext) this.gameContext);
    }

    private int GetSpraytagIndex()
    {
      GameEntity[] entities = this.gameContext.GetGroup((IMatcher<GameEntity>) GameMatcher.AllOf(GameMatcher.Spraytag)).GetEntities();
      if (entities.Length == 0)
        return 1;
      int num = ((IEnumerable<GameEntity>) entities).Max<GameEntity>((Func<GameEntity, int>) (sprayIndex => sprayIndex.spraytag.spraytagIndex));
      return num >= entities.Length ? num + 1 : entities.Length;
    }

    private void OnLoadLocalArena(NetworkEvent<LoadArenaMessage> e) => this.metaController.StartArenaLoading(e.msg.arenaName, e.msg.numPlayers);

    private void OnPlayerHealthChangedMsg(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(playerId);
      List<ModifyHealth> newModifyHealthEvents = entityWithPlayerId.hasPlayerHealth ? entityWithPlayerId.playerHealth.modifyHealthEvents : new List<ModifyHealth>();
      entityWithPlayerId.ReplacePlayerHealth(currentHealth, newModifyHealthEvents);
      this.events.FireEventPlayerHealthChanged(playerId, oldHealth, currentHealth, maxHealth, isDead);
    }

    private void OnPlayerDeath(ulong playerId, ulong instigatorPlayerId, float respawnDuration)
    {
      Log.Debug(string.Format("Player {0} killed by {1} respawnTime: {2}", (object) playerId, (object) instigatorPlayerId, (object) respawnDuration));
      this.gameContext.gamePhysics.world.RemoveBody(this.gameContext.GetFirstEntityWithPlayerId(playerId).rigidbody.value);
      this.events.FireEventPlayerDeath(playerId, instigatorPlayerId, respawnDuration);
    }

    private void OnWillSpawnPickup(UniqueId id, PickupType pickupType, float duration)
    {
      Log.Debug(string.Format("Pickup will spawn in {0} seconds with id {1} Type= {2}", (object) duration, (object) id, (object) pickupType));
      GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(id);
      entityWithUniqueId.unityView.gameObject.GetComponent<PickupSpawnpointUnityBehaviourBase>().ShowPickupCountdown(entityWithUniqueId.uniqueId.id, pickupType, duration);
    }

    private void OnSpawnPickup(UniqueId id, PickupType pickupType, float x, float y, float z)
    {
      Log.Debug("SpawnPickup received " + (object) pickupType);
      GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(id);
      if (entityWithUniqueId == null)
        return;
      entityWithUniqueId.pickup.activeType = pickupType;
      if (!entityWithUniqueId.hasUnityView)
        return;
      entityWithUniqueId.unityView.gameObject.GetComponent<PickupSpawnpointUnityBehaviourBase>().ActivatePickupView(entityWithUniqueId);
    }

    private void OnResetPickup(UniqueId id)
    {
      Log.Debug(string.Format("ResetPickup received uid: {0}", (object) id));
      GameEntity entityWithUniqueId = this.gameContext.GetFirstEntityWithUniqueId(id);
      if (entityWithUniqueId == null)
        return;
      entityWithUniqueId.pickup.isActive = false;
      entityWithUniqueId.pickup.currentDuration = 0.0f;
      if (entityWithUniqueId.hasUnityView)
        entityWithUniqueId.unityView.gameObject.GetComponent<PickupSpawnpointUnityBehaviourBase>().DeactivatePickupView(entityWithUniqueId.pickup.activeType);
      this.events.FireEventPickupReset(id);
    }

    private void OnPickupConsumed(UniqueId id, UniqueId playerUniqueId)
    {
      Log.Debug(string.Format("PickupConsumedMessage received: PickupID = {0} PlayerID = {1}", (object) id, (object) playerUniqueId));
      GameEntity entityWithUniqueId1 = this.gameContext.GetFirstEntityWithUniqueId(id);
      GameEntity entityWithUniqueId2 = this.gameContext.GetFirstEntityWithUniqueId(playerUniqueId);
      if (entityWithUniqueId1.hasUnityView)
      {
        entityWithUniqueId1.unityView.gameObject.GetComponent<PickupSpawnpointUnityBehaviourBase>().DeactivatePickupView(entityWithUniqueId1.pickup.activeType);
        this.events.FireEventPickupConsumed(id, playerUniqueId);
      }
      string audioId = "";
      if (entityWithUniqueId2 == null || !entityWithUniqueId2.hasUnityView)
        return;
      entityWithUniqueId2.ReplacePickupConsumed(entityWithUniqueId1.pickup.activeType);
      switch (entityWithUniqueId1.pickup.activeType)
      {
        case PickupType.RefreshSkills:
          entityWithUniqueId2.unityView.gameObject.GetComponent<Player>().PlaySkillRefreshFXTrigger();
          audioId = "PickupItemSkill";
          break;
        case PickupType.RegainHealth:
          entityWithUniqueId2.unityView.gameObject.GetComponent<Player>().PlayHealthGainFXTrigger();
          audioId = "PickupItemHealth";
          break;
        case PickupType.RefreshSprint:
          entityWithUniqueId2.unityView.gameObject.GetComponent<Player>().PlaySprintRefreshFXTrigger();
          audioId = "PickupItemHealth";
          break;
      }
      AudioTriggerManager.PlayAudioUnwatched2DIfLocal(audioId, entityWithUniqueId2, volumeIfRemote: 0.8f);
    }

    private void OnScoreEvent(NetworkEvent<ScoreMessage> e)
    {
      if (e.msg.isReset)
      {
        this.gameContext.score.score[Team.Alpha] = 0;
        this.gameContext.score.score[Team.Beta] = 0;
      }
      else
        this.gameContext.ReplaceScore(e.msg.lastTeamThatScored, e.msg.playerId, e.msg.score);
    }

    private void OnTransitionPlayerToLobby(ulong playerId)
    {
      GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(playerId);
      if (entityWithPlayerId != null)
      {
        entityWithPlayerId.ReplaceArenaLoaded(true);
        if (!entityWithPlayerId.isLocalEntity)
          return;
        Log.Debug(string.Format("Local Player entered the Lobby: ClientId = {0}.", (object) playerId));
        ImiServices.Instance.LoadingScreenService.HideLoadingScreen();
      }
      else
        Log.Warning(string.Format("TransitionPlayerToLobbyMessage: Player Entity was null for Player:{0}. ArenaLoadComponent was not set! Ignore for now if you played with Fake Players.", (object) playerId));
    }

    private void OnBumperCollisionEnable(NetworkEvent<BumperCollisionEnableMessage> e)
    {
      Log.Debug(string.Format("Received BumperCollisionEnableMessage for {0} Bumpers.", (object) e.msg.BumperIds.Length));
      GameContext game = Contexts.sharedInstance.game;
      foreach (UniqueId bumperId in e.msg.BumperIds)
      {
        GameEntity entityWithUniqueId = game.GetFirstEntityWithUniqueId(bumperId);
        game.gamePhysics.world.AddBody(entityWithUniqueId.rigidbody.value);
        if (entityWithUniqueId.hasUnityView)
        {
          BallBumper component1 = entityWithUniqueId.unityView.gameObject.GetComponent<BallBumper>();
          if (component1.GetBumperType() == BumperType.Round)
          {
            entityWithUniqueId.unityView.gameObject.SetActive(true);
            component1.GetFloorUi().gameObject.SetActive(true);
            PlayerSpawnView component2 = entityWithUniqueId.unityView.gameObject.GetComponent<PlayerSpawnView>();
            if ((UnityEngine.Object) component2 != (UnityEngine.Object) null)
              component2.RespawnPlayerEffect();
          }
        }
      }
    }

    private void OnBumperCollisionDisable(NetworkEvent<BumperCollisionDisableMessage> e)
    {
      Log.Debug(string.Format("Received BumperCollisionDisableMessage for {0} Bumpers", (object) e.msg.BumperIds.Length));
      GameContext game = Contexts.sharedInstance.game;
      foreach (UniqueId bumperId in e.msg.BumperIds)
      {
        GameEntity entityWithUniqueId = game.GetFirstEntityWithUniqueId(bumperId);
        game.gamePhysics.world.RemoveBody(entityWithUniqueId.rigidbody.value);
        if (entityWithUniqueId.hasUnityView)
        {
          BallBumper component = entityWithUniqueId.unityView.gameObject.GetComponent<BallBumper>();
          if (component.GetBumperType() == BumperType.Round)
          {
            entityWithUniqueId.unityView.gameObject.SetActive(false);
            component.GetFloorUi().gameObject.SetActive(false);
          }
        }
      }
    }

    private void OnQuickChatMessage(ulong playerId, int msgType)
    {
      Log.Debug(string.Format("Received QuickChatMessage: {0}", (object) msgType));
      Events.Global.FireEventQuickChat(playerId, msgType);
    }

    private void OnLobbyPickOrderMessage(NetworkEvent<LobbyPickOrderMessage> e)
    {
      Log.Debug(string.Format("Received OnLobbyPickOrderMessage: {0} - {1}", (object) e.msg.alphaPickOrder.Length, (object) e.msg.betaPickOrder.Length));
      Events.Global.FireEventLobbyPickOrder(e.msg.alphaPickOrder, e.msg.betaPickOrder);
    }

    private void OnLobbyPickTimesMessage(NetworkEvent<LobbyPickTimesMessage> e)
    {
      Log.Debug(string.Format("Received OnLobbyPickTimesMessage: {0} - {1}", (object) e.msg.AlphaPlayerPickTimes.Length, (object) e.msg.BetaPlayerPickTimes.Length));
      ImiServices.Instance.LoadingScreenService.HideLoadingScreen();
      Events.Global.FireEventLobbyPickTimes(ref e.msg.AlphaPlayerPickTimes, ref e.msg.BetaPlayerPickTimes);
    }

    private void OnPlayerFinishedPicking(ulong playerId, ChampionType type)
    {
      Log.Debug(string.Format("Received OnPlayerFinishedPicking: {0} - {1}", (object) playerId, (object) type));
      Events.Global.FireEventPlayerFinishedPicking(playerId, type);
    }

    private void OnMatchInfo(NetworkEvent<MatchInfoMessage> e)
    {
      Log.Debug(string.Format("MATCH START : {0} - {1} - GameType: {2}", (object) e.msg.matchId, (object) e.msg.arena, (object) e.msg.gameType));
      if (!Contexts.sharedInstance.meta.hasMetaMatch)
      {
        Contexts.sharedInstance.meta.CreateEntity().AddMetaMatch(e.msg.matchId, "", e.msg.arena, e.msg.gameType, false, false);
      }
      else
      {
        Contexts.sharedInstance.meta.metaMatchEntity.metaMatch.matchId = e.msg.matchId;
        Contexts.sharedInstance.meta.metaMatchEntity.metaMatch.currentArena = e.msg.arena;
        Contexts.sharedInstance.meta.metaMatchEntity.metaMatch.gameType = e.msg.gameType;
      }
      this.events.FireEventMatchInfo(e.msg.arena, e.msg.matchId, e.msg.gameType);
    }

    private void OnForfeitMatch(ulong playerId, Team team)
    {
      Log.Debug(string.Format("Forfeit Match: {0} - {1}", (object) playerId, (object) team));
      this.events.FireEventForfeitMatchOver(playerId, team);
    }

    private void OnPlayerForfeitMatch(ulong playerId, bool forfeit)
    {
      Log.Debug(string.Format("Received Player Forfeit Match: {0} - {1}", (object) playerId, (object) forfeit));
      GameEntity entityWithPlayerId = this.gameContext.GetFirstEntityWithPlayerId(playerId);
      if (entityWithPlayerId != null)
      {
        if (!entityWithPlayerId.hasPlayerForfeit)
          entityWithPlayerId.AddPlayerForfeit(forfeit);
        else
          entityWithPlayerId.playerForfeit.hasForfeit = forfeit;
      }
      this.events.FireEventPlayerForfeitMatch(playerId, forfeit);
    }

    private void OnPlayersVoteUpdate(NetworkEvent<PlayersVoteUpdateMessage> e)
    {
      Log.Debug("Received PlayersVoteUpdateMessage: " + (object) e.msg.PlayerVotes.Count);
      this.events.FireEventPlayersVoteUpdate(e.msg.PlayerVotes);
    }
  }
}
