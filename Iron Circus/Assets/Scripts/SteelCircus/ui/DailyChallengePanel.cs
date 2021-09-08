// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.DailyChallengePanel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class DailyChallengePanel : MonoBehaviour
  {
    [Header("Visible In Menus")]
    [SerializeField]
    private List<MenuObject> visibleInMenus;
    [Header("References")]
    [SerializeField]
    private ShopManager shopManager;
    public GameObject dailyChallengeEntryPrefab;
    [SerializeField]
    private float rewardDurationTime;
    [SerializeField]
    private RectTransform challengeParent;
    [SerializeField]
    private RectTransform parentLayoutGroup;
    [SerializeField]
    private RectTransform challengeHeightContainer;
    [SerializeField]
    private RectTransform milestoneRewardParent;
    [SerializeField]
    private RectTransform milestoneHeightContainer;
    [SerializeField]
    private RectTransform tutorialParent;
    [SerializeField]
    private RectTransform tutorialHeightController;
    [SerializeField]
    private GameObject rewardOverlayPanel;
    public List<GameObject> dailyChallengeEntries;
    public List<GameObject> rewardEntries;
    public List<GameObject> milestoneRewardEntries;
    public List<GameObject> tutorialEntries;
    public bool panelVisible;
    [SerializeField]
    private List<Button> challengePanelButtonsToDisable;
    [SerializeField]
    private List<Button> mainMenuButtonsToDisable;
    [Header("MilestonePanel")]
    [SerializeField]
    private GameObject milestonePanel;
    [SerializeField]
    private TextMeshProUGUI milestoneProgress;
    [SerializeField]
    private TextMeshProUGUI milestoneDescription;
    [SerializeField]
    private Image milestoneCompletionCircle;
    [SerializeField]
    private Image milestoneItemImage;
    [SerializeField]
    private Image milestoneBackgroundImage;
    [SerializeField]
    private Image milestoneItemBackgroundImage;
    [SerializeField]
    private Image milestoneRewardProgressBar;
    [SerializeField]
    private TextMeshProUGUI milestoneRewardTypeText;
    [Header("Credits Milestone Elements")]
    [SerializeField]
    private TextMeshProUGUI milestoneCreditsAmountText;
    [SerializeField]
    private GameObject milestoneCreditsObjectParent;
    [SerializeField]
    private TextMeshProUGUI milestoneSteelAmountText;
    [SerializeField]
    private GameObject milestoneSteelObjectParent;
    private InputService input;
    private int milestoneGoalItemId;
    private int milestoneLevelGoal;
    private Navigation noNavigation;
    private Navigation autoNavigation;

    private void Start()
    {
      this.mainMenuButtonsToDisable = new List<Button>();
      this.challengePanelButtonsToDisable = new List<Button>();
      this.noNavigation = new Navigation();
      this.autoNavigation = new Navigation();
      this.noNavigation.mode = Navigation.Mode.None;
      this.autoNavigation.mode = Navigation.Mode.Automatic;
      this.input = ImiServices.Instance.InputService;
      this.GetMainMenuPanelButtons();
      ImiServices.Instance.progressManager.OnPlayerLevelUpdated += new ProgressManager.OnPlayerLevelUpdatedHandler(this.OnPlayerLevelUpdated);
      ImiServices.Instance.UiProgressionService.OnUnlockChallengePanel += new UIProgressionService.OnUnlockChallengePanelEventHandler(this.OnPlayUnlockAnimationEvent);
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnMenuChangedEvent));
      ImiServices.Instance.UiProgressionService.OnUIUpdateButtonLockStatus += new UIProgressionService.OnUIUpdateButtonLockStatusEventHandler(this.OnUpdateProgressionStatus);
      this.GetCachedChallenges();
      ImiServices.Instance.progressManager.OnDailyQuestProgressReceived += new ProgressManager.OnDailyQuestProgressReceivedEventHandler(this.ParseDailyChallenge);
      ImiServices.Instance.progressManager.OnMilestoneProgressReceived += new ProgressManager.OnMilestoneProgressReceivedEventHandler(this.ParseMilestones);
      ImiServices.Instance.progressManager.OnTutorialProgressReceived += new ProgressManager.OnTutorialProgressReceivedEventHandler(this.ParseTutorialProgress);
    }

    private void OnDestroy()
    {
      ImiServices.Instance.progressManager.OnPlayerLevelUpdated -= new ProgressManager.OnPlayerLevelUpdatedHandler(this.OnPlayerLevelUpdated);
      ImiServices.Instance.UiProgressionService.OnUnlockChallengePanel -= new UIProgressionService.OnUnlockChallengePanelEventHandler(this.OnPlayUnlockAnimationEvent);
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnMenuChangedEvent));
      ImiServices.Instance.UiProgressionService.OnUIUpdateButtonLockStatus -= new UIProgressionService.OnUIUpdateButtonLockStatusEventHandler(this.OnUpdateProgressionStatus);
      ImiServices.Instance.progressManager.OnDailyQuestProgressReceived -= new ProgressManager.OnDailyQuestProgressReceivedEventHandler(this.ParseDailyChallenge);
      ImiServices.Instance.progressManager.OnMilestoneProgressReceived -= new ProgressManager.OnMilestoneProgressReceivedEventHandler(this.ParseMilestones);
      ImiServices.Instance.progressManager.OnTutorialProgressReceived -= new ProgressManager.OnTutorialProgressReceivedEventHandler(this.ParseTutorialProgress);
    }

    private void GetCachedChallenges()
    {
      if (ImiServices.Instance.progressManager.TutorialQuestInfo != null)
        this.ParseTutorialProgress(ImiServices.Instance.progressManager.TutorialQuestInfo);
      if (ImiServices.Instance.progressManager.DailyChallengeInfo != null)
        this.ParseDailyChallenge(ImiServices.Instance.progressManager.DailyChallengeInfo);
      if (ImiServices.Instance.progressManager.MilestoneInfo == null)
        return;
      this.ParseMilestones(ImiServices.Instance.progressManager.MilestoneInfo);
    }

    private void OnPlayUnlockAnimationEvent()
    {
      this.parentLayoutGroup.gameObject.SetActive(true);
      this.panelVisible = true;
      this.GetComponent<Animator>().SetTrigger("unlock");
    }

    private void OnMenuChangedEvent()
    {
      bool flag1 = ImiServices.Instance.UiProgressionService == null || ImiServices.Instance.UiProgressionService.getCurrentProgressionState() == null || ImiServices.Instance.UiProgressionService.getCurrentProgressionState().challengeMenuState.enabled;
      if (ImiServices.Instance != null && ImiServices.Instance.UiProgressionService != null && ImiServices.Instance.UiProgressionService.getCurrentProgressionState() != null && ImiServices.Instance.UiProgressionService.getCurrentProgressionState().challengeMenuState.enabled && PlayerPrefs.HasKey("FTUEAnimationCompletedForStep") && PlayerPrefs.GetInt("FTUEAnimationCompletedForStep") != ImiServices.Instance.UiProgressionService.getCurrentProgressionState().stateID)
        flag1 = false;
      bool flag2 = false;
      if (flag1)
      {
        foreach (UnityEngine.Object visibleInMenu in this.visibleInMenus)
        {
          if ((UnityEngine.Object) MenuController.Instance.currentMenu == visibleInMenu)
          {
            flag2 = true;
            break;
          }
        }
      }
      this.parentLayoutGroup.gameObject.SetActive(flag2);
    }

    private void Update()
    {
      if (this.parentLayoutGroup.gameObject.activeInHierarchy)
      {
        if (this.input.GetButtonDown(DigitalInput.UIShortcut))
        {
          if (this.rewardEntries != null && this.rewardEntries.Count > 0)
            this.rewardEntries[0].GetComponent<DailyChallengeEntry>().CollectReward();
          else if (this.milestoneRewardEntries != null && this.milestoneRewardEntries.Count > 0)
            this.milestoneRewardEntries[0].GetComponent<DailyChallengeEntry>().CollectReward();
        }
        if (this.input.GetButtonDown(DigitalInput.UINext))
          this.ToggleShow();
        if (this.input.GetButtonDown(DigitalInput.UICancel) && this.panelVisible)
          this.HidePanel();
      }
      LayoutRebuilder.MarkLayoutForRebuild(this.parentLayoutGroup);
    }

    private void OnDisable() => this.HidePanel();

    public void OnPlayerLevelUpdated(ulong playerId, int playerLevel)
    {
      this.milestoneProgress.text = playerLevel.ToString() + "/" + (object) this.milestoneLevelGoal;
      int num = ImiServices.Instance.progressManager.GetPlayerLevel() - this.milestoneLevelGoal + 10;
      this.milestoneCompletionCircle.fillAmount = (float) num / 10f;
      this.milestoneRewardProgressBar.fillAmount = (float) num / 10f;
    }

    public void RemoveRewardFromList(GameObject entry)
    {
      if (!this.rewardEntries.Contains(entry))
        return;
      this.rewardEntries.Remove(entry);
    }

    private void UpdateRewardButtonPrompts()
    {
      if (this.rewardEntries == null)
        return;
      for (int index = 0; index < this.rewardEntries.Count; ++index)
      {
        if (index == 0)
        {
          this.rewardEntries[index].GetComponent<DailyChallengeEntry>().GetRewardButtonPrompt.SetActive(true);
          this.rewardEntries[index].GetComponent<DailyChallengeEntry>().twitchGetRewardButtonPrompt.SetActive(true);
        }
        else
        {
          this.rewardEntries[index].GetComponent<DailyChallengeEntry>().GetRewardButtonPrompt.SetActive(false);
          this.rewardEntries[index].GetComponent<DailyChallengeEntry>().twitchGetRewardButtonPrompt.SetActive(false);
        }
      }
    }

    public void OnUpdateProgressionStatus(
      Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> buttonStates,
      UIProgressionButtonState inviteButtonState,
      bool updateHighlightedState)
    {
      this.OnMenuChangedEvent();
    }

    public void ParseMilestones(JObject obj)
    {
      Log.Debug("Parsing Milestones from metaservice: " + obj.ToString());
      if (obj["error"] == null && obj["msg"] == null && obj["nextMilestone"] != null)
      {
        JToken jtoken = obj["nextMilestone"];
        this.milestonePanel.SetActive(true);
        this.milestoneLevelGoal = (int) jtoken[(object) "level"];
        this.milestoneProgress.text = ImiServices.Instance.progressManager.GetPlayerLevel().ToString() + "/" + (object) jtoken[(object) "level"];
        this.milestoneDescription.text = ImiServices.Instance.LocaService.GetLocalizedValue("@reachLevel") + " " + (object) jtoken[(object) "level"] + "!";
        if (jtoken[(object) "item"] != null)
        {
          ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID((int) jtoken[(object) "item"]);
          this.milestoneGoalItemId = itemById.definitionId;
          this.milestoneRewardTypeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + itemById.type.ToString());
          this.milestoneItemImage.sprite = itemById.icon;
          this.milestoneItemBackgroundImage.sprite = this.shopManager.tieredBackgrounds[(int) itemById.tier];
          this.milestoneBackgroundImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().GetTieredBackgroundSprite(itemById.tier);
        }
        if (jtoken[(object) "credits"] != null)
        {
          this.milestoneCreditsAmountText.text = ((int) jtoken[(object) "credits"]).ToString();
          this.milestoneItemBackgroundImage.sprite = this.shopManager.tieredBackgrounds[3];
          this.milestoneBackgroundImage.sprite = this.shopManager.tieredBackgrounds[3];
        }
        float y = 0.0f;
        this.ClearMilestoneRewards();
        if (obj["rewards"] != null)
        {
          for (int index = 0; index < obj["rewards"].Count<JToken>(); ++index)
          {
            JToken rewardResult = obj["rewards"][(object) index];
            if (!(bool) rewardResult[(object) "collected"])
            {
              GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.dailyChallengeEntryPrefab);
              y += gameObject.GetComponent<RectTransform>().sizeDelta.y;
              this.milestoneRewardEntries.Add(gameObject);
              gameObject.transform.SetParent((Transform) this.milestoneRewardParent, false);
              DailyChallengeEntry component = gameObject.GetComponent<DailyChallengeEntry>();
              component.SetStyleForCompleted();
              component.rewardPanelManager = this.gameObject;
              component.dailyChallengePanel = this.gameObject;
              this.SetEntryRewardContent(rewardResult, component);
              if (rewardResult[(object) "rewardId"] != null)
                component.rewardId = (int) rewardResult[(object) "rewardId"];
              if (rewardResult[(object) "id"] != null)
                component.rewardId = (int) rewardResult[(object) "id"];
            }
          }
        }
        this.milestoneHeightContainer.GetComponent<RectTransform>().sizeDelta = new Vector2(this.challengeHeightContainer.GetComponent<RectTransform>().sizeDelta.x, y);
        int num = ImiServices.Instance.progressManager.GetPlayerLevel() - (int) jtoken[(object) "level"] + 10;
        this.milestoneItemImage.preserveAspect = true;
        this.milestoneCompletionCircle.fillAmount = (float) num / 10f;
        this.milestoneRewardProgressBar.fillAmount = (float) num / 10f;
        this.SetRewardPanelsButtonsToDisable();
        foreach (Selectable selectable in this.challengePanelButtonsToDisable)
          selectable.navigation = this.noNavigation;
        this.RebuildLayoutElement();
      }
      else
        this.milestonePanel.SetActive(false);
    }

    public void ParseDailyChallenge(JObject obj)
    {
      this.SetTutorialComplete();
      Log.Debug("Parse daily challenges: " + (object) obj);
      this.ClearEntries();
      float y = 0.0f;
      if (obj["result"] != null)
      {
        for (int index = 0; index < obj["result"].Count<JToken>(); ++index)
        {
          JToken rewardResult = obj["result"][(object) index];
          GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.dailyChallengeEntryPrefab, (Transform) this.challengeParent, false);
          y += gameObject.GetComponent<RectTransform>().sizeDelta.y;
          this.dailyChallengeEntries.Add(gameObject);
          DailyChallengeEntry component = gameObject.GetComponent<DailyChallengeEntry>();
          component.rewardPanelManager = this.gameObject;
          component.dailyChallengePanel = this.gameObject;
          if ((bool) rewardResult[(object) "completed"])
          {
            component.SetStyleForNoChallenge();
            int num = (int) obj["result"][(object) index][(object) "countdown"];
            int secondsLeft = num * 60 + (int) (((double) (float) obj["result"][(object) index][(object) "countdown"] - (double) num) * 60.0);
            component.FillCountdown(secondsLeft);
          }
          else
            component.SetStyleForInProgress();
          this.SetEntryRewardContent(rewardResult, component);
          component.playerQuestId = (int) rewardResult[(object) "playerQuestId"];
          if (obj["result"][(object) index][(object) "rewardId"] != null)
            component.rewardId = (int) rewardResult[(object) "rewardId"];
          component.FillChallengeInfo(rewardResult[(object) "name"].ToString(), (int) rewardResult[(object) "progress"], (int) rewardResult[(object) "completionProgress"], component.rewardType, component.rewardAmount, component.rewardId);
        }
      }
      if (obj["rewards"] != null)
      {
        for (int index = 0; index < obj["rewards"].Count<JToken>(); ++index)
        {
          JToken rewardResult = obj["rewards"][(object) index];
          if (!(bool) rewardResult[(object) "collected"])
          {
            GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.dailyChallengeEntryPrefab);
            y += gameObject.GetComponent<RectTransform>().sizeDelta.y;
            this.rewardEntries.Add(gameObject);
            gameObject.transform.SetParent((Transform) this.challengeParent, false);
            DailyChallengeEntry component = gameObject.GetComponent<DailyChallengeEntry>();
            if (rewardResult[(object) "twitchDrop"] != null && (bool) rewardResult[(object) "twitchDrop"])
              component.SetStyleForTwitchDrop();
            else
              component.SetStyleForCompleted();
            component.rewardPanelManager = this.gameObject;
            component.dailyChallengePanel = this.gameObject;
            this.SetEntryRewardContent(rewardResult, component);
            component.playerQuestId = (int) rewardResult[(object) "playerQuestId"];
            if (rewardResult[(object) "rewardId"] != null)
              component.rewardId = (int) rewardResult[(object) "rewardId"];
            if (rewardResult[(object) "id"] != null)
              component.rewardId = (int) rewardResult[(object) "id"];
          }
        }
        this.UpdateRewardButtonPrompts();
      }
      this.SetRewardPanelsButtonsToDisable();
      this.challengeHeightContainer.GetComponent<RectTransform>().sizeDelta = new Vector2(this.challengeHeightContainer.GetComponent<RectTransform>().sizeDelta.x, y);
      this.RebuildLayoutElement();
      Log.Debug(obj.ToString());
    }

    private void SetTutorialComplete()
    {
      this.tutorialHeightController.GetComponent<RectTransform>().sizeDelta = new Vector2(this.tutorialHeightController.GetComponent<RectTransform>().sizeDelta.x, 0.0f);
      ImiServices.Instance.UiProgressionService.SetCurrentProgressionState(0);
    }

    private void ParseTutorialProgress(JObject obj)
    {
      if (obj == null || obj["error"] != null || obj["msg"] != null || obj["result"] == null)
      {
        Log.Error("Failed parsing tutorials. CHecking for daily quests.");
        this.SetTutorialComplete();
      }
      else if (!obj["result"].Any<JToken>() && !obj["rewards"].Any<JToken>())
      {
        Log.Error("No Tutorial quests. Requesting daily challenges.");
        this.SetTutorialComplete();
      }
      else
      {
        Log.Debug("Parsing tutorial quests: " + (object) obj);
        if (obj["result"].Any<JToken>())
        {
          string str = obj["result"][(object) 0][(object) "name"].ToString();
          if (!(str == "tutorialBasicTraining"))
          {
            if (!(str == "tutorialAdvancedTraining"))
            {
              if (!(str == "tutorialQuickMatch"))
                return;
              ImiServices.Instance.UiProgressionService.SetCurrentProgressionState(3);
            }
            else
              ImiServices.Instance.UiProgressionService.SetCurrentProgressionState(2);
          }
          else
            ImiServices.Instance.UiProgressionService.SetCurrentProgressionState(1);
        }
        else
        {
          ImiServices.Instance.UiProgressionService.SetCurrentProgressionState(4);
          JToken jtoken = obj["rewards"][(object) 0];
          DailyChallengeEntry.ChallengeRewardType type = DailyChallengeEntry.ChallengeRewardType.None;
          int num = 0;
          if (!jtoken[(object) "steelReward"].ToString().IsNullOrEmpty() && (int) jtoken[(object) "steelReward"] > 0)
          {
            type = DailyChallengeEntry.ChallengeRewardType.Steel;
            num = (int) jtoken[(object) "steelReward"];
          }
          if (!jtoken[(object) "creditReward"].ToString().IsNullOrEmpty() && (int) jtoken[(object) "creditReward"] > 0)
          {
            type = DailyChallengeEntry.ChallengeRewardType.Creds;
            num = (int) jtoken[(object) "creditReward"];
          }
          ImiServices.Instance.UiProgressionService.SetCurrentProgressionReward(type, num);
          this.CollectReward((int) jtoken[(object) "id"], type, num);
        }
      }
    }

    public void CollectReward(
      int rewardId,
      DailyChallengeEntry.ChallengeRewardType type,
      int amount)
    {
      if (rewardId != 0)
        this.StartCoroutine(MetaServiceHelpers.CollectQuestReward(ImiServices.Instance.LoginService.GetPlayerId(), rewardId, type, amount, new Action<JObject, DailyChallengeEntry.ChallengeRewardType, int>(this.OnCollectTutorialReward)));
      else
        Log.Warning("No reward Id set for daily Challenge!");
    }

    public void OnCollectTutorialReward(
      JObject result,
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount)
    {
      if (result["error"] == null && result["msg"] == null)
      {
        if (rewardType == DailyChallengeEntry.ChallengeRewardType.Creds || rewardType == DailyChallengeEntry.ChallengeRewardType.Steel)
          ImiServices.Instance.progressManager.FetchPlayerProgress();
        ImiServices.Instance.progressManager.StartLoadingQuestProgress();
      }
      else
      {
        if (result["error"] != null)
          Log.Error("Error Collecting rewards: " + (object) result["errror"]);
        if (result["msg"] == null)
          return;
        Log.Error("Error Collecting rewards: " + (object) result["msg"]);
      }
    }

    private void GetMainMenuPanelButtons()
    {
      foreach (Button componentsInChild in MenuController.Instance.mainMenuPanel.gameObject.GetComponentsInChildren<Button>())
      {
        if (componentsInChild.navigation.mode == Navigation.Mode.Automatic)
          this.mainMenuButtonsToDisable.Add(componentsInChild);
      }
    }

    private void ClearEntries()
    {
      foreach (UnityEngine.Object rewardEntry in this.rewardEntries)
        UnityEngine.Object.Destroy(rewardEntry);
      foreach (UnityEngine.Object dailyChallengeEntry in this.dailyChallengeEntries)
        UnityEngine.Object.Destroy(dailyChallengeEntry);
      this.rewardEntries = new List<GameObject>();
      this.dailyChallengeEntries = new List<GameObject>();
    }

    private void ClearMilestoneRewards()
    {
      foreach (UnityEngine.Object milestoneRewardEntry in this.milestoneRewardEntries)
        UnityEngine.Object.Destroy(milestoneRewardEntry);
      this.milestoneRewardEntries = new List<GameObject>();
    }

    private void ClearTutorialEntries()
    {
      foreach (UnityEngine.Object tutorialEntry in this.tutorialEntries)
        UnityEngine.Object.Destroy(tutorialEntry);
      this.tutorialEntries = new List<GameObject>();
    }

    private void SetRewardPanelsButtonsToDisable()
    {
      this.challengePanelButtonsToDisable = new List<Button>();
      foreach (GameObject dailyChallengeEntry in this.dailyChallengeEntries)
      {
        foreach (Button componentsInChild in dailyChallengeEntry.GetComponentsInChildren<Button>())
        {
          if (componentsInChild.navigation.mode == Navigation.Mode.Automatic)
            this.challengePanelButtonsToDisable.Add(componentsInChild);
        }
      }
      foreach (GameObject rewardEntry in this.rewardEntries)
      {
        foreach (Button componentsInChild in rewardEntry.GetComponentsInChildren<Button>())
        {
          if (componentsInChild.navigation.mode == Navigation.Mode.Automatic)
            this.challengePanelButtonsToDisable.Add(componentsInChild);
        }
      }
      foreach (Button componentsInChild in this.milestonePanel.GetComponentsInChildren<Button>())
      {
        if (componentsInChild.navigation.mode == Navigation.Mode.Automatic)
          this.challengePanelButtonsToDisable.Add(componentsInChild);
      }
    }

    private void SetEntryRewardContent(JToken rewardResult, DailyChallengeEntry newChallengeEntry)
    {
      int num1 = 0;
      int num2 = 0;
      DailyChallengeEntry.ChallengeRewardType challengeRewardType = DailyChallengeEntry.ChallengeRewardType.None;
      if (rewardResult[(object) "steelReward"].ToString() != "" && (int) rewardResult[(object) "steelReward"] > 0)
      {
        challengeRewardType = DailyChallengeEntry.ChallengeRewardType.Steel;
        num1 = (int) rewardResult[(object) "steelReward"];
      }
      if (rewardResult[(object) "creditReward"].ToString() != "" && (int) rewardResult[(object) "creditReward"] > 0)
      {
        challengeRewardType = DailyChallengeEntry.ChallengeRewardType.Creds;
        num1 = (int) rewardResult[(object) "creditReward"];
      }
      if (rewardResult[(object) "xpReward"].ToString() != "" && (int) rewardResult[(object) "xpReward"] > 0)
      {
        challengeRewardType = DailyChallengeEntry.ChallengeRewardType.XP;
        num1 = (int) rewardResult[(object) "xpReward"];
      }
      if (rewardResult[(object) "itemReward"].ToString() != "" && rewardResult[(object) "itemReward"].ToString() != "null")
      {
        challengeRewardType = DailyChallengeEntry.ChallengeRewardType.Item;
        num2 = (int) rewardResult[(object) "itemReward"];
      }
      newChallengeEntry.rewardItemId = num2;
      newChallengeEntry.rewardType = challengeRewardType;
      newChallengeEntry.rewardAmount = num1;
      newChallengeEntry.rewardRewardAmountText.text = num1.ToString();
      newChallengeEntry.twitchRewardRewardAmountText.text = num1.ToString();
      switch (newChallengeEntry.rewardType)
      {
        case DailyChallengeEntry.ChallengeRewardType.Steel:
          newChallengeEntry.rewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().steelSprite;
          newChallengeEntry.twitchRewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().steelSprite;
          break;
        case DailyChallengeEntry.ChallengeRewardType.Creds:
          newChallengeEntry.rewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().creditsSprite;
          newChallengeEntry.twitchRewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().creditsSprite;
          break;
        default:
          newChallengeEntry.rewardCurrencyIconImage.gameObject.SetActive(false);
          newChallengeEntry.twitchRewardCurrencyIconImage.gameObject.SetActive(false);
          break;
      }
    }

    public void ShowRewardPanel(
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount)
    {
      this.rewardOverlayPanel.GetComponent<ShowChallengeRewards>().Show(this.rewardDurationTime, rewardType, rewardAmount);
      this.SetRewardPanelsButtonsToDisable();
    }

    public void SetChallengeContainerDimensions()
    {
      float y = 0.0f;
      foreach (Transform transform in this.challengeParent.transform)
        y += transform.GetComponent<RectTransform>().sizeDelta.y;
      this.challengeParent.sizeDelta = new Vector2(this.challengeParent.sizeDelta.x, y);
      this.challengeParent.anchoredPosition = new Vector2(this.challengeParent.sizeDelta.x / 2f, y / -2f);
    }

    public void RebuildLayoutElement()
    {
      this.UpdateRewardButtonPrompts();
      if (!this.gameObject.activeInHierarchy)
        return;
      this.StartCoroutine(this.DelayedRebuildLayoutElement());
    }

    public IEnumerator DelayedRebuildLayoutElement()
    {
      yield return (object) 0;
      LayoutRebuilder.MarkLayoutForRebuild(this.challengeParent);
    }

    public void RemoveEntry(GameObject entry)
    {
      this.challengeHeightContainer.sizeDelta = new Vector2(this.challengeHeightContainer.sizeDelta.x, this.challengeHeightContainer.sizeDelta.y - entry.GetComponent<RectTransform>().sizeDelta.y);
      if (this.rewardEntries.Contains(entry))
        this.rewardEntries.Remove(entry);
      if (!this.dailyChallengeEntries.Contains(entry))
        return;
      this.dailyChallengeEntries.Remove(entry);
    }

    public void PreviewChallengeItem()
    {
      MenuController.Instance.shopBuyPanel.ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
      MenuController.Instance.shopBuyPanel.GetComponent<ShopPanel>().FillShopPanelPreview(SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this.milestoneGoalItemId), ImiServices.Instance.LocaService.GetLocalizedValue("@unlockedAtLevel") + " " + (object) this.milestoneLevelGoal + "!");
    }

    private void HidePanel()
    {
      foreach (Selectable selectable in this.challengePanelButtonsToDisable)
        selectable.navigation = this.noNavigation;
      this.panelVisible = false;
      this.GetComponent<Animator>().ResetTrigger("enter");
      this.GetComponent<Animator>().SetTrigger("exit");
    }

    private void ShowPanel()
    {
      foreach (Button button in this.challengePanelButtonsToDisable)
      {
        if ((UnityEngine.Object) button != (UnityEngine.Object) null && !button.IsDestroyed())
          button.navigation = this.autoNavigation;
      }
      this.panelVisible = true;
      this.GetComponent<Animator>().ResetTrigger("exit");
      this.GetComponent<Animator>().SetTrigger("enter");
    }

    public void ToggleShow()
    {
      if (this.panelVisible)
        this.HidePanel();
      else
        this.ShowPanel();
    }
  }
}
