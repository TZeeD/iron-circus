// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.NetworkedWorldClient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.Unity;
using Imi.Diagnostics;
using Imi.Game;
using Imi.Networking.Messages;
using Imi.ScEntitas;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Imi.SteelCircus.Utils;
using Imi.Utils.Extensions;
using Jitter.LinearMath;
using Newtonsoft.Json.Linq;
using SharedWithServer.ScEvents;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.Networking;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace SteelCircus.Core
{
  public class NetworkedWorldClient
  {
    private readonly ConfigProvider configProvider;
    private readonly Contexts contexts;
    private readonly Events events;
    private readonly GameEntityFactory gameEntityFactory;
    private InputController inputController;
    private bool arePlayersInitialized;
    private bool fetchedLoadout;
    private bool fetchedLevels;
    private bool fetchedSteamIds;
    private Queue<GameMessage> gameQueue = new Queue<GameMessage>();
    private LocalPlayerVisualSmoothingConfig visualSmoothingConfig;
    private SerializedSkillGraphs tmpSerializedSkillGraph = SerializedSkillGraphs.GetCachableSerializedSkillGraph();
    private BallBaseline localBallBaseline = new BallBaseline();
    private PlayerBaseline localPlayerBaseline = new PlayerBaseline();
    private Dictionary<ulong, PlayerBaseline> playerBaselines = new Dictionary<ulong, PlayerBaseline>(6);
    private int tickRate;
    private int errorRate;
    private Entitas.Systems rollbackSystems;
    private RemoteEntityLerpSystem remoteEntityLerpSystem;
    public static Action<ulong, SerializedSkillGraphs> OnSkillDiffReceived;

    public NetworkedWorldClient(
      ConfigProvider configProvider,
      Contexts contexts,
      Events events,
      GameEntityFactory gameEntityFactory,
      ClientTick ticker,
      int tickRate,
      Entitas.Systems rollbackSystems,
      RemoteEntityLerpSystem remoteEntityLerpSystem)
    {
      this.configProvider = configProvider;
      this.contexts = contexts;
      this.events = events;
      this.gameEntityFactory = gameEntityFactory;
      this.visualSmoothingConfig = configProvider.visualSmoothingConfig;
      this.inputController = new InputController(contexts.game);
      this.tickRate = tickRate;
      this.rollbackSystems = rollbackSystems;
      this.remoteEntityLerpSystem = remoteEntityLerpSystem;
    }

    public void OnMatchStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      Log.Debug(string.Format("MatchState change from [{0}] to [{1}]", (object) this.contexts.game.matchState.value, (object) matchState));
      this.contexts.game.ReplaceMatchState(matchState);
      this.events.FireEventMatchStateChanged(matchState, cutsceneDuration, remainingMatchTime);
      this.contexts.game.isRemainingMatchTime = true;
      this.contexts.game.remainingMatchTimeEntity.ReplaceCountdownAction(CountdownAction.WithDuration(remainingMatchTime).WithPauseCondition((Func<bool>) (() => this.contexts.game.hasMatchState && this.contexts.game.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)).Create());
    }

    public void OnMetaStateChanged(MetaState newMetaState)
    {
      if (newMetaState != MetaState.Waiting || !this.fetchedLevels && !this.fetchedLoadout && !this.fetchedSteamIds)
        return;
      this.fetchedLevels = this.fetchedLoadout = this.fetchedSteamIds = false;
    }

    public void OnUpdatePlayerUsername(NetworkEvent<UsernameMessage> e)
    {
      string username = e.msg.username;
      Log.Debug(string.Format("Received UsernameMessage: {0} - {1} - isTwitch={2} - viewers={3}", (object) e.msg.playerId, (object) username, (object) e.msg.isTwitchUser, (object) e.msg.twitchViewerCount));
      GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(e.msg.playerId);
      if (entityWithPlayerId != null)
      {
        entityWithPlayerId.ReplacePlayerUsername(true, username, false, "", 0, 0);
        this.SetTwitchInfo(entityWithPlayerId.playerUsername, e.msg);
      }
      else
      {
        Log.Debug(string.Format("No PlayerEntity for id {0} found. Cannot update Username.", (object) e.msg.playerId));
        GameEntity remotePlayer = this.gameEntityFactory.CreateRemotePlayer(e.msg.playerId, UniqueId.Invalid, ChampionType.Invalid, Team.None);
        remotePlayer.ReplacePlayerUsername(true, username, false, "", 0, 0);
        this.SetTwitchInfo(remotePlayer.playerUsername, e.msg);
      }
    }

    private void SetTwitchInfo(PlayerUsernameComponent username, UsernameMessage e)
    {
      username.isTwitchUser = e.isTwitchUser;
      if (!e.isTwitchUser)
        return;
      username.twitchUsername = e.twitchUsername;
      username.twitchViewerCount = e.twitchViewerCount;
    }

    public void OnUpdatePlayerChampionData(NetworkEvent<PreMatchChangedMessage> e)
    {
      foreach (KeyValuePair<ulong, PlayerChampionData> keyValuePair in e.msg.preMatchData)
      {
        Log.Debug(string.Format("Received ChampionData Update for Player {0}", (object) keyValuePair.Key));
        GameEntity player = this.contexts.game.GetFirstEntityWithPlayerId(keyValuePair.Key);
        if (player == null)
        {
          Log.Debug(string.Format("Create Remote Player {0}, uniqueId[{1}]", (object) keyValuePair.Key, (object) keyValuePair.Value.uniqueId));
          player = this.gameEntityFactory.CreateRemotePlayer(keyValuePair.Key, keyValuePair.Value.uniqueId, keyValuePair.Value.type, keyValuePair.Value.team);
        }
        if (!player.hasUniqueId || player.uniqueId.id == UniqueId.Invalid)
        {
          Log.Debug(string.Format("Update UniqueId for player [{0}]: [{1}] -> [{2}]", (object) keyValuePair.Key, player.hasUniqueId ? (object) player.uniqueId.id.ToString() : (object) "", (object) keyValuePair.Value.uniqueId));
          player.ReplaceUniqueId(keyValuePair.Value.uniqueId);
        }
        player.isFakePlayer = keyValuePair.Value.isFakePlayer;
        if (!player.hasPlayerUsername)
        {
          if (player.isFakePlayer)
          {
            if (player.hasPlayerChampionData)
            {
              string fakeUsername = NetworkedWorldClient.GetFakeUsername(player.playerChampionData.value.type);
              player.ReplacePlayerUsername(true, fakeUsername, false, "", 0, 0);
            }
          }
          else if (player.isLocalEntity)
            player.ReplacePlayerUsername(true, ImiServices.Instance.LoginService.GetUsername(), false, "", 0, 0);
          else
            player.ReplacePlayerUsername(true, "UsernameError", false, "", 0, 0);
        }
        NetworkedWorldClient.FetchPlayerLoadoutForFakePlayer(player);
        if (e.msg.preMatchData.Count == Contexts.sharedInstance.game.matchData.numPlayers)
        {
          this.FetchPlayerLoadout(e, player);
          this.FetchPlayerLevels(e);
          this.FetchPlayersSteamIds(e);
        }
        PlayerChampionData playerChampionData1 = player.hasPlayerChampionData ? player.playerChampionData.value : new PlayerChampionData();
        PlayerChampionData playerChampionData2 = keyValuePair.Value;
        if (!playerChampionData1.Equals(playerChampionData2))
          Log.Debug(string.Format("Setting PlayerChampionData: Pid[{0}], Uid[{1}], Champ[{2}], ", (object) keyValuePair.Key, (object) keyValuePair.Value.uniqueId, (object) keyValuePair.Value.type) + string.Format("Skin[{0}], Team[{1}], isReady[{2}]", (object) keyValuePair.Value.skinId, (object) keyValuePair.Value.team, (object) keyValuePair.Value.isReady));
        player.ReplacePlayerChampionData(playerChampionData2);
      }
      if (!this.arePlayersInitialized && e.msg.startGame)
      {
        this.arePlayersInitialized = true;
        Log.Debug("Instantiating Players...");
        this.InitializePlayers(e.msg.preMatchData);
        this.inputController.RegisterIngamePlayerInput(ImiServices.Instance.LoginService.GetPlayerId());
        Log.Debug("Game is starting...");
      }
      this.events.FireEventMatchStartCountdown(e.msg.matchStartCountdown, e.msg.lobbyState);
    }

    private static string GetFakeUsername(ChampionType champType) => champType != ChampionType.Robot ? SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(champType).displayName : ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) champType);

    private void FetchPlayerLoadout(NetworkEvent<PreMatchChangedMessage> e, GameEntity player)
    {
      if (this.fetchedLoadout)
        return;
      this.fetchedLoadout = true;
      ulong[] myArray = e.msg.preMatchData.Keys.Where<ulong>((Func<ulong, bool>) (x => x < 18446744073709551515UL)).ToArray<ulong>();
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayerLoadoutsCoroutine(myArray, (Action<JObject>) (jObj =>
      {
        if (jObj == null || jObj["results"] == null || jObj["error"] != null)
        {
          this.fetchedLoadout = false;
        }
        else
        {
          foreach (ulong idx in myArray)
          {
            if (jObj["results"][(object) idx.ToString()] != null)
            {
              GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(idx);
              Dictionary<ChampionType, ChampionLoadout> newItemLoadouts = new Dictionary<ChampionType, ChampionLoadout>();
              int num = 0;
              Sprite newPlayerAvatarSprite = (Sprite) null;
              foreach (JObject data in (IEnumerable<JToken>) jObj["results"][(object) idx.ToString()])
              {
                if ((int) data["champion"] != -1)
                {
                  ChampionLoadout championLoadout = new ChampionLoadout(data);
                  ChampionType key = (ChampionType) int.Parse(data["champion"].ToString());
                  newItemLoadouts.Add(key, championLoadout);
                }
                else
                {
                  num = (int) data["avatarIcon"];
                  newPlayerAvatarSprite = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(num, ShopManager.ShopItemType.avatarIcon).icon;
                }
              }
              entityWithPlayerId.ReplacePlayerLoadout(true, num, newPlayerAvatarSprite, newItemLoadouts);
              Log.Debug(string.Format("Player {0} fetched player loadout!", (object) player.playerId.value));
            }
            else
              Log.Error(string.Format("No Player Loadout Data for Player: {0} reveiced", (object) idx));
          }
          Log.Debug("Player Loadout parsing finished.");
        }
      }));
    }

    private void FetchPlayersSteamIds(NetworkEvent<PreMatchChangedMessage> e)
    {
      if (this.fetchedSteamIds)
        return;
      this.fetchedSteamIds = true;
      ulong[] myArray = e.msg.preMatchData.Keys.Where<ulong>((Func<ulong, bool>) (x => x < 18446744073709551515UL)).ToArray<ulong>();
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayersSteamIdsCoroutine(myArray, (Action<JObject>) (jObj =>
      {
        if (jObj == null || jObj["error"] != null)
        {
          this.fetchedSteamIds = false;
        }
        else
        {
          foreach (ulong num in myArray)
          {
            if (jObj[num.ToString()] != null)
            {
              CSteamID steamIDUserPlayedWith = (CSteamID) (ulong) jObj[num.ToString()];
              if ((long) ImiServices.Instance.LoginService.GetPlayerId() != (long) num)
              {
                SteamFriends.SetPlayedWith(steamIDUserPlayedWith);
                int coplayFriendCount = SteamFriends.GetCoplayFriendCount();
                string str = "";
                for (int iCoplayFriend = 0; iCoplayFriend < coplayFriendCount; ++iCoplayFriend)
                  str = str + (object) SteamFriends.GetCoplayFriend(iCoplayFriend) + "\n";
                Log.Debug(string.Format("Updated Recently Played With for {0} with SteamId {1} SteamCoPlayerCount = {2}:\n{3}", (object) num, (object) steamIDUserPlayedWith, (object) coplayFriendCount, (object) str));
              }
            }
            else
              Log.Error(string.Format("No Player Level Data for Player: {0} reveiced", (object) num));
          }
          Log.Debug("Players SteamIds parsing finished.");
        }
      }));
    }

    private void FetchPlayerLevels(NetworkEvent<PreMatchChangedMessage> e)
    {
      if (this.fetchedLevels)
        return;
      this.fetchedLevels = true;
      ulong[] myArray = e.msg.preMatchData.Keys.Where<ulong>((Func<ulong, bool>) (x => x < 18446744073709551515UL)).ToArray<ulong>();
      SingletonManager<MetaServiceHelpers>.Instance.GetPlayerLevelsCoroutine(myArray, (Action<JObject>) (jObj =>
      {
        if (jObj == null || jObj["error"] != null)
        {
          this.fetchedLevels = false;
        }
        else
        {
          Dictionary<ulong, int> playerLevels = new Dictionary<ulong, int>(6);
          foreach (ulong num in myArray)
          {
            if (jObj[num.ToString()] != null)
            {
              GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(num);
              int newPlayerLevel = int.Parse(jObj[num.ToString()].ToString());
              playerLevels[num] = newPlayerLevel;
              if (entityWithPlayerId.hasPlayerUsername)
                entityWithPlayerId.playerUsername.playerLevel = newPlayerLevel;
              else
                entityWithPlayerId.ReplacePlayerUsername(true, "UsernameError", false, "", 0, newPlayerLevel);
              Log.Debug(string.Format("Player {0} fetched player Level!", (object) num));
            }
            else
              Log.Error(string.Format("No Player Level Data for Player: {0} reveiced", (object) num));
          }
          ImiServices.Instance.Analytics.OnMatchmakingPlayerLevelsReceived(playerLevels);
          Log.Debug("Player Levels parsing finished.");
        }
      }));
    }

    private void InitializePlayers(
      Dictionary<ulong, PlayerChampionData> matchStartData)
    {
      foreach (KeyValuePair<ulong, PlayerChampionData> keyValuePair in matchStartData)
        this.InitializeSinglePlayer(keyValuePair.Key, keyValuePair.Value);
    }

    public void InitializeSinglePlayer(ulong playerId, PlayerChampionData data)
    {
      Log.Debug("Initializing Player: " + string.Format("Pid[{0}], ", (object) playerId) + string.Format("Uid[{0}], ", (object) data.uniqueId) + string.Format("Champ[{0}], ", (object) data.type) + string.Format("Skin[{0}], ", (object) data.skinId) + string.Format("Team[{0}], ", (object) data.team) + string.Format("isReady[{0}]", (object) data.isReady));
      GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(playerId);
      this.gameEntityFactory.InitializePlayerEntity(entityWithPlayerId, data.type, data.team);
      NetworkedWorldClient.FetchPlayerLoadoutForFakePlayer(entityWithPlayerId);
      GameObject gameObject = MatchObjectsParent.Add(UnityEngine.Object.Instantiate<GameObject>(Resources.Load<GameObject>("Prefabs/Player")));
      Player component = gameObject.GetComponent<Player>();
      PlayerUtils.CreateIngameModelFromLoadout(entityWithPlayerId.championConfig.value, entityWithPlayerId.playerLoadout.itemLoadouts, component.ViewTransform, entityWithPlayerId.playerTeam.value);
      entityWithPlayerId.AddUnityView(gameObject);
      gameObject.Link((IEntity) entityWithPlayerId, (IContext) this.contexts.game);
      Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
      if ((UnityEngine.Object) componentInChildren != (UnityEngine.Object) null)
        componentInChildren.SetFloat("maxSpeed", entityWithPlayerId.championConfig.value.maxSpeed);
      entityWithPlayerId.isAlignViewToBottom = true;
      this.playerBaselines[entityWithPlayerId.playerId.value] = new PlayerBaseline();
      PlayerBaseline playerBaseline = this.playerBaselines[entityWithPlayerId.playerId.value];
      playerBaseline.skills = SerializedSkillGraphs.CreateFrom(entityWithPlayerId, playerBaseline.cachedByteArray);
      playerBaseline.status = SerializedStatusEffects.CreateFrom(entityWithPlayerId.statusEffect.effects);
      playerBaseline.animation = AnimationStates.CreateFrom(entityWithPlayerId.animationState);
      if (entityWithPlayerId.isLocalEntity)
        this.localPlayerBaseline = playerBaseline;
      PlayerUtils.OverrideAnimationsForPlayer(entityWithPlayerId, entityWithPlayerId.unityView.gameObject);
    }

    public void CreatePlayer(
      ulong playerId,
      PlayerChampionData playerChampionData,
      JVector position,
      JQuaternion rotation)
    {
      if (this.contexts.game.GetFirstEntityWithPlayerId(playerId) != null)
        return;
      PlayerChampionData playerChampionData1 = playerChampionData;
      Log.Debug(string.Format("Create New Player {0}, uniqueId[{1}]", (object) playerId, (object) playerChampionData1.uniqueId));
      GameEntity remotePlayer = this.gameEntityFactory.CreateRemotePlayer(playerId, playerChampionData1.uniqueId, playerChampionData1.type, playerChampionData1.team);
      remotePlayer.isFakePlayer = playerChampionData1.isFakePlayer;
      remotePlayer.ReplacePlayerChampionData(playerChampionData1);
      if (!remotePlayer.isFakePlayer)
        throw new NotImplementedException("NEED TO IMPLEMENT PLAYER CREATION FOR NON-FAKE PLAYERS!");
      if (remotePlayer.hasPlayerChampionData)
      {
        string fakeUsername = NetworkedWorldClient.GetFakeUsername(remotePlayer.playerChampionData.value.type);
        remotePlayer.ReplacePlayerUsername(true, fakeUsername, false, "", 0, 0);
        remotePlayer.playerUsername.isTwitchUser = false;
      }
      this.InitializeSinglePlayer(playerId, playerChampionData1);
      remotePlayer.TransformReplacePosition(position);
      remotePlayer.TransformReplaceRotation(rotation);
      GameObject gameObject = remotePlayer.unityView.gameObject;
      gameObject.transform.SetPositionAndRotation(position.ToVector3(), rotation.ToQuaternion());
      Player componentInChildren = gameObject.GetComponentInChildren<Player>();
      componentInChildren.StartCoroutine(componentInChildren.PlaySpawnFX());
    }

    private static void FetchPlayerLoadoutForFakePlayer(GameEntity player)
    {
      if (player.hasPlayerLoadout)
        return;
      Dictionary<ChampionType, ChampionLoadout> newItemLoadouts = new Dictionary<ChampionType, ChampionLoadout>();
      foreach (ChampionType championType in Enum.GetValues(typeof (ChampionType)))
      {
        switch (championType)
        {
          case ChampionType.Invalid:
          case ChampionType.Random:
            continue;
          default:
            ChampionLoadout loadoutForChampion = SingletonScriptableObject<ItemsConfig>.Instance.GetFakePlayerLoadoutForChampion(championType);
            newItemLoadouts.Add(championType, loadoutForChampion);
            continue;
        }
      }
      if (!player.isFakePlayer)
        return;
      Sprite newPlayerAvatarSprite;
      if (player.hasPlayerTeam)
      {
        newPlayerAvatarSprite = player.playerTeam.value != Team.Alpha ? Resources.Load<Sprite>("UI/UserAvatars/avatar_botBlue_ui") : Resources.Load<Sprite>("UI/UserAvatars/avatar_botOrange_ui");
      }
      else
      {
        Log.Error("Player " + (object) player.playerId + "does not have team!");
        newPlayerAvatarSprite = Resources.Load<Sprite>("UI/UserAvatars/userAvatar_CeresWorkersUnionLogo_ui");
      }
      player.AddPlayerLoadout(true, -1, newPlayerAvatarSprite, newItemLoadouts);
      Log.Debug(string.Format("Fake Player {0} using default player loadout", (object) player.playerId.value));
    }

    public void TickInput() => this.inputController.Tick();

    public void TickReprediction(int tick)
    {
      GameEntity globalTimeEntity = this.contexts.game.globalTimeEntity;
      globalTimeEntity.ReplaceGlobalTime(1f / (float) this.tickRate, globalTimeEntity.globalTime.timeSinceMatchStart + 1f / (float) this.tickRate, tick, globalTimeEntity.globalTime.lastServerTick, globalTimeEntity.globalTime.timeSinceStartOfTick, true);
      this.rollbackSystems.Execute();
      this.rollbackSystems.Cleanup();
      globalTimeEntity.globalTime.isReprediction = false;
    }

    public void SendInput(int tick)
    {
      GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(ImiServices.Instance.LoginService.GetPlayerId());
      if (this.inputController.HasInputFor(entityWithPlayerId.playerId.value))
        entityWithPlayerId.input.SetInput(tick, this.inputController.GetInputFor(entityWithPlayerId.playerId.value, tick));
      Contexts.sharedInstance.meta.metaNetwork.value.SendUnreliable((Message) new SimpleDeltaInputMessage(tick, this.contexts.game.globalTime.lastServerTick, new Imi.Networking.Messages.TickInput(tick - 2, entityWithPlayerId.hasInput ? entityWithPlayerId.input.GetInput(tick - 2) : Imi.SharedWithServer.ScEntitas.Components.Input.Zero), new Imi.Networking.Messages.TickInput(tick - 1, entityWithPlayerId.hasInput ? entityWithPlayerId.input.GetInput(tick - 1) : Imi.SharedWithServer.ScEntitas.Components.Input.Zero), new Imi.Networking.Messages.TickInput(tick, entityWithPlayerId.hasInput ? entityWithPlayerId.input.GetInput(tick) : Imi.SharedWithServer.ScEntitas.Components.Input.Zero), new Imi.Networking.Messages.TickInput(tick + 1, Imi.SharedWithServer.ScEntitas.Components.Input.Invalid), new Imi.Networking.Messages.TickInput(tick + 2, Imi.SharedWithServer.ScEntitas.Components.Input.Invalid), new Imi.Networking.Messages.TickInput(tick + 3, Imi.SharedWithServer.ScEntitas.Components.Input.Invalid), new Imi.Networking.Messages.TickInput(tick + 4, Imi.SharedWithServer.ScEntitas.Components.Input.Invalid)));
    }

    public void Reset()
    {
      this.arePlayersInitialized = false;
      this.fetchedLoadout = false;
      this.fetchedLevels = false;
      this.fetchedSteamIds = false;
      this.inputController.UnregisterIngamePlayerInput(ImiServices.Instance.LoginService.GetPlayerId());
      this.gameQueue.Clear();
      this.tmpSerializedSkillGraph = SerializedSkillGraphs.GetCachableSerializedSkillGraph();
      this.localBallBaseline = new BallBaseline();
      this.playerBaselines = new Dictionary<ulong, PlayerBaseline>(6);
    }

    public void OnGameplayState(GameMessage msg, float currentTickRateMillis)
    {
      ServerStatusHeader status = msg.status;
      GlobalTimeComponent globalTime = this.contexts.game.globalTime;
      this.contexts.game.ReplaceGlobalTime(globalTime.fixedSimTimeStep, globalTime.timeSinceMatchStart, globalTime.currentTick, status.serverTick, globalTime.timeSinceStartOfTick, globalTime.isReprediction);
      ConnectionInfoComponent connectionInfo = this.contexts.game.GetFirstLocalEntity().connectionInfo;
      connectionInfo.currentTickRateMillis = currentTickRateMillis;
      connectionInfo.lastReceivedRemoteTick = msg.status.serverTick;
      this.gameQueue.Enqueue(msg);
      this.AddServerStateToRemoteInterpolationHistory(msg);
      uint serverTick = (uint) msg.status.serverTick;
      uint serverBaseline = (uint) msg.status.serverBaseline;
      foreach (KeyValuePair<UniqueId, FullPlayerState> playerState in msg.playerStates)
      {
        GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(playerState.Key);
        if (entityWithUniqueId != null && this.playerBaselines.ContainsKey(entityWithUniqueId.playerId.value))
        {
          PlayerBaseline playerBaseline = this.playerBaselines[entityWithUniqueId.playerId.value];
          this.SetPlayerEntityBaseline(serverTick, serverBaseline, playerBaseline, playerState.Value, entityWithUniqueId);
        }
      }
      this.localBallBaseline.tick = serverTick;
      this.localBallBaseline.transform = TransformStateDelta.Merge(this.localBallBaseline.transform, msg.ballTransformStateDelta);
      this.localBallBaseline.owner = msg.ballOwner;
      this.localBallBaseline.traveledDistance = msg.ballTraveledDistance;
      this.localBallBaseline.flightDuration = msg.ballFlighDuration;
      this.localBallBaseline.ballHoldDisabled = msg.ballHoldDisabled;
      if (this.localBallBaseline.owner == UniqueId.Zero || this.localBallBaseline.owner == UniqueId.Invalid)
        return;
      this.localBallBaseline.transform.velocity = JVector.Zero;
    }

    private void SetPlayerEntityBaseline(
      uint serverTick,
      uint serverBaseline,
      PlayerBaseline playerBaseline,
      FullPlayerState playerState,
      GameEntity player)
    {
      if (playerBaseline.tick >= serverTick || !this.arePlayersInitialized)
        return;
      TransformState transformState = TransformStateDelta.Merge(playerBaseline.transform, playerState.tState);
      SerializedSkillGraphs.ApplyDiff(playerBaseline.skills.serializedGraphs, playerState.smStatesDelta.serializedGraphs, player);
      bool shouldHaveCrashed;
      SerializedStatusEffects serializedStatusEffects = SerializedStatusEffects.Merge(playerBaseline.status, playerState.seStatesDelta, out shouldHaveCrashed);
      if (shouldHaveCrashed)
        Log.Debug(string.Format("Baseline {0}, newBaseline {1}, current {2}", (object) playerBaseline.tick, (object) serverBaseline, (object) this.contexts.game.globalTime.currentTick));
      AnimationStates animationStates = AnimationStates.Merge(playerBaseline.animation, playerState.aniStatesDelta);
      playerBaseline.transform = transformState;
      playerBaseline.animation = animationStates;
      playerBaseline.status = serializedStatusEffects;
      playerBaseline.tick = serverTick;
    }

    private void AddServerStateToRemoteInterpolationHistory(GameMessage msg)
    {
      List<RemoteEntityState> states = new List<RemoteEntityState>(6);
      foreach (KeyValuePair<UniqueId, FullPlayerState> playerState in msg.playerStates)
      {
        GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(playerState.Key);
        if (entityWithUniqueId != null && !entityWithUniqueId.isLocalEntity && entityWithUniqueId.hasTransform)
        {
          TransformState newState = TransformStateDelta.Merge(entityWithUniqueId.ToTransformState(), playerState.Value.tState);
          this.FireProxyEvent(entityWithUniqueId.uniqueId.id, msg.status.serverTick, newState);
          states.Add(new RemoteEntityState(entityWithUniqueId.uniqueId.id, newState.position, newState.velocity, newState.rotation));
        }
      }
      if (this.contexts.game.ballEntity != null && this.contexts.game.ballEntity.hasTransform)
      {
        UniqueId id = this.contexts.game.ballEntity.uniqueId.id;
        TransformState transformState = TransformStateDelta.Merge(this.contexts.game.ballEntity.ToTransformState(), msg.ballTransformStateDelta);
        states.Add(new RemoteEntityState(id, transformState.position, transformState.velocity, transformState.rotation));
      }
      foreach (KeyValuePair<UniqueId, TransformStateDelta> tmpEntity in msg.tmpEntities)
      {
        TransformStateDelta delta = tmpEntity.Value;
        GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(tmpEntity.Key);
        if (entityWithUniqueId != null)
        {
          TransformState transformState = TransformStateDelta.Merge(entityWithUniqueId.ToTransformState(), delta);
          states.Add(new RemoteEntityState(tmpEntity.Key, transformState.position, transformState.velocity, transformState.rotation));
        }
        else
          states.Add(new RemoteEntityState(tmpEntity.Key, delta.State.position, delta.State.velocity, delta.State.rotation));
      }
      if (states.Count <= 0)
        return;
      this.remoteEntityLerpSystem.Add(states, msg.status.serverTick);
    }

    private void FireProxyEvent(UniqueId localUniqueId, int remoteTick, TransformState newState)
    {
      if (!this.configProvider.debugConfig.showServerProxies)
        return;
      this.events.FireEventProxyTransform(remoteTick, localUniqueId, newState.position, newState.rotation, true);
    }

    private bool ShouldAbortRollback(int remoteTick, int currentTick)
    {
      switch (this.contexts.game.matchState.value)
      {
        case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
        case Imi.SharedWithServer.Game.MatchState.VictoryPose:
        case Imi.SharedWithServer.Game.MatchState.StatsScreens:
          this.errorRate = 0;
          return true;
        default:
          if (currentTick - remoteTick > 30)
          {
            Log.Error(string.Format("Client tick too far in front of Server: ClientTick[{0}] ServerTick[{1}](Last received) D[{2}]", (object) currentTick, (object) remoteTick, (object) (currentTick - remoteTick)));
            ++this.errorRate;
            if (this.errorRate > 30 * this.tickRate)
            {
              this.contexts.game.matchState.value = Imi.SharedWithServer.Game.MatchState.WaitingForPlayers;
              this.contexts.meta.metaState.value = MetaState.None;
              this.errorRate = 0;
              ImiServices.Instance.GoBackToMenu();
            }
            return true;
          }
          this.errorRate = Math.Max(0, --this.errorRate);
          return false;
      }
    }

    public void HandleRollback()
    {
      while (this.gameQueue.Count > 0)
      {
        GameMessage gameMessage = this.gameQueue.Dequeue();
        if (this.gameQueue.Count == 0)
          this.ClientServerReconciliation(gameMessage);
        Contexts.sharedInstance.meta.metaNetwork.value.ReleaseGameMessage(gameMessage);
      }
      if (this.contexts.game.matchState.value == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers)
        return;
      int lastServerTick = this.contexts.game.globalTime.lastServerTick;
      if (lastServerTick <= 0)
        return;
      this.RollbackAndRepredict(this.contexts.game.GetFirstLocalEntity(), lastServerTick, (int) this.localPlayerBaseline.tick);
    }

    private void ClientServerReconciliation(GameMessage msg)
    {
      GameEntity firstLocalEntity = this.contexts.game.GetFirstLocalEntity();
      if (firstLocalEntity == null || !firstLocalEntity.hasUniqueId)
        return;
      UniqueId id = firstLocalEntity.uniqueId.id;
      int serverTick = msg.status.serverTick;
      foreach (KeyValuePair<UniqueId, FullPlayerState> playerState in msg.playerStates)
      {
        GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(playerState.Key);
        if (entityWithUniqueId != null && !(entityWithUniqueId.uniqueId.id == id))
        {
          PlayerBaseline playerBaseline = this.playerBaselines[entityWithUniqueId.playerId.value];
          playerBaseline.skills.ApplyTo(entityWithUniqueId);
          entityWithUniqueId.SetTransformState(playerBaseline.transform);
          entityWithUniqueId.SetStatusEffectStates(playerBaseline.status);
          entityWithUniqueId.SetAnimationStates(playerBaseline.animation);
          entityWithUniqueId.input.SetInput(serverTick, playerState.Value.input);
        }
      }
      foreach (UniqueId key in msg.tmpEntities.Keys)
      {
        GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(key);
        if (entityWithUniqueId != null)
        {
          TransformState state = TransformStateDelta.Merge(entityWithUniqueId.ToTransformState(), msg.tmpEntities[key]);
          entityWithUniqueId.SetTransformState(state);
        }
      }
    }

    private void RollbackAndRepredict(GameEntity localPlayer, int remoteTick, int baseline)
    {
      GameEntity ballEntity = this.contexts.game.ballEntity;
      if (ballEntity.hasBallOwner)
      {
        long playerId = (long) ballEntity.ballOwner.playerId;
      }
      JVector zero = JVector.Zero;
      if (localPlayer.hasTransform)
      {
        JVector position = localPlayer.transform.position;
      }
      localPlayer.SetTransformState(this.localPlayerBaseline.transform);
      this.localPlayerBaseline.skills.ApplyTo(localPlayer);
      localPlayer.SetStatusEffectStates(this.localPlayerBaseline.status);
      localPlayer.SetAnimationStates(this.localPlayerBaseline.animation);
      ballEntity.ReplaceRemoteTransform(this.localBallBaseline.transform);
      ballEntity.ReplaceLastKnownRemoteTick(remoteTick);
      ballEntity.ReplaceVelocityOverride(this.localBallBaseline.transform.velocity);
      ballEntity.ReplaceTransform(this.localBallBaseline.transform.position, this.localBallBaseline.transform.rotation);
      ballEntity.rigidbody.value.LinearVelocity = this.localBallBaseline.transform.velocity;
      ballEntity.rigidbody.value.Position = this.localBallBaseline.transform.position - ballEntity.rigidbody.offset;
      ballEntity.rigidbody.value.Position = this.localBallBaseline.transform.position;
      ballEntity.rigidbody.value.Orientation = JMatrix.CreateFromQuaternion(this.localBallBaseline.transform.rotation);
      ballEntity.positionTimeline.value.Add(ScTime.TicksToMillis(remoteTick, 1f / (float) this.tickRate), this.localBallBaseline.transform.position);
      ballEntity.ReplaceBallFlightInfo(this.localBallBaseline.traveledDistance, this.localBallBaseline.flightDuration);
      ballEntity.isBallHitDisabled = this.localBallBaseline.ballHoldDisabled;
      GameEntity entityWithUniqueId = this.contexts.game.GetFirstEntityWithUniqueId(this.localBallBaseline.owner);
      if (entityWithUniqueId != null)
      {
        if (!ballEntity.hasBallOwner || (long) ballEntity.ballOwner.playerId != (long) entityWithUniqueId.playerId.value)
          ballEntity.ReplaceBallOwner(entityWithUniqueId.playerId.value);
      }
      else if (ballEntity.hasBallOwner)
        ballEntity.RemoveBallOwner();
      this.contexts.game.collisionEvents.collisions.Clear();
      this.contexts.game.collisionEvents.triggerEnter.Clear();
      this.contexts.game.collisionEvents.triggerStay.Clear();
      this.contexts.game.deferredCollisionEvents.collisions.Clear();
      this.contexts.game.deferredCollisionEvents.triggerEnter.Clear();
      this.contexts.game.deferredCollisionEvents.triggerStay.Clear();
      int currentTick1 = this.contexts.game.globalTime.currentTick;
      int currentTick2 = this.contexts.game.globalTime.currentTick;
      if (this.ShouldAbortRollback(remoteTick, currentTick2))
        return;
      for (int tick = remoteTick; tick < currentTick2; ++tick)
      {
        try
        {
          this.TickReprediction(tick);
        }
        catch (Exception ex)
        {
          Log.Error(ex.Message + "\n" + ex.StackTrace);
        }
      }
      this.contexts.game.globalTime.currentTick = ++this.contexts.game.globalTime.currentTick;
      this.FireProxyEvent(localPlayer.uniqueId.id, remoteTick, this.localPlayerBaseline.transform);
    }

    private void UpdateVisualSmoothing(GameEntity localPlayer, JVector positionBeforeReprediction)
    {
      if (!localPlayer.hasTransform)
        return;
      JVector position = localPlayer.transform.position;
      float num = (position - positionBeforeReprediction).Length();
      if ((double) num <= (double) this.visualSmoothingConfig.startSmoothingThreshold)
        return;
      Log.Warning(string.Format("Position changed by reprediction! distance: \t{0}\n", (object) num) + string.Format("before:\t{0}\n", (object) positionBeforeReprediction) + string.Format("after:\t{0}\n", (object) position));
      if (!localPlayer.hasUnityView)
        return;
      if ((double) num <= (double) this.visualSmoothingConfig.skipSmoothingThreshold)
      {
        float newLerpFactor = 0.0f;
        if (localPlayer.hasVisualSmoothing)
          newLerpFactor = localPlayer.visualSmoothing.lerpFactor;
        localPlayer.ReplaceVisualSmoothing(newLerpFactor);
      }
      else if (localPlayer.hasVisualSmoothing)
      {
        Log.Warning(string.Format("Snapping VisualSmoothing. dist[{0}]", (object) num));
        localPlayer.RemoveVisualSmoothing();
      }
      JVector jvector = localPlayer.unityView.gameObject.transform.position.ToJVector();
      jvector.Y = 0.0f;
      JQuaternion jquaternion = localPlayer.unityView.gameObject.transform.rotation.ToJQuaternion();
      this.ReplaceLocalPlayerVisualSmoothingLerp(localPlayer, jvector, jquaternion, localPlayer.transform.Position2D, localPlayer.transform.rotation);
    }

    private void ReplaceLocalPlayerVisualSmoothingLerp(
      GameEntity localPlayer,
      JVector localViewPosition,
      JQuaternion localViewRotation,
      JVector updatedLocalPosition,
      JQuaternion updatedLocalRotation)
    {
      float num1 = (updatedLocalPosition - localViewPosition).Length();
      float num2 = JQuaternion.Angle(localViewRotation, updatedLocalRotation);
      float snapThreshold = this.visualSmoothingConfig.snapThreshold;
      double minSmoothDuration = (double) this.visualSmoothingConfig.minSmoothDuration;
      float maxSmoothDuration = this.visualSmoothingConfig.maxSmoothDuration;
      double positionDeltaMinSmooth = (double) this.visualSmoothingConfig.positionDeltaMinSmooth;
      float positionDeltaMaxSmooth = this.visualSmoothingConfig.positionDeltaMaxSmooth;
      float rotationDeltaMinSmooth = this.visualSmoothingConfig.rotationDeltaMinSmooth;
      float rotationDeltaMaxSmooth = this.visualSmoothingConfig.rotationDeltaMaxSmooth;
      double num3 = (double) positionDeltaMaxSmooth;
      double num4 = (double) num1;
      float num5 = Mathf.Max(Mathf.InverseLerp((float) positionDeltaMinSmooth, (float) num3, (float) num4), Mathf.InverseLerp(rotationDeltaMinSmooth, rotationDeltaMaxSmooth, num2));
      double num6 = (double) maxSmoothDuration;
      double num7 = (double) num5;
      float a = Mathf.Lerp((float) minSmoothDuration, (float) num6, (float) num7);
      float num8 = 0.0f;
      int num9 = (double) num1 >= (double) snapThreshold ? 1 : 0;
      if (num9 != 0)
      {
        a = 0.0f;
        num8 = 1f;
      }
      LocalPlayerVisualSmoothing playerVisualSmoothing1 = localPlayer.localPlayerVisualSmoothing;
      if (num9 == 0 && (double) playerVisualSmoothing1.currentLerpDuration != 0.0 && (double) playerVisualSmoothing1.currentLerpFactor != 1.0)
      {
        num8 = 0.0f;
        a = Mathf.Max(a, playerVisualSmoothing1.currentLerpDuration * (1f - playerVisualSmoothing1.currentLerpFactor));
      }
      LocalPlayerVisualSmoothing playerVisualSmoothing2 = localPlayer.localPlayerVisualSmoothing;
      playerVisualSmoothing2.currentLerpFactor = num8;
      playerVisualSmoothing2.currentLerpDuration = a;
      localPlayer.ReplaceComponent(40, (IComponent) playerVisualSmoothing2);
    }

    public void ReplaceVisualSmoothing()
    {
      GameEntity firstLocalEntity = this.contexts.game.GetFirstLocalEntity();
      if (firstLocalEntity == null || !firstLocalEntity.hasUniqueId || !firstLocalEntity.hasLocalPlayerVisualSmoothing)
        return;
      LocalPlayerVisualSmoothing playerVisualSmoothing = firstLocalEntity.localPlayerVisualSmoothing;
      playerVisualSmoothing.interpolationStartTransform = playerVisualSmoothing.interpolationEndTransform;
      playerVisualSmoothing.interpolationEndTransform = playerVisualSmoothing.smoothedTransform;
      playerVisualSmoothing.positionTimeline.Add(ScTime.TicksToMillis(this.contexts.game.globalTime.currentTick + 1, this.contexts.game.globalTime.fixedSimTimeStep), firstLocalEntity.transform.position);
      float fixedSimTimeStep = this.contexts.game.globalTime.fixedSimTimeStep;
      playerVisualSmoothing.frameDtOffset = Time.time - playerVisualSmoothing.tickStartTime - fixedSimTimeStep + playerVisualSmoothing.frameDtOffset;
      if ((double) Mathf.Abs(playerVisualSmoothing.frameDtOffset) > (double) fixedSimTimeStep)
        playerVisualSmoothing.frameDtOffset = 0.0f;
      playerVisualSmoothing.tickStartTime = Time.time;
      firstLocalEntity.ReplaceComponent(40, (IComponent) playerVisualSmoothing);
    }
  }
}
