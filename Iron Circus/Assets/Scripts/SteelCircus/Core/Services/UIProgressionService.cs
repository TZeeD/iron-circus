// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.UIProgressionService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.ScriptableObjects;
using SteelCircus.UI;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace SteelCircus.Core.Services
{
  public class UIProgressionService
  {
    private Dictionary<int, UIProgressionState> progressionStates;
    private ImiServicesHelper imiHelper;
    private UIProgressionState currentProgressionState;
    private bool rewardAnimEnded;
    private bool unlockAnimEnded;
    private Coroutine unlockProgressCoroutine;

    public event UIProgressionService.OnUIProgressionServiceRewardShowEventHandler OnUIProgressionServiceRewardShow;

    public event UIProgressionService.OnUIUnlockButtonAnimationPlayEventHandler OnUIUnlockButtonAnimationPlay;

    public event UIProgressionService.OnUIUpdateButtonLockStatusEventHandler OnUIUpdateButtonLockStatus;

    public event UIProgressionService.OnUnlockChallengePanelEventHandler OnUnlockChallengePanel;

    public event UIProgressionService.OnUnlockGroupInviteButtonEventHandler OnUnlockGroupInviteButton;

    public UIProgressionService(ImiServicesHelper imiHelper)
    {
      this.imiHelper = imiHelper;
      this.AddListeners();
    }

    private void Uninitialize() => this.RemoveListeners();

    private void AddListeners()
    {
      this.imiHelper.UpdateEvent += new Action(this.OnUpdate);
      this.imiHelper.ApplicationQuitEvent += new Action(this.Uninitialize);
    }

    private void RemoveListeners()
    {
      this.imiHelper.UpdateEvent -= new Action(this.OnUpdate);
      this.imiHelper.ApplicationQuitEvent -= new Action(this.Uninitialize);
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnChangeMenu));
    }

    private void OnChangeMenu()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu != (UnityEngine.Object) MenuController.Instance.playMenu) || this.unlockProgressCoroutine == null)
        return;
      this.imiHelper.StopCoroutine(this.unlockProgressCoroutine);
      this.unlockProgressCoroutine = (Coroutine) null;
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnChangeMenu));
    }

    private void OnUpdate()
    {
      if (!Input.GetKeyDown("j"))
        return;
      this.DebugProgress();
    }

    private void DebugProgress()
    {
      if (this.progressionStates == null)
        return;
      if (this.progressionStates.ContainsKey(this.currentProgressionState.stateID + 1))
        this.currentProgressionState = this.progressionStates[this.currentProgressionState.stateID + 1];
      else
        this.currentProgressionState = this.progressionStates[0];
    }

    public UIProgressionState getCurrentProgressionState() => this.currentProgressionState;

    public bool SetCurrentProgressionState(int stateId)
    {
      if (this.progressionStates == null || !this.progressionStates.ContainsKey(stateId))
        return false;
      Log.Debug("Setting current UI progression state to: " + (object) stateId);
      this.currentProgressionState = this.progressionStates[stateId];
      return true;
    }

    public void SetCurrentProgressionReward(
      DailyChallengeEntry.ChallengeRewardType type,
      int rewardAmount)
    {
      this.currentProgressionState.rewardType = type;
      this.currentProgressionState.rewardAmount = rewardAmount;
      if (type != DailyChallengeEntry.ChallengeRewardType.Steel)
      {
        if (type == DailyChallengeEntry.ChallengeRewardType.Creds)
          this.getCurrentProgressionState().rewardText = "@TutorialRewardTextCredits";
        else
          this.getCurrentProgressionState().rewardText = "";
      }
      else
        this.getCurrentProgressionState().rewardText = "@TutorialRewardTextSteel";
    }

    public void SetupProgressionStates() => this.progressionStates = SingletonScriptableObject<UIProgressionConfig>.Instance.GetUIStatesDict();

    public void UpdateUIProgressionState()
    {
      if (this.unlockProgressCoroutine != null)
        this.imiHelper.StopCoroutine(this.unlockProgressCoroutine);
      Log.Debug("Starting to update UI PRogression State.");
      this.unlockProgressCoroutine = this.imiHelper.StartCoroutine(this.ProgressUI(this.currentProgressionState));
    }

    public void UpdateButtonLockStatus(bool updateHighlightedState = false)
    {
      Log.Debug("UIProgressionService is Updating UI Buttons lock states.");
      if (this.currentProgressionState == null)
        return;
      UIProgressionService.OnUIUpdateButtonLockStatusEventHandler buttonLockStatus = this.OnUIUpdateButtonLockStatus;
      if (buttonLockStatus == null)
        return;
      buttonLockStatus(this.currentProgressionState.playMenuButtonState, this.currentProgressionState.inviteButtonState, updateHighlightedState);
    }

    public void UpdateButtonLockStatusToPrevious()
    {
      Log.Debug("UIProgressionService is Updating to previous UI Buttons lock states.");
      if (this.currentProgressionState == null || this.currentProgressionState.stateID == 0)
        return;
      UIProgressionService.OnUIUpdateButtonLockStatusEventHandler buttonLockStatus = this.OnUIUpdateButtonLockStatus;
      if (buttonLockStatus == null)
        return;
      buttonLockStatus(this.progressionStates[this.currentProgressionState.previosStateID].playMenuButtonState, this.progressionStates[this.currentProgressionState.previosStateID].inviteButtonState, false);
    }

    private IEnumerator ProgressUI(UIProgressionState state)
    {
      UIProgressionService progressionService = this;
      if (state != null)
      {
        Log.Debug("Progressing UI state to: " + (object) state.stateID);
        if (PlayerPrefs.HasKey("FTUEAnimationCompletedForStep") && PlayerPrefs.GetInt("FTUEAnimationCompletedForStep") == state.stateID)
        {
          Log.Debug("Animation already completed. Updating button Lock status.");
          progressionService.UpdateButtonLockStatus(true);
        }
        else
        {
          MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(progressionService.OnChangeMenu));
          Log.Debug("Progression ui to state " + (object) state.stateID);
          progressionService.UpdateButtonLockStatusToPrevious();
          if (state.hasReward)
          {
            progressionService.SetRewardAnimEnded(false);
            UIProgressionService.OnUIProgressionServiceRewardShowEventHandler serviceRewardShow = progressionService.OnUIProgressionServiceRewardShow;
            if (serviceRewardShow != null)
              serviceRewardShow(state.rewardType, state.rewardAmount, state.rewardText);
            yield return (object) new WaitUntil(new Func<bool>(progressionService.HasRewardAnimEnded));
            progressionService.rewardAnimEnded = false;
          }
          List<UIProgressionService.uiProgressionButton> unlockedButtons = state.GetUnlockedUIButtons();
          Log.Debug("Unlocked Buttons: " + (object) unlockedButtons.Count);
          if (unlockedButtons.Count > 0)
          {
            progressionService.SetUnlockAnimEnded(false);
            UIProgressionService.OnUIUnlockButtonAnimationPlayEventHandler buttonAnimationPlay = progressionService.OnUIUnlockButtonAnimationPlay;
            if (buttonAnimationPlay != null)
              buttonAnimationPlay(unlockedButtons);
            yield return (object) new WaitUntil(new Func<bool>(progressionService.HasUnlockAnimEnded));
          }
          if (state.inviteButtonState.newlyUnlocked)
          {
            UIProgressionService.OnUnlockGroupInviteButtonEventHandler groupInviteButton = progressionService.OnUnlockGroupInviteButton;
            if (groupInviteButton != null)
              groupInviteButton();
          }
          if (state.challengeMenuState.newlyUnlocked)
          {
            if (unlockedButtons.Count == 0)
              yield return (object) new WaitForSeconds(1f);
            Log.Debug("Unlocking challenge panel Event.");
            UIProgressionService.OnUnlockChallengePanelEventHandler unlockChallengePanel = progressionService.OnUnlockChallengePanel;
            if (unlockChallengePanel != null)
              unlockChallengePanel();
          }
          Log.Debug("Unlock Progress Animation concluded");
          PlayerPrefs.SetInt("FTUEAnimationCompletedForStep", state.stateID);
          MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(progressionService.OnChangeMenu));
          unlockedButtons = (List<UIProgressionService.uiProgressionButton>) null;
        }
      }
      yield return (object) null;
      progressionService.unlockProgressCoroutine = (Coroutine) null;
    }

    public UIProgressionService.uiProgressionButton GetCurrentlyHighlightedButton()
    {
      foreach (KeyValuePair<UIProgressionService.uiProgressionButton, UIProgressionButtonState> keyValuePair in this.currentProgressionState.playMenuButtonState)
      {
        if (keyValuePair.Value.highlighted)
          return keyValuePair.Key;
      }
      return UIProgressionService.uiProgressionButton.none;
    }

    public bool HasRewardAnimEnded() => this.rewardAnimEnded;

    public void SetRewardAnimEnded(bool ended) => this.rewardAnimEnded = ended;

    public bool HasUnlockAnimEnded() => this.unlockAnimEnded;

    public void SetUnlockAnimEnded(bool ended)
    {
      Log.Debug("Set Unlock animation ended: " + ended.ToString());
      this.unlockAnimEnded = ended;
    }

    public enum uiProgressionButton
    {
      none,
      playButton,
      quickMatchButton,
      playingGroundButton,
      botMatchButton,
      customMatchButton,
      rankedMatchButton,
      freeTrainingButton,
    }

    public delegate void OnUIProgressionServiceRewardShowEventHandler(
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int amount,
      string rewardText);

    public delegate void OnUIUnlockButtonAnimationPlayEventHandler(
      List<UIProgressionService.uiProgressionButton> button);

    public delegate void OnUIUpdateButtonLockStatusEventHandler(
      Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> buttonStates,
      UIProgressionButtonState inviteButtonState,
      bool updateHighlightedState);

    public delegate void OnUnlockGroupInviteButtonEventHandler();

    public delegate void OnUnlockChallengePanelEventHandler();
  }
}
