// Decompiled with JetBrains decompiler
// Type: SkillUiInstance
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils.Extensions;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class SkillUiInstance : MonoBehaviour
{
  [SerializeField]
  private Image chargeIndicatorFg;
  [SerializeField]
  private Image chargeIndicatorBg;
  [SerializeField]
  private Image refilledShine;
  [SerializeField]
  private Image refilledShineBig;
  [SerializeField]
  private Image buttonIcon;
  [SerializeField]
  private GameObject particles;
  [SerializeField]
  private float shineIntensity = 1f;
  [SerializeField]
  private float bigShineIntensity = 0.4f;
  [SerializeField]
  private float blinkDuration = 0.3f;
  private SkillUiStateData stateData;
  private Color shineColor;
  private bool playBlink;
  private bool blinkIsReadyToPlay;
  private Coroutine blinkCo;
  private readonly string championSkillIconPath = "UI/SkillUI/Skill Icons/";

  public void InitializeSkillIcons(ChampionType championType, Imi.SharedWithServer.ScEntitas.Components.ButtonType type)
  {
    Sprite sprite1 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championType.ToString().ToLower() + "_" + type.ToString().ToLower() + "_fg_ui");
    Sprite sprite2 = UnityEngine.Resources.Load<Sprite>(this.championSkillIconPath + championType.ToString().ToLower() + "_" + type.ToString().ToLower() + "_bg_ui");
    if ((Object) sprite1 != (Object) null)
      this.chargeIndicatorFg.sprite = sprite1;
    if (!((Object) sprite2 != (Object) null))
      return;
    this.chargeIndicatorBg.sprite = sprite2;
  }

  private void Start()
  {
    if ((Object) this.refilledShine != (Object) null)
      this.shineColor = this.refilledShine.color;
    if ((Object) this.chargeIndicatorFg == (Object) null)
      this.chargeIndicatorFg = this.transform.GetChild(0).gameObject.GetComponent<Image>();
    if (!((Object) this.chargeIndicatorBg == (Object) null))
      return;
    this.chargeIndicatorBg = this.GetComponent<Image>();
  }

  private void OnDisable()
  {
    if (this.blinkCo == null)
      return;
    this.StopCoroutine(this.blinkCo);
    this.playBlink = false;
    this.blinkIsReadyToPlay = false;
    if ((Object) this.particles != (Object) null)
      this.particles.SetActive(false);
    this.shineColor.a = 0.0f;
    this.refilledShine.color = this.shineColor;
  }

  public void SetUiStateData(SkillUiStateData newStateData)
  {
    this.stateData = newStateData;
    this.chargeIndicatorFg.fillAmount = this.stateData.fillAmount;
    this.chargeIndicatorBg.fillAmount = 1f - this.stateData.fillAmount;
    this.chargeIndicatorFg.color = new Color(this.chargeIndicatorFg.color.r, this.chargeIndicatorFg.color.g, this.chargeIndicatorFg.color.b, this.stateData.fillAmount.MapValue(0.0f, 1f, 0.4f, 0.8f));
    this.ResetCooldownState();
    if (!this.playBlink || !this.blinkIsReadyToPlay || this.stateData.buttonType == Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint || !this.gameObject.activeInHierarchy)
      return;
    this.blinkCo = this.StartCoroutine(this.PlayBlinkCoroutine(this.blinkDuration, 1));
    AudioController.Play("SkillCooldownComplete");
  }

  private void ResetCooldownState()
  {
    if ((double) this.stateData.fillAmount >= 0.990000009536743)
      this.playBlink = true;
    if ((double) this.stateData.fillAmount > 0.100000001490116)
      return;
    this.playBlink = false;
    this.blinkIsReadyToPlay = true;
    if (!((Object) this.particles != (Object) null))
      return;
    this.particles.SetActive(false);
  }

  private IEnumerator PlayBlinkCoroutine(float duration, int blinkCount)
  {
    this.playBlink = false;
    this.blinkIsReadyToPlay = false;
    if ((Object) this.particles != (Object) null)
      this.particles.SetActive(true);
    this.shineColor.a = 0.0f;
    this.refilledShine.color = this.shineColor;
    this.refilledShineBig.color = this.shineColor;
    for (int k = 0; k < blinkCount; ++k)
    {
      float i;
      for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float from = i / duration;
        this.shineColor.a = from.MapValue(0.0f, 1f, 0.0f, this.shineIntensity);
        this.refilledShine.color = this.shineColor;
        this.shineColor.a = from.MapValue(0.0f, 1f, 0.0f, this.bigShineIntensity);
        this.refilledShineBig.color = this.shineColor;
        yield return (object) null;
      }
      for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float from = (float) (1.0 - (double) i / (double) duration);
        this.shineColor.a = from.MapValue(0.0f, 1f, 0.0f, this.shineIntensity);
        this.refilledShine.color = this.shineColor;
        this.shineColor.a = from.MapValue(0.0f, 1f, 0.0f, this.bigShineIntensity);
        this.refilledShineBig.color = this.shineColor;
        yield return (object) null;
      }
    }
    this.shineColor.a = 0.0f;
    this.refilledShine.color = this.shineColor;
    this.refilledShineBig.color = this.shineColor;
  }

  private void SetSkillReadyButtonColor() => this.chargeIndicatorFg.color = this.shineColor;

  public void PlayBlink()
  {
    if ((Object) this.particles != (Object) null)
      this.particles.SetActive(false);
    this.playBlink = true;
    this.blinkIsReadyToPlay = true;
  }

  public void SetSprite(Sprite sprite) => this.buttonIcon.sprite = sprite;
}
