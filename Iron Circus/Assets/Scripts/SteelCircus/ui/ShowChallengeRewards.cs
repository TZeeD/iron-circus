// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShowChallengeRewards
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ShowChallengeRewards : MonoBehaviour
  {
    [Header("TutorialRewardOverlay")]
    [SerializeField]
    private GameObject TutorialRewardGroup;
    [SerializeField]
    private TextMeshProUGUI tutorialRewardText;
    [SerializeField]
    private TextMeshProUGUI tutorialExplanationText;
    [SerializeField]
    private GameObject TutorialCreditsImage;
    [SerializeField]
    private GameObject TutorialSteelImage;
    [SerializeField]
    private GameObject TutorialItemImageObject;
    [SerializeField]
    private Image TutorialtemImage;
    [SerializeField]
    private CanvasGroup tutorialCanvasGrp;
    [Header("RewardOverlay")]
    [SerializeField]
    private TextMeshProUGUI rewardText;
    [SerializeField]
    private GameObject creditsImage;
    [SerializeField]
    private GameObject steelImage;
    [SerializeField]
    private GameObject itemImageObject;
    [SerializeField]
    private Image itemImage;
    [SerializeField]
    private DailyChallengePanel dailyChallengePanel;
    [SerializeField]
    private CanvasGroup canvasGrp;
    private bool isShowing;
    private bool isShowingTutorialReward;
    private IEnumerator hideTriggerCoroutine;
    [SerializeField]
    private GameObject rewardAnimator;

    public void ShowTutorialReward(
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount,
      string rewardText)
    {
      if (rewardType == DailyChallengeEntry.ChallengeRewardType.None)
        return;
      Log.Debug("Showing Tutorial Reward.");
      this.tutorialCanvasGrp.blocksRaycasts = true;
      this.TutorialRewardGroup.SetActive(true);
      this.rewardAnimator.SetActive(false);
      this.StartCoroutine(this.DelayedDisableButtons());
      this.SetRewardGraphics(rewardType, rewardAmount, this.TutorialSteelImage, this.TutorialCreditsImage, this.TutorialItemImageObject, this.TutorialtemImage);
      this.tutorialExplanationText.text = ImiServices.Instance.LocaService.GetLocalizedValue(rewardText);
      this.TutorialRewardGroup.GetComponent<Animator>().SetTrigger("showReward");
      this.isShowingTutorialReward = true;
    }

    public IEnumerator DelayedDisableButtons()
    {
      yield return (object) null;
      Log.Error("Disabling buttons in main menus after waiting one frame");
      MenuController.Instance.mainMenuPanel.DisableButtonsOnExit();
      MenuController.Instance.playMenu.DisableButtonsOnExit();
    }

    public void Show(
      float durationInSeconds,
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount)
    {
      if (rewardType == DailyChallengeEntry.ChallengeRewardType.None || this.isShowingTutorialReward)
        return;
      Log.Debug("Show Reward Window. Disabling Main Menu Buttons");
      MenuController.Instance.mainMenuPanel.DisableButtonsOnExit();
      MenuController.Instance.playMenu.DisableButtonsOnExit();
      this.canvasGrp.blocksRaycasts = true;
      this.SetRewardGraphics(rewardType, rewardAmount, this.steelImage, this.creditsImage, this.itemImageObject, this.itemImage);
      this.TutorialRewardGroup.SetActive(false);
      this.rewardAnimator.SetActive(true);
      if (this.isShowing)
        this.rewardAnimator.GetComponent<Animator>().Play("Hidden");
      this.rewardAnimator.GetComponent<Animator>().SetTrigger("showReward");
      this.isShowing = true;
      this.hideTriggerCoroutine = this.Hide(durationInSeconds);
      this.StartCoroutine(this.hideTriggerCoroutine);
    }

    public void SetRewardGraphics(
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount,
      GameObject steelImage,
      GameObject creditsImage,
      GameObject itemImageObject,
      Image itemImage)
    {
      switch (rewardType)
      {
        case DailyChallengeEntry.ChallengeRewardType.Steel:
          steelImage.SetActive(true);
          itemImageObject.SetActive(false);
          creditsImage.SetActive(false);
          this.rewardText.text = rewardAmount.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@STEEL EARNED");
          this.tutorialRewardText.text = rewardAmount.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@STEEL EARNED");
          break;
        case DailyChallengeEntry.ChallengeRewardType.Creds:
          steelImage.SetActive(false);
          itemImageObject.SetActive(false);
          creditsImage.SetActive(true);
          this.rewardText.text = rewardAmount.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@CREDITS EARNED");
          this.tutorialRewardText.text = rewardAmount.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@CREDITS EARNED");
          break;
        case DailyChallengeEntry.ChallengeRewardType.Item:
          steelImage.SetActive(false);
          itemImageObject.SetActive(true);
          creditsImage.SetActive(false);
          itemImage.sprite = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(rewardAmount).icon;
          this.rewardText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@ITEM RECEIVED");
          this.tutorialRewardText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@ITEM RECEIVED");
          break;
      }
    }

    public void HideTutorialReward()
    {
      this.tutorialCanvasGrp.blocksRaycasts = false;
      this.tutorialCanvasGrp.interactable = false;
      this.TutorialRewardGroup.GetComponent<Animator>().SetTrigger("hide");
      this.isShowingTutorialReward = false;
      MenuController.Instance.mainMenuPanel.EnableButtonsOnEnter();
      MenuController.Instance.playMenu.EnableButtonsOnEnter();
      ImiServices.Instance.UiProgressionService.SetRewardAnimEnded(true);
    }

    public IEnumerator Hide(float wait)
    {
      yield return (object) new WaitForSeconds(wait);
      this.canvasGrp.blocksRaycasts = false;
      this.canvasGrp.interactable = false;
      this.rewardAnimator.GetComponent<Animator>().SetTrigger("hide");
      this.isShowing = false;
      MenuController.Instance.mainMenuPanel.EnableButtonsOnEnter();
      MenuController.Instance.playMenu.EnableButtonsOnEnter();
    }

    private void Update()
    {
      if (this.isShowing && (ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UICancel) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UISubmit)))
      {
        this.SkipRewardAnim();
        this.canvasGrp.blocksRaycasts = false;
      }
      if (!this.isShowingTutorialReward || !ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UICancel) && !ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UISubmit))
        return;
      this.HideTutorialReward();
    }

    public void SkipRewardAnim()
    {
      Log.Debug("Skipping reward animator. Hiding reward overly");
      this.rewardAnimator.GetComponent<Animator>().SetTrigger("hide");
      this.isShowing = false;
      MenuController.Instance.mainMenuPanel.EnableButtonsOnEnter();
      MenuController.Instance.playMenu.EnableButtonsOnEnter();
      this.canvasGrp.blocksRaycasts = false;
      if (this.hideTriggerCoroutine == null)
        return;
      this.StopCoroutine(this.hideTriggerCoroutine);
    }
  }
}
