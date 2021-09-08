// Decompiled with JetBrains decompiler
// Type: OvertimeUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using SteelCircus.FX;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class OvertimeUi : MonoBehaviour
{
  [SerializeField]
  private TextMeshProUGUI overtimeTxt;
  [SerializeField]
  private TextMeshProUGUI goldenGoalTxt;
  [SerializeField]
  private TextMeshProUGUI infoTxt;
  [SerializeField]
  private Image background;
  [SerializeField]
  private Image scoreBorder;
  [SerializeField]
  private Transform animationParent;
  [SerializeField]
  private GameObject animationPrefab;
  private GameObject animationInstance;

  private void Start()
  {
  }

  private void Update()
  {
  }

  public void StartMainAnimation(float duration)
  {
    this.overtimeTxt.gameObject.SetActive(true);
    MatchObjectsParent.FloorStateManager.StartOvertimeDisplay();
    this.StartCoroutine(this.MainAnimationCR(duration));
  }

  private void StopBackgroundAnimation()
  {
    if (!((Object) this.animationInstance != (Object) null))
      return;
    Object.Destroy((Object) this.animationInstance);
  }

  private IEnumerator MainAnimationCR(float duration)
  {
    yield return (object) new WaitForSeconds(1f);
    this.StartBackgroundAnimation();
    this.scoreBorder.gameObject.SetActive(true);
    this.infoTxt.gameObject.SetActive(true);
    yield return (object) new WaitForSeconds(duration - 1f);
    this.overtimeTxt.gameObject.SetActive(false);
    this.infoTxt.gameObject.SetActive(false);
    this.StopBackgroundAnimation();
  }

  public void CleanupCutscene() => this.overtimeTxt.gameObject.SetActive(false);

  public void CleanupCutsceneMatchOver() => this.scoreBorder.gameObject.SetActive(false);

  public void FadeIn(float duration) => this.StartCoroutine(this.FadeInCR(duration, 0.8f));

  public void FadeOut(float duration) => this.StartCoroutine(this.FadeOutCR(duration, 0.8f));

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

  private void StartBackgroundAnimation()
  {
    if ((Object) this.animationInstance != (Object) null)
      Object.Destroy((Object) this.animationInstance);
    this.animationInstance = Object.Instantiate<GameObject>(this.animationPrefab, this.animationParent);
    this.animationInstance.GetComponent<VictoryAnimation>().SetupOvertime();
  }
}
