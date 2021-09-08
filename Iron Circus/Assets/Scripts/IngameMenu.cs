// Decompiled with JetBrains decompiler
// Type: IngameMenu
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.Utils;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class IngameMenu : MonoBehaviour
{
  [SerializeField]
  private GameObject ingameMenuPanel;
  [SerializeField]
  private GameObject buttonContainer;
  [SerializeField]
  private GameObject controlsPanel;
  [SerializeField]
  private GameObject controlsPanelBody;
  [SerializeField]
  private GameObject voiceChatPanel;
  [SerializeField]
  private GameObject mainPanel;
  [SerializeField]
  private GameObject buttonToSelect;
  [SerializeField]
  private GameObject[] menuButtons;
  [SerializeField]
  private GameObject controlsButtonToSelect;
  [SerializeField]
  private GameObject voiceChatButtonToSelect;
  [SerializeField]
  private GameObject leaveMatchButton;
  [SerializeField]
  private GameObject voiceChatOptionsButton;
  [SerializeField]
  private GameObject joinVoiceChatButton;
  [SerializeField]
  private GameObject forfeitMatchButton;
  [SerializeField]
  private Animator animator;
  [Header("Lobby Button Objects")]
  [SerializeField]
  private CanvasGroup lobbyButtonsGroup;
  private bool isActive;
  private bool isIngame;
  private bool isInLobby;
  private string sceneToReturnTo;
  private InputService input;
  private Rewired.UI.ControlMapper.ControlMapper controlMapper;
  private bool isPollingForInput;
  private bool aPlayerHasForfeited;
  private bool localPlayerHasForfeited;
  private bool showLeaveMatchButton = true;
  private bool toggleAllowed = true;
  private bool isOvertime;

  private void Awake()
  {
    Events.Global.OnEventDisableLeaveButton += new Events.EventDisableLeaveButton(this.OnDisableLeaveButton);
    this.isOvertime = false;
  }

  private void OnDestroy() => Events.Global.OnEventDisableLeaveButton -= new Events.EventDisableLeaveButton(this.OnDisableLeaveButton);

  private void OnDisableLeaveButton() => this.showLeaveMatchButton = false;

  private void OnEnable()
  {
    this.input = ImiServices.Instance.InputService;
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
    Events.Global.OnEventDisconnect += new Events.EventDisconnect(this.OnScPlayerDisconnected);
    Events.Global.OnEventPlayerForfeitMatch += new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    this.sceneToReturnTo = SceneManager.GetActiveScene().name;
    this.animator = this.GetComponent<Animator>();
    this.controlMapper = this.controlsPanel.GetComponent<Rewired.UI.ControlMapper.ControlMapper>();
    this.controlMapper.InputPollingStartedEvent += new Action(this.PollingForInputStarted);
    this.controlMapper.InputPollingEndedEvent += new Action(this.PollingForInputEnded);
    ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen += new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnLobbyEntered);
  }

  private void OnScPlayerDisconnected(ulong id, byte index)
  {
  }

  private void OnDisable()
  {
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
    Events.Global.OnEventDisconnect -= new Events.EventDisconnect(this.OnScPlayerDisconnected);
    Events.Global.OnEventPlayerForfeitMatch -= new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    this.controlMapper.InputPollingStartedEvent -= new Action(this.PollingForInputStarted);
    this.controlMapper.InputPollingEndedEvent -= new Action(this.PollingForInputEnded);
    ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen -= new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnLobbyEntered);
  }

  private void OnPlayerForfeit(ulong playerId, bool forfeit)
  {
    if ((long) playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
    {
      this.DeactivateIngameMenu();
      this.localPlayerHasForfeited = forfeit;
    }
    this.aPlayerHasForfeited = forfeit;
  }

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    switch (matchState)
    {
      case Imi.SharedWithServer.Game.MatchState.Intro:
        this.showLeaveMatchButton = true;
        this.isActive = false;
        this.ToggleIngameMenu();
        this.isIngame = true;
        this.isInLobby = false;
        break;
      case Imi.SharedWithServer.Game.MatchState.Overtime:
        this.forfeitMatchButton.SetActive(false);
        this.isOvertime = true;
        break;
      case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
        this.isIngame = false;
        this.isInLobby = false;
        this.ingameMenuPanel.SetActive(false);
        break;
      case Imi.SharedWithServer.Game.MatchState.StatsScreens:
        this.input.SetInputMapCategory(InputMapCategory.UI);
        break;
    }
  }

  private void OnLobbyEntered()
  {
    if (!Contexts.sharedInstance.meta.hasMetaMatch || !((UnityEngine.Object) MenuController.Instance == (UnityEngine.Object) null) && MenuController.Instance.gameObject.activeInHierarchy)
      return;
    this.isInLobby = true;
  }

  private void Update()
  {
    if (!this.isIngame && !this.isInLobby)
      return;
    MetaContext meta = Contexts.sharedInstance.meta;
    this.leaveMatchButton.SetActive(this.showLeaveMatchButton);
    this.joinVoiceChatButton.SetActive(meta.hasMetaMatch && !meta.metaMatch.gameType.IsPlayground() && !meta.metaMatch.gameType.IsBasicTraining() && !meta.metaMatch.gameType.IsAdvancedTraining());
    bool flag = false;
    if (this.toggleAllowed && (this.input.GetButtonDown(DigitalInput.Menu) || this.input.GetButtonDown(DigitalInput.UIMenu)))
    {
      this.isActive = !this.isActive;
      this.ToggleIngameMenu();
      flag = true;
      this.toggleAllowed = false;
      this.StartCoroutine(this.ResetToggleAllowed());
    }
    if (!this.input.IsUsingSteamInput() && this.controlsPanel.activeInHierarchy)
      this.input.ForceButtonSpriteReload();
    if (!flag && this.input.GetButtonDown(DigitalInput.UICancel) && !this.voiceChatPanel.activeInHierarchy && !this.controlsPanel.activeInHierarchy && !PopupManager.Instance.IsActive() && !this.isPollingForInput)
    {
      this.isActive = false;
      this.ToggleIngameMenu();
    }
    if (this.input.GetButtonDown(DigitalInput.UICancel) && this.controlsPanel.activeInHierarchy && !this.isPollingForInput)
      this.HideControls();
    if (!this.input.GetButtonDown(DigitalInput.UICancel) || !this.voiceChatPanel.activeInHierarchy || this.isPollingForInput)
      return;
    this.HideVoiceChatSettings();
  }

  public IEnumerator ResetToggleAllowed()
  {
    yield return (object) new WaitForSeconds(0.15f);
    this.toggleAllowed = true;
  }

  public void ToggleIngameMenu()
  {
    if (this.isActive)
    {
      this.input.SetInputMapCategory(InputMapCategory.UI);
      if (this.isInLobby)
        this.lobbyButtonsGroup.interactable = false;
    }
    else
    {
      if (this.controlsPanel.activeInHierarchy)
        this.HideControls();
      if (this.voiceChatPanel.activeInHierarchy)
        this.HideVoiceChatSettings();
      if (this.isIngame)
        this.input.SetInputMapCategory(InputMapCategory.Champions);
      if (this.isInLobby && this.isInLobby)
        this.lobbyButtonsGroup.interactable = true;
    }
    if (this.isOvertime || Contexts.sharedInstance.meta.hasMetaMatch && (Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground() || Contexts.sharedInstance.meta.metaMatch.gameType.IsAdvancedTraining() || Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining()))
      this.forfeitMatchButton.gameObject.SetActive(false);
    else
      this.forfeitMatchButton.gameObject.SetActive(true);
    this.ingameMenuPanel.SetActive(this.isActive);
    this.buttonToSelect.GetComponent<Selectable>().Select();
  }

  private void CheckForForfeitOption()
  {
    if (this.aPlayerHasForfeited)
      return;
    float remainingTime = MatchUtils.GetRemainingTime();
    if ((double) StartupSetup.configProvider.matchConfig.durationInSeconds - (double) remainingTime > (double) StartupSetup.configProvider.matchConfig.forfeitStartTime)
      this.forfeitMatchButton.SetActive(true);
    else
      this.forfeitMatchButton.SetActive(false);
  }

  public void DeactivateIngameMenu()
  {
    this.isActive = false;
    this.HideControls();
    this.HideVoiceChatSettings();
    this.ToggleIngameMenu();
  }

  public void LeaveMatchButton()
  {
    if (this.isInLobby || Contexts.sharedInstance.meta.hasMetaMatch && (Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground() || Contexts.sharedInstance.meta.metaMatch.gameType.IsCustomMatch() || Contexts.sharedInstance.meta.metaMatch.gameType.IsAdvancedTraining() || Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining()))
      this.TryToLeaveMatch();
    else
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@LeaveMatchRequestDescription", "@Yes", "@No", title: "@LeaveMatchRequestTitle"), (Action) (() => this.TryToLeaveMatch()), (Action) null, (Action) null, (Action) null, (Selectable) null);
  }

  public void TryToForfeitMatch()
  {
    float remainingTime = MatchUtils.GetRemainingTime();
    float num = (float) StartupSetup.configProvider.matchConfig.durationInSeconds - remainingTime;
    Log.Debug(string.Format("Trying to forfeit match: {0} remainingTime {1}", (object) num, (object) remainingTime));
    if ((double) num > (double) StartupSetup.configProvider.matchConfig.forfeitStartTime && (double) remainingTime > 1.0)
      IngameMenu.ForfeitMatch();
    else
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@ForfeitNotPossibleDescription", "@Ok", title: "@ForfeitNotPossibleTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
  }

  private static void ForfeitMatch()
  {
    GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    if (firstLocalEntity.hasPlayerForfeit)
    {
      if (firstLocalEntity.playerForfeit.hasForfeit)
        Log.Debug(string.Format("Player: {0} has already forfeited. We are not resending the message", (object) firstLocalEntity.playerId.value));
      else
        Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new PlayerForfeitMatchMessage(ImiServices.Instance.LoginService.GetPlayerId(), !firstLocalEntity.playerForfeit.hasForfeit));
    }
    else
      Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new PlayerForfeitMatchMessage(ImiServices.Instance.LoginService.GetPlayerId(), true));
  }

  private void TryToLeaveMatch()
  {
    PopupManager.Instance.HidePopup();
    if (ImiServices.Instance.PartyService.IsInGroup() && !Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground())
      ImiServices.Instance.PartyService.LeaveGroup();
    if (CustomLobbyUi.isInitialized)
      CustomLobbyUi.isAborted = true;
    ImiServices.Instance.GoBackToMenu();
    if (Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground())
      return;
    ImiServices.Instance.Analytics.OnPlayerAbortedMatch();
  }

  public void ShowControls()
  {
    if (ImiServices.Instance.InputService.IsUsingSteamInput())
    {
      ImiServices.Instance.InputService.ShowSteamBindingPanel();
    }
    else
    {
      this.controlsPanel.SetActive(true);
      this.controlsPanelBody.SetActive(true);
      this.mainPanel.SetActive(false);
      this.controlsButtonToSelect.GetComponent<Selectable>().Select();
    }
  }

  public void HideControls()
  {
    this.controlsPanel.SetActive(false);
    this.controlsPanelBody.SetActive(false);
    this.mainPanel.SetActive(true);
    this.buttonToSelect.GetComponent<Selectable>().Select();
  }

  public void HideVoiceChatSettings()
  {
    this.voiceChatPanel.SetActive(false);
    this.mainPanel.SetActive(true);
    this.buttonToSelect.GetComponent<Selectable>().Select();
  }

  public void ShowVoiceChatSettings()
  {
    this.voiceChatPanel.SetActive(true);
    this.mainPanel.SetActive(false);
    this.voiceChatButtonToSelect.GetComponent<Selectable>().Select();
  }

  public void DisableButton(int btn) => this.menuButtons[btn].SetActive(false);

  public void EnableButton(int btn) => this.menuButtons[btn].SetActive(true);

  public void SetButtonSelected(int isExpand)
  {
    if (isExpand == 1)
      this.buttonToSelect.GetComponent<Selectable>().Select();
    else
      this.controlsButtonToSelect.GetComponent<Selectable>().Select();
  }

  public bool IsMenuActive() => this.isActive;

  private void PollingForInputStarted() => this.isPollingForInput = true;

  private void PollingForInputEnded() => this.isPollingForInput = false;
}
