// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.SteelClientAdapter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Networking.Messages;
using Imi.ScEntitas;
using Imi.ScEvents;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using System;
using System.Collections.Generic;
using unittests.server.SharedWithServer.Networking.Messages;

namespace Imi.SteelCircus.Networking
{
  public class SteelClientAdapter
  {
    private readonly Dictionary<RumpfieldMessageType, Type> typeToMessage;
    private readonly Dictionary<RumpfieldMessageType, Type> typeToEvent;
    private readonly Pool<GameMessage> gameMessagePool = new Pool<GameMessage>(10);
    private readonly HashSet<RumpfieldMessageType> pooledSet = new HashSet<RumpfieldMessageType>();
    private readonly MessageFactory messageFactory = new MessageFactory();
    private const string AssertText = "RumpfieldMessageType not contained in Type Mapping.";

    public SteelClientAdapter()
    {
      this.typeToMessage = new Dictionary<RumpfieldMessageType, Type>(30);
      this.typeToEvent = new Dictionary<RumpfieldMessageType, Type>(30);
      this.RegisterMessageAdapter<MatchStateMessage>();
      this.RegisterMessageAdapter<MetaStateChangedMessage>();
      this.RegisterMessageAdapter<NotifyDisconnectReason>();
      this.RegisterMessageAdapter<ScoreMessage>();
      this.RegisterMessageAdapter<GenericMessage>();
      this.RegisterMessageAdapter<MatchStartedMessage>();
      this.RegisterMessageAdapter<GameIsReadyMessage>();
      this.RegisterMessageAdapter<UsernameMessage>();
      this.RegisterMessageAdapter<DisconnectMessage>();
      this.RegisterMessageAdapter<BallCollisionMessage>();
      this.RegisterMessageAdapter<PlayerHealthChangedMessage>();
      this.RegisterMessageAdapter<SpawnPointLinkedMessage>();
      this.RegisterMessageAdapter<PreMatchChangedMessage>();
      this.RegisterMessageAdapter<PlayerRespawnMessage>();
      this.RegisterMessageAdapter<GameMessage>();
      this.RegisterMessageAdapter<DestroyEntityMessage>();
      this.RegisterMessageAdapter<SpawnSpraytagMessage>();
      this.RegisterMessageAdapter<GameStatMatchFinishedMessage>();
      this.RegisterMessageAdapter<PlayerDeathMessage>();
      this.RegisterMessageAdapter<PickupConsumedMessage>();
      this.RegisterMessageAdapter<PickupResetMessage>();
      this.RegisterMessageAdapter<PickupWillSpawnMessage>();
      this.RegisterMessageAdapter<SpawnPickupMessage>();
      this.RegisterMessageAdapter<VelocityMessage>();
      this.RegisterMessageAdapter<LoadArenaMessage>();
      this.RegisterMessageAdapter<SimpleDebugMessage>();
      this.RegisterMessageAdapter<TeamChatInfoMessage>();
      this.RegisterMessageAdapter<TrackingEventMessage>();
      this.RegisterMessageAdapter<TransitionPlayerToLobbyMessage>();
      this.RegisterMessageAdapter<QuickChatMessage>();
      this.RegisterMessageAdapter<LobbyPickOrderMessage>();
      this.RegisterMessageAdapter<LobbyPickTimesMessage>();
      this.RegisterMessageAdapter<BumperCollisionEnableMessage>();
      this.RegisterMessageAdapter<BumperCollisionDisableMessage>();
      this.RegisterMessageAdapter<PlayerFinishedPickingMessage>();
      this.RegisterMessageAdapter<MatchInfoMessage>();
      this.RegisterMessageAdapter<CreatePlayerMessage>();
      this.RegisterMessageAdapter<PlayerForfeitMatchMessage>();
      this.RegisterMessageAdapter<ForfeitMatchOverMessage>();
      this.RegisterMessageAdapter<PlayersVoteUpdateMessage>();
      this.RegisterMessageAdapter<VoteForMvpMessage>();
      this.RegisterMessageAdapter<VoteForRematchMessage>();
    }

    public Message CreateMessage(RumpfieldMessageType type)
    {
      switch (type)
      {
        case RumpfieldMessageType.Generic:
          return !this.pooledSet.Contains(type) ? (Message) new GenericMessage() : (Message) this.messageFactory.Get<GenericMessage>(type);
        case RumpfieldMessageType.GameState:
          return !this.pooledSet.Contains(type) ? (Message) new MatchStateMessage() : (Message) this.messageFactory.Get<MatchStateMessage>(type);
        case RumpfieldMessageType.Score:
          return !this.pooledSet.Contains(type) ? (Message) new ScoreMessage() : (Message) this.messageFactory.Get<ScoreMessage>(type);
        case RumpfieldMessageType.MatchStarted:
          return !this.pooledSet.Contains(type) ? (Message) new MatchStartedMessage() : (Message) this.messageFactory.Get<MatchStartedMessage>(type);
        case RumpfieldMessageType.PickupConsumed:
          return !this.pooledSet.Contains(type) ? (Message) new PickupConsumedMessage() : (Message) this.messageFactory.Get<PickupConsumedMessage>(type);
        case RumpfieldMessageType.PickupWillSpawn:
          return !this.pooledSet.Contains(type) ? (Message) new PickupWillSpawnMessage() : (Message) this.messageFactory.Get<PickupWillSpawnMessage>(type);
        case RumpfieldMessageType.PickupSpawned:
          return !this.pooledSet.Contains(type) ? (Message) new SpawnPickupMessage() : (Message) this.messageFactory.Get<SpawnPickupMessage>(type);
        case RumpfieldMessageType.ResetPickup:
          return !this.pooledSet.Contains(type) ? (Message) new PickupResetMessage() : (Message) this.messageFactory.Get<PickupResetMessage>(type);
        case RumpfieldMessageType.Username:
          return !this.pooledSet.Contains(type) ? (Message) new UsernameMessage() : (Message) this.messageFactory.Get<UsernameMessage>(type);
        case RumpfieldMessageType.Disconnect:
          return !this.pooledSet.Contains(type) ? (Message) new DisconnectMessage() : (Message) this.messageFactory.Get<DisconnectMessage>(RumpfieldMessageType.Disconnect);
        case RumpfieldMessageType.Velocity:
          return !this.pooledSet.Contains(type) ? (Message) new VelocityMessage() : (Message) this.messageFactory.Get<VelocityMessage>(type);
        case RumpfieldMessageType.BallCollision:
          return !this.pooledSet.Contains(type) ? (Message) new BallCollisionMessage() : (Message) this.messageFactory.Get<BallCollisionMessage>(type);
        case RumpfieldMessageType.PlayerHealthChanged:
          return !this.pooledSet.Contains(type) ? (Message) new PlayerHealthChangedMessage() : (Message) this.messageFactory.Get<PlayerHealthChangedMessage>(type);
        case RumpfieldMessageType.PlayerDeath:
          return !this.pooledSet.Contains(type) ? (Message) new PlayerDeathMessage() : (Message) this.messageFactory.Get<PlayerDeathMessage>(type);
        case RumpfieldMessageType.SpawnPointLinked:
          return !this.pooledSet.Contains(type) ? (Message) new SpawnPointLinkedMessage() : (Message) this.messageFactory.Get<SpawnPointLinkedMessage>(type);
        case RumpfieldMessageType.PreMatchDataChanged:
          return !this.pooledSet.Contains(type) ? (Message) new PreMatchChangedMessage() : (Message) this.messageFactory.Get<PreMatchChangedMessage>(type);
        case RumpfieldMessageType.GameIsReady:
          return !this.pooledSet.Contains(type) ? (Message) new GameIsReadyMessage() : (Message) this.messageFactory.Get<GameIsReadyMessage>(type);
        case RumpfieldMessageType.PlayerRespawn:
          return !this.pooledSet.Contains(type) ? (Message) new PlayerRespawnMessage() : (Message) this.messageFactory.Get<PlayerRespawnMessage>(type);
        case RumpfieldMessageType.DestroyEntity:
          return !this.pooledSet.Contains(type) ? (Message) new DestroyEntityMessage() : (Message) this.messageFactory.Get<DestroyEntityMessage>(type);
        case RumpfieldMessageType.SpawnSpraytag:
          return !this.pooledSet.Contains(type) ? (Message) new SpawnSpraytagMessage() : (Message) this.messageFactory.Get<SpawnSpraytagMessage>(type);
        case RumpfieldMessageType.MatchStats:
          return !this.pooledSet.Contains(type) ? (Message) new GameStatMatchFinishedMessage() : (Message) this.messageFactory.Get<GameStatMatchFinishedMessage>(type);
        case RumpfieldMessageType.GameMessage:
          GameMessage gameMessage = this.gameMessagePool.Get();
          gameMessage.Clear();
          return (Message) gameMessage;
        case RumpfieldMessageType.LoadArena:
          return !this.pooledSet.Contains(type) ? (Message) new LoadArenaMessage() : (Message) this.messageFactory.Get<LoadArenaMessage>(type);
        case RumpfieldMessageType.VoteForMvp:
          return !this.pooledSet.Contains(type) ? (Message) new VoteForMvpMessage() : (Message) this.messageFactory.Get<VoteForMvpMessage>(RumpfieldMessageType.VoteForMvp);
        case RumpfieldMessageType.PlayersVoteUpdate:
          return !this.pooledSet.Contains(type) ? (Message) new PlayersVoteUpdateMessage() : (Message) this.messageFactory.Get<PlayersVoteUpdateMessage>(RumpfieldMessageType.PlayersVoteUpdate);
        case RumpfieldMessageType.SimpleDebug:
          return !this.pooledSet.Contains(type) ? (Message) new SimpleDebugMessage() : (Message) this.messageFactory.Get<SimpleDebugMessage>(type);
        case RumpfieldMessageType.AverageFps:
          return !this.pooledSet.Contains(type) ? (Message) new AverageFpsMessage() : (Message) this.messageFactory.Get<AverageFpsMessage>(type);
        case RumpfieldMessageType.UpdateSkillConfig:
          return !this.pooledSet.Contains(type) ? (Message) new UpdateSkillConfigMessage() : (Message) this.messageFactory.Get<UpdateSkillConfigMessage>(type);
        case RumpfieldMessageType.TeamChatInfo:
          return !this.pooledSet.Contains(type) ? (Message) new TeamChatInfoMessage() : (Message) this.messageFactory.Get<TeamChatInfoMessage>(type);
        case RumpfieldMessageType.MetaStateChanged:
          return !this.pooledSet.Contains(type) ? (Message) new MetaStateChangedMessage() : (Message) this.messageFactory.Get<MetaStateChangedMessage>(type);
        case RumpfieldMessageType.NotifyDisconnect:
          return !this.pooledSet.Contains(type) ? (Message) new NotifyDisconnectReason() : (Message) this.messageFactory.Get<NotifyDisconnectReason>(type);
        case RumpfieldMessageType.TrackingEvent:
          return !this.pooledSet.Contains(type) ? (Message) new TrackingEventMessage() : (Message) this.messageFactory.Get<TrackingEventMessage>(type);
        case RumpfieldMessageType.TransitionPlayerToLobby:
          return !this.pooledSet.Contains(type) ? (Message) new TransitionPlayerToLobbyMessage() : (Message) this.messageFactory.Get<TransitionPlayerToLobbyMessage>(type);
        case RumpfieldMessageType.QuickChatMessage:
          return !this.pooledSet.Contains(type) ? (Message) new QuickChatMessage() : (Message) this.messageFactory.Get<QuickChatMessage>(type);
        case RumpfieldMessageType.LobbyPickOrder:
          return !this.pooledSet.Contains(type) ? (Message) new LobbyPickOrderMessage() : (Message) this.messageFactory.Get<LobbyPickOrderMessage>(type);
        case RumpfieldMessageType.LobbyPickTimes:
          return !this.pooledSet.Contains(type) ? (Message) new LobbyPickTimesMessage() : (Message) this.messageFactory.Get<LobbyPickTimesMessage>(type);
        case RumpfieldMessageType.BumperCollisionEnable:
          return !this.pooledSet.Contains(type) ? (Message) new BumperCollisionEnableMessage() : (Message) this.messageFactory.Get<BumperCollisionEnableMessage>(type);
        case RumpfieldMessageType.BumperCollisionDisable:
          return !this.pooledSet.Contains(type) ? (Message) new BumperCollisionDisableMessage() : (Message) this.messageFactory.Get<BumperCollisionDisableMessage>(type);
        case RumpfieldMessageType.PlayerFinishedPicking:
          return !this.pooledSet.Contains(type) ? (Message) new PlayerFinishedPickingMessage() : (Message) this.messageFactory.Get<PlayerFinishedPickingMessage>(type);
        case RumpfieldMessageType.MatchInfo:
          return !this.pooledSet.Contains(type) ? (Message) new MatchInfoMessage() : (Message) this.messageFactory.Get<MatchInfoMessage>(type);
        case RumpfieldMessageType.CreatePlayerMessage:
          return !this.pooledSet.Contains(type) ? (Message) new CreatePlayerMessage() : (Message) this.messageFactory.Get<CreatePlayerMessage>(type);
        case RumpfieldMessageType.ForfeitMatch:
          return !this.pooledSet.Contains(type) ? (Message) new PlayerForfeitMatchMessage() : (Message) this.messageFactory.Get<PlayerForfeitMatchMessage>(type);
        case RumpfieldMessageType.ForfeitMatchOver:
          return !this.pooledSet.Contains(type) ? (Message) new ForfeitMatchOverMessage() : (Message) this.messageFactory.Get<ForfeitMatchOverMessage>(type);
        case RumpfieldMessageType.VoteForRematch:
          return !this.pooledSet.Contains(type) ? (Message) new VoteForRematchMessage() : (Message) this.messageFactory.Get<VoteForRematchMessage>(RumpfieldMessageType.VoteForRematch);
        default:
          throw new ArgumentOutOfRangeException(nameof (type), (object) type, (string) null);
      }
    }

    public void ReleaseGameMessage(GameMessage m) => this.gameMessagePool.Release(m);

    public void CreateEvent(Message msg)
    {
      RumpfieldMessageType messageType = msg.GetMessageType();
      switch (messageType)
      {
        case RumpfieldMessageType.Generic:
          Events.Global.FireNetEventGenericMessage((GenericMessage) msg);
          break;
        case RumpfieldMessageType.GameState:
          MatchStateMessage matchStateMessage = (MatchStateMessage) msg;
          Events.Global.FireNetEventMatchStateMessage(matchStateMessage.matchState, matchStateMessage.cutsceneDuration, matchStateMessage.remainingMatchTime);
          break;
        case RumpfieldMessageType.Score:
          Events.Global.FireNetEventScoreMessage(new NetworkEvent<ScoreMessage>((ScoreMessage) msg));
          break;
        case RumpfieldMessageType.MatchStarted:
          Events.Global.FireNetEventMatchStartedMessage(((MatchStartedMessage) msg).durationInSeconds);
          break;
        case RumpfieldMessageType.PickupConsumed:
          PickupConsumedMessage pickupConsumedMessage = (PickupConsumedMessage) msg;
          Events.Global.FireNetEventPickupConsumedMessage(pickupConsumedMessage.id, pickupConsumedMessage.playerUniqueId);
          break;
        case RumpfieldMessageType.PickupWillSpawn:
          PickupWillSpawnMessage willSpawnMessage = (PickupWillSpawnMessage) msg;
          Events.Global.FireNetEventPickupWillSpawnMessage(willSpawnMessage.id, willSpawnMessage.pickupType, willSpawnMessage.duration);
          break;
        case RumpfieldMessageType.PickupSpawned:
          SpawnPickupMessage spawnPickupMessage = (SpawnPickupMessage) msg;
          Events.Global.FireNetEventSpawnPickupMessage(spawnPickupMessage.id, (PickupType) spawnPickupMessage.pickupType, spawnPickupMessage.x, spawnPickupMessage.y, spawnPickupMessage.z);
          break;
        case RumpfieldMessageType.ResetPickup:
          Events.Global.FireNetEventSpawnPickupMessage(((PickupResetMessage) msg).id);
          break;
        case RumpfieldMessageType.Username:
          Events.Global.FireNetEventUsernameMessage(new NetworkEvent<UsernameMessage>((UsernameMessage) msg));
          break;
        case RumpfieldMessageType.Disconnect:
          DisconnectMessage disconnectMessage = (DisconnectMessage) msg;
          Events.Global.FireNetEventDisconnectMessage(disconnectMessage.id, disconnectMessage.index);
          break;
        case RumpfieldMessageType.Velocity:
          VelocityMessage velocityMessage = (VelocityMessage) msg;
          Events.Global.FireNetEventVelocityMessage(velocityMessage.id, velocityMessage.x, velocityMessage.y, velocityMessage.z);
          break;
        case RumpfieldMessageType.BallCollision:
          BallCollisionMessage collisionMessage = (BallCollisionMessage) msg;
          Events.Global.FireNetEventBallCollisionMessage(collisionMessage.collideeUniqueId, collisionMessage.position, collisionMessage.normal);
          break;
        case RumpfieldMessageType.PlayerHealthChanged:
          PlayerHealthChangedMessage healthChangedMessage = (PlayerHealthChangedMessage) msg;
          Events.Global.FireNetEventPlayerHealthChangedMessage(healthChangedMessage.playerId, healthChangedMessage.oldHealth, healthChangedMessage.currentHealth, healthChangedMessage.maxHealth, healthChangedMessage.isDead);
          break;
        case RumpfieldMessageType.PlayerDeath:
          PlayerDeathMessage playerDeathMessage = (PlayerDeathMessage) msg;
          Events.Global.FireNetEventPlayerDeathMessage(playerDeathMessage.playerId, playerDeathMessage.instigatorPlayerId, playerDeathMessage.respawnDuration);
          break;
        case RumpfieldMessageType.SpawnPointLinked:
          SpawnPointLinkedMessage pointLinkedMessage = (SpawnPointLinkedMessage) msg;
          Events.Global.FireNetEventSpawnPointLinkedMessage(pointLinkedMessage.matchType, pointLinkedMessage.playerId, pointLinkedMessage.team, pointLinkedMessage.uniqueId);
          break;
        case RumpfieldMessageType.PreMatchDataChanged:
          Events.Global.FireNetEventPreMatchChangedMessage(new NetworkEvent<PreMatchChangedMessage>((PreMatchChangedMessage) msg));
          break;
        case RumpfieldMessageType.GameIsReady:
          Events.Global.FireNetEventGameIsReadyMessage();
          break;
        case RumpfieldMessageType.PlayerRespawn:
          PlayerRespawnMessage playerRespawnMessage = (PlayerRespawnMessage) msg;
          Events.Global.FireNetEventPlayerRespawnMessage(playerRespawnMessage.position, playerRespawnMessage.orientation);
          break;
        case RumpfieldMessageType.DestroyEntity:
          Events.Global.FireNetEventDestroyEntityMessage(((DestroyEntityMessage) msg).uniqueId);
          break;
        case RumpfieldMessageType.SpawnSpraytag:
          SpawnSpraytagMessage spawnSpraytagMessage = (SpawnSpraytagMessage) msg;
          Events.Global.FireNetEventSpawnSpraytagMessage(spawnSpraytagMessage.playerID, spawnSpraytagMessage.x, spawnSpraytagMessage.z, spawnSpraytagMessage.spraytagSlot);
          break;
        case RumpfieldMessageType.MatchStats:
          Events.Global.FireNetEventGameStatMatchFinishedMessage(new NetworkEvent<GameStatMatchFinishedMessage>((GameStatMatchFinishedMessage) msg));
          break;
        case RumpfieldMessageType.GameMessage:
          Events.Global.FireNetEventGameMessage((GameMessage) msg);
          break;
        case RumpfieldMessageType.LoadArena:
          Events.Global.FireNetEventLoadArenaMessage(new NetworkEvent<LoadArenaMessage>((LoadArenaMessage) msg));
          break;
        case RumpfieldMessageType.PlayersVoteUpdate:
          Events.Global.FireNetEventPlayersVoteUpdateMessage(new NetworkEvent<PlayersVoteUpdateMessage>((PlayersVoteUpdateMessage) msg));
          break;
        case RumpfieldMessageType.SimpleDebug:
          Events.Global.FireNetEventSimpleDebugMessage(new NetworkEvent<SimpleDebugMessage>((SimpleDebugMessage) msg));
          break;
        case RumpfieldMessageType.AverageFps:
          Events.Global.FireNetEventAverageFpsMessage(new NetworkEvent<AverageFpsMessage>((AverageFpsMessage) msg));
          break;
        case RumpfieldMessageType.UpdateSkillConfig:
          Events.Global.FireNetEventUpdateSkillConfigMessage(new NetworkEvent<UpdateSkillConfigMessage>((UpdateSkillConfigMessage) msg));
          break;
        case RumpfieldMessageType.TeamChatInfo:
          Events.Global.FireNetEventTeamChatInfoMessage(new NetworkEvent<TeamChatInfoMessage>((TeamChatInfoMessage) msg));
          break;
        case RumpfieldMessageType.MetaStateChanged:
          Events.Global.FireNetEventMetaStateChangedMessage(((MetaStateChangedMessage) msg).state);
          break;
        case RumpfieldMessageType.NotifyDisconnect:
          Events.Global.FireNetEventNotifyDisconnectReason(((NotifyDisconnectReason) msg).reason);
          break;
        case RumpfieldMessageType.TrackingEvent:
          TrackingEventMessage trackingEventMessage = (TrackingEventMessage) msg;
          Events.Global.FireNetEventTrackingEventMessage(trackingEventMessage.playerId, trackingEventMessage.statistics, trackingEventMessage.value);
          break;
        case RumpfieldMessageType.TransitionPlayerToLobby:
          Events.Global.FireNetEventTransitionPlayerToLobbyMessage(((TransitionPlayerToLobbyMessage) msg).PlayerId);
          break;
        case RumpfieldMessageType.QuickChatMessage:
          QuickChatMessage quickChatMessage = (QuickChatMessage) msg;
          Events.Global.FireNetEventQuickChatMessage(quickChatMessage.PlayerId, quickChatMessage.MsgType);
          break;
        case RumpfieldMessageType.LobbyPickOrder:
          Events.Global.FireNetEventLobbyPickOrderMessage(new NetworkEvent<LobbyPickOrderMessage>((LobbyPickOrderMessage) msg));
          break;
        case RumpfieldMessageType.LobbyPickTimes:
          Events.Global.FireNetEventLobbyPickTimesMessage(new NetworkEvent<LobbyPickTimesMessage>((LobbyPickTimesMessage) msg));
          break;
        case RumpfieldMessageType.BumperCollisionEnable:
          Events.Global.FireNetEventBumperCollisionEnableMessage(new NetworkEvent<BumperCollisionEnableMessage>((BumperCollisionEnableMessage) msg));
          break;
        case RumpfieldMessageType.BumperCollisionDisable:
          Events.Global.FireNetEventBumperCollisionDisableMessage(new NetworkEvent<BumperCollisionDisableMessage>((BumperCollisionDisableMessage) msg));
          break;
        case RumpfieldMessageType.PlayerFinishedPicking:
          PlayerFinishedPickingMessage finishedPickingMessage = (PlayerFinishedPickingMessage) msg;
          Events.Global.FireNetEventPlayerFinishedPickingMessage(finishedPickingMessage.playerId, finishedPickingMessage.type);
          break;
        case RumpfieldMessageType.MatchInfo:
          Events.Global.FireNetEventMatchInfoMessage(new NetworkEvent<MatchInfoMessage>((MatchInfoMessage) msg));
          break;
        case RumpfieldMessageType.CreatePlayerMessage:
          CreatePlayerMessage createPlayerMessage = (CreatePlayerMessage) msg;
          Events.Global.FireNetEventCreatePlayerMessage(createPlayerMessage.playerId, createPlayerMessage.playerChampionData, createPlayerMessage.position, createPlayerMessage.rotation);
          break;
        case RumpfieldMessageType.ForfeitMatch:
          PlayerForfeitMatchMessage forfeitMatchMessage = (PlayerForfeitMatchMessage) msg;
          Events.Global.FireNetEventPlayerForfeitMatchMessage(forfeitMatchMessage.playerId, forfeitMatchMessage.forfeit);
          break;
        case RumpfieldMessageType.ForfeitMatchOver:
          ForfeitMatchOverMessage matchOverMessage = (ForfeitMatchOverMessage) msg;
          Events.Global.FireNetEventForfeitMatchOverMessage(matchOverMessage.playerId, matchOverMessage.team);
          break;
        default:
          throw new ArgumentOutOfRangeException("type", (object) messageType, (string) null);
      }
    }

    public void RegisterMessageAdapter<T>() where T : Message, new()
    {
      T obj = new T();
      RumpfieldMessageType messageType = obj.GetMessageType();
      this.typeToMessage.Add(messageType, typeof (T));
      this.typeToEvent.Add(messageType, typeof (NetworkEvent<T>));
      if (!obj.IsPooled())
        return;
      this.messageFactory.RegisterPool<T>(messageType);
      this.pooledSet.Add(messageType);
    }

    public void Return(Message message)
    {
      if (!message.IsPooled())
        return;
      this.messageFactory.Return<Message>(message);
    }
  }
}
