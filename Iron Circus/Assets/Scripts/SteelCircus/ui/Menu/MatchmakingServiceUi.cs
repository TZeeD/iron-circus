// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.MatchmakingServiceUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.UI.Network;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using SteelCircus.Networking;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  public class MatchmakingServiceUi : MonoBehaviour
  {
    private bool successfullyFoundMatch;
    [SerializeField]
    private GameObject steelCircusHeader;
    [SerializeField]
    private GameObject cancelButton;
    [SerializeField]
    private GameObject cancelButtonContent;
    [SerializeField]
    private GameObject connectingInfoObject;
    [SerializeField]
    private GameObject cancellingInfoObject;
    [SerializeField]
    private GameObject successfulInfoObject;
    [SerializeField]
    private GameObject matchmakingPanel;
    [SerializeField]
    private Animator matchmakingPanelAnimator;
    [SerializeField]
    private TextMeshProUGUI matchmakingStatus;
    [SerializeField]
    private Dropdown regionDropdown;
    [SerializeField]
    private Dropdown matchmakingTypeDropdown;
    [Header("MatchmakingButtons")]
    [SerializeField]
    private Button quickMatchButton;
    [SerializeField]
    private Button trainingsGroundButton;
    [SerializeField]
    private Button rankedMatchButton;
    [SerializeField]
    private Button customMatchButton;
    [SerializeField]
    private Button botMatchButton;
    [SerializeField]
    private Button freeTrainingsButton;
    private int currentMatchmakingSystem;
    private string currentMatchmakingRegion;
    private string currentTicketId;

    public void OnEnable()
    {
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen += new LoadingScreenService.OnShowLoadingScreenEventHandler(this.HideMenus);
      ImiServices.Instance.MatchmakingService.OnMatchMakingStatusChanged += new AMatchmakingService.OnMatchmakingStatusChangedEventHandler(this.OnMatchmakingStatusChanged);
      ImiServices.Instance.MatchmakingService.OnMatchmakingError += new AMatchmakingService.OnMatchmakingErrorEventHandler(this.OnMatchmakingError);
      ImiServices.Instance.MatchmakingService.OnMatchmakingSuccessful += new AMatchmakingService.OnMatchmakingSuccessfulEventHandler(this.OnMatchmakingSuccessful);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted += new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted += new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupEntered += new APartyService.OnGroupEnteredEventHandler(this.OnGroupLeftOrEntered);
      ImiServices.Instance.PartyService.OnGroupLeft += new APartyService.OnGroupLeftEventHandler(this.OnGroupLeftOrEntered);
      ImiServices.Instance.MatchmakingService.OnMatchmakingCancelled += new AMatchmakingService.OnMatchmakingCanceledEventHandler(this.OnMatchmakingCancelled);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen += new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
      if ((UnityEngine.Object) this.regionDropdown != (UnityEngine.Object) null)
      {
        this.regionDropdown.ClearOptions();
        this.regionDropdown.AddOptions(ImiServices.Instance.MatchmakingService.GetRegions());
      }
      this.matchmakingTypeDropdown.value = this.matchmakingTypeDropdown.options.Count;
      ImiServices.Instance.MatchmakingService.SetMatchmakingType((MatchmakingType) (this.matchmakingTypeDropdown.options.Count - 1));
    }

    private void Start()
    {
      if (!PlayerPrefs.HasKey("MatchmakingRegion"))
        this.StartCoroutine(this.ShowRegionSelectionPopup());
      this.SendExitEndScreenMessageToTeam();
    }

    private void OnHideLoadingScreen()
    {
    }

    private void DisableMenuController() => MenuController.Instance.gameObject.SetActive(false);

    private IEnumerator ShowRegionSelectionPopup()
    {
      yield return (object) new WaitUntil((Func<bool>) (() => !PopupManager.Instance.IsActive()));
      List<SCPopupButton> buttons = new List<SCPopupButton>();
      foreach (string region1 in ImiServices.Instance.MatchmakingService.GetRegions())
      {
        string region = region1;
        buttons.Add(new SCPopupButton((Action) (() =>
        {
          PlayerPrefs.SetString("MatchmakingRegion", region);
          PopupManager.Instance.HidePopup();
        }), "@MatchmakingRegion_" + region));
      }
      PopupManager.Instance.ShowPopup(PopupManager.Popup.NButtons, (IPopupSettings) new Popup("@RegionSelectionPopupText", buttons), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
    }

    private void OnDisable()
    {
      ImiServices.Instance.LoadingScreenService.OnShowLoadingScreen -= new LoadingScreenService.OnShowLoadingScreenEventHandler(this.HideMenus);
      ImiServices.Instance.MatchmakingService.OnMatchMakingStatusChanged -= new AMatchmakingService.OnMatchmakingStatusChangedEventHandler(this.OnMatchmakingStatusChanged);
      ImiServices.Instance.MatchmakingService.OnMatchmakingError -= new AMatchmakingService.OnMatchmakingErrorEventHandler(this.OnMatchmakingError);
      ImiServices.Instance.MatchmakingService.OnMatchmakingSuccessful -= new AMatchmakingService.OnMatchmakingSuccessfulEventHandler(this.OnMatchmakingSuccessful);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted -= new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted -= new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnMatchmakingStarted);
      ImiServices.Instance.PartyService.OnGroupEntered -= new APartyService.OnGroupEnteredEventHandler(this.OnGroupLeftOrEntered);
      ImiServices.Instance.PartyService.OnGroupLeft -= new APartyService.OnGroupLeftEventHandler(this.OnGroupLeftOrEntered);
      ImiServices.Instance.MatchmakingService.OnMatchmakingCancelled -= new AMatchmakingService.OnMatchmakingCanceledEventHandler(this.OnMatchmakingCancelled);
      ImiServices.Instance.LoadingScreenService.OnHideLoadingScreen -= new LoadingScreenService.OnHideLoadingScreenEventHandler(this.OnHideLoadingScreen);
    }

    private void OnGroupLeftOrEntered() => this.OnMatchmakingCancelled();

    private void OnMatchmakingCancelled()
    {
      Log.Debug(string.Format("OnMatchmakingCancelled: Matchmaking was cancelled. {0}", (object) this));
      ImiServices.Instance.MatchmakingService.SetMatchmakingRequestedBool(false);
      this.currentTicketId = "";
      this.ResetMatchmakingUi();
    }

    private void ResetMatchmakingUi()
    {
      this.ResetButtons();
      this.matchmakingPanel.SetActive(false);
      this.steelCircusHeader.SetActive(true);
      this.matchmakingPanelAnimator.SetBool("matchmaking", false);
      if (this.successfullyFoundMatch)
        return;
      AudioController.Play("ExitQueue");
    }

    private void OnMatchmakingButtonClicked()
    {
      this.currentMatchmakingRegion = PlayerPrefs.GetString("MatchmakingRegion", "");
      ImiServices.Instance.MatchmakingService.SetMatchmakingRequestedBool(true);
      this.StyleUIForMatchmakingButtonPressed();
      this.quickMatchButton.interactable = false;
    }

    private void StyleUIForMatchmakingButtonPressed()
    {
      this.cancelButtonContent.SetActive(false);
      this.connectingInfoObject.SetActive(true);
      this.cancellingInfoObject.SetActive(false);
      this.successfulInfoObject.SetActive(false);
      this.matchmakingStatus.gameObject.SetActive(false);
      this.cancelButton.SetActive(true);
      this.cancelButton.GetComponent<Button>().interactable = false;
      this.SetHeaderForMatchmaking();
      Log.Debug(string.Format("OnMatchmakingStarted: matchmaking was started. {0}", (object) this));
      AudioController.Play("EnterQueue");
    }

    private void SetUIForCancelButtonPressed()
    {
      this.cancelButtonContent.SetActive(false);
      this.connectingInfoObject.SetActive(false);
      this.cancellingInfoObject.SetActive(true);
      this.successfulInfoObject.SetActive(false);
      this.matchmakingStatus.gameObject.SetActive(false);
      this.cancelButton.SetActive(true);
      this.cancelButton.GetComponent<Button>().interactable = false;
      this.SetHeaderForMatchmaking();
      Log.Debug(string.Format("OnMatchmakingStarted: matchmaking was started. {0}", (object) this));
      AudioController.Play("EnterQueue");
    }

    private void OnMatchmakingStarted(string ticketId, string matchmakerregion)
    {
      if (this.currentTicketId == ticketId)
        return;
      this.currentTicketId = ticketId;
      this.successfullyFoundMatch = false;
      this.cancelButtonContent.SetActive(true);
      this.connectingInfoObject.SetActive(false);
      this.cancellingInfoObject.SetActive(false);
      this.successfulInfoObject.SetActive(false);
      this.matchmakingStatus.gameObject.SetActive(true);
      this.currentMatchmakingRegion = PlayerPrefs.GetString("MatchmakingRegion", "");
      this.cancelButton.GetComponent<Button>().interactable = true;
      this.cancelButton.SetActive(true);
      Log.Debug(string.Format("OnMatchmakingStarted: matchmaking was started. {0}", (object) this));
      this.quickMatchButton.interactable = false;
      this.SetHeaderForMatchmaking();
    }

    private void SetHeaderForMatchmaking()
    {
      this.steelCircusHeader.SetActive(false);
      this.matchmakingPanel.SetActive(true);
      this.matchmakingPanelAnimator.SetBool("matchmaking", true);
      this.matchmakingStatus.text = ImiServices.Instance.LocaService.GetLocalizedValue("@MATCHMAKING");
    }

    private void OnMatchmakingSuccessful(ConnectionInfo connectioninfo)
    {
      Log.Debug(string.Format("OnMatchmakingSuccessful: Matchmaking was successful. {0}", (object) this));
      this.successfullyFoundMatch = true;
      this.cancelButtonContent.SetActive(false);
      this.connectingInfoObject.SetActive(false);
      this.cancellingInfoObject.SetActive(false);
      this.successfulInfoObject.SetActive(true);
      ImiServices.Instance.isInMatchService.IsPlayerInMatch = true;
    }

    private void OnMatchmakingError(string errormessage)
    {
      this.matchmakingStatus.text = "Quick Match failed: " + errormessage;
      ImiServices.Instance.MatchmakingService.SetMatchmakingRequestedBool(false);
      this.currentTicketId = "";
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(errormessage, "OK", title: "Matchmaking failed!"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      this.ResetMatchmakingUi();
    }

    private void OnMatchmakingStatusChanged(string status, string ticketId)
    {
      this.currentTicketId = ticketId;
      Log.Debug("Matchmaking Status Changed: " + status);
      string str = "";
      if (status == "TryingToCancelMatchmaking")
        this.SetUIForCancelButtonPressed();
      if (this.currentMatchmakingRegion.IsNullOrEmpty())
        this.matchmakingStatus.text = str + ImiServices.Instance.LocaService.GetLocalizedValue("@" + status);
      else
        this.matchmakingStatus.text = str + ImiServices.Instance.LocaService.GetLocalizedValue("@" + status) + " - " + ImiServices.Instance.LocaService.GetLocalizedValue("@MatchmakingRegionShort_" + this.currentMatchmakingRegion);
    }

    private List<UIProgressionService.uiProgressionButton> GetActiveButtons()
    {
      Log.Debug("Trying to get buttons to enable/disable in play menu");
      UIProgressionState progressionState = ImiServices.Instance.UiProgressionService.getCurrentProgressionState();
      if (progressionState == null || progressionState.playMenuButtonState == null || progressionState.playMenuButtonState.Count == 0)
      {
        Log.Debug("No Buttons found, activating all buttons");
        return new List<UIProgressionService.uiProgressionButton>()
        {
          UIProgressionService.uiProgressionButton.playButton,
          UIProgressionService.uiProgressionButton.botMatchButton,
          UIProgressionService.uiProgressionButton.quickMatchButton,
          UIProgressionService.uiProgressionButton.freeTrainingButton,
          UIProgressionService.uiProgressionButton.playingGroundButton,
          UIProgressionService.uiProgressionButton.customMatchButton
        };
      }
      Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> playMenuButtonState = ImiServices.Instance.UiProgressionService.getCurrentProgressionState().playMenuButtonState;
      List<UIProgressionService.uiProgressionButton> progressionButtonList = new List<UIProgressionService.uiProgressionButton>();
      foreach (KeyValuePair<UIProgressionService.uiProgressionButton, UIProgressionButtonState> keyValuePair in playMenuButtonState)
      {
        if (keyValuePair.Value.enabled)
          progressionButtonList.Add(keyValuePair.Key);
      }
      Log.Debug("Found active buttons: " + progressionButtonList.ToArray().ToString());
      return progressionButtonList;
    }

    private Button GetButtonForType(
      UIProgressionService.uiProgressionButton buttonType)
    {
      switch (buttonType)
      {
        case UIProgressionService.uiProgressionButton.quickMatchButton:
          return this.quickMatchButton;
        case UIProgressionService.uiProgressionButton.playingGroundButton:
          return this.trainingsGroundButton;
        case UIProgressionService.uiProgressionButton.botMatchButton:
          return this.botMatchButton;
        case UIProgressionService.uiProgressionButton.customMatchButton:
          return this.customMatchButton;
        case UIProgressionService.uiProgressionButton.rankedMatchButton:
          return this.rankedMatchButton;
        case UIProgressionService.uiProgressionButton.freeTrainingButton:
          return this.freeTrainingsButton;
        default:
          return (Button) null;
      }
    }

    private void UpdatePlayButtonsOnMatchmakingStarted(
      UIProgressionService.uiProgressionButton buttonPressed)
    {
      Log.Debug("BotmatchButton: " + (object) this.GetButtonForType(UIProgressionService.uiProgressionButton.botMatchButton));
      foreach (UIProgressionService.uiProgressionButton activeButton in this.GetActiveButtons())
      {
        if (activeButton != buttonPressed)
          this.SetButtonStateDisabled(activeButton, this.GetButtonForType(activeButton));
        else
          this.SetButtonStateMatching(activeButton, this.GetButtonForType(activeButton));
      }
    }

    private void SetButtonStateDisabled(
      UIProgressionService.uiProgressionButton buttonState,
      Button button)
    {
      if (!((UnityEngine.Object) button != (UnityEngine.Object) null))
        return;
      Log.Debug("Setting Button disabled: " + (object) buttonState + " - " + (object) button);
      button.animationTriggers.disabledTrigger = "DisabledTemp";
      button.interactable = false;
      button.gameObject.GetComponent<Animator>().SetTrigger("DisabledTemp");
    }

    private void SetButtonStateMatching(
      UIProgressionService.uiProgressionButton buttonState,
      Button button)
    {
      if (!((UnityEngine.Object) button != (UnityEngine.Object) null))
        return;
      Log.Debug("Setting Button matching: " + (object) buttonState + " - " + (object) button);
      button.animationTriggers.disabledTrigger = "Matching";
      button.interactable = false;
      button.gameObject.GetComponent<Animator>().SetTrigger("Matching");
    }

    private void SetButtonStateEnabled(
      UIProgressionService.uiProgressionButton buttonState,
      Button button)
    {
      if (!((UnityEngine.Object) button != (UnityEngine.Object) null))
        return;
      Log.Debug("Resetting button state of " + (object) button + " to true");
      button.interactable = true;
    }

    private void ResetButtons()
    {
      Log.Debug("Resetting Buttons");
      foreach (UIProgressionService.uiProgressionButton activeButton in this.GetActiveButtons())
      {
        Log.Debug(string.Format("Setting {0} enabled.", (object) activeButton));
        this.SetButtonStateEnabled(activeButton, this.GetButtonForType(activeButton));
      }
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.playMenu))
        return;
      MenuController.Instance.buttonFocusManager.FocusButtonOnChangeMenu();
    }

    private void HideMenus(LoadingScreenService.LoadingScreenIntent intent)
    {
      if ((UnityEngine.Object) MenuController.Instance != (UnityEngine.Object) null)
        MenuController.Instance.DisableMainMenus();
      this.DisableMenuController();
    }

    public void SendExitEndScreenMessageToTeam()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup() || (long) ImiServices.Instance.PartyService.GetGroupOwner() != (long) ImiServices.Instance.LoginService.GetPlayerId())
        return;
      Debug.Log((object) "Sending quit exit screen message to teammates");
      ImiServices.Instance.PartyService.NotifyGroupLeaveEndScreen();
    }

    public void StartBasicTrainingButton()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup() || ImiServices.Instance.PartyService.GetCurrentGroup().Count == 1)
      {
        this.StyleUIForMatchmakingButtonPressed();
        this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.playingGroundButton);
        ImiServices.Instance.MatchmakingService.StartBasicTraining(ImiServices.Instance.LoginService.GetPlayerId(), MatchmakingServiceUi.GetMatchmakingRegionFromPlayerPrefs());
      }
      else
        this.ShowPopupNoTrainingWhileInGroup();
    }

    public void StartAdvancedTrainingButton()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup() || ImiServices.Instance.PartyService.GetCurrentGroup().Count == 1)
      {
        this.StyleUIForMatchmakingButtonPressed();
        this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.botMatchButton);
        ImiServices.Instance.MatchmakingService.StartBotMatch(ImiServices.Instance.LoginService.GetPlayerId(), "Arena_Mars_01_VariationA", 1, 0, MatchType.Match2Vs2, GameType.AdvancedTraining, MatchmakingServiceUi.GetMatchmakingRegionFromPlayerPrefs(), AwsPinger.RegionLatencies, (Action<bool>) (b =>
        {
          if (!b)
            return;
          Log.Error("BotMatch error.");
        }));
      }
      else
        this.ShowPopupNoTrainingWhileInGroup();
    }

    public void StartMatchmakingButton()
    {
      Log.Debug("quickMatchButton clicked!");
      ImiServices.Instance.Analytics.OnQuickMatchButtonClicked();
      if (ImiServices.Instance.MatchmakingService.IsMatchmaking())
        return;
      if (ImiServices.Instance.PartyService.IsInGroup() && !ImiServices.Instance.PartyService.IsGroupOwner())
      {
        PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@NoPermissionToStartMatchmakingPopupDescription", "Ok", button3: "@NoPermissionToStartMatchmakingPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      }
      else
      {
        this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.quickMatchButton);
        this.OnMatchmakingButtonClicked();
        this.StartCoroutine(MetaServiceHelpers.GetMatchmakingSystem(new Action<int>(this.OnMatchmakingSystemReceived)));
      }
    }

    private void StartMatchmaking(int mmSystem)
    {
      if (ImiServices.Instance.PartyService.IsInGroup())
      {
        List<ulong> currentGroupPlayerIds = ImiServices.Instance.PartyService.GetCurrentGroupPlayerIds();
        int currentMatchmakingType = ImiServices.Instance.MatchmakingService.GetMaxGroupSizeForCurrentMatchmakingType();
        if (currentGroupPlayerIds.Count <= currentMatchmakingType)
          this.StartGroupMatchmaking(mmSystem, currentGroupPlayerIds);
        else
          this.ShowPopupInvalidGroupSize();
      }
      else
        this.StartSoloMatchmaking(mmSystem);
    }

    private void OnMatchmakingSystemReceived(int mmSystem)
    {
      Log.Debug("We are Using MatchmakingSystem " + (object) mmSystem);
      this.currentMatchmakingSystem = mmSystem;
      this.StartMatchmaking(mmSystem);
    }

    public static string GetMatchmakingRegionFromPlayerPrefs() => PlayerPrefs.HasKey("MatchmakingRegion") ? PlayerPrefs.GetString("MatchmakingRegion") : "eu-west-1";

    public static string GetCustomMatchMatchmakingRegionFromPlayerPrefs() => PlayerPrefs.HasKey("CustomMatchMatchmakingRegion") ? PlayerPrefs.GetString("CustomMatchMatchmakingRegion") : "eu-west-1";

    public void CreateAndJoinTrainingSessions()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup() || ImiServices.Instance.PartyService.GetCurrentGroup().Count == 1)
      {
        this.StyleUIForMatchmakingButtonPressed();
        ImiServices.Instance.Analytics.OnCreateAndJoinTrainingSession();
        this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.freeTrainingButton);
        ImiServices.Instance.MatchmakingService.StartTrainingsGround(ImiServices.Instance.LoginService.GetPlayerId(), MatchmakingServiceUi.GetMatchmakingRegionFromPlayerPrefs());
      }
      else
        this.ShowPopupNoTrainingWhileInGroup();
    }

    private void StartSoloMatchmaking(int mmSystem)
    {
      this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.quickMatchButton);
      Log.Debug(string.Format("Starting Solo Matchmaking. {0}", (object) this));
      ImiServices.Instance.MatchmakingService.StartMatchmaking(mmSystem, ImiServices.Instance.LoginService.GetPlayerId(), MatchmakingServiceUi.GetMatchmakingRegionFromPlayerPrefs(), AwsPinger.RegionLatencies);
    }

    private void StartGroupMatchmaking(int mmSystem, List<ulong> playerIds)
    {
      this.UpdatePlayButtonsOnMatchmakingStarted(UIProgressionService.uiProgressionButton.quickMatchButton);
      Log.Debug(string.Format("Starting Group Matchmaking. {0}", (object) this));
      ImiServices.Instance.MatchmakingService.StartMatchmaking(mmSystem, ImiServices.Instance.LoginService.GetPlayerId(), playerIds, MatchmakingServiceUi.GetMatchmakingRegionFromPlayerPrefs(), AwsPinger.RegionLatencies);
    }

    private void ShowPopupInvalidGroupSize() => PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@InvalidGroupSizeForMatchmakingTypePopupDescription", "OK", title: "@InvalidGroupSizeForMatchmakingTypePopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);

    private void ShowPopupNoTrainingWhileInGroup() => PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@NoTrainingsGroundWhileInGroupPopupDescription", "OK", button3: "@NoTrainingsGroundWhileInGroupPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);

    public void CancelMatchmakingButton()
    {
      Log.Debug(string.Format("Cancel Matchmaking Button clicked. {0}", (object) this));
      if (!ImiServices.Instance.MatchmakingService.IsMatchmaking())
        return;
      ImiServices.Instance.MatchmakingService.CancelMatchmaking();
    }

    public void ChangeMatchmakingRegionButton(int id)
    {
      List<string> regions = ImiServices.Instance.MatchmakingService.GetRegions();
      if (id > regions.Count)
      {
        Log.Error(string.Format("The RegionDropdown returned a higher index than allowed region! {0}", (object) this));
      }
      else
      {
        PlayerPrefs.SetString("MatchmakingRegion", regions[id]);
        Log.Debug(string.Format("{0}. {1}", (object) PlayerPrefs.GetString("MatchmakingRegion"), (object) this));
      }
    }

    public void ChangeMatchmakingTypeButton(int id) => ImiServices.Instance.MatchmakingService.SetMatchmakingType((MatchmakingType) id);

    private static string GetRegionForServer(string server)
    {
      List<string> regions = ImiServices.Instance.MatchmakingService.GetRegions();
      if (regions == null || regions.Count <= 1)
        return "";
      switch (server)
      {
        case "ap-northeast-1":
          return regions[2];
        case "ap-northeast-2":
          return regions[2];
        case "ap-southeast-1":
          return regions[2];
        case "ca-central-1":
          return regions[1];
        case "eu-central-1":
          return regions[0];
        case "eu-west-1":
          return regions[0];
        case "sa-east-1":
          return regions[1];
        case "us-east-1":
          return regions[1];
        case "us-west-1":
          return regions[1];
        default:
          return "";
      }
    }
  }
}
