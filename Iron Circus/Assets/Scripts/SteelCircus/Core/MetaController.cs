// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.MetaController
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
using Imi.SharedWithServer.Networking.Rumpfield.Core;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SharedWithServer.ScEntitas.Systems.Gameplay;
using Imi.SharedWithServer.ScEntitas.Systems.Physics;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.Networking;
using Imi.SteelCircus.ScEntitas.Systems;
using Imi.SteelCircus.ScEntitas.Systems.ViewSystems;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Imi.Utils.Extensions;
using Jitter;
using Jitter.Collision;
using Jitter.Dynamics;
using Jitter.LinearMath;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Core
{
  public class MetaController : MonoBehaviour
  {
    [Header("Time - Settings")]
    [SerializeField]
    private int tickRate = 60;
    [SerializeField]
    private ClockSync clockSync;
    [SerializeField]
    private ConfigProvider configProvider;
    [SerializeField]
    private MatchResourcesInitializer matchResourcesInitializer;
    private GameClientSystemHelper systemHelper;
    private ClientTick ticker;
    private Contexts contexts;
    private Entitas.Systems arenaLoadingSystems;
    private Entitas.Systems simulationSystems;
    private Entitas.Systems rollbackSystems;
    private Entitas.Systems clientOnlySystems;
    private Entitas.Systems ballViewSystem;
    private GameEntityFactory gameEntityFactory;
    private EntitasSetup entitasSetup;
    private ServerCommandRegistry serverCmdRegistry;
    private NetworkedWorldClient world;
    private Events events;
    public Text text;
    private RemoteEntityLerpSystem remoteEntityLerpSystem;
    private ServerStatusHeader statusHeader;
    private bool processServerStatus;
    public bool showDebugText;
    private bool kicked;

    private void Awake()
    {
      Debug.Log((object) "Meta Awake");
      this.systemHelper = new GameClientSystemHelper();
      if (!ImiServices.Instance.LoginService.IsLoginOk())
      {
        Debug.Log((object) "Meta Login Ok");
        // ISSUE: method pointer
        ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler((object) this, __methodptr(\u003CAwake\u003Eg__MetaLoginSuccessful\u007C22_0));
        this.enabled = false;
      }
      ImiServices.Instance.OnTryToDisconnect += new ImiServices.OnTryToDisconnectEventHandler(this.OnTryToDisconnect);
      ImiServices.Instance.OnResetState += new ImiServices.OnResetStateEventHandler(this.OnResetState);
      ImiServices.Instance.OnConnectToGameServer += new ImiServices.OnConnectToGameServerEventHandler(this.OnConnectToGameServer);
      ImiServices.Instance.OnConnectToServerManagerServer += new ImiServices.OnConnectToServerManagerServerEventHandler(this.OnConnectToServerManager);
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(ImiServices.Instance.progressManager.FetchChampionUnlockInfo);
    }

    private void Start()
    {
      Debug.Log((object) "Meta Start");
      this.events = Events.Global;
      this.contexts = Contexts.sharedInstance;
      this.serverCmdRegistry = new ServerCommandRegistry(this, this.events, this.contexts.game, this.configProvider);
      this.gameEntityFactory = new GameEntityFactory(this.contexts.game, this.events, this.configProvider, true);
      this.entitasSetup = new EntitasSetup(this.contexts, this.gameEntityFactory, this.configProvider, this.events);
      this.CreateGameSystems();
      this.clockSync.Init(this.tickRate);
      this.ticker = new ClientTick(this.clockSync, (ISystemHelper) this.systemHelper, new ClientTick.OnTickDelegate(this.OnTick), true);
      this.world = new NetworkedWorldClient(this.configProvider, this.contexts, this.events, this.gameEntityFactory, this.ticker, this.tickRate, this.rollbackSystems, this.remoteEntityLerpSystem);
      this.AddListeners();
      this.CreateUniqueMetaEntities(this.contexts.meta);
      MetaEntity entity = this.contexts.meta.CreateEntity();
      entity.AddMetaPlayerId(ImiServices.Instance.LoginService.GetPlayerId());
      entity.AddMetaUsername(ImiServices.Instance.LoginService.GetUsername());
      MetaController.CreateUniqueGameEntities(this.contexts, this.gameEntityFactory, this.configProvider.physicsEngineConfig, this.configProvider.matchConfig, false, (uint) this.entitasSetup.NumPlayers);
    }

    private IEnumerator DoReset()
    {
      Log.Warning("Did we just leave a match? Might want to kill some things.");
      yield return (object) new WaitForEndOfFrame();
      this.kicked = false;
      this.ClearReactiveSystems();
      this.DeactivateReactiveSystems();
      this.TearDownSystems();
      MatchObjectsParent.DisableAllChildren();
      this.gameEntityFactory.Reset();
      this.world.Reset();
      VfxManager.Reset();
      this.ClearGameContext();
      MatchObjectsParent.Clear();
      this.ActivateReactiveSystems();
      MetaController.CreateUniqueGameEntities(this.contexts, this.gameEntityFactory, this.configProvider.physicsEngineConfig, this.configProvider.matchConfig, false, (uint) this.entitasSetup.NumPlayers);
    }

    private void OnConnectToServerManager(ConnectionInfo connectionInfo)
    {
    }

    private void OnConnectToGameServer(ConnectionInfo connectionInfo)
    {
      this.InitializeSystems();
      if (connectionInfo.connectToken == null)
        throw new ImiException("Can't connect without token.");
      this.contexts.meta.metaNetwork.value.Connect(connectionInfo.connectToken, connectionInfo.playerId, (double) this.systemHelper.GetTimeSinceStartup(), (Action) (() =>
      {
        Log.Netcode("Connection Successful");
        this.events.FireEventConnectionOk();
        ImiServices.Instance.LoadingScreenService.ShowLoadingScreen(LoadingScreenService.LoadingScreenIntent.loadingLobby);
        this.StartCoroutine(MetaController.SendInitialMessagesDelayed(connectionInfo.gameLiftPlayerSessionId));
      }), (Action<string>) (obj =>
      {
        Log.Error("Connection Failed!");
        this.events.FireEventConnectionNotOk(obj, connectionInfo.ToString());
      }));
    }

    private static IEnumerator SendInitialMessagesDelayed(string sessionId)
    {
      yield return (object) new WaitForSecondsRealtime(1.5f);
      GameLiftHelpers.SendPlayerSession(sessionId);
    }

    private void CreateGameSystems()
    {
      this.arenaLoadingSystems = SystemsFactory.CreateArenaLoadingSystems(this.entitasSetup);
      this.simulationSystems = SystemsFactory.CreateSystemsWithBuilder(this.entitasSetup);
      this.clientOnlySystems = SystemsFactory.CreateClientOnlySystems(this.entitasSetup);
      this.remoteEntityLerpSystem = new RemoteEntityLerpSystem(this.entitasSetup);
      this.clientOnlySystems.Add((ISystem) this.remoteEntityLerpSystem);
      this.rollbackSystems = SystemsFactory.CreateRepredictionSystems(this.entitasSetup);
      Entitas.Systems systems = new Entitas.Systems();
      systems.Add((ISystem) this.arenaLoadingSystems);
      systems.Add((ISystem) this.simulationSystems);
      systems.Add((ISystem) this.clientOnlySystems);
      systems.Add((ISystem) this.rollbackSystems);
      this.ActivateReactiveSystems();
    }

    private void ActivateReactiveSystems()
    {
      this.simulationSystems.ActivateReactiveSystems();
      this.clientOnlySystems.ActivateReactiveSystems();
      this.rollbackSystems.ActivateReactiveSystems();
      this.arenaLoadingSystems.ActivateReactiveSystems();
    }

    private void InitializeSystems()
    {
      this.arenaLoadingSystems.Initialize();
      this.simulationSystems.Initialize();
      this.rollbackSystems.Initialize();
      this.clientOnlySystems.Initialize();
    }

    private void TearDownSystems()
    {
      this.arenaLoadingSystems.TearDown();
      this.simulationSystems.TearDown();
      this.clientOnlySystems.TearDown();
      this.rollbackSystems.TearDown();
    }

    private void DeactivateReactiveSystems()
    {
      this.arenaLoadingSystems.DeactivateReactiveSystems();
      this.simulationSystems.DeactivateReactiveSystems();
      this.clientOnlySystems.DeactivateReactiveSystems();
      this.rollbackSystems.DeactivateReactiveSystems();
    }

    private void ClearReactiveSystems()
    {
      this.arenaLoadingSystems.ClearReactiveSystems();
      this.simulationSystems.ClearReactiveSystems();
      this.clientOnlySystems.ClearReactiveSystems();
      this.rollbackSystems.ClearReactiveSystems();
    }

    private void CreateUniqueMetaEntities(MetaContext metaContext)
    {
      if (!metaContext.hasMetaState)
        metaContext.SetMetaState(MetaState.None);
      if (metaContext.hasMetaNetwork)
        return;
      metaContext.SetMetaNetwork(new SteelClient());
      metaContext.metaNetwork.value.SetNetworkInfoCallback(new Action<float, float, float, float, float>(this.SetEndpointInfo));
      metaContext.metaNetwork.value.OnStateChanged += (SteelClient.OnStateChangedDelegate) (state =>
      {
        MetaState metaState = this.contexts.meta.metaState.value;
        Imi.SharedWithServer.Game.MatchState matchState = this.contexts.game.matchState.value;
        Log.Netcode(string.Format("New Connection state: new State: {0} ", (object) state) + string.Format("{0} ", (object) metaState) + string.Format("{0}", (object) matchState));
        if (state != RumpfieldState.Error)
          return;
        this.events.FireEventConnectionNotOk("@ConnectionNotOkError", "{Empty error - talk to niki}");
      });
    }

    private void SetEndpointInfo(float rtt, float packetLoss, float sent, float recv, float ack)
    {
      GameEntity firstLocalEntity = this.contexts.game.GetFirstLocalEntity();
      if (firstLocalEntity == null || !firstLocalEntity.hasConnectionInfo)
        return;
      firstLocalEntity.connectionInfo.SetEndpointInfo(rtt, packetLoss, sent, recv, ack);
    }

    private static void CreateUniqueGameEntities(
      Contexts contexts,
      GameEntityFactory factory,
      PhysicsEngineConfig physicsConfig,
      MatchConfig matchConfig,
      bool createBruteForceSystem,
      uint numPlayers)
    {
      Log.Debug("Initialize Unique Entities");
      factory.CreateLocalPlayer(ImiServices.Instance.LoginService.GetPlayerId());
      contexts.game.ReplaceEventDispatcher((AEventDispatcher) new MockEventDispatcher());
      contexts.game.ReplaceMatchData(MatchTypeUtils.GetMatchType((int) numPlayers), (int) numPlayers);
      contexts.game.ReplaceGlobalTime(0.0f, 0.0f, 0, 0, 0.0f, false);
      contexts.game.ReplaceMatchState(Imi.SharedWithServer.Game.MatchState.WaitingForPlayers);
      contexts.game.ReplaceScore(Team.None, 0UL, TeamExtensions.TeamWithIntegers());
      contexts.game.ReplaceMatchConfig(matchConfig);
      World newWorld = new World(createBruteForceSystem ? (CollisionSystem) new CollisionSystemBrute() : (CollisionSystem) new CollisionSystemSAP());
      ContactSettings contactSettings = newWorld.ContactSettings;
      contactSettings.BiasFactor = physicsConfig.bias;
      contactSettings.MaximumBias = physicsConfig.maximumBias;
      contactSettings.MinimumVelocity = physicsConfig.minVelocity;
      contactSettings.AllowedPenetration = physicsConfig.allowedPenetration;
      contactSettings.BreakThreshold = physicsConfig.breakThreshold;
      contexts.game.ReplaceGamePhysics(newWorld, (Action<int, int, GameEntity, Action>) null);
      contexts.game.ReplaceCameraTarget(JVector.Zero, false);
      contexts.game.ReplaceCollisionEvents(new List<JCollision>(), new List<JCollision>(), new List<JCollision>());
      contexts.game.ReplaceDeferredCollisionEvents(new List<JCollision>(), new List<JCollision>(), new List<JCollision>());
    }

    private void AddListeners()
    {
      this.events.OnNetEventGameMessage += new Events.NetEventGameMessage(this.OnServerStateUpdate);
      this.events.OnNetEventUsernameMessage += new Events.EventNetworkEvent<UsernameMessage>(this.OnUpdatePlayerUsername);
      this.events.OnNetEventNotifyDisconnectReason += new Events.NetEventNotifyDisconnectReason(this.OnNotifyDisconnectReason);
      this.events.OnNetEventCreatePlayerMessage += new Events.NetEventCreatePlayerMessage(this.OnCreatePlayer);
      this.events.OnNetEventMatchStateMessage += new Events.NetEventMatchStateChanged(this.OnMatchStateChanged);
      this.events.OnNetEventDisconnectMessage += new Events.NetEventDisconnectMessage(this.OnPlayerDisconnected);
      this.events.OnNetEventPreMatchChangedMessage += new Events.EventNetworkEvent<PreMatchChangedMessage>(this.OnUpdatePlayerChampionData);
      this.events.OnEventMetaStateChanged += new Events.EventMetaStateChanged(this.OnMetaStateChanged);
      this.events.OnEventSelectTeam += new Events.EventSelectTeam(this.OnTeamSelected);
      this.events.OnEventSelectChampion += new Events.EventSelectChampion(this.OnChampionSelected);
      this.events.OnEventChampionSelectionReady += new Events.EventChampionSelectionReady(this.OnChampionSelectionIsReady);
      this.events.OnEventPlayerFinishedPicking += new Events.EventPlayerFinishedPicking(this.OnInstantiatePlayer);
    }

    private void RemoveListeners()
    {
      this.events.OnEventMetaStateChanged -= new Events.EventMetaStateChanged(this.OnMetaStateChanged);
      this.events.OnEventSelectTeam -= new Events.EventSelectTeam(this.OnTeamSelected);
      this.events.OnEventSelectChampion -= new Events.EventSelectChampion(this.OnChampionSelected);
      this.events.OnEventChampionSelectionReady -= new Events.EventChampionSelectionReady(this.OnChampionSelectionIsReady);
      this.events.OnEventPlayerFinishedPicking -= new Events.EventPlayerFinishedPicking(this.OnInstantiatePlayer);
      this.events.OnNetEventGameMessage -= new Events.NetEventGameMessage(this.OnServerStateUpdate);
      this.events.OnNetEventUsernameMessage -= new Events.EventNetworkEvent<UsernameMessage>(this.OnUpdatePlayerUsername);
      this.events.OnNetEventNotifyDisconnectReason -= new Events.NetEventNotifyDisconnectReason(this.OnNotifyDisconnectReason);
      this.events.OnNetEventCreatePlayerMessage -= new Events.NetEventCreatePlayerMessage(this.OnCreatePlayer);
      this.events.OnNetEventMatchStateMessage -= new Events.NetEventMatchStateChanged(this.OnMatchStateChanged);
      this.events.OnNetEventDisconnectMessage -= new Events.NetEventDisconnectMessage(this.OnPlayerDisconnected);
      this.events.OnNetEventPreMatchChangedMessage -= new Events.EventNetworkEvent<PreMatchChangedMessage>(this.OnUpdatePlayerChampionData);
    }

    private void OnNotifyDisconnectReason(DisconnectReason reason)
    {
      switch (reason)
      {
        case DisconnectReason.ConnectionWindowTimeout:
          this.events.FireEventConnectionNotOk("@APlayerCouldNotConnect", "{Empty error - talk to niki}");
          ImiServices.Instance.Analytics.OnMatchmakingFailed("APlayerCouldNotConnect");
          this.NotifyUserDisconnectPopup("@APlayerCouldNotConnect");
          break;
        case DisconnectReason.MatchAborted:
          this.events.FireEventConnectionNotOk("@MatchAborted", "{Empty error - talk to niki}");
          this.NotifyUserDisconnectTimedPopup("@MatchAborted", false);
          ImiServices.Instance.Analytics.OnMatchAborted();
          break;
        case DisconnectReason.PlayerDisconnectInLobby:
          this.events.FireEventConnectionNotOk("@APlayerHasLeftTheLobby", "{Empty error - talk to niki}");
          ImiServices.Instance.Analytics.OnMatchmakingFailed("APlayerHasLeftTheLobby");
          this.NotifyUserDisconnectPopup("@APlayerHasLeftTheLobby");
          break;
        case DisconnectReason.PlayerFailedToLoad:
          this.events.FireEventConnectionNotOk("@APlayerCouldNotLoad", "{Empty error - talk to niki}");
          ImiServices.Instance.Analytics.OnMatchmakingFailed("APlayerCouldNotLoad");
          this.NotifyUserDisconnectPopup("@APlayerCouldNotLoad");
          break;
        case DisconnectReason.PlayerFailedToGetUnlockedChampions:
          this.events.FireEventConnectionNotOk("@FailedToLoadChampUnlocks", "{Empty error - talk to niki}");
          ImiServices.Instance.Analytics.OnMatchmakingFailed("CouldNotContactMetaService");
          this.NotifyUserDisconnectPopup("@FailedToLoadChampUnlocks");
          break;
        case DisconnectReason.AFK:
          this.kicked = true;
          this.contexts.meta.metaNetwork.value.SendReliable((Message) new ConfirmInactivityKickMessage());
          this.NotifyUserDisconnectPopup("@KickedForInactivity");
          break;
        case DisconnectReason.BackfillFailed:
          this.events.FireEventConnectionNotOk("@BackfillFailed", "{Empty error - talk to niki}");
          this.NotifyUserDisconnectPopup("@BackfillFailed");
          break;
        default:
          throw new ArgumentOutOfRangeException();
      }
    }

    private void NotifyUserDisconnectTimedPopup(string locaKey, bool returnToMainMenu = true)
    {
      ImiServices.Instance.InputService.SetInputMapCategory(InputMapCategory.UI);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TimeInformationNoCountdown, (IPopupSettings) new Popup(locaKey + "Description", "OK", title: locaKey, timer: 5), returnToMainMenu ? new Action(GoBackToMainMenu) : (Action) null, returnToMainMenu ? new Action(GoBackToMainMenu) : (Action) null, (Action) null, (Action) null, (Selectable) null);
      Cursor.visible = true;

      void GoBackToMainMenu()
      {
        ImiServices.Instance.GoBackToMenu();
        PopupManager.Instance.HidePopup();
      }
    }

    private void NotifyUserDisconnectPopup(string locaKey, bool returnToMainMenu = true)
    {
      ImiServices.Instance.InputService.SetInputMapCategory(InputMapCategory.UI);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(locaKey + "Description", "OK", title: locaKey), returnToMainMenu ? new Action(GoBackToMainMenu) : (Action) null, returnToMainMenu ? new Action(GoBackToMainMenu) : (Action) null, (Action) null, (Action) null, (Selectable) null);
      Cursor.visible = true;

      void GoBackToMainMenu()
      {
        ImiServices.Instance.GoBackToMenu();
        PopupManager.Instance.HidePopup();
      }
    }

    public void OnPlayerDisconnected(ulong id, byte index)
    {
      Log.Debug(string.Format("Player {0} disconnected", (object) id));
      this.events.FireEventShowHidePlayerUi(id, false, false);
      GameEntity entityWithPlayerId = this.contexts.game.GetFirstEntityWithPlayerId(id);
      if (entityWithPlayerId == null)
        return;
      if (entityWithPlayerId.hasPlayerUsername && entityWithPlayerId.hasPlayerTeam)
      {
        Color usernameColor = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithPlayerId.playerTeam.value);
        this.events.FireEventPlayerLeft(entityWithPlayerId.playerUsername.username, usernameColor);
      }
      if (entityWithPlayerId.hasRigidbody)
        this.contexts.game.gamePhysics.world.RemoveBody(entityWithPlayerId.rigidbody.value);
      if (entityWithPlayerId.hasUnityView)
      {
        GameObject gameObject = entityWithPlayerId.unityView.gameObject;
        gameObject.Unlink();
        UnityEngine.Object.Destroy((UnityEngine.Object) gameObject);
      }
      if (entityWithPlayerId.hasSkillGraph)
      {
        foreach (SkillGraph skillStateMachine in entityWithPlayerId.GetAllSkillStateMachines())
          skillStateMachine.Destroy();
      }
      entityWithPlayerId.Destroy();
    }

    private void OnChampionSelected(ChampionType type, int skinId, bool isReady)
    {
      PlayerChampionData playerChampionData = this.contexts.game.GetFirstLocalEntity().playerChampionData.value;
      playerChampionData.type = type;
      playerChampionData.skinId = skinId;
      playerChampionData.isReady = isReady;
      this.contexts.meta.metaNetwork.value.SendReliable((Message) new ChampionSelectionChangedMessage(playerChampionData));
    }

    private void OnTeamSelected(Team team)
    {
      PlayerChampionData playerChampionData = this.contexts.game.GetFirstLocalEntity().playerChampionData.value;
      playerChampionData.team = team;
      this.contexts.meta.metaNetwork.value.SendReliable((Message) new ChampionSelectionChangedMessage(playerChampionData));
    }

    private void OnChampionSelectionIsReady()
    {
      PlayerChampionData playerChampionData = this.contexts.game.GetFirstLocalEntity().playerChampionData.value;
      playerChampionData.isReady = true;
      Log.Netcode("SEND READY");
      this.contexts.meta.metaNetwork.value.SendReliable((Message) new ChampionSelectionChangedMessage(playerChampionData));
    }

    private void OnMetaStateChanged(in MetaState metaState)
    {
      this.contexts.meta.ReplaceMetaState(metaState);
      this.world.OnMetaStateChanged(metaState);
    }

    private void OnTryToDisconnect()
    {
      if (!this.contexts.meta.metaNetwork.value.IsConnected())
        return;
      this.contexts.meta.metaNetwork.value.Disconnect();
    }

    private void OnResetState() => this.StartCoroutine(this.DoReset());

    private void ClearGameContext()
    {
      foreach (GameEntity entity in this.contexts.game.GetEntities())
      {
        if (entity.hasUnityView)
        {
          GameObject gameObject = entity.unityView.gameObject;
          entity.unityView.gameObject.Unlink();
          UnityEngine.Object.Destroy((UnityEngine.Object) gameObject);
        }
        entity.Destroy();
      }
    }

    private void OnServerStateUpdate(GameMessage message)
    {
      this.statusHeader = message.status;
      this.processServerStatus = true;
      this.world.OnGameplayState(message, this.ticker.GetDeltaTime() * 1000f);
    }

    private void Update()
    {
      if (this.kicked)
        return;
      this.ticker.Tick();
      this.Debug_ShowInfo();
      this.world.TickInput();
      this.contexts.game.globalTime.timeSinceStartOfTick += Time.deltaTime;
      if (this.contexts.game.matchState.value == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers)
        return;
      this.clientOnlySystems.Execute();
      this.clientOnlySystems.Cleanup();
    }

    private void Debug_ShowInfo()
    {
      if (!this.showDebugText)
        return;
      int tick = this.ticker.GetTick();
      int lastServerTick = this.contexts.game.globalTime.lastServerTick;
      this.text.text = string.Format("Tick - {0} {1} || {2}\n", (object) tick, (object) lastServerTick, (object) (tick - lastServerTick)) + string.Format("Network: {0}  \n", (object) Contexts.sharedInstance.meta.metaNetwork.value.GetState()) + string.Format("Meta {0} Game {1}\n", (object) this.contexts.meta.metaState.value, (object) this.contexts.game.matchState.value) + string.Format("Entitas: Meta - {0} | Game - {1}", (object) this.contexts.meta.count, (object) this.contexts.game.count);
    }

    private void OnTick(int currentTick, float timeSinceStart)
    {
      GameEntity globalTimeEntity = this.contexts.game.globalTimeEntity;
      GlobalTimeComponent globalTime = globalTimeEntity.globalTime;
      GameEntity firstLocalEntity = this.contexts.game.GetFirstLocalEntity();
      float newFixedSimTimeStep = 1f / (float) this.tickRate;
      float newTimeSinceStartOfTick = Mathf.Clamp(globalTime.timeSinceStartOfTick, -globalTime.fixedSimTimeStep, globalTime.fixedSimTimeStep) - globalTime.fixedSimTimeStep;
      globalTimeEntity.ReplaceGlobalTime(newFixedSimTimeStep, timeSinceStart, currentTick, globalTimeEntity.globalTime.lastServerTick, newTimeSinceStartOfTick, false);
      this.contexts.meta.metaNetwork.value.HandleTick((double) Time.realtimeSinceStartup);
      this.ProcessClockSync();
      if (this.contexts.meta.metaNetwork.value.IsConnected())
        this.world.SendInput(currentTick);
      if (this.contexts.meta.metaState.value == MetaState.Game)
      {
        int lastServerTick = globalTimeEntity.globalTime.lastServerTick;
        this.GoingToTheFuture(currentTick, lastServerTick, ref firstLocalEntity, ref globalTimeEntity);
        this.world.HandleRollback();
        this.simulationSystems.Execute();
        this.simulationSystems.Cleanup();
        this.world.ReplaceVisualSmoothing();
      }
      this.contexts.meta.metaNetwork.value.ForceSend((double) Time.realtimeSinceStartup);
    }

    private void ProcessClockSync()
    {
      if (!this.processServerStatus)
        return;
      this.ticker.OnClockSync(this.statusHeader.serverTick, (int) this.statusHeader.clientToServerOffset, this.contexts.meta.metaNetwork.value.GetRttt(this.tickRate), this.statusHeader.wasLastInputLate);
      this.processServerStatus = false;
    }

    private void GoingToTheFuture(int cTick, int rTick, ref GameEntity local, ref GameEntity time)
    {
      if (cTick > rTick)
        return;
      int num1 = 0;
      int num2 = cTick;
      while (cTick < rTick)
      {
        cTick = this.ticker.ForceTickIncrement();
        ++num1;
      }
      for (int index = cTick; index < rTick + 3; ++index)
        cTick = this.ticker.ForceTickIncrement();
      int num3 = cTick;
      if (local.hasInput)
      {
        for (int index = 0; index < num3 - num2 + 1; ++index)
          local.input.Duplicate(num2 + index);
      }
      float newFixedSimTimeStep = 1f / (float) this.tickRate;
      float newTimeSinceMatchStart = time.globalTime.timeSinceMatchStart + (float) num1 / (float) this.tickRate;
      float sinceStartOfTick = time.globalTime.timeSinceStartOfTick;
      int lastServerTick = time.globalTime.lastServerTick;
      time.ReplaceGlobalTime(newFixedSimTimeStep, newTimeSinceMatchStart, cTick, lastServerTick, sinceStartOfTick, false);
      Log.Warning(string.Format("Lightweight going to the future. From {0} to {1} - {2}", (object) num2, (object) (rTick + 3), (object) cTick));
    }

    private void OnDestroy()
    {
      ImiServices.Instance.OnTryToDisconnect -= new ImiServices.OnTryToDisconnectEventHandler(this.OnTryToDisconnect);
      ImiServices.Instance.OnResetState -= new ImiServices.OnResetStateEventHandler(this.OnResetState);
      ImiServices.Instance.OnConnectToGameServer -= new ImiServices.OnConnectToGameServerEventHandler(this.OnConnectToGameServer);
      ImiServices.Instance.OnConnectToServerManagerServer -= new ImiServices.OnConnectToServerManagerServerEventHandler(this.OnConnectToServerManager);
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(ImiServices.Instance.progressManager.FetchChampionUnlockInfo);
      Debug.Log((object) "Meta Destroy");
      if (this.contexts?.meta != null && this.contexts.meta.hasMetaNetwork)
      {
        SteelClient steelClient = this.contexts.meta.metaNetwork.value;
        if (steelClient.IsConnected() || steelClient.IsConnecting())
          steelClient.Disconnect();
      }
      this.serverCmdRegistry?.TearDown();
      this.RemoveListeners();
    }

    public void StartArenaLoading(string arenaName, int numPlayers)
    {
      ImiServices.Instance.isInMatchService.CurrentArena = arenaName;
      MenuController objectOfType = UnityEngine.Object.FindObjectOfType(typeof (MenuController)) as MenuController;
      if ((UnityEngine.Object) objectOfType != (UnityEngine.Object) null)
      {
        objectOfType.DisplayLobby();
        objectOfType.HideAllMenus();
        objectOfType.ClearMenuHistory();
      }
      this.contexts.game.ReplaceLoadArenaInfo(arenaName, "JSON/");
      LoadArenaSystem.LoadArena(this.contexts.game, "JSON/", arenaName);
      this.matchResourcesInitializer.LoadArena(arenaName, (Action<string, uint>) ((arenaName_, durationInMs) =>
      {
        Log.Debug("Arena " + arenaName_ + " is loaded.");
        BallCreateSystem.CreateBall(this.contexts.game, this.gameEntityFactory, this.configProvider.ballConfig);
        CreateBallViewSystem.CreateBallView(this.contexts.game, this.configProvider.ballConfig);
        this.contexts.game.ReplaceMatchData(MatchTypeUtils.GetMatchType(numPlayers), numPlayers);
        this.contexts.game.loadArenaInfoEntity.Destroy();
        this.contexts.meta.metaNetwork.value.SendReliable((Message) new ArenaLoadedMessage(arenaName_, durationInMs));
      }));
    }

    private void OnUpdatePlayerChampionData(NetworkEvent<PreMatchChangedMessage> e) => this.world.OnUpdatePlayerChampionData(e);

    private void OnUpdatePlayerUsername(NetworkEvent<UsernameMessage> e) => this.world.OnUpdatePlayerUsername(e);

    private void OnMatchStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.world.OnMatchStateChanged(matchState, cutsceneDuration, remainingMatchTime);
    }

    private void OnCreatePlayer(
      ulong playerId,
      PlayerChampionData playerChampionData,
      JVector position,
      JQuaternion rotation)
    {
      this.world.CreatePlayer(playerId, playerChampionData, position, rotation);
    }

    private void OnInstantiatePlayer(ulong playerId, ChampionType type)
    {
    }
  }
}
