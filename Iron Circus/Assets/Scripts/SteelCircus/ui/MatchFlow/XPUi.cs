// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.XPUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
  public class XPUi : MonoBehaviour
  {
    [SerializeField]
    private GameObject XPPanel;
    [Header("XP UI")]
    [SerializeField]
    private Text matchOutcomeTxt;
    [SerializeField]
    private TextMeshProUGUI currentLevelTxt;
    [SerializeField]
    private TextMeshProUGUI nextLevelTxt;
    [SerializeField]
    private Image XPBar;
    [SerializeField]
    private TextMeshProUGUI totalEarnedXPTxt;
    [SerializeField]
    private TextMeshProUGUI currentXPProgressTxt;
    [SerializeField]
    private TextMeshProUGUI nextLevelXPText;
    [SerializeField]
    private TextMeshProUGUI rewardText;
    [SerializeField]
    private Transform xpArrowParent;
    [Header("Achievement Panels")]
    [SerializeField]
    private GameObject achievementGroup;
    [Header("Rewards Panel")]
    [SerializeField]
    private GameObject creditsRewardImage;
    [SerializeField]
    private GameObject steelRewardImage;
    [SerializeField]
    private GameObject itemRewardImage;
    [SerializeField]
    private GameObject itemRewardIconImage;
    [Header("DebugSprites")]
    public Sprite debugSpriteA;
    public Sprite debugSpriteB;
    public Sprite debugSpriteC;
    [SerializeField]
    private Sprite bonusIcon;
    [SerializeField]
    private Sprite mvpIcon;
    [SerializeField]
    private Sprite participantIcon;
    [SerializeField]
    private Sprite rewardIcon;
    [SerializeField]
    private Sprite winIcon;
    [SerializeField]
    private Sprite penaltyIcon;
    [Header("Prefabs")]
    [SerializeField]
    private GameObject achievementPanelPrefab;
    [SerializeField]
    private GameObject matchEndXPRewardPrefab;
    private List<GameObject> allAchievementPanels;
    [Header("Animators")]
    [SerializeField]
    private Animator levelUpRewardAnimator;
    [SerializeField]
    private Animator levelUpDisplayAnimator;
    private IEnumerator waitForRewardsPanelCoroutine;
    private int currentLevelStartXP;
    private int currentLevel;
    private int leftoverXPAfterCurrentLevel;
    private float xPBarFillduration;
    public XPUi.xpStats stats;
    public MVPScreen.mvpStats awardStats;
    public GameStatMatchFinishedEvent.MatchResult matchResult;
    public bool animFinished;
    public bool animStarted;
    public bool skipTrigger;
    public bool rewardPanelActive;

    public void SkipStep()
    {
      if (this.rewardPanelActive)
      {
        this.xPBarFillduration = 3f;
        this.HideRewardsPanel();
        this.StopCoroutine(this.waitForRewardsPanelCoroutine);
        this.FillXpBarToNextLevel();
      }
      else
      {
        this.skipTrigger = true;
        this.xPBarFillduration = 0.1f;
        if (this.animStarted)
          return;
        this.animStarted = true;
        this.FillXpBarToNextLevel();
      }
    }

    public void StopSkipStep()
    {
      this.skipTrigger = false;
      this.xPBarFillduration = 3f;
    }

    private void Start() => this.allAchievementPanels = new List<GameObject>();

    public void SetUiValues(
      int currentLevel,
      int nextLevel,
      int totalEarnedXp,
      int currentXPProgress,
      int levelUpXpValue)
    {
      this.currentLevelTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@lvl") + currentLevel.ToString();
      this.nextLevelTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@lvl") + nextLevel.ToString();
      this.totalEarnedXPTxt.text = totalEarnedXp.ToString();
      this.currentXPProgressTxt.text = currentXPProgress.ToString();
      this.nextLevelXPText.text = currentXPProgress.ToString() + "/" + (object) levelUpXpValue;
    }

    public void SetMatchOutcome(string result, Color color)
    {
      this.matchOutcomeTxt.text = result;
      this.matchOutcomeTxt.color = color;
    }

    public IEnumerator PopulateAchievementGroup(
      GameStatMatchFinishedEvent.MatchResult result)
    {
      GameObject[] gameObjectArray = new GameObject[this.stats.boni.Length];
      if (this.stats.xpGainedThroughMatchOutcome > 0 || this.stats.penaltiesLeft > 0)
      {
        Sprite debugSpriteA = this.debugSpriteA;
        string key;
        Sprite iconSprite;
        if (result.outcome == MatchOutcome.Win)
        {
          key = "@WIN";
          iconSprite = this.winIcon;
        }
        else
        {
          key = "@COMPLETED MATCH";
          iconSprite = this.participantIcon;
        }
        this.AddAchievementPanel().GetComponent<AchievementPanelUI>().StyleAchievementPanel(iconSprite, ImiServices.Instance.LocaService.GetLocalizedValue(key), this.stats.xpGainedThroughMatchOutcome);
      }
      if (this.stats.xpGainedThroughAwards > 0)
      {
        Sprite debugSpriteA = this.debugSpriteA;
        string key;
        Sprite iconSprite;
        if (this.stats.isMVP)
        {
          key = "@MVP";
          iconSprite = this.mvpIcon;
        }
        else
        {
          key = "@AwardBadge";
          iconSprite = this.rewardIcon;
        }
        this.AddAchievementPanel().GetComponent<AchievementPanelUI>().StyleAchievementPanel(iconSprite, ImiServices.Instance.LocaService.GetLocalizedValue(key), this.stats.xpGainedThroughAwards);
      }
      if (gameObjectArray.Length != 0)
      {
        for (int index = 0; index < gameObjectArray.Length; ++index)
        {
          GameObject gameObject = this.AddAchievementPanel();
          gameObjectArray[index] = gameObject;
          gameObject.GetComponent<AchievementPanelUI>().StyleAchievementPanel(this.bonusIcon, ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.stats.boni[index].name), this.stats.boni[index].bonusXP);
        }
      }
      if (this.stats.penaltiesLeft > 0)
      {
        GameObject gameObject = this.AddAchievementPanel();
        gameObject.GetComponent<AchievementPanelUI>().StyleAchievementPanel(this.penaltyIcon, ImiServices.Instance.LocaService.GetLocalizedValue(""), 0);
        gameObject.GetComponent<AchievementPanelUI>().HideXP();
        gameObject.GetComponent<AchievementPanelUI>().StyleAchievementDescription("@PenaltyRewardMessage", Color.red);
      }
      if (this.stats.steelGainedThroughMatchOutcome > 0)
        this.AddSteelRewardAchievementPanel().GetComponent<SteelRewardAchievementPanelUI>().StyleAchievementPanel(ImiServices.Instance.LocaService.GetLocalizedValue("@MatchEndSteelReward"), this.stats.steelGainedThroughMatchOutcome);
      foreach (GameObject panel in this.allAchievementPanels)
      {
        if ((Object) panel != (Object) null)
        {
          if (!this.skipTrigger)
            yield return (object) new WaitForSeconds(0.3f);
          panel.GetComponent<Animator>().SetTrigger("activate");
          AudioController.Play("ShowSmallCard");
        }
      }
    }

    public GameObject AddAchievementPanel()
    {
      GameObject gameObject = Object.Instantiate<GameObject>(this.achievementPanelPrefab, this.achievementGroup.transform, false);
      this.allAchievementPanels.Add(gameObject);
      return gameObject;
    }

    public GameObject AddSteelRewardAchievementPanel()
    {
      GameObject gameObject = Object.Instantiate<GameObject>(this.matchEndXPRewardPrefab, this.achievementGroup.transform, false);
      this.allAchievementPanels.Add(gameObject);
      return gameObject;
    }

    public void SetXPBarStartPosition(int startXp, int levelUpXpValue)
    {
      float num = (float) (1255 - 1255 * startXp / levelUpXpValue);
      this.XPBar.GetComponent<RectTransform>().offsetMax = new Vector2(-1f * num, this.XPBar.GetComponent<RectTransform>().offsetMax.y);
      this.xpArrowParent.GetComponent<RectTransform>().anchoredPosition = new Vector2(1255f - num, this.xpArrowParent.GetComponent<RectTransform>().anchoredPosition.y);
    }

    public void FillXpBarToNextLevel()
    {
      this.SetXPBarStartPosition(this.currentLevelStartXP, this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded);
      this.SetUiValues(this.currentLevel, this.currentLevel + 1, this.stats.xpGained, this.currentLevelStartXP, this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded);
      int num = this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded - this.currentLevelStartXP;
      bool levelUp = false;
      if (this.leftoverXPAfterCurrentLevel >= num)
      {
        float duration = this.xPBarFillduration * ((float) num / (float) this.stats.xpGained);
        levelUp = true;
        this.StartCoroutine(this.FillXpBar(this.currentLevelStartXP, this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded, this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded, duration, levelUp, this.currentLevel + 1));
      }
      else
        this.StartCoroutine(this.FillXpBar(this.currentLevelStartXP, this.currentLevelStartXP + this.leftoverXPAfterCurrentLevel, this.stats.levels[this.currentLevel - this.stats.startLevel].xpNeeded, this.xPBarFillduration * ((float) this.leftoverXPAfterCurrentLevel / (float) this.stats.xpGained)));
      if (!levelUp)
        return;
      this.leftoverXPAfterCurrentLevel -= num;
      ++this.currentLevel;
      this.currentLevelStartXP = 0;
    }

    private IEnumerator FillXpBar(
      int startXP,
      int endXP,
      int levelUpXP,
      float duration,
      bool levelUp = false,
      int newLevel = 0)
    {
      XPUi xpUi = this;
      AudioController.Play("XpProgressBar");
      for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float num = (float) (1255 - 1355 * startXP / levelUpXP) - 1355f * i / duration * (float) (endXP - startXP) / (float) levelUpXP;
        xpUi.XPBar.GetComponent<RectTransform>().offsetMax = new Vector2(-1f * num, xpUi.XPBar.GetComponent<RectTransform>().offsetMax.y);
        xpUi.xpArrowParent.GetComponent<RectTransform>().anchoredPosition = new Vector2(1255f - num, xpUi.xpArrowParent.GetComponent<RectTransform>().anchoredPosition.y);
        xpUi.currentXPProgressTxt.text = ((int) Mathf.Lerp((float) startXP, (float) endXP, i / duration)).ToString();
        xpUi.nextLevelXPText.text = ((int) Mathf.Lerp((float) startXP, (float) endXP, i / duration)).ToString() + "/" + (object) levelUpXP;
        yield return (object) null;
        if (xpUi.skipTrigger)
          break;
      }
      float num1 = (float) (1255 - 1355 * startXP / levelUpXP - 1355 * (endXP - startXP) / levelUpXP);
      xpUi.XPBar.GetComponent<RectTransform>().offsetMax = new Vector2(-1f * num1, xpUi.XPBar.GetComponent<RectTransform>().offsetMax.y);
      xpUi.xpArrowParent.GetComponent<RectTransform>().anchoredPosition = new Vector2(1255f - num1, xpUi.xpArrowParent.GetComponent<RectTransform>().anchoredPosition.y);
      xpUi.currentXPProgressTxt.text = ((int) Mathf.Lerp((float) startXP, (float) endXP, 1f)).ToString();
      xpUi.nextLevelXPText.text = ((int) Mathf.Lerp((float) startXP, (float) endXP, 1f)).ToString() + "/" + (object) levelUpXP;
      yield return (object) null;
      if (levelUp)
      {
        xpUi.StopSkipStep();
        AudioController.Stop("XpProgressBar", 0.25f);
        xpUi.waitForRewardsPanelCoroutine = xpUi.WaitForRewardsPanel(6f, newLevel);
        xpUi.StartCoroutine(xpUi.waitForRewardsPanelCoroutine);
      }
      else
      {
        xpUi.animFinished = true;
        AudioController.Stop("XpProgressBar", 0.35f);
      }
    }

    private IEnumerator WaitForRewardsPanel(float duration, int newLevel)
    {
      this.levelUpRewardAnimator.SetTrigger("activateReward");
      this.ShowRewardsPanel(this.stats.levels[newLevel - this.stats.startLevel - 1]);
      yield return (object) new WaitForSeconds(duration);
      this.HideRewardsPanel();
      this.FillXpBarToNextLevel();
    }

    public void ShowRewardsPanel(XPUi.xpStats.level rewards)
    {
      this.steelRewardImage.SetActive(false);
      this.creditsRewardImage.SetActive(false);
      this.itemRewardImage.SetActive(false);
      if (rewards.steelReward > 0)
      {
        this.steelRewardImage.SetActive(true);
        this.rewardText.text = rewards.steelReward.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@STEEL EARNED");
      }
      if (rewards.hasItemReward)
      {
        this.itemRewardImage.SetActive(true);
        this.itemRewardIconImage.GetComponent<Image>().sprite = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(rewards.itemRewardId).icon;
        this.rewardText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@ITEM RECEIVED");
      }
      this.rewardPanelActive = true;
      this.achievementGroup.GetComponent<CanvasGroup>().alpha = 0.0f;
      this.levelUpDisplayAnimator.gameObject.SetActive(true);
      this.levelUpDisplayAnimator.Play("Activate_anim");
      this.levelUpDisplayAnimator.ResetTrigger("hide");
      AudioController.Play("LevelUp");
      AudioController.Play("CoinReward");
    }

    public void HideRewardsPanel()
    {
      this.rewardPanelActive = false;
      this.levelUpRewardAnimator.SetTrigger("deactivateReward");
      this.levelUpDisplayAnimator.SetTrigger("hide");
      this.achievementGroup.GetComponent<CanvasGroup>().alpha = 1f;
    }

    public IEnumerator PlayXPScreenCoroutine()
    {
      XPUi xpUi = this;
      xpUi.xPBarFillduration = 3f;
      xpUi.levelUpDisplayAnimator.gameObject.SetActive(false);
      xpUi.XPPanel.SetActive(true);
      xpUi.GetComponentInParent<Animator>().SetTrigger("swipeToXP");
      xpUi.StartCoroutine(xpUi.PopulateAchievementGroup(xpUi.matchResult));
      xpUi.SetXPBarStartPosition(xpUi.stats.xpStartLevel, xpUi.stats.levels[0].xpNeeded);
      xpUi.currentLevel = xpUi.stats.startLevel;
      xpUi.currentLevelStartXP = xpUi.stats.xpStartLevel;
      xpUi.leftoverXPAfterCurrentLevel = xpUi.stats.xpGained;
      xpUi.SetUiValues(xpUi.currentLevel, xpUi.currentLevel + 1, xpUi.stats.xpGained, xpUi.stats.xpStartLevel, xpUi.stats.levels[0].xpNeeded);
      yield return (object) new WaitForSeconds(2.5f);
      if (!xpUi.animStarted)
      {
        xpUi.animStarted = true;
        xpUi.FillXpBarToNextLevel();
      }
    }

    public class xpStats
    {
      public bool isMVP;
      public int penaltiesLeft;
      public int xpStart;
      public int xpEnd;
      public int xpGained;
      public int xpGainedThroughMatchOutcome;
      public int xpGainedThroughAwards;
      public int xpGainedThroughBonus;
      public int xpStartLevel;
      public int startLevel;
      public int endLevel;
      public XPUi.xpStats.level[] levels;
      public XPUi.xpStats.bonusAward[] boni;
      public int steelGainedThroughMatchOutcome;

      public class level
      {
        public int xpNeeded;
        public int steelReward;
        public int creditsReward;
        public bool hasItemReward;
        public int itemRewardId;
      }

      public class bonusAward
      {
        public string name;
        public int bonusXP;
      }
    }
  }
}
