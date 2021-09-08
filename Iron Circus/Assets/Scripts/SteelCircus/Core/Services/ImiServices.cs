// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.ImiServices
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using ChromaSDK;
using Imi.Game;
using Imi.SharedWithServer.Utils;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using SharedWithServer.ScEvents;
using SteelCircus.Networking;
using SteelCircus.UI;
using SteelCircus.UI.OptionsUI;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace SteelCircus.Core.Services
{
  public sealed class ImiServices
  {
    private static ImiServices instance = (ImiServices) null;
    private static readonly object padlock = new object();
    private ImiServicesHelper imiHelper;
    private bool isInitialized;
    public ILoginService LoginService;
    public LocalizationManager LocaService;
    public AMatchmakingService MatchmakingService;
    public APartyService PartyService;
    public LoadingScreenService LoadingScreenService;
    public IsInMatchService isInMatchService;
    public PatchNotesService PatchNotesService;
    public CameraManager CameraManager;
    public InputService InputService;
    public AnalyticsService Analytics;
    public VoiceChatService VoiceChatService;
    public TwitchService TwitchService;
    public QualityManager QualityManager;
    public UIProgressionService UiProgressionService;
    public ProgressManager progressManager;

    public bool IsInitialized => this.isInitialized;

    public event ImiServices.OnMetaLoginSuccessfulEventHandler OnMetaLoginSuccessful;

    public event ImiServices.OnMetaLoginUnsuccessfulEventHandler OnMetaLoginUnsuccessful;

    public event ImiServices.OnConnectToGameServerEventHandler OnConnectToGameServer;

    public event ImiServices.OnConnectToServerManagerServerEventHandler OnConnectToServerManagerServer;

    public event ImiServices.OnTryToDisconnectEventHandler OnTryToDisconnect;

    public event ImiServices.OnResetStateEventHandler OnResetState;

    private ImiServices()
    {
    }

    private void OnLoginError(string errorMessage)
    {
      Imi.Diagnostics.Log.Error("Login failed: " + errorMessage);
      this.LoginService.SetLoginFailed();
      ImiServices.OnMetaLoginUnsuccessfulEventHandler loginUnsuccessful = this.OnMetaLoginUnsuccessful;
      if (loginUnsuccessful == null)
        return;
      loginUnsuccessful(errorMessage);
    }

    private void OnLoginSuccessful(ulong playerId)
    {
      Imi.Diagnostics.Log.Debug("Login successful " + (object) playerId);
      this.Analytics.Initialize(playerId);
      ImiServices.OnMetaLoginSuccessfulEventHandler metaLoginSuccessful = this.OnMetaLoginSuccessful;
      if (metaLoginSuccessful == null)
        return;
      metaLoginSuccessful(playerId);
    }

    private void OnClientVersionMismatch(string currentClientVersion)
    {
      Imi.Diagnostics.Log.Debug("Login failed because of Version Mismatch: " + currentClientVersion + "\nYour Version is: 20191126-216_live_Update_0.8");
      ImiServices.OnMetaLoginUnsuccessfulEventHandler loginUnsuccessful = this.OnMetaLoginUnsuccessful;
      if (loginUnsuccessful == null)
        return;
      loginUnsuccessful("Login failed because of Version Mismatch: " + currentClientVersion + " Your Version is: 20191126-216_live_Update_0.8");
    }

    public static ImiServices Instance
    {
      get
      {
        lock (ImiServices.padlock)
        {
          if (ImiServices.instance == null)
            ImiServices.instance = new ImiServices();
          return ImiServices.instance;
        }
      }
    }

    public static void Create()
    {
      if (ImiServices.Instance.IsInitialized)
        return;
      Stopwatch stopwatch = Stopwatch.StartNew();
      Imi.Diagnostics.Log.Debug("ImiServices creation started.");
      try
      {
        Imi.Diagnostics.Log.Debug("ChromaSDK Init.");
        if (ChromaAnimationAPI.Init() == 0)
          RazerChromaHelper.LoadAndCacheRazerAnimations();
      }
      catch (Exception ex)
      {
        Imi.Diagnostics.Log.Error(ex.ToString());
      }
      ImiServicesHelper imiHelper = new GameObject("ImiServicesHelper").AddComponent<ImiServicesHelper>();
      imiHelper.DontDestroyOnLoad();
      ImiServices.Instance.Initialize(imiHelper);
      Imi.Diagnostics.Log.Debug(string.Format("ImiServices creation finished: {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }

    private void Initialize(ImiServicesHelper imiHelper)
    {
      this.imiHelper = imiHelper;
      imiHelper.StartEvent += new Action(this.OnStart);
      imiHelper.UpdateEvent += new Action(this.OnUpdate);
      imiHelper.ApplicationQuitEvent += new Action(this.OnApplicationQuit);
      AwsPinger.PingAll((MonoBehaviour) imiHelper);
      foreach (KeyValuePair<string, long> regionLatency in AwsPinger.RegionLatencies)
        Imi.Diagnostics.Log.Debug(regionLatency.Key + " " + (object) regionLatency.Value);
      Application.backgroundLoadingPriority = ThreadPriority.BelowNormal;
      this.InitializeQualityManager();
      ImiServices.InitializeMemoryManager();
      this.InitializeLocalizationService();
      this.InitializeMatchmakingService();
      this.InitializePartyService();
      this.InitializeLoginService();
      this.LoadingScreenService = new LoadingScreenService();
      this.InitializeIsInMatchService();
      this.InitializePatchNotesService();
      this.InitializeInputService();
      this.InitializeAnalyticsService();
      this.InitializeVoiceChatService();
      this.InitializeTwitchService();
      this.InitializeUiProgressionService();
      Imi.Diagnostics.Log.Debug("ProgressManager creation started.");
      this.progressManager = new ProgressManager(imiHelper);
      Imi.Diagnostics.Log.Debug("ProgressManager creation finished.");
      this.isInitialized = true;
    }

    public bool IsInMainMenu() => (UnityEngine.Object) MenuController.Instance != (UnityEngine.Object) null && MenuController.isInMenu;

    private void InitializeUiProgressionService() => this.UiProgressionService = new UIProgressionService(this.imiHelper);

    private void InitializeTwitchService() => this.TwitchService = new TwitchService(this.imiHelper);

    private void InitializeVoiceChatService()
    {
      this.VoiceChatService = new VoiceChatService(this.imiHelper);
      this.VoiceChatService.UpdateVCSettings(VoiceChatOptionsController.LoadSettingsFromPlayerPrefs());
    }

    private void InitializeAnalyticsService() => this.Analytics = new AnalyticsService();

    public void InitializeAssetsForUnityEditor()
    {
    }

    public IEnumerator LoadAssetsAfterLogin()
    {
      yield return (object) null;
    }

    public static void InitializeSingletonConfigs()
    {
      Imi.Diagnostics.Log.Debug("Loading SingletonScriptableObject Configs started.");
      UnityEngine.Resources.Load<ItemsConfig>("Configs/Items/ItemsConfig");
      Imi.Diagnostics.Log.Debug("ItemConfig " + ((UnityEngine.Object) SingletonScriptableObject<ItemsConfig>.Instance == (UnityEngine.Object) null ? "is Null!" : "was successfuly loaded."));
      UnityEngine.Resources.Load<ChampionConfigProvider>("Configs/ChampionConfigProvider");
      Imi.Diagnostics.Log.Debug("ChampionConfigProvider " + ((UnityEngine.Object) SingletonScriptableObject<ChampionConfigProvider>.Instance == (UnityEngine.Object) null ? "is Null!" : "was successfuly loaded."));
    }

    private void InitializeQualityManager() => this.QualityManager = new QualityManager(this.imiHelper);

    private static void InitializeMemoryManager() => new GameObject("MemoryManager").AddComponent<MemoryManager>();

    private void OnUpdate()
    {
      this.MatchmakingService.OnUpdate();
      this.InputService?.PollInputData();
    }

    private void OnApplicationQuit()
    {
      Imi.Diagnostics.Log.Debug("Closing");
      try
      {
        ChromaAnimationAPI.Uninit();
        Imi.Diagnostics.Log.Debug("Chroma.. done");
      }
      catch (Exception ex)
      {
        Imi.Diagnostics.Log.Error(ex.ToString());
      }
      this.PartyService.LeaveGroup();
      Imi.Diagnostics.Log.Debug("Steam.. done");
      this.MatchmakingService.CancelMatchmaking();
      this.MatchmakingService.Quit();
      Imi.Diagnostics.Log.Debug("MatchmakingService.. done");
      this.InputService.Cleanup();
      Imi.Diagnostics.Log.Debug("InputService.. done");
      this.Analytics.OnQuit();
      Imi.Diagnostics.Log.Debug("Analytics.. done");
    }

    private void OnStart()
    {
      if (this.LoginService.IsLoginOk())
        return;
      this.LoginService.Connect();
    }

    public void ConnectToGameServer(ConnectionInfo connectionInfo, byte[] token)
    {
      Imi.Diagnostics.Log.Debug(string.Format("Connecting to game server: PlayerId: {0} ip:{1}:{2}", (object) connectionInfo.playerId, (object) connectionInfo.ip, (object) connectionInfo.port));
      connectionInfo.connectToken = token;
      ImiServices.OnConnectToGameServerEventHandler connectToGameServer = this.OnConnectToGameServer;
      if (connectToGameServer == null)
        return;
      connectToGameServer(connectionInfo);
    }

    public void ConnectToServerManagerServer(ConnectionInfo connectionInfo)
    {
      Imi.Diagnostics.Log.Debug(string.Format("Connecting to Server Manager server: PlayerId: {0} ip:{1}:{2}", (object) connectionInfo.playerId, (object) connectionInfo.ip, (object) connectionInfo.port));
      ImiServices.OnConnectToServerManagerServerEventHandler serverManagerServer = this.OnConnectToServerManagerServer;
      if (serverManagerServer == null)
        return;
      serverManagerServer(connectionInfo);
    }

    public void GoBackToMenu()
    {
      double time = (double) Time.time;
      ImiServices.Instance.LoadingScreenService.ShowLoadingScreen(LoadingScreenService.LoadingScreenIntent.loadingMainMenu);
      if (this.VoiceChatService.IsInVoiceChannel() && (!CustomLobbyUi.isInitialized || CustomLobbyUi.isInitialized && CustomLobbyUi.isAborted))
        ImiServices.instance.VoiceChatService.LeaveVoiceChannel();
      string sceneName = "SC_MainMenu";
      Imi.Diagnostics.Log.Debug("Going back to menu and reloading the Scene: " + sceneName + "  " + new StackTrace().ToString());
      Events global = Events.Global;
      MetaState metaState = MetaState.None;
      ref MetaState local = ref metaState;
      global.FireEventMetaStateChanged(in local);
      ImiServices.Instance.isInMatchService.IsPlayerInMatch = false;
      SceneManager.LoadScene(sceneName, LoadSceneMode.Single);
      ImiServices.OnTryToDisconnectEventHandler onTryToDisconnect = this.OnTryToDisconnect;
      if (onTryToDisconnect != null)
        onTryToDisconnect();
      ImiServices.OnResetStateEventHandler onResetState = this.OnResetState;
      if (onResetState != null)
        onResetState();
      ImiServices.Instance.CameraManager.ActivateCamera(Imi.SteelCircus.CameraSystem.CameraType.MenuUICamera);
    }

    public void LoginSessionExpiredPopup() => PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("Your Login Session expired!\n You need to Login again!", "OK", title: "LOGIN EXPIRED!"), (Action) (() =>
    {
      this.GoBackToConnectionScreen();
      PopupManager.Instance.HidePopup();
    }), (Action) null, (Action) null, (Action) null, (Selectable) null);

    public void GoBackToConnectionScreen()
    {
      SceneManager.LoadScene("SC_ConnectionScreen", LoadSceneMode.Single);
      this.LoginService.Connect();
    }

    private void ConnectAfterMatchmaking(ConnectionInfo connectionInfo)
    {
      Imi.Diagnostics.Log.Debug("Matchmaking is finished - Fetching ConnectToken..");
      SingletonManager<MetaServiceHelpers>.Instance.GetConnectTokenFromService(connectionInfo, new Action<ConnectionInfo, byte[]>(this.ConnectToGameServer), new Action(this.MatchmakingService.RaiseOnMatchmakingCancelled));
    }

    private void InitializePartyService()
    {
      Imi.Diagnostics.Log.Debug("InitializePartyService started.");
      this.PartyService = (APartyService) new SteelCircus.Core.Services.PartyService((AGroup) new SteamGroup());
      Imi.Diagnostics.Log.Debug("InitializePartyService finished.");
    }

    private void InitializeMatchmakingService()
    {
      Imi.Diagnostics.Log.Debug("InitializeMatchmakingService started.");
      this.MatchmakingService = (AMatchmakingService) new SteelCircus.Core.Services.MatchmakingService((MonoBehaviour) this.imiHelper, new Action<ConnectionInfo>(this.ConnectAfterMatchmaking));
      Imi.Diagnostics.Log.Debug("InitializeMatchmakingService finished.");
    }

    private void InitializeLoginService()
    {
      Imi.Diagnostics.Log.Debug("InitializeLoginService started");
      this.LoginService = (ILoginService) new SteamLoginService((MonoBehaviour) this.imiHelper, new Action<ulong>(this.OnLoginSuccessful), new Action<string>(this.OnLoginError), new Action<string>(this.OnClientVersionMismatch));
      Imi.Diagnostics.Log.Debug("InitializeLoginService finished");
    }

    public static ulong GeneratePlayerIdAsInt(string dbgUsername)
    {
      ulong sHashed;
      SimpleHash.FromString(dbgUsername, out sHashed);
      int num = (int) sHashed;
      if (num < 0)
        num *= -1;
      Imi.Diagnostics.Log.Debug(string.Format("Generated a Debug PlayerId: {0}", (object) num));
      return (ulong) num;
    }

    private void InitializeLocalizationService()
    {
      this.LocaService = new LocalizationManager();
      this.LocaService.LoadLocalizedText("localization.tsv", false);
    }

    private void InitializeIsInMatchService()
    {
      Imi.Diagnostics.Log.Debug("InitializeIsInMatchService creation started.");
      this.isInMatchService = new IsInMatchService();
      this.isInMatchService.IsPlayerInMatch = false;
      Imi.Diagnostics.Log.Debug("InitializeIsInMatchService creation finished.");
    }

    private void InitializePatchNotesService()
    {
      Imi.Diagnostics.Log.Debug("InitializePatchNotesService creation started.");
      this.PatchNotesService = new PatchNotesService();
      Imi.Diagnostics.Log.Debug("InitializePatchNotesService creation finished.");
    }

    private void InitializeInputService()
    {
      this.InputService = new InputService();
      this.InputService.Initialize((short) 0, (MonoBehaviour) this.imiHelper);
    }

    public IEnumerator LoadCameraManagerAsync(
      Action<GameObject> OnCameraManagerPrefabLoaded)
    {
      Stopwatch stopwatch = Stopwatch.StartNew();
      ResourceRequest cameraManagerResource = UnityEngine.Resources.LoadAsync<GameObject>("Prefabs/Camera/CameraManager");
      while (!cameraManagerResource.isDone)
        yield return (object) null;
      Action<GameObject> action = OnCameraManagerPrefabLoaded;
      if (action != null)
        action(cameraManagerResource.asset as GameObject);
      Imi.Diagnostics.Log.Debug(string.Format("LoadCameraManagerAsync Resources Load . {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }

    public void InitializeCameraManagerAsync(GameObject cameraManagerPrefab)
    {
      Stopwatch stopwatch = Stopwatch.StartNew();
      this.CameraManager = UnityEngine.Object.Instantiate<GameObject>(cameraManagerPrefab).GetComponent<CameraManager>();
      Imi.Diagnostics.Log.Debug(string.Format("InitializeCameraManagerAsync creation finished. {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }

    public void InitializeCameraManager()
    {
      Stopwatch stopwatch1 = Stopwatch.StartNew();
      Stopwatch stopwatch2 = Stopwatch.StartNew();
      Imi.Diagnostics.Log.Debug("InitializeCameraManager creation started.");
      GameObject original = UnityEngine.Resources.Load<GameObject>("Prefabs/Camera/CameraManager");
      Imi.Diagnostics.Log.Debug(string.Format("InitializeCameraManager Resources Load . {0}", (object) (uint) stopwatch2.Elapsed.TotalMilliseconds));
      Stopwatch stopwatch3 = Stopwatch.StartNew();
      this.CameraManager = UnityEngine.Object.Instantiate<GameObject>(original).GetComponent<CameraManager>();
      Imi.Diagnostics.Log.Debug(string.Format("InitializeCameraManager GameObject instantiation. {0}", (object) (uint) stopwatch3.Elapsed.TotalMilliseconds));
      Imi.Diagnostics.Log.Debug(string.Format("InitializeCameraManager creation finished. {0}", (object) (uint) stopwatch1.Elapsed.TotalMilliseconds));
    }

    public delegate void OnMetaLoginSuccessfulEventHandler(ulong playerId);

    public delegate void OnMetaLoginUnsuccessfulEventHandler(string errorMessage);

    public delegate void OnConnectToGameServerEventHandler(ConnectionInfo connectionInfo);

    public delegate void OnConnectToServerManagerServerEventHandler(ConnectionInfo connectionInfo);

    public delegate void OnTryToDisconnectEventHandler();

    public delegate void OnResetStateEventHandler();
  }
}
