// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.MatchOutcomeScreen
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.FX;
using SteelCircus.UI.Misc;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
  public class MatchOutcomeScreen : MonoBehaviour
  {
    [SerializeField]
    private TextMeshProUGUI outcomeText;
    [SerializeField]
    private TextMeshProUGUI scoreText;
    [SerializeField]
    private Image background;
    [SerializeField]
    private Transform animationParent;
    [SerializeField]
    private GameObject animationPrefab;
    private GameObject animationInstance;
    private ScreenFader screenFader;
    private float screenFadeDuration = 1f;

    public void Setup(ScreenFader screenFader, float screenFadeDuration)
    {
      this.screenFader = screenFader;
      this.screenFadeDuration = screenFadeDuration;
    }

    public void FadeIn(float duration) => this.StartCoroutine(this.FadeInCR(duration, 0.8f));

    public void FadeOut(float duration) => this.StartCoroutine(this.FadeOutCR(duration, 0.8f));

    public void StartMainAnimation(float duration) => this.StartCoroutine(this.MainAnimationCR(duration));

    private IEnumerator FadeInCR(float duration, float fadeAmount)
    {
      for (float i = 0.0f; (double) i < (double) duration; i += Time.deltaTime)
      {
        this.background.color = new Color(this.background.color.r, this.background.color.g, this.background.color.b, i / duration * fadeAmount);
        yield return (object) null;
      }
    }

    private IEnumerator FadeOutCR(float duration, float fadeAmount)
    {
      for (float i = 0.0f; (double) i < (double) duration; i += Time.deltaTime)
      {
        this.background.color = new Color(this.background.color.r, this.background.color.g, this.background.color.b, (float) (1.0 - (double) i / (double) duration) * fadeAmount);
        yield return (object) null;
      }
    }

    private void StartBackgroundAnimation(MatchOutcome matchOutcome)
    {
      if ((Object) this.animationInstance != (Object) null)
        Object.Destroy((Object) this.animationInstance);
      this.animationInstance = Object.Instantiate<GameObject>(this.animationPrefab, this.animationParent);
      VictoryAnimation component = this.animationInstance.GetComponent<VictoryAnimation>();
      if (matchOutcome == MatchOutcome.Win)
        component.SetupVictory();
      else
        component.SetupDefeat();
    }

    private void StopBackgroundAnimation()
    {
      if (!((Object) this.animationInstance != (Object) null))
        return;
      Object.Destroy((Object) this.animationInstance);
    }

    private IEnumerator MainAnimationCR(float duration)
    {
      MatchOutcome matchOutcome = TeamExtensions.GetMatchOutcomeForTeam(Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value);
      bool playerTeamLost = true;
      string key;
      switch (matchOutcome)
      {
        case MatchOutcome.Win:
          key = "@victory";
          playerTeamLost = false;
          break;
        case MatchOutcome.Draw:
          key = "@draw";
          break;
        default:
          key = "@defeat";
          break;
      }
      if (!Contexts.sharedInstance.meta.metaMatch.gameType.IsPlayground())
        ImiServices.Instance.Analytics.OnMatchEnd(playerTeamLost);
      string str = "";
      if (Contexts.sharedInstance.meta.hasMetaMatch && Contexts.sharedInstance.meta.metaMatch.isOvertime)
        Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(Contexts.sharedInstance.game.score.playerScored);
      this.outcomeText.text = string.IsNullOrEmpty(str) ? ImiServices.Instance.LocaService.GetLocalizedValue(key) : str + "\n" + ImiServices.Instance.LocaService.GetLocalizedValue(key);
      this.scoreText.text = string.Format("{0}:{1}", (object) TeamExtensions.GetScore(Team.Alpha), (object) TeamExtensions.GetScore(Team.Beta));
      if (Contexts.sharedInstance.meta.metaMatch.gameType.IsBasicTraining())
      {
        matchOutcome = MatchOutcome.Win;
        this.scoreText.text = "";
        this.outcomeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@victory");
      }
      this.StartBackgroundAnimation(matchOutcome);
      yield return (object) new WaitForSeconds(1.5f);
      this.outcomeText.gameObject.SetActive(true);
      this.scoreText.gameObject.SetActive(true);
      if (StartupSetup.configProvider.debugConfig.skipCutscenes)
        duration = 1f;
      yield return (object) new WaitForSeconds((float) ((double) duration - 1.5 - (double) this.screenFadeDuration / 2.0));
      this.screenFader.FadeIn(this.screenFadeDuration / 2f);
      yield return (object) new WaitForSeconds(this.screenFadeDuration / 2f);
      this.StopBackgroundAnimation();
      this.outcomeText.gameObject.SetActive(false);
      this.scoreText.gameObject.SetActive(false);
      this.background.color = new Color(this.background.color.r, this.background.color.g, this.background.color.b, 0.0f);
    }
  }
}
