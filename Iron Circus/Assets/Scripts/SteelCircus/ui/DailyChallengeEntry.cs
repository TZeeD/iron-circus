// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.DailyChallengeEntry
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Diagnostics;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class DailyChallengeEntry : MonoBehaviour
  {
    private Stopwatch countdown;
    private int timeLeftToNewChallenge;
    [Header("RewardBackgroundGraphics")]
    [SerializeField]
    private Sprite steelBG;
    [SerializeField]
    private Sprite credsBG;
    [SerializeField]
    private Sprite emptyBG;
    [Header("ObjectReferences")]
    public GameObject dailyChallengePanel;
    [SerializeField]
    private TextMeshProUGUI challengeNameText;
    [SerializeField]
    private TextMeshProUGUI challengeDescriptionText;
    [SerializeField]
    private Image completionCircle;
    [SerializeField]
    private TextMeshProUGUI completionAmountText;
    [SerializeField]
    public TextMeshProUGUI challengeRewardAmountText;
    [SerializeField]
    private Image challengeRewardIcon;
    [Header("Empty Challenge Objects")]
    [SerializeField]
    private TextMeshProUGUI noChallengeText;
    [SerializeField]
    private TextMeshProUGUI noChallengeCountdownText;
    [SerializeField]
    private Image noChallengeTimerFillCircle;
    [Header("Reward Objects")]
    [SerializeField]
    public Image rewardCurrencyIconImage;
    [SerializeField]
    private Image rewardBackgroundImage;
    [SerializeField]
    public TextMeshProUGUI rewardRewardAmountText;
    [SerializeField]
    public GameObject GetRewardButtonPrompt;
    [Header("Twitch Reward Objects")]
    [SerializeField]
    public Image twitchRewardCurrencyIconImage;
    [SerializeField]
    private Image twitchRewardBackgroundImage;
    [SerializeField]
    public TextMeshProUGUI twitchRewardRewardAmountText;
    [SerializeField]
    public GameObject twitchGetRewardButtonPrompt;
    [Header("Reward Info")]
    public int playerQuestId;
    public int rewardId;
    public DailyChallengeEntry.ChallengeRewardType rewardType;
    public int rewardAmount;
    public GameObject rewardPanelManager;
    public int rewardItemId;
    [Header("SubstateObjects")]
    [SerializeField]
    private GameObject InProgressGroup;
    [SerializeField]
    private GameObject completedGroup;
    [SerializeField]
    private GameObject noChallengeGroup;
    [SerializeField]
    private GameObject rewardsButtonGroup;
    [SerializeField]
    private GameObject twitchDropGroup;

    private void Update()
    {
      if (this.countdown == null || !this.countdown.IsRunning)
        return;
      if (this.countdown.ElapsedMilliseconds >= (long) (this.timeLeftToNewChallenge * 1000))
      {
        ImiServices.Instance.progressManager.StartLoadingQuestProgress();
        this.countdown.Stop();
      }
      else
      {
        TimeSpan timeSpan = TimeSpan.FromMilliseconds((double) ((long) (this.timeLeftToNewChallenge * 1000) - this.countdown.ElapsedMilliseconds));
        this.noChallengeCountdownText.text = string.Format("{0:D}:{1:D2}:{2:D2}:{3:D2}", (object) timeSpan.Days, (object) timeSpan.Hours, (object) timeSpan.Minutes, (object) timeSpan.Seconds);
      }
    }

    public void FillCountdown(int secondsLeft)
    {
      this.timeLeftToNewChallenge = secondsLeft;
      this.countdown = new Stopwatch();
      this.countdown.Start();
    }

    public IEnumerator ChallengeCountdown(int seconds)
    {
      while (seconds >= 0)
      {
        if ((UnityEngine.Object) MenuController.Instance != (UnityEngine.Object) null)
        {
          this.noChallengeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NextChallengeIn");
          this.noChallengeCountdownText.text = ((int) ((double) seconds / 3600.0)).ToString() + ":" + ((int) ((double) seconds / 60.0) % 60).ToString("D2") + ":" + (seconds % 60).ToString("D2");
          this.noChallengeTimerFillCircle.fillAmount = (float) (1.0 - 86400.0 / (double) seconds);
          --seconds;
          yield return (object) new WaitForSeconds(1f);
        }
      }
    }

    public void CollectReward()
    {
      if (this.rewardId != 0)
        this.StartCoroutine(MetaServiceHelpers.CollectQuestReward(ImiServices.Instance.LoginService.GetPlayerId(), this.rewardId, this.rewardType, this.rewardAmount, new Action<JObject, DailyChallengeEntry.ChallengeRewardType, int>(this.OnCollectRewardSuccessfully)));
      else
        Imi.Diagnostics.Log.Warning("No reward Id set for daily Challenge!");
    }

    public void OnCollectRewardSuccessfully(
      JObject result,
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount)
    {
      if (result["error"] == null && result["msg"] == null)
      {
        if (rewardType == DailyChallengeEntry.ChallengeRewardType.Creds || rewardType == DailyChallengeEntry.ChallengeRewardType.Steel)
          ImiServices.Instance.progressManager.FetchPlayerProgress();
        this.rewardPanelManager.GetComponent<DailyChallengePanel>().ShowRewardPanel(rewardType, rewardAmount);
        this.GetComponentInChildren<Selectable>().navigation = new Navigation()
        {
          mode = Navigation.Mode.None
        };
        this.GetComponent<Animator>().SetTrigger("hide");
        this.GetComponent<RectTransform>().parent = MenuController.Instance.mainMenuPanel.transform;
        this.dailyChallengePanel.GetComponent<DailyChallengePanel>().RemoveRewardFromList(this.gameObject);
        this.dailyChallengePanel.GetComponent<DailyChallengePanel>().SetChallengeContainerDimensions();
        this.dailyChallengePanel.GetComponent<DailyChallengePanel>().RebuildLayoutElement();
      }
      else
      {
        if (result["error"] != null)
          Imi.Diagnostics.Log.Error("Error Collecting rewards: " + (object) result["errror"]);
        if (result["msg"] == null)
          return;
        Imi.Diagnostics.Log.Error("Error Collecting rewards: " + (object) result["msg"]);
      }
    }

    public void FillChallengeInfo(
      string challengeNameLocaString,
      int challengeCurrentValue,
      int challengeMaxValue,
      DailyChallengeEntry.ChallengeRewardType reward,
      int challengeRewardAmount = 1,
      int challengeRewardItemId = 0)
    {
      this.challengeNameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + challengeNameLocaString);
      if ((UnityEngine.Object) this.challengeDescriptionText != (UnityEngine.Object) null)
        this.challengeDescriptionText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + challengeNameLocaString + "Description");
      this.completionAmountText.text = challengeCurrentValue.ToString() + "/" + (object) challengeMaxValue;
      this.completionCircle.fillAmount = (float) challengeCurrentValue / (float) challengeMaxValue;
      if ((UnityEngine.Object) this.challengeRewardAmountText != (UnityEngine.Object) null)
      {
        if (challengeRewardAmount > 1)
        {
          this.challengeRewardAmountText.gameObject.SetActive(true);
          this.challengeRewardAmountText.text = challengeRewardAmount.ToString();
        }
        else
          this.challengeRewardAmountText.gameObject.SetActive(false);
      }
      switch (reward)
      {
        case DailyChallengeEntry.ChallengeRewardType.Steel:
          this.challengeRewardIcon.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().steelSprite;
          this.rewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().steelSprite;
          this.rewardBackgroundImage.sprite = this.steelBG;
          break;
        case DailyChallengeEntry.ChallengeRewardType.Creds:
          this.challengeRewardIcon.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().creditsSprite;
          this.rewardCurrencyIconImage.sprite = MenuController.Instance.shopMenu.GetComponent<ShopManager>().creditsSprite;
          this.rewardBackgroundImage.sprite = this.credsBG;
          break;
        case DailyChallengeEntry.ChallengeRewardType.Item:
          this.challengeRewardIcon.sprite = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(challengeRewardItemId).icon;
          this.rewardCurrencyIconImage.gameObject.SetActive(false);
          this.rewardBackgroundImage.sprite = this.emptyBG;
          break;
        case DailyChallengeEntry.ChallengeRewardType.XP:
          this.rewardCurrencyIconImage.gameObject.SetActive(false);
          this.challengeRewardIcon.sprite = (Sprite) null;
          this.rewardBackgroundImage.sprite = this.emptyBG;
          break;
        case DailyChallengeEntry.ChallengeRewardType.None:
          this.rewardCurrencyIconImage.gameObject.SetActive(false);
          this.challengeRewardIcon.sprite = (Sprite) null;
          this.rewardsButtonGroup.SetActive(false);
          this.rewardBackgroundImage.sprite = this.emptyBG;
          break;
      }
      this.challengeRewardIcon.preserveAspect = true;
      this.rewardCurrencyIconImage.preserveAspect = true;
      this.rewardBackgroundImage.preserveAspect = true;
    }

    public void BackgroundClickedAction() => this.dailyChallengePanel.GetComponent<DailyChallengePanel>().ToggleShow();

    private void HideAllGroups()
    {
      this.twitchDropGroup.SetActive(false);
      this.rewardsButtonGroup.SetActive(false);
      this.completedGroup.SetActive(false);
      this.InProgressGroup.SetActive(false);
      if (!((UnityEngine.Object) this.noChallengeGroup != (UnityEngine.Object) null))
        return;
      this.noChallengeGroup.SetActive(false);
    }

    public void SetStyleForCompleted()
    {
      this.HideAllGroups();
      this.completedGroup.SetActive(true);
      this.rewardsButtonGroup.SetActive(false);
    }

    public void SetStyleForInProgress()
    {
      this.HideAllGroups();
      this.InProgressGroup.SetActive(true);
      this.rewardsButtonGroup.SetActive(true);
    }

    public void SetStyleForNoChallenge()
    {
      this.HideAllGroups();
      this.noChallengeGroup.SetActive(true);
    }

    public void SetStyleForTwitchDrop()
    {
      this.HideAllGroups();
      this.twitchDropGroup.SetActive(true);
    }

    public void Remove()
    {
      this.rewardPanelManager.GetComponent<DailyChallengePanel>().RemoveEntry(this.gameObject);
      UnityEngine.Object.Destroy((UnityEngine.Object) this.gameObject);
    }

    public enum ChallengeRewardType
    {
      Steel,
      Creds,
      Item,
      XP,
      None,
    }
  }
}
