// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MenuController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.UI.Network;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class MenuController : MonoBehaviour
  {
    public static bool isInMenu = false;
    public static bool firstTimeInMenu = true;
    public UnityEvent EnteredMenuEvent;
    public UnityEvent ButtonPageGeneratedEvent;
    [SerializeField]
    private GameObject background;
    [SerializeField]
    private GameObject userProfile;
    [SerializeField]
    public GameObject navigator;
    [Header("Turntables")]
    [SerializeField]
    public GameObject mainMenuTurntable;
    public GameObject championGalleryTurntable;
    [Header("Menu Objects")]
    public MenuObject mainMenuPanel;
    public MenuObject championGallery;
    public MenuObject championPage;
    public MenuObject optionsMenu;
    public MenuObject controlsView;
    public MenuObject shopMenu;
    public MenuObject shopBuyPanel;
    public MenuObject playMenu;
    public MenuObject slotEquipMenu;
    public MenuObject playerProfile;
    public LoadoutNavigation LoadoutNavigation;
    [Header("Special UI")]
    [SerializeField]
    private GameObject specialUi;
    public ButtonFocusManager buttonFocusManager;
    [SerializeField]
    private Button inviteButton;
    [SerializeField]
    private Animator champInfoAnimator;
    [SerializeField]
    private AudioMixer audioMixer;
    private InputService input;
    private bool loginWasSuccessful;
    private Stack<MenuObject> menuStack;
    public bool logMenuPass;
    public MenuObject[] debugMenuStackDisplay;
    private IPopupSettings popupSettings;
    public MenuObject currentMenu;
    private static MenuController _instance;

    public static MenuController Instance => MenuController._instance;

    private void Update() => this.LogMenuStack();

    private void Awake()
    {
      if ((UnityEngine.Object) MenuController._instance != (UnityEngine.Object) null && (UnityEngine.Object) MenuController._instance != (UnityEngine.Object) this)
        UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
      else
        MenuController._instance = this;
      Log.Debug("Menucontroller Awake: OnMetaLogin subscribe.");
      ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      ImiServices.Instance.OnMetaLoginUnsuccessful += new ImiServices.OnMetaLoginUnsuccessfulEventHandler(this.OnMetaLoginUnsuccessful);
      this.EnteredMenuEvent = new UnityEvent();
      this.ButtonPageGeneratedEvent = new UnityEvent();
      this.input = ImiServices.Instance.InputService;
      this.menuStack = new Stack<MenuObject>();
    }

    private void Start()
    {
      ImiServices.Instance.LoadingScreenService.SetSceneLoadingComplete("SC_MainMenu");
      Log.Debug("Menucontroller Start.");
      ImiServices.Instance.isInMatchService.IsPlayerInMatch = false;
      SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged += new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
      this.EnteredMenuEvent.AddListener(new UnityAction(this.OnEnteredMenu));
      if (ImiServices.Instance.LoginService.IsLoginOk())
      {
        Log.Debug("Menucontroller: Login is OK, Removing Connection screen.");
        this.SetLoginSuccessful(true);
        this.RemoveLoginPanel();
        this.specialUi.SetActive(true);
        Log.Debug("Entering Menu for the first time: " + MenuController.firstTimeInMenu.ToString());
        if (MenuController.firstTimeInMenu)
        {
          ImiServices.Instance.UiProgressionService.UpdateUIProgressionState();
          this.DisplayMainMenu();
          MenuController.firstTimeInMenu = false;
        }
      }
      RazerChromaHelper.ExecuteRazerAnimationForTeam(Team.None);
    }

    private void OnEnable()
    {
      MenuController.isInMenu = true;
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen += new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
    }

    private void OnDisable()
    {
      MenuController.isInMenu = false;
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.OnShowLoadingScreen);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen -= new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
    }

    private void OnShowLoadingScreen(LoadingScreenService.LoadingScreenIntent intent)
    {
      this.DisplayLobby();
      this.HideAllMenus();
      this.ClearMenuHistory();
    }

    private void OnHideLoadingScreen()
    {
      if (!MenuController.isInMenu)
        return;
      if (!AudioController.IsPlaying("MusicMainMenu"))
        AudioController.PlayMusic("MusicMainMenu");
      if (MenuController.firstTimeInMenu)
        return;
      this.menuStack.Push(this.mainMenuPanel);
      if (CustomLobbyUi.isInitialized)
        return;
      this.playMenu.ActualShowMenu(MenuObject.animationType.changeInstantly, false);
    }

    private void OnDestroy()
    {
      SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged -= new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
      ImiServices.Instance.OnMetaLoginSuccessful -= new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      ImiServices.Instance.OnMetaLoginUnsuccessful -= new ImiServices.OnMetaLoginUnsuccessfulEventHandler(this.OnMetaLoginUnsuccessful);
      this.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnEnteredMenu));
    }

    private void OnEnteredMenu()
    {
      if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
        this.GetComponent<GraphicRaycaster>().enabled = false;
      else
        this.GetComponent<GraphicRaycaster>().enabled = true;
    }

    private void OnMetaLoginSuccessful(ulong playerId)
    {
      Log.Debug("Login successful [MenuController]: " + (object) playerId);
      this.SetLoginSuccessful(true);
      if (playerId == 0UL)
        return;
      this.RemoveLoginPanel();
      this.DisplayMainMenu();
    }

    private void OnMetaLoginUnsuccessful(string errormessage)
    {
      Log.Debug("Login Failed: " + errormessage);
      this.SetLoginSuccessful(false);
    }

    private void OnGameStateChangedEvent(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      if (matchState != Imi.SharedWithServer.Game.MatchState.Intro)
        return;
      Debug.Log((object) "MatchState.Intro in MenuController");
      this.HideUserProfile();
    }

    private void CheckRaycast()
    {
      if (!Input.GetKeyDown(KeyCode.Mouse0))
        return;
      GraphicRaycaster component = this.GetComponent<GraphicRaycaster>();
      PointerEventData pointerEventData = new PointerEventData(this.GetComponent<EventSystem>());
      pointerEventData.position = (Vector2) Input.mousePosition;
      List<RaycastResult> raycastResultList = new List<RaycastResult>();
      PointerEventData eventData = pointerEventData;
      List<RaycastResult> resultAppendList = raycastResultList;
      component.Raycast(eventData, resultAppendList);
      foreach (RaycastResult raycastResult in raycastResultList)
      {
        string str = raycastResult.gameObject.name;
        GameObject gameObject = raycastResult.gameObject;
        while ((UnityEngine.Object) gameObject.transform.parent != (UnityEngine.Object) null)
        {
          gameObject = gameObject.transform.parent.gameObject;
          str = gameObject.name + "/" + str;
        }
        Debug.Log((object) ("Hit " + str));
      }
    }

    public void SetLoginSuccessful(bool success) => this.loginWasSuccessful = success;

    public void ClearMenuHistory() => this.menuStack = new Stack<MenuObject>();

    private void HideUserProfile() => this.userProfile.SetActive(false);

    public void EnableUiInputMap() => this.input.SetInputMapCategory(InputMapCategory.UI);

    public void RemoveLoginPanel()
    {
      if (!this.loginWasSuccessful)
        return;
      this.navigator.SetActive(true);
      this.HideAllMenus();
    }

    public void DisplayMainMenu()
    {
      this.mainMenuPanel.gameObject.SetActive(true);
      this.mainMenuPanel.GetComponent<MenuObject>().ShowMenu(2);
    }

    public void EnableInputDelayed(float delay) => this.StartCoroutine(this.EnableInputDelayedCoroutine(delay));

    public IEnumerator EnableInputDelayedCoroutine(float delay)
    {
      yield return (object) new WaitForSeconds(delay);
      Log.Debug("EnableInputDelayed ");
      this.EnableUiInputMap();
    }

    public void DisplayLobby()
    {
      this.mainMenuPanel.gameObject.SetActive(false);
      this.background.SetActive(false);
    }

    public void HideAllMenus()
    {
      foreach (MenuObject componentsInChild in this.transform.GetComponentsInChildren<MenuObject>())
        componentsInChild.HideMenu(2, false);
    }

    public void HideAllButCurrent()
    {
      if (this.currentMenu.layeredMenu)
        return;
      foreach (MenuObject componentsInChild in this.transform.GetComponentsInChildren<MenuObject>())
      {
        if ((UnityEngine.Object) componentsInChild != (UnityEngine.Object) this.currentMenu)
          componentsInChild.HideMenu(2, false);
      }
    }

    public void DisableMainMenus()
    {
      foreach (Component componentsInChild in this.transform.GetComponentsInChildren<SubPanelObject>())
        componentsInChild.gameObject.SetActive(false);
      foreach (Component componentsInChild in this.transform.GetComponentsInChildren<MenuObject>())
        componentsInChild.gameObject.SetActive(false);
      this.mainMenuTurntable.SetActive(false);
      this.championGalleryTurntable.gameObject.SetActive(false);
      this.navigator.GetComponent<SimplePromptSwitch>().HideAllButtons();
    }

    public void AddMenuToStack(MenuObject previousMenu) => this.menuStack.Push(previousMenu);

    public MenuObject MenuStackPeek() => this.menuStack.Peek();

    private void LogMenuStack()
    {
      if (!this.logMenuPass)
        return;
      this.debugMenuStackDisplay = this.menuStack.ToArray();
    }

    public void GoToPreviousMenu()
    {
      MenuObject menuObject;
      if (this.menuStack.Count == 0)
      {
        if ((UnityEngine.Object) this.currentMenu == (UnityEngine.Object) this.mainMenuPanel.GetComponent<MenuObject>())
          return;
        menuObject = this.mainMenuPanel.GetComponent<MenuObject>();
      }
      else
      {
        while ((UnityEngine.Object) this.currentMenu == (UnityEngine.Object) this.menuStack.Peek())
          this.menuStack.Pop();
        menuObject = this.menuStack.Pop();
      }
      AudioController.Play("Back");
      menuObject.GetComponent<MenuObject>().ReturnToMenu(1);
    }

    public void HideLayeredMenu()
    {
      Debug.Log((object) "Hide Layered menu!");
      if (this.menuStack.Count == 0 || !this.currentMenu.GetComponent<MenuObject>().layeredMenu)
        return;
      this.currentMenu.GetComponent<MenuObject>().HideLayeredMenu(2);
      this.currentMenu = this.menuStack.Pop();
      AudioController.Play("Back");
      this.currentMenu.UpdateNavigatorBar();
    }

    public void UpdateNavigatorBar(
      SimplePromptSwitch.ButtonFunction submitButtonFunction,
      SimplePromptSwitch.ButtonFunction secondaryButtonFunction,
      SimplePromptSwitch.ButtonFunction backButtonFunction,
      string confirmButtonLocaOverride = "",
      string secondaryButtonLocaOverride = "",
      string backButtonLocaOverride = "")
    {
      this.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(submitButtonFunction, secondaryButtonFunction, backButtonFunction, confirmButtonLocaOverride, secondaryButtonLocaOverride, backButtonLocaOverride);
    }

    public void ExitGame()
    {
      Log.Debug("ExitGame called. Showing Popup.");
      this.popupSettings = (IPopupSettings) new Popup("@ExitGamePopupDescription", "@Yes", "@No", title: "@ExitGamePopupTitle");
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, this.popupSettings, (Action) (() =>
      {
        Log.Debug("Calling ExitGameCoroutine.");
        this.StartCoroutine(this.ExitGameCoroutine());
      }), (Action) null, (Action) null, (Action) null, EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>());
    }

    public void ExitGameImmediate()
    {
      Log.Debug("ExitGameImmediate was called.");
      Application.Quit();
    }

    public void setInviteButtonNavigationActive(bool navigationActive)
    {
      Navigation navigation = new Navigation();
      navigation.mode = !navigationActive ? Navigation.Mode.None : Navigation.Mode.Automatic;
      if (!((UnityEngine.Object) this.inviteButton != (UnityEngine.Object) null))
        return;
      this.inviteButton.navigation = navigation;
    }

    private IEnumerator ExitGameCoroutine()
    {
      MenuController menuController = this;
      Log.Debug("ExitGame with logout was called.");
      menuController.StartCoroutine(MetaServiceHelpers.LogoutFromUserService(ImiServices.Instance.LoginService.GetPlayerId(), (Action) (() => Log.Debug("Logout was Successful")), (Action<string>) (s => Log.Debug("Logout failed due to: " + s))));
      yield return (object) null;
      Log.Debug("Quitting");
      Application.Quit();
    }
  }
}
