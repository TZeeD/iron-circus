// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.MenuProgressionUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using SteelCircus.UI.Misc;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  public class MenuProgressionUI : MonoBehaviour
  {
    [Header("Buttons")]
    [SerializeField]
    private Button playButton;
    [SerializeField]
    private Button quickMatchButton;
    [SerializeField]
    private Button playGroundButton;
    [SerializeField]
    private Button botMatchButton;
    [SerializeField]
    private Button customGameButton;
    [SerializeField]
    private Button rankedGameButton;
    [SerializeField]
    private Button freeTrainingButton;
    [Header("UI Elements")]
    [SerializeField]
    private ShowChallengeRewards rewardPanel;
    [SerializeField]
    private GameObject GroupInviteButton;
    [Header("CoroutineRunner")]
    [SerializeField]
    private CoroutineRunner playMenuCoroutineRunner;
    [Header("Prefabs")]
    [SerializeField]
    private GameObject buttonUnlockGlowAnimPrefab;

    private void Awake()
    {
      ImiServices.Instance.UiProgressionService.OnUIUnlockButtonAnimationPlay += new UIProgressionService.OnUIUnlockButtonAnimationPlayEventHandler(this.OnAnimateUnlockButton);
      ImiServices.Instance.UiProgressionService.OnUnlockGroupInviteButton += new UIProgressionService.OnUnlockGroupInviteButtonEventHandler(this.ShowGroupInviteButton);
      ImiServices.Instance.UiProgressionService.OnUIUpdateButtonLockStatus += new UIProgressionService.OnUIUpdateButtonLockStatusEventHandler(this.OnUpdateButtonLockStates);
      ImiServices.Instance.UiProgressionService.OnUIProgressionServiceRewardShow += new UIProgressionService.OnUIProgressionServiceRewardShowEventHandler(this.OnShowReward);
    }

    private void Start() => MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnMenuEntered));

    private void OnDestroy()
    {
      ImiServices.Instance.UiProgressionService.OnUIUnlockButtonAnimationPlay -= new UIProgressionService.OnUIUnlockButtonAnimationPlayEventHandler(this.OnAnimateUnlockButton);
      ImiServices.Instance.UiProgressionService.OnUnlockGroupInviteButton -= new UIProgressionService.OnUnlockGroupInviteButtonEventHandler(this.ShowGroupInviteButton);
      ImiServices.Instance.UiProgressionService.OnUIUpdateButtonLockStatus -= new UIProgressionService.OnUIUpdateButtonLockStatusEventHandler(this.OnUpdateButtonLockStates);
      ImiServices.Instance.UiProgressionService.OnUIProgressionServiceRewardShow -= new UIProgressionService.OnUIProgressionServiceRewardShowEventHandler(this.OnShowReward);
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnMenuEntered));
    }

    public void OnMenuEntered()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playMenu) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.mainMenuPanel) || ImiServices.Instance.MatchmakingService.IsMatchmaking())
        return;
      ImiServices.Instance.UiProgressionService.UpdateUIProgressionState();
    }

    private void ShowGroupInviteButton() => this.GroupInviteButton.SetActive(true);

    public IEnumerator StartAnimationCoroutine(
      List<UIProgressionService.uiProgressionButton> buttons)
    {
      yield return (object) null;
      if ((Object) this.playMenuCoroutineRunner != (Object) null && this.playMenuCoroutineRunner.isActiveAndEnabled)
        this.playMenuCoroutineRunner.StartCoroutine(this.PlayUnlockAnims(buttons));
    }

    public MenuProgressionUI.ButtonObjectInfo GetButtonObject(
      UIProgressionService.uiProgressionButton button)
    {
      switch (button)
      {
        case UIProgressionService.uiProgressionButton.playButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.playButton, MenuController.Instance.mainMenuPanel);
        case UIProgressionService.uiProgressionButton.quickMatchButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.quickMatchButton, MenuController.Instance.playMenu);
        case UIProgressionService.uiProgressionButton.playingGroundButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.playGroundButton, MenuController.Instance.playMenu);
        case UIProgressionService.uiProgressionButton.botMatchButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.botMatchButton, MenuController.Instance.playMenu);
        case UIProgressionService.uiProgressionButton.customMatchButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.customGameButton, MenuController.Instance.playMenu);
        case UIProgressionService.uiProgressionButton.rankedMatchButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.rankedGameButton, MenuController.Instance.playMenu);
        case UIProgressionService.uiProgressionButton.freeTrainingButton:
          return new MenuProgressionUI.ButtonObjectInfo(this.freeTrainingButton, MenuController.Instance.playMenu);
        default:
          Log.Error("No Button Info Object for " + (object) button);
          return (MenuProgressionUI.ButtonObjectInfo) null;
      }
    }

    private void OnShowReward(
      DailyChallengeEntry.ChallengeRewardType challengeRewardType,
      int amount,
      string rewardText)
    {
      this.rewardPanel.ShowTutorialReward(challengeRewardType, amount, rewardText);
      Log.Debug("Show Rewards: " + (object) amount + " " + challengeRewardType.ToString());
    }

    private void OnAnimateUnlockButton(
      List<UIProgressionService.uiProgressionButton> buttons)
    {
      this.StartCoroutine(this.StartAnimationCoroutine(buttons));
    }

    public IEnumerator SetHighlightAfterAnimationEnd(
      float animTime,
      UIProgressionService.uiProgressionButton highlightedButton)
    {
      yield return (object) new WaitForSeconds(animTime);
      this.SetButtonHighlighted(highlightedButton);
    }

    public IEnumerator PlayUnlockAnims(
      List<UIProgressionService.uiProgressionButton> buttons)
    {
      MenuProgressionUI menuProgressionUi = this;
      yield return (object) new WaitForSeconds(0.1f);
      foreach (UIProgressionService.uiProgressionButton unlockedButton in buttons)
      {
        Log.Debug("Play Anim for " + (object) unlockedButton);
        menuProgressionUi.GetButtonObject(unlockedButton).buttonObject.GetComponent<Animator>().SetTrigger("TutorialUnlock");
        yield return (object) null;
        if (ImiServices.Instance.UiProgressionService.getCurrentProgressionState().playMenuButtonState[unlockedButton].highlighted)
          menuProgressionUi.StartCoroutine(menuProgressionUi.SetHighlightAfterAnimationEnd(3.7f, unlockedButton));
        yield return (object) new WaitForSeconds(2f);
      }
      ImiServices.Instance.UiProgressionService.SetUnlockAnimEnded(true);
    }

    private void OnUpdateButtonLockStates(
      Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> buttonStates,
      UIProgressionButtonState inviteButtonState,
      bool updateHighlightedState)
    {
      foreach (KeyValuePair<UIProgressionService.uiProgressionButton, UIProgressionButtonState> buttonState in buttonStates)
        this.SetButtonLockState(buttonState.Key, buttonState.Value, updateHighlightedState);
      if (ImiServices.Instance.UiProgressionService.getCurrentProgressionState().stateID == 1)
        this.SetButtonHighlighted(UIProgressionService.uiProgressionButton.playButton);
      if (inviteButtonState.enabled)
        this.GroupInviteButton.SetActive(true);
      else
        this.GroupInviteButton.SetActive(false);
      if (!updateHighlightedState)
        return;
      foreach (KeyValuePair<UIProgressionService.uiProgressionButton, UIProgressionButtonState> buttonState in buttonStates)
      {
        if (buttonState.Value.highlighted)
          this.SetButtonHighlighted(buttonState.Key);
      }
    }

    private void SetButtonHighlighted(UIProgressionService.uiProgressionButton button)
    {
      Button buttonObject = this.GetButtonObject(button).buttonObject;
      buttonObject.interactable = true;
      if ((Object) EventSystem.current.currentSelectedGameObject != (Object) null)
        EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>();
      if (!((Object) buttonObject != (Object) null))
        return;
      Log.Debug("Set Button Highlighted: " + (object) button);
      buttonObject.GetComponent<Button>().animationTriggers.normalTrigger = "TutorialHighlight";
      buttonObject.GetComponent<Button>().animationTriggers.highlightedTrigger = "TutorialHighlightSelect";
      if (ImiServices.Instance.InputService.GetLastInputSource() == InputSource.Mouse)
      {
        buttonObject.GetComponent<Animator>().SetTrigger("TutorialHighlight");
      }
      else
      {
        Log.Debug("Setting Button Selected: " + (object) buttonObject);
        MenuController.Instance.buttonFocusManager.FocusOnButton((Selectable) buttonObject);
      }
    }

    private void SetButtonLockState(
      UIProgressionService.uiProgressionButton button,
      UIProgressionButtonState state,
      bool setHighlightedState = true)
    {
      switch (button)
      {
        case UIProgressionService.uiProgressionButton.playButton:
          this.SetButtonLockState(this.playButton, state);
          if (!setHighlightedState || !state.highlighted)
            break;
          this.SetButtonHighlighted(button);
          break;
        case UIProgressionService.uiProgressionButton.quickMatchButton:
          this.SetButtonLockState(this.quickMatchButton, state);
          break;
        case UIProgressionService.uiProgressionButton.playingGroundButton:
          this.SetButtonLockState(this.playGroundButton, state);
          break;
        case UIProgressionService.uiProgressionButton.botMatchButton:
          this.SetButtonLockState(this.botMatchButton, state);
          break;
        case UIProgressionService.uiProgressionButton.customMatchButton:
          this.SetButtonLockState(this.customGameButton, state);
          break;
        case UIProgressionService.uiProgressionButton.rankedMatchButton:
          this.SetButtonLockState(this.rankedGameButton, state);
          break;
        case UIProgressionService.uiProgressionButton.freeTrainingButton:
          this.SetButtonLockState(this.freeTrainingButton, state);
          break;
      }
    }

    private void SetButtonLockState(Button button, UIProgressionButtonState state) => button.interactable = state.enabled;

    public IEnumerator SetTriggerDelayed(Animator anim, string trigger)
    {
      yield return (object) null;
      anim.SetTrigger(trigger);
    }

    public class ButtonObjectInfo
    {
      public Button buttonObject;
      public MenuObject menu;

      public ButtonObjectInfo(Button button, MenuObject menu)
      {
        this.buttonObject = button;
        this.menu = menu;
      }
    }
  }
}
