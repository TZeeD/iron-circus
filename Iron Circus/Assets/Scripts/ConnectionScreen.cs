// Decompiled with JetBrains decompiler
// Type: ConnectionScreen
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using SteelCircus.UI.OptionsUI;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class ConnectionScreen : MonoBehaviour
{
  public float timeToWaitBeforeTransition;
  [SerializeField]
  private LoggingInUi loginScreen;
  [SerializeField]
  private MaintenanceUi maintanaceScreen;
  [SerializeField]
  private string customerSupportUrl;
  [SerializeField]
  private GameObject Camera;
  [SerializeField]
  private GameObject ExitBtn;
  [SerializeField]
  private Animator connectionScreenAnimator;
  [SerializeField]
  private AudioMixer audioMixer;
  private bool gotUnlockedChampions;
  private bool gotItemDefinitions = true;
  private List<IPopupSettings> popupList = new List<IPopupSettings>();
  private int popupIndex;

  private void Awake()
  {
    Log.Debug("ConnectionScreen Awake");
    this.LoadSettings();
    ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
    ImiServices.Instance.OnMetaLoginUnsuccessful += new ImiServices.OnMetaLoginUnsuccessfulEventHandler(this.OnMetaLoginUnsuccessful);
    SceneManager.sceneLoaded += new UnityAction<Scene, LoadSceneMode>(this.OnSceneLoaded);
  }

  private void Start()
  {
    Log.Debug("Loading Audio Settings)");
    this.LoadAudioSettingsSettings();
  }

  private void LoadSettings()
  {
    Log.Debug("Loading Display Settings");
    DisplaySettings.LoadDisplaySettingsFromPlayerPrefs();
    Log.Debug("Loading Rumble Settings");
    RumbleSettings.LoadRumbleSettings();
  }

  private void OnDestroy()
  {
    ImiServices.Instance.OnMetaLoginSuccessful -= new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
    ImiServices.Instance.OnMetaLoginUnsuccessful -= new ImiServices.OnMetaLoginUnsuccessfulEventHandler(this.OnMetaLoginUnsuccessful);
    SceneManager.sceneLoaded -= new UnityAction<Scene, LoadSceneMode>(this.OnSceneLoaded);
  }

  private void OnSceneLoaded(Scene scene, LoadSceneMode loadMode)
  {
    Log.Debug("Scene " + scene.name + " was Loaded.");
    if (!(scene.name == "SC_MainMenu") && !(scene.name == "SC_DevMenu"))
      return;
    this.ExitBtn.SetActive(false);
    SceneManager.SetActiveScene(scene);
    Log.Debug("Unloading SC_ConnectionScreen.");
    this.connectionScreenAnimator.SetTrigger("Transition");
    this.Invoke("RemoveConnectionScreen", 1f);
  }

  private void RemoveConnectionScreen() => SceneManager.UnloadSceneAsync("SC_ConnectionScreen");

  private void OnMetaLoginUnsuccessful(string errormessage)
  {
    Log.Debug("ConnectionScreen OnMetaLoginUnsuccessful: " + errormessage);
    bool banned = false;
    if (errormessage != "maintenance" && errormessage != "banned")
      this.popupList.Add((IPopupSettings) new Popup(errormessage, "Close", title: "LOGIN FAILED"));
    else if (errormessage == "banned")
      banned = true;
    this.maintanaceScreen.gameObject.SetActive(true);
    this.StartCoroutine(this.LoadFurtherResources(false, banned));
  }

  private void OnMetaLoginSuccessful(ulong playerid)
  {
    Log.Debug(string.Format("ConnectionScreen OnMetaLoginSuccessful: {0}", (object) playerid));
    if (playerid == 0UL)
      return;
    this.StartCoroutine(this.LoadFurtherResources(true));
  }

  private IEnumerator LoadFurtherResources(bool loginSuccessful, bool banned = false)
  {
    ConnectionScreen connectionScreen = this;
    yield return (object) null;
    Log.Debug("Login Was:" + (loginSuccessful ? " Successful. Starting to Load Assets." : " Unsuccessful."));
    connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenSetupSystems"));
    yield return (object) connectionScreen.StartCoroutine(StartupSetup.LoadSetupConfigAsync(new Action<SetupConfig>(StartupSetup.Initialize)));
    StartupSetup.RewiredSetup();
    connectionScreen.ExitBtn.SetActive(true);
    connectionScreen.ExitBtn.GetComponent<Selectable>().Select();
    if (banned)
    {
      // ISSUE: reference to a compiler-generated method
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@BannedDescription", "@SupportButton", title: "@BannedTitle"), new Action(connectionScreen.\u003CLoadFurtherResources\u003Eb__20_0), (Action) null, (Action) null, (Action) null, (Selectable) null);
    }
    connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenSetupCamera"));
    if ((UnityEngine.Object) ImiServices.Instance.CameraManager == (UnityEngine.Object) null)
      yield return (object) connectionScreen.StartCoroutine(ImiServices.Instance.LoadCameraManagerAsync(new Action<GameObject>(ImiServices.Instance.InitializeCameraManagerAsync)));
    connectionScreen.Camera.SetActive(false);
    connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenLoadingAssets"));
    yield return (object) connectionScreen.StartCoroutine(StartupSetup.LoadConfigsAsync());
    if (loginSuccessful)
    {
      connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenLoadingItemDefinitions"));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.GetAllItemDefinitions(new Action<JObject, Action<string>>(SingletonScriptableObject<ItemsConfig>.Instance.OnImportItemDefinitions), new Action<string>(connectionScreen.OnItemsConfigMatchError)));
      SingletonScriptableObject<ItemsConfig>.Instance.CreateDictionaries();
    }
    if (connectionScreen.popupList.Count > 0 && (!loginSuccessful || !connectionScreen.gotItemDefinitions))
      connectionScreen.ShowNextPopup();
    if (loginSuccessful && connectionScreen.gotItemDefinitions)
    {
      connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenLoadingPlayerData"));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.CheckDlcStatus(new Action<JObject>(ImiServices.Instance.Analytics.BuyChampionDlcGameAnalyticsEvent)));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.GetItemSubset(ImiServices.Instance.LoginService.GetPlayerId(), ShopManager.ShopItemType.champion, new Action<JObject, ShopManager.ShopItemType>(connectionScreen.OnChampionsLockStateReceived), new Action<JObject, ShopManager.ShopItemType>(connectionScreen.OnChampionsLockStateError)));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.GetAllItemsForPlayer(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(ImiServices.Instance.progressManager.OnFetchedAllItems)));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.GetPlayerLoadout(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(ImiServices.Instance.progressManager.OnFetchedPlayerLoadout)));
      yield return (object) connectionScreen.StartCoroutine(MetaServiceHelpers.GetPlayerProgress(ImiServices.Instance.LoginService.GetPlayerId(), new Action<ulong, JObject>(ImiServices.Instance.progressManager.OnFetchedPlayerProgress)));
      yield return (object) connectionScreen.StartCoroutine(ImiServices.Instance.progressManager.LoadQuestProgressTask());
      yield return (object) connectionScreen.StartCoroutine(ImiServices.Instance.TwitchService.LoadTwitchInfo());
      ImiServices.Instance.Analytics.OnAppStart();
      if (connectionScreen.gotUnlockedChampions)
      {
        connectionScreen.SaveLastClientVersionLocally();
        connectionScreen.loginScreen.SetLoadingText(ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectionscreenLoadingMainMenu"));
        yield return (object) connectionScreen.StartCoroutine(connectionScreen.GoToMenu(connectionScreen.timeToWaitBeforeTransition));
      }
    }
  }

  private void ShowNextPopup()
  {
    if (!this.ArePopupsLeftToDisplay())
    {
      PopupManager.Instance.HidePopup();
    }
    else
    {
      IPopupSettings popup = this.popupList[this.popupIndex];
      ++this.popupIndex;
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, popup, new Action(this.ShowNextPopup), (Action) null, (Action) null, (Action) null, (Selectable) null);
    }
  }

  private bool ArePopupsLeftToDisplay() => this.popupIndex < this.popupList.Count;

  private void OnItemsConfigMatchError(string errorMsg)
  {
    this.popupList.Add((IPopupSettings) new Popup("Error Loading Item Definitions", "Close", title: "ITEM ERROR"));
    Log.Error(errorMsg);
  }

  private void OnChampionsLockStateError(JObject obj, ShopManager.ShopItemType itemType)
  {
    if (obj == null)
      this.popupList.Add((IPopupSettings) new Popup("THe client could not establish a connection to the Progression Service!", "Retry", title: "CONTACTING SERVICES FAILED"));
    else if (obj["error"] != null)
      this.popupList.Add((IPopupSettings) new Popup(obj["error"].ToString(), "Retry", title: "SERVICE RETURNED ERROR"));
    else
      this.popupList.Add((IPopupSettings) new Popup(obj.ToString(), "Retry", title: "SERVICE RETURNED MALFORMED ERROR"));
  }

  private void OnChampionsLockStateReceived(JObject obj, ShopManager.ShopItemType itemType)
  {
    if (!ImiServices.Instance.progressManager.ParseChampionUnlockInfo(obj))
      return;
    this.gotUnlockedChampions = true;
  }

  private IEnumerator GoToMenu(float time)
  {
    ConnectionScreen connectionScreen = this;
    yield return (object) new WaitForSeconds(time);
    yield return (object) connectionScreen.StartCoroutine(connectionScreen.LoadArenaAsyncScene("SC_MainMenu", LoadSceneMode.Additive));
  }

  public IEnumerator LoadArenaAsyncScene(string scene, LoadSceneMode mode)
  {
    AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(scene, mode);
    yield return (object) null;
    while (!asyncLoad.isDone)
      yield return (object) null;
    yield return (object) null;
  }

  private void SaveLastClientVersionLocally()
  {
    string key = "ClientVersion";
    if (PlayerPrefs.HasKey(key) && !(PlayerPrefs.GetString(key) != "20191126-216_live_Update_0.8"))
      return;
    PlayerPrefs.SetString(key, "20191126-216_live_Update_0.8");
    ImiServices.Instance.PatchNotesService.SetFirstStartWithCurrentVersion();
  }

  private void LoadAudioSettingsSettings()
  {
    Log.Debug("Loading AudioSettings from PlayerPrefs.");
    if (PlayerPrefs.HasKey("MasterVolume"))
      this.audioMixer.SetFloat("Master", AudioSettingsController.ConvertLinearToDecibel(PlayerPrefs.GetFloat("MasterVolume")));
    else
      this.audioMixer.SetFloat("Master", AudioSettingsController.ConvertLinearToDecibel(50f));
    if (PlayerPrefs.HasKey("MusicVolume"))
      this.audioMixer.SetFloat("MUSIC", AudioSettingsController.ConvertLinearToDecibel(PlayerPrefs.GetFloat("MusicVolume")));
    if (!PlayerPrefs.HasKey("SFXVolume"))
      return;
    this.audioMixer.SetFloat("SFX ALL", AudioSettingsController.ConvertLinearToDecibel(PlayerPrefs.GetFloat("SFXVolume")));
  }
}
