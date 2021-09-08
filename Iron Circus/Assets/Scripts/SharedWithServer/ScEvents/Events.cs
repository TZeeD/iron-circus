// Decompiled with JetBrains decompiler
// Type: SharedWithServer.ScEvents.Events
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.Networking.Messages;
using Imi.ScEntitas;
using Imi.ScEvents;
using Imi.ScGameStats;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.Core;
using Jitter.LinearMath;
using SharedWithServer.Networking.Messages;
using SteelCircus.Core;
using SteelCircus.ScEvents;
using System.Collections.Generic;
using UnityEngine;

namespace SharedWithServer.ScEvents
{
  public class Events
  {
    public static Events Global { get; } = new Events();

    public event Events.EventCameraShake OnEventCameraShake = (_param1, _param2) => { };

    public void FireEventCameraShake(Transform referenceTransform, float strength = 1f) => this.OnEventCameraShake(referenceTransform, strength);

    public event Events.EventQualitySettingsChanged OnEventQualitySettingsChanged = _param1 => { };

    public void FireEventQualitySettingsChanged(QualityManager.RenderSettings newRenderSettings) => this.OnEventQualitySettingsChanged(newRenderSettings);

    public event Events.EventInputCollected OnEventInputCollected = _param1 => { };

    public void FireEventInputCollected(InputController.InputCollectedEvent input) => this.OnEventInputCollected(input);

    public event Events.EventCutscene OnEventCutscene = (_param1, _param2) => { };

    public void FireEventCutscene(CutsceneEventType type, string affectedObject) => this.OnEventCutscene(type, affectedObject);

    public event Events.EventPlayerLeft OnEventPlayerLeft = (_param1, _param2) => { };

    public void FireEventPlayerLeft(string username, Color usernameColor) => this.OnEventPlayerLeft(username, usernameColor);

    public event Events.EventLobbyPickOrder OnEventLobbyPickOrder = (_param1, _param2) => { };

    public void FireEventLobbyPickOrder(UniqueId[] alphaPickOrder, UniqueId[] betaPickOrder) => this.OnEventLobbyPickOrder(alphaPickOrder, betaPickOrder);

    public event Events.EventLobbyPickTimes OnEventLobbyPickTimes = (ref int[,] _param1, ref int[,] _param2) => { };

    public void FireEventLobbyPickTimes(
      ref int[,] alphaPlayerPickTimes,
      ref int[,] betaPlayerPickTimes)
    {
      this.OnEventLobbyPickTimes(ref alphaPlayerPickTimes, ref betaPlayerPickTimes);
    }

    public event Events.EventMetaStateChanged OnEventMetaStateChanged = (in MetaState _param1) => { };

    public void FireEventMetaStateChanged(in MetaState metaState) => this.OnEventMetaStateChanged(in metaState);

    public event Events.EventMatchStateChanged OnEventMatchStateChanged = (_param1, _param2, _param3) => { };

    public void FireEventMatchStateChanged(
      MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.OnEventMatchStateChanged(matchState, cutsceneDuration, remainingMatchTime);
    }

    public event Events.EventDisconnect OnEventDisconnect = (_param1, _param2) => { };

    public void FireEventDisconnect(ulong id, byte index) => this.OnEventDisconnect(id, index);

    public event Events.EventSelectTeam OnEventSelectTeam = _param1 => { };

    public void FireEventSelectTeam(Team team) => this.OnEventSelectTeam(team);

    public event Events.EventSelectChampion OnEventSelectChampion = (_param1, _param2, _param3) => { };

    public void FireEventSelectChampion(ChampionType type, int skinId, bool isReady) => this.OnEventSelectChampion(type, skinId, isReady);

    public event Events.EventChampionSelectionReady OnEventChampionSelectionReady = () => { };

    public void FireEventChampionSelectionReady() => this.OnEventChampionSelectionReady();

    public event Events.EventCutsceneCleanup OnEventCutsceneCleanup = _param1 => { };

    public void FireEventCutsceneCleanup(MatchState matchState) => this.OnEventCutsceneCleanup(matchState);

    public event Events.EventMatchInfo OnEventMatchInfo = (_param1, _param2, _param3) => { };

    public void FireEventMatchInfo(string arena, string matchId, GameType gameType) => this.OnEventMatchInfo(arena, matchId, gameType);

    public event Events.EventPlayerFinishedPicking OnEventPlayerFinishedPicking = (_param1, _param2) => { };

    public void FireEventPlayerFinishedPicking(ulong playerId, ChampionType type) => this.OnEventPlayerFinishedPicking(playerId, type);

    public event Events.EventShowHidePlayerUi OnEventShowHidePlayerUi = (_param1, _param2, _param3) => { };

    public void FireEventShowHidePlayerUi(ulong playerId, bool showFloorUi, bool showOverhead) => this.OnEventShowHidePlayerUi(playerId, showFloorUi, showOverhead);

    public event Events.EventPickupConsumed OnEventPickupConsumed = (_param1, _param2) => { };

    public void FireEventPickupConsumed(UniqueId id, UniqueId playerUniqueId) => this.OnEventPickupConsumed(id, playerUniqueId);

    public event Events.EventPickupReset OnEventPickupReset = _param1 => { };

    public void FireEventPickupReset(UniqueId id) => this.OnEventPickupReset(id);

    public event Events.EventDisableLeaveButton OnEventDisableLeaveButton = () => { };

    public void FireEventDisableLeaveButton() => this.OnEventDisableLeaveButton();

    public event Events.EventPlayerHealthChanged OnEventPlayerHealthChanged = (_param1, _param2, _param3, _param4, _param5) => { };

    public void FireEventPlayerHealthChanged(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      this.OnEventPlayerHealthChanged(playerId, oldHealth, currentHealth, maxHealth, isDead);
    }

    public event Events.EventMatchStartCountdown OnEventMatchStartCountdown = (_param1, _param2) => { };

    public void FireEventMatchStartCountdown(float countdown, LobbyState lobbyState) => this.OnEventMatchStartCountdown(countdown, lobbyState);

    public event Events.EventQuickChat OnEventQuickChat = (_param1, _param2) => { };

    public void FireEventQuickChat(ulong playerId, int msgType) => this.OnEventQuickChat(playerId, msgType);

    public event Events.EventPlayersVoteUpdate OnEventPlayersVoteUpdate = _param1 => { };

    public void FireEventPlayersVoteUpdate(Dictionary<ulong, int> playerVotes) => this.OnEventPlayersVoteUpdate(playerVotes);

    public event Events.EventPlayerForfeitMatch OnEventPlayerForfeitMatch = (_param1, _param2) => { };

    public void FireEventPlayerForfeitMatch(ulong playerId, bool forfeit) => this.OnEventPlayerForfeitMatch(playerId, forfeit);

    public event Events.EventForfeitMatchOver OnEventForfeitMatchOver = (_param1, _param2) => { };

    public void FireEventForfeitMatchOver(ulong playerId, Team team) => this.OnEventForfeitMatchOver(playerId, team);

    public event Events.EventVoteForMvp OnEventVoteForMvp = (_param1, _param2) => { };

    public void FireEventVoteForMvp(ulong playerId, ulong votedForPlayerId) => this.OnEventVoteForMvp(playerId, votedForPlayerId);

    public event Events.EventVoteForRematch OnEventVoteForRematch = (_param1, _param2) => { };

    public void FireEventVoteForRematch(ulong playerId, bool wantsRematch) => this.OnEventVoteForRematch(playerId, wantsRematch);

    public event Events.EventGameStatMatchFinished OnEventGameStatMatchFinished = _param1 => { };

    public void FireEventGameStatMatchFinished(GameStatMatchFinishedEvent @event) => this.OnEventGameStatMatchFinished(@event);

    public event Events.EventAverageFpsReport OnEventAverageFpsReport = (_param1, _param2, _param3) => { };

    public void FireEventAverageFpsReport(ulong playerId, float averageFps, string deviceName) => this.OnEventAverageFpsReport(playerId, averageFps, deviceName);

    public event Events.EventBallCollision OnEventBallCollision = (_param1, _param2, _param3) => { };

    public void FireEventBallCollision(UniqueId collideeUniqueId, JVector position, JVector normal) => this.OnEventBallCollision(collideeUniqueId, position, normal);

    public event Events.EventGameLog OnEventGameLog = _param1 => { };

    public void FireEventGameLog(GameLogEvent @event) => this.OnEventGameLog(@event);

    public event Events.EventDebug OnEventDebug = (_param1, _param2) => { };

    public void FireEventDebug(ulong playerId, DebugEventType type) => this.OnEventDebug(playerId, type);

    public event Events.EventSpawnProjectile OnEventSpawnProjectile = (_param1, _param2, _param3, _param4, _param5, _param6, _param7, _param8, _param9) => { };

    public void FireEventSpawnProjectile(
      ushort uniqueId,
      ulong owner,
      ProjectileType projectileType,
      float radius,
      float height,
      JVector position,
      JVector velocity,
      JQuaternion orientation,
      ProjectileImpactEffect projectileImpactEffect)
    {
      this.OnEventSpawnProjectile(uniqueId, owner, projectileType, radius, height, position, velocity, orientation, projectileImpactEffect);
    }

    public event Events.EventPlayerDeath OnEventPlayerDeath = (_param1, _param2, _param3) => { };

    public void FireEventPlayerDeath(
      ulong playerId,
      ulong instigatorPlayerId,
      float respawnDuration)
    {
      this.OnEventPlayerDeath(playerId, instigatorPlayerId, respawnDuration);
    }

    public event Events.EventSpawnSpraytag OnEventSpawnSpraytag = (_param1, _param2, _param3) => { };

    public void FireEventSpawnSpraytag(ulong playerId, JVector position, int spraytagSlot) => this.OnEventSpawnSpraytag(playerId, position, spraytagSlot);

    public event Events.EventMatchAborted OnEventMatchAborted = (_param1, _param2) => { };

    public void FireEventMatchAborted(float matchDuration, float matchTimeElapsed) => this.OnEventMatchAborted(matchDuration, matchTimeElapsed);

    public event Events.EventPlayerChampionDataChanged OnEventPlayerChampionDataChanged = (_param1, _param2) => { };

    public void FireEventPlayerChampionDataChanged(
      ulong playerId,
      PlayerChampionData playerChampionData)
    {
      this.OnEventPlayerChampionDataChanged(playerId, playerChampionData);
    }

    public event Events.EventAllPlayersAreReady OnEventAllPlayersAreReady = (ref Dictionary<ulong, PlayerChampionData> _param1, string _param2) => { };

    public void FireEventAllPlayersAreReady(
      ref Dictionary<ulong, PlayerChampionData> preMatchData,
      string arenaName)
    {
      this.OnEventAllPlayersAreReady(ref preMatchData, arenaName);
    }

    public event Events.EventConnectionNotOk OnEventConnectionNotOk = (_param1, _param2) => { };

    public void FireEventConnectionNotOk(string message, string info) => this.OnEventConnectionNotOk(message, info);

    public event Events.EventBumperBallCollision OnEventBumperBallCollision = (_param1, _param2, _param3) => { };

    public void FireEventBumperBallCollision(UniqueId id, JVector position, JVector normal) => this.OnEventBumperBallCollision(id, position, normal);

    public event Events.EventBallTerrainCollision OnEventBallTerrainCollision = (_param1, _param2, _param3) => { };

    public void FireEventBallTerrainCollision(UniqueId id, JVector position, JVector normal) => this.OnEventBallTerrainCollision(id, position, normal);

    public event Events.EventBumperCollisionEnable OnEventBumperCollisionEnable = (ref UniqueId[] _param1) => { };

    public void FireEventBumperCollisionEnable(ref UniqueId[] bumperIds) => this.OnEventBumperCollisionEnable(ref bumperIds);

    public event Events.EventBumperCollisionDisable OnEventBumperCollisionDisable = (ref UniqueId[] _param1) => { };

    public void FireEventBumperCollisionDisable(ref UniqueId[] bumperIds) => this.OnEventBumperCollisionDisable(ref bumperIds);

    public event Events.EventMatchStarted OnEventMatchStarted = _param1 => { };

    public void FireEventMatchStarted(float durationInSeconds) => this.OnEventMatchStarted(durationInSeconds);

    public event Events.EventPickupWillSpawn OnEventPickupWillSpawn = (_param1, _param2, _param3) => { };

    public void FireEventPickupWillSpawn(UniqueId id, PickupType pickupType, float duration) => this.OnEventPickupWillSpawn(id, pickupType, duration);

    public event Events.EventSpawnPickup OnEventSpawnPickup = (_param1, _param2, _param3) => { };

    public void FireEventSpawnPickup(UniqueId id, PickupType type, JVector position) => this.OnEventSpawnPickup(id, type, position);

    public event Events.EventPlayerRespawn OnEventPlayerRespawn = (_param1, _param2, _param3) => { };

    public void FireEventPlayerRespawn(ulong clientId, JVector position, JQuaternion orientation) => this.OnEventPlayerRespawn(clientId, position, orientation);

    public event Events.EventNewScore OnEventNewScore = (Team _param1, ref Dictionary<Team, int> _param2, ulong _param3, bool _param4) => { };

    public void FireEventNewScore(
      Team lastTeamThatScored,
      ref Dictionary<Team, int> score,
      ulong playerScored,
      bool isReset = false)
    {
      this.OnEventNewScore(lastTeamThatScored, ref score, playerScored, isReset);
    }

    public event Events.EventPlayerStatusChanged OnEventPlayerStatusChanged = (ulong _param1, ref StatusEffectComponent _param2) => { };

    public void FireEventPlayerStatusChanged(
      ulong playerId,
      ref StatusEffectComponent statusComponent)
    {
      this.OnEventPlayerStatusChanged(playerId, ref statusComponent);
    }

    public event Events.EventDestroyEntity OnEventDestroyEntity = _param1 => { };

    public void FireEventDestroyEntity(ushort uniqueId) => this.OnEventDestroyEntity(uniqueId);

    public event Events.EventSpawnPointLinked OnEventSpawnPointLinked = (_param1, _param2, _param3, _param4) => { };

    public void FireEventSpawnPointLinked(
      int matchType,
      ulong playerId,
      Team team,
      UniqueId uniqueId)
    {
      this.OnEventSpawnPointLinked(matchType, playerId, team, uniqueId);
    }

    public event Events.EventArenaLoadingProgress OnEventArenaLoadingProgress = (_param1, _param2) => { };

    public void FireEventArenaLoadingProgress(string currentTask, float progress = 0.0f) => this.OnEventArenaLoadingProgress(currentTask, progress);

    public event Events.EventArenaUnloaded OnEventArenaUnloaded = _param1 => { };

    public void FireEventArenaUnloaded(string arenaName) => this.OnEventArenaUnloaded(arenaName);

    public event Events.EventMemoryOverLimit OnEventMemoryOverLimit = (_param1, _param2) => { };

    public void FireEventMemoryOverLimit(long usedMemory, long limit) => this.OnEventMemoryOverLimit(usedMemory, limit);

    public event Events.EventConnectionOk OnEventConnectionOk = () => { };

    public void FireEventConnectionOk() => this.OnEventConnectionOk();

    public event Events.EventProxyTransform OnEventProxyTransform = (_param1, _param2, _param3, _param4, _param5) => { };

    public void FireEventProxyTransform(
      int tick,
      UniqueId id,
      JVector position,
      JQuaternion rotation,
      bool show)
    {
      this.OnEventProxyTransform(tick, id, position, rotation, show);
    }

    public event Events.EventTrackingEvent OnEventTrackingEvent = _param1 => { };

    public void FireEventTrackingEvent(TrackingEvent trackingEvent) => this.OnEventTrackingEvent(trackingEvent);

    public event Events.NetEventGameMessage OnNetEventGameMessage = _param1 => { };

    public void FireNetEventGameMessage(GameMessage message) => this.OnNetEventGameMessage(message);

    public event Events.EventNetworkEvent<UsernameMessage> OnNetEventUsernameMessage = _param1 => { };

    public void FireNetEventUsernameMessage(NetworkEvent<UsernameMessage> usernameMessageEvent) => this.OnNetEventUsernameMessage(usernameMessageEvent);

    public event Events.NetEventNotifyDisconnectReason OnNetEventNotifyDisconnectReason = _param1 => { };

    public void FireNetEventNotifyDisconnectReason(DisconnectReason reason) => this.OnNetEventNotifyDisconnectReason(reason);

    public event Events.NetEventMatchStateChanged OnNetEventMatchStateMessage = (_param1, _param2, _param3) => { };

    public void FireNetEventMatchStateMessage(
      MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.OnNetEventMatchStateMessage(matchState, cutsceneDuration, remainingMatchTime);
    }

    public event Events.NetEventCreatePlayerMessage OnNetEventCreatePlayerMessage = (_param1, _param2, _param3, _param4) => { };

    public void FireNetEventCreatePlayerMessage(
      ulong playerId,
      PlayerChampionData playerChampionData,
      JVector position,
      JQuaternion rotation)
    {
      this.OnNetEventCreatePlayerMessage(playerId, playerChampionData, position, rotation);
    }

    public event Events.NetEventDisconnectMessage OnNetEventDisconnectMessage = (_param1, _param2) => { };

    public void FireNetEventDisconnectMessage(ulong id, byte index) => this.OnNetEventDisconnectMessage(id, index);

    public event Events.NetEventGenericMessage OnNetEventGenericMessage = _param1 => { };

    public void FireNetEventGenericMessage(GenericMessage message) => this.OnNetEventGenericMessage(message);

    public event Events.NetEventMetaStateChanged OnNetEventMetaStateChangedMessage = _param1 => { };

    public void FireNetEventMetaStateChangedMessage(MetaState state) => this.OnNetEventMetaStateChangedMessage(state);

    public event Events.NetEventMatchStartedMessage OnNetEventMatchStartedMessage = _param1 => { };

    public void FireNetEventMatchStartedMessage(float durationInSeconds) => this.OnNetEventMatchStartedMessage(durationInSeconds);

    public event Events.NetEventGameIsReadyMessage OnNetEventGameIsReadyMessage = () => { };

    public void FireNetEventGameIsReadyMessage() => this.OnNetEventGameIsReadyMessage();

    public event Events.NetEventBallCollisionMessage OnNetEventBallCollisionMessage = (_param1, _param2, _param3) => { };

    public void FireNetEventBallCollisionMessage(
      UniqueId collideeUniqueId,
      JVector position,
      JVector normal)
    {
      this.OnNetEventBallCollisionMessage(collideeUniqueId, position, normal);
    }

    public event Events.NetEventSpawnPointLinkedMessage OnNetEventSpawnPointLinkedMessage = (_param1, _param2, _param3, _param4) => { };

    public void FireNetEventSpawnPointLinkedMessage(
      int matchType,
      ulong playerId,
      Team team,
      UniqueId uniqueId)
    {
      this.OnNetEventSpawnPointLinkedMessage(matchType, playerId, team, uniqueId);
    }

    public event Events.EventNetworkEvent<PreMatchChangedMessage> OnNetEventPreMatchChangedMessage = _param1 => { };

    public void FireNetEventPreMatchChangedMessage(NetworkEvent<PreMatchChangedMessage> @event) => this.OnNetEventPreMatchChangedMessage(@event);

    public event Events.NetEventPlayerRespawnMessage OnNetEventPlayerRespawnMessage = (_param1, _param2) => { };

    public void FireNetEventPlayerRespawnMessage(JVector position, JQuaternion orientation) => this.OnNetEventPlayerRespawnMessage(position, orientation);

    public event Events.NetEventDestroyEntityMessage OnNetEventDestroyEntityMessage = _param1 => { };

    public void FireNetEventDestroyEntityMessage(ushort uniqueId) => this.OnNetEventDestroyEntityMessage(uniqueId);

    public event Events.NetEventSpawnSpraytagMessage OnNetEventSpawnSpraytagMessage = (_param1, _param2, _param3, _param4) => { };

    public void FireNetEventSpawnSpraytagMessage(ulong playerId, float x, float z, int spraySlot) => this.OnNetEventSpawnSpraytagMessage(playerId, x, z, spraySlot);

    public event Events.NetEventVelocityMessage OnNetEventVelocityMessage = (_param1, _param2, _param3, _param4) => { };

    public void FireNetEventVelocityMessage(UniqueId id, float x, float y, float z) => this.OnNetEventVelocityMessage(id, x, y, z);

    public event Events.EventNetworkEvent<LoadArenaMessage> OnNetEventLoadArenaMessage = _param1 => { };

    public void FireNetEventLoadArenaMessage(NetworkEvent<LoadArenaMessage> @event) => this.OnNetEventLoadArenaMessage(@event);

    public event Events.NetEventPickupConsumedMessage OnNetEventPickupConsumedMessage = (_param1, _param2) => { };

    public void FireNetEventPickupConsumedMessage(UniqueId id, UniqueId playerUniqueId) => this.OnNetEventPickupConsumedMessage(id, playerUniqueId);

    public event Events.NetEventPickupWillSpawnMessage OnNetEventPickupWillSpawnMessage = (_param1, _param2, _param3) => { };

    public void FireNetEventPickupWillSpawnMessage(
      UniqueId id,
      PickupType pickupType,
      float duration)
    {
      this.OnNetEventPickupWillSpawnMessage(id, pickupType, duration);
    }

    public event Events.NetEventSpawnPickupMessage OnNetEventSpawnPickupMessage = (_param1, _param2, _param3, _param4, _param5) => { };

    public void FireNetEventSpawnPickupMessage(
      UniqueId id,
      PickupType pickupType,
      float x,
      float y,
      float z)
    {
      this.OnNetEventSpawnPickupMessage(id, pickupType, x, y, z);
    }

    public event Events.NetEventResetPickupMessage OnNetEventResetPickupMessage = _param1 => { };

    public void FireNetEventSpawnPickupMessage(UniqueId id) => this.OnNetEventResetPickupMessage(id);

    public event Events.EventNetworkEvent<ScoreMessage> OnNetEventScoreMessage = _param1 => { };

    public void FireNetEventScoreMessage(NetworkEvent<ScoreMessage> @event) => this.OnNetEventScoreMessage(@event);

    public event Events.EventNetworkEvent<GameStatMatchFinishedMessage> OnNetEventGameStatMatchFinishedMessage = _param1 => { };

    public void FireNetEventGameStatMatchFinishedMessage(
      NetworkEvent<GameStatMatchFinishedMessage> @event)
    {
      this.OnNetEventGameStatMatchFinishedMessage(@event);
    }

    public event Events.NetEventPlayerHealthChangedMessage OnNetEventPlayerHealthChangedMessage = (_param1, _param2, _param3, _param4, _param5) => { };

    public void FireNetEventPlayerHealthChangedMessage(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead)
    {
      this.OnNetEventPlayerHealthChangedMessage(playerId, oldHealth, currentHealth, maxHealth, isDead);
    }

    public event Events.EventNetworkEvent<SimpleDebugMessage> OnNetEventSimpleDebugMessage = _param1 => { };

    public void FireNetEventSimpleDebugMessage(NetworkEvent<SimpleDebugMessage> @event) => this.OnNetEventSimpleDebugMessage(@event);

    public event Events.EventNetworkEvent<AverageFpsMessage> OnNetEventAverageFpsMessage = _param1 => { };

    public void FireNetEventAverageFpsMessage(NetworkEvent<AverageFpsMessage> @event) => this.OnNetEventAverageFpsMessage(@event);

    public event Events.NetEventPlayerDeathMessage OnNetEventPlayerDeathMessage = (_param1, _param2, _param3) => { };

    public void FireNetEventPlayerDeathMessage(
      ulong playerId,
      ulong instigatorPlayerId,
      float respawnDuration)
    {
      this.OnNetEventPlayerDeathMessage(playerId, instigatorPlayerId, respawnDuration);
    }

    public event Events.EventNetworkEvent<TeamChatInfoMessage> OnNetEventTeamChatInfoMessage = _param1 => { };

    public void FireNetEventTeamChatInfoMessage(NetworkEvent<TeamChatInfoMessage> @event) => this.OnNetEventTeamChatInfoMessage(@event);

    public event Events.EventNetworkEvent<UpdateSkillConfigMessage> OnNetEventUpdateSkillConfigMessage = _param1 => { };

    public void FireNetEventUpdateSkillConfigMessage(NetworkEvent<UpdateSkillConfigMessage> @event) => this.OnNetEventUpdateSkillConfigMessage(@event);

    public event Events.NetEventTrackingEventMessage OnNetEventTrackingEventMessage = (_param1, _param2, _param3) => { };

    public void FireNetEventTrackingEventMessage(ulong playerId, Statistics type, float value) => this.OnNetEventTrackingEventMessage(playerId, type, value);

    public event Events.NetEventTransitionPlayerToLobbyMessage OnNetEventTransitionPlayerToLobbyMessage = _param1 => { };

    public void FireNetEventTransitionPlayerToLobbyMessage(ulong playerId) => this.OnNetEventTransitionPlayerToLobbyMessage(playerId);

    public event Events.NetEventQuickChatMessage OnNetEventQuickChatMessage = (_param1, _param2) => { };

    public void FireNetEventQuickChatMessage(ulong playerId, int msgType) => this.OnNetEventQuickChatMessage(playerId, msgType);

    public event Events.EventNetworkEvent<LobbyPickOrderMessage> OnNetEventLobbyPickOrderMessage = _param1 => { };

    public void FireNetEventLobbyPickOrderMessage(NetworkEvent<LobbyPickOrderMessage> @event) => this.OnNetEventLobbyPickOrderMessage(@event);

    public event Events.EventNetworkEvent<LobbyPickTimesMessage> OnNetEventLobbyPickTimesMessage = _param1 => { };

    public void FireNetEventLobbyPickTimesMessage(NetworkEvent<LobbyPickTimesMessage> @event) => this.OnNetEventLobbyPickTimesMessage(@event);

    public event Events.EventNetworkEvent<BumperCollisionEnableMessage> OnNetEventBumperCollisionEnableMessage = _param1 => { };

    public void FireNetEventBumperCollisionEnableMessage(
      NetworkEvent<BumperCollisionEnableMessage> @event)
    {
      this.OnNetEventBumperCollisionEnableMessage(@event);
    }

    public event Events.EventNetworkEvent<BumperCollisionDisableMessage> OnNetEventBumperCollisionDisableMessage = _param1 => { };

    public void FireNetEventBumperCollisionDisableMessage(
      NetworkEvent<BumperCollisionDisableMessage> @event)
    {
      this.OnNetEventBumperCollisionDisableMessage(@event);
    }

    public event Events.NetEventPlayerFinishedPickingMessage OnNetEventPlayerFinishedPickingMessage = (_param1, _param2) => { };

    public void FireNetEventPlayerFinishedPickingMessage(ulong playerId, ChampionType type) => this.OnNetEventPlayerFinishedPickingMessage(playerId, type);

    public event Events.EventNetworkEvent<MatchInfoMessage> OnNetEventMatchInfoMessage = _param1 => { };

    public void FireNetEventMatchInfoMessage(NetworkEvent<MatchInfoMessage> @event) => this.OnNetEventMatchInfoMessage(@event);

    public event Events.NetEventPlayerForfeitMatchMessage OnNetEventPlayerForfeitMatchMessage = (_param1, _param2) => { };

    public void FireNetEventPlayerForfeitMatchMessage(ulong playerId, bool forfeit) => this.OnNetEventPlayerForfeitMatchMessage(playerId, forfeit);

    public event Events.NetEventForfeitMatchOverMessage OnNetEventForfeitMatchOverMessage = (_param1, _param2) => { };

    public void FireNetEventForfeitMatchOverMessage(ulong playerId, Team team) => this.OnNetEventForfeitMatchOverMessage(playerId, team);

    public event Events.EventNetworkEvent<PlayersVoteUpdateMessage> OnNetEventPlayersVoteUpdateMessage = _param1 => { };

    public void FireNetEventPlayersVoteUpdateMessage(NetworkEvent<PlayersVoteUpdateMessage> @event) => this.OnNetEventPlayersVoteUpdateMessage(@event);

    public delegate void EventCameraShake(Transform referenceTransform, float strength = 1f);

    public delegate void EventQualitySettingsChanged(QualityManager.RenderSettings newRenderSettings);

    public delegate void EventInputCollected(InputController.InputCollectedEvent input);

    public delegate void EventCutscene(CutsceneEventType type, string affectedObject);

    public delegate void EventPlayerLeft(string username, Color usernameColor);

    public delegate void EventLobbyPickOrder(UniqueId[] alphaPickOrder, UniqueId[] betaPickOrder);

    public delegate void EventLobbyPickTimes(
      ref int[,] alphaPlayerPickTimes,
      ref int[,] betaPlayerPickTimes);

    public delegate void EventMetaStateChanged(in MetaState metaState);

    public delegate void EventMatchStateChanged(
      MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime);

    public delegate void EventDisconnect(ulong id, byte index);

    public delegate void EventSelectTeam(Team team);

    public delegate void EventSelectChampion(ChampionType type, int skinId, bool isReady);

    public delegate void EventChampionSelectionReady();

    public delegate void EventCutsceneCleanup(MatchState matchState);

    public delegate void EventMatchInfo(string arena, string matchId, GameType gameType);

    public delegate void EventPlayerFinishedPicking(ulong playerId, ChampionType type);

    public delegate void EventShowHidePlayerUi(ulong playerId, bool showFloorUi, bool showOverhead);

    public delegate void EventPickupConsumed(UniqueId id, UniqueId playerUniqueId);

    public delegate void EventPickupReset(UniqueId id);

    public delegate void EventDisableLeaveButton();

    public delegate void EventPlayerHealthChanged(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead);

    public delegate void EventMatchStartCountdown(float countdown, LobbyState lobbyState);

    public delegate void EventQuickChat(ulong playerId, int msgType);

    public delegate void EventPlayersVoteUpdate(Dictionary<ulong, int> playerVotes);

    public delegate void EventPlayerForfeitMatch(ulong playerId, bool forfeit);

    public delegate void EventForfeitMatchOver(ulong playerId, Team team);

    public delegate void EventVoteForMvp(ulong playerId, ulong votedForPlayerId);

    public delegate void EventVoteForRematch(ulong playerId, bool wantsRematch);

    public delegate void EventGameStatMatchFinished(GameStatMatchFinishedEvent @event);

    public delegate void EventAverageFpsReport(ulong playerId, float averageFps, string deviceName);

    public delegate void EventBallCollision(
      UniqueId collideeUniqueId,
      JVector position,
      JVector normal);

    public delegate void EventGameLog(GameLogEvent @event);

    public delegate void EventDebug(ulong playerId, DebugEventType type);

    public delegate void EventSpawnProjectile(
      ushort uniqueId,
      ulong owner,
      ProjectileType projectileType,
      float radius,
      float height,
      JVector position,
      JVector velocity,
      JQuaternion orientation,
      ProjectileImpactEffect projectileImpactEffect);

    public delegate void EventPlayerDeath(
      ulong playerId,
      ulong instigatorPlayerId,
      float respawnDuration);

    public delegate void EventSpawnSpraytag(ulong playerId, JVector position, int spraytagSlot);

    public delegate void EventMatchAborted(float matchDuration, float matchTimeElapsed);

    public delegate void EventPlayerChampionDataChanged(
      ulong playerId,
      PlayerChampionData playerChampionData);

    public delegate void EventAllPlayersAreReady(
      ref Dictionary<ulong, PlayerChampionData> preMatchData,
      string arenaName);

    public delegate void EventConnectionNotOk(string message, string info);

    public delegate void EventBumperBallCollision(UniqueId id, JVector position, JVector normal);

    public delegate void EventBallTerrainCollision(UniqueId id, JVector position, JVector normal);

    public delegate void EventBumperCollisionEnable(ref UniqueId[] bumperIds);

    public delegate void EventBumperCollisionDisable(ref UniqueId[] bumperIds);

    public delegate void EventMatchStarted(float durationInSeconds);

    public delegate void EventPickupWillSpawn(UniqueId id, PickupType pickupType, float duration);

    public delegate void EventSpawnPickup(UniqueId id, PickupType type, JVector position);

    public delegate void EventPlayerRespawn(
      ulong clientId,
      JVector position,
      JQuaternion orientation);

    public delegate void EventNewScore(
      Team lastTeamThatScored,
      ref Dictionary<Team, int> score,
      ulong playerScored,
      bool isReset = false);

    public delegate void EventPlayerStatusChanged(
      ulong playerId,
      ref StatusEffectComponent statusComponent);

    public delegate void EventDestroyEntity(ushort uniqueId);

    public delegate void EventSpawnPointLinked(
      int matchType,
      ulong playerId,
      Team team,
      UniqueId uniqueId);

    public delegate void EventArenaLoadingProgress(string currentTask, float progress = 0.0f);

    public delegate void EventArenaUnloaded(string arenaName);

    public delegate void EventMemoryOverLimit(long usedMemory, long limit);

    public delegate void EventConnectionOk();

    public delegate void EventProxyTransform(
      int tick,
      UniqueId id,
      JVector position,
      JQuaternion rotation,
      bool show);

    public delegate void EventTrackingEvent(TrackingEvent trackingEvent);

    public delegate void EventNetworkEvent<T>(NetworkEvent<T> networkEvent) where T : Message;

    public delegate void NetEventGameMessage(GameMessage message);

    public delegate void NetEventNotifyDisconnectReason(DisconnectReason reason);

    public delegate void NetEventMatchStateChanged(
      MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime);

    public delegate void NetEventCreatePlayerMessage(
      ulong playerId,
      PlayerChampionData playerChampionData,
      JVector position,
      JQuaternion rotation);

    public delegate void NetEventDisconnectMessage(ulong id, byte index);

    public delegate void NetEventGenericMessage(GenericMessage message);

    public delegate void NetEventMetaStateChanged(MetaState state);

    public delegate void NetEventMatchStartedMessage(float durationInSeconds);

    public delegate void NetEventGameIsReadyMessage();

    public delegate void NetEventBallCollisionMessage(
      UniqueId collideeUniqueId,
      JVector position,
      JVector normal);

    public delegate void NetEventSpawnPointLinkedMessage(
      int matchType,
      ulong playerId,
      Team team,
      UniqueId uniqueId);

    public delegate void NetEventPlayerRespawnMessage(JVector position, JQuaternion orientation);

    public delegate void NetEventDestroyEntityMessage(ushort uniqueId);

    public delegate void NetEventSpawnSpraytagMessage(
      ulong playerId,
      float x,
      float z,
      int spraySlot);

    public delegate void NetEventVelocityMessage(UniqueId id, float x, float y, float z);

    public delegate void NetEventPickupConsumedMessage(UniqueId id, UniqueId playerUniqueId);

    public delegate void NetEventPickupWillSpawnMessage(
      UniqueId id,
      PickupType pickupType,
      float duration);

    public delegate void NetEventSpawnPickupMessage(
      UniqueId id,
      PickupType pickupType,
      float x,
      float y,
      float z);

    public delegate void NetEventResetPickupMessage(UniqueId id);

    public delegate void NetEventPlayerHealthChangedMessage(
      ulong playerId,
      int oldHealth,
      int currentHealth,
      int maxHealth,
      bool isDead);

    public delegate void NetEventPlayerDeathMessage(
      ulong playerId,
      ulong instigatorPlayerId,
      float respawnDuration);

    public delegate void NetEventTrackingEventMessage(ulong playerId, Statistics type, float value);

    public delegate void NetEventTransitionPlayerToLobbyMessage(ulong playerId);

    public delegate void NetEventQuickChatMessage(ulong playerId, int msgType);

    public delegate void NetEventPlayerFinishedPickingMessage(ulong playerId, ChampionType type);

    public delegate void NetEventPlayerForfeitMatchMessage(ulong playerId, bool forfeit);

    public delegate void NetEventForfeitMatchOverMessage(ulong playerId, Team team);
  }
}
