// Decompiled with JetBrains decompiler
// Type: MainSkillUiInstance
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.Utils.Extensions;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.UI.SkillInfo;
using System;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MainSkillUiInstance : MonoBehaviour
{
  public bool UseSetupColors;
  [SerializeField]
  private Image skillIcon;
  [SerializeField]
  private CanvasGroup skillBox;
  [SerializeField]
  private Image coolDownFill;
  [SerializeField]
  private Image[] colorAffectedSkillImages;
  [SerializeField]
  private Image colorUnaffectedSkillImage;
  [SerializeField]
  private GameObject particleGlow;
  [SerializeField]
  private Image buttonIcon;
  private ParticleSystem[] particleSystems;
  [SerializeField]
  private TextMeshProUGUI coolDownText;
  [Header("Shine Effect")]
  [SerializeField]
  private Image refilledShine;
  [SerializeField]
  private Image refilledShineBig;
  [SerializeField]
  private float shineIntensity = 1f;
  [SerializeField]
  private float bigShineIntensity = 0.4f;
  [SerializeField]
  private float blinkDuration = 0.3f;
  private Color usedColor;
  [Header("Blink Data")]
  [SerializeField]
  private float inactiveAlpha = 0.1f;
  [SerializeField]
  private float transitionFadeDuration = 0.5f;
  private Animator animator;
  private SkillUiStateData stateData;
  private GameEntity player;
  private bool isUsable;
  private bool skillWasSetActive;
  private bool skillWasSetInactive;
  private Coroutine setActiveCoroutine;
  private Coroutine setInactiveCoroutine;
  private Coroutine blinkCo;

  public Image SkillIcon => this.skillIcon;

  private void Awake() => this.animator = this.GetComponent<Animator>();

  private void Start()
  {
    this.usedColor = SingletonScriptableObject<ColorsConfig>.Instance.skillIsActiveColor;
    this.particleSystems = this.particleGlow.GetComponentsInChildren<ParticleSystem>();
    if (Contexts.sharedInstance.game.HasLocalEntity())
      this.player = Contexts.sharedInstance.game.GetFirstLocalEntity();
    this.SetupColors();
  }

  private void OnEnable()
  {
    this.usedColor.a = 0.0f;
    this.refilledShine.color = this.usedColor;
    this.refilledShineBig.color = this.usedColor;
  }

  private void SetupColors()
  {
    if (!SkillHud.UseTeamColorsForSkillUi)
      this.SetColors(SingletonScriptableObject<ColorsConfig>.Instance.skillIsActiveColor);
    else if (this.player.playerTeam.value == Team.Alpha)
      this.SetColors(SingletonScriptableObject<ColorsConfig>.Instance.team1ColorMiddle);
    else if (this.player.playerTeam.value == Team.Beta)
      this.SetColors(SingletonScriptableObject<ColorsConfig>.Instance.team2ColorMiddle);
    else
      Log.Error("player has no Team assigned!");
  }

  private void SetColors(Color color)
  {
    foreach (ParticleSystem particleSystem in this.particleSystems)
      particleSystem.main.startColor = (ParticleSystem.MinMaxGradient) color;
    this.usedColor = color;
    this.coolDownFill.color = this.usedColor;
  }

  public void SetUiStateData(SkillUiStateData newStateData)
  {
    this.stateData = newStateData;
    this.coolDownText.text = string.Concat((object) (int) Math.Ceiling((double) this.stateData.coolDownLeft));
    this.coolDownFill.fillAmount = this.stateData.fillAmount;
    this.UpdateColors();
    this.ResetCooldownState();
  }

  private void UpdateColors()
  {
    if (!this.UseSetupColors)
      return;
    this.SetupColors();
  }

  private IEnumerator PlaySetActiveCoroutine(float duration)
  {
    for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
    {
      float t = i / duration;
      this.skillBox.alpha = Mathf.Lerp(this.inactiveAlpha, 1f, t);
      foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
        affectedSkillImage.color = Color.Lerp(SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor, this.usedColor, t);
      yield return (object) null;
    }
    this.SetActiveState();
  }

  private void SetActiveState()
  {
    this.skillBox.alpha = 1f;
    foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
      affectedSkillImage.color = this.usedColor;
    this.colorUnaffectedSkillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor;
  }

  private IEnumerator PlaySetInactiveCoroutine(float duration)
  {
    for (float i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
    {
      float t = i / duration;
      this.skillBox.alpha = Mathf.Lerp(1f, this.inactiveAlpha, t);
      foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
        affectedSkillImage.color = Color.Lerp(this.usedColor, SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor, t);
      yield return (object) null;
    }
    this.SetInactiveState();
  }

  private void SetInactiveState()
  {
    this.skillBox.alpha = this.inactiveAlpha;
    foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
      affectedSkillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor;
    this.colorUnaffectedSkillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor;
  }

  private void ResetCooldownState()
  {
    if ((double) this.stateData.fillAmount >= 0.990000009536743)
    {
      this.isUsable = true;
      this.SetSkillActive();
    }
    else
    {
      this.isUsable = false;
      this.SetSkillInactive();
    }
  }

  private void SetSkillActive()
  {
    if (this.gameObject.activeInHierarchy)
      this.animator.SetBool("Extend", true);
    this.coolDownText.gameObject.SetActive(false);
    this.coolDownFill.gameObject.SetActive(false);
    this.particleGlow.SetActive(true);
    if (!this.isUsable || this.skillWasSetActive)
      return;
    if (this.gameObject.activeInHierarchy)
    {
      this.setActiveCoroutine = this.StartCoroutine(this.PlaySetActiveCoroutine(this.transitionFadeDuration));
      this.blinkCo = this.StartCoroutine(this.PlayBlinkCoroutine(this.blinkDuration, 1));
    }
    else
      this.SetActiveState();
    AudioController.Play("SkillCooldownComplete");
    this.skillWasSetActive = true;
    this.skillWasSetInactive = false;
  }

  private void SetSkillInactive()
  {
    if (this.gameObject.activeInHierarchy)
      this.animator.SetBool("Extend", false);
    this.coolDownText.gameObject.SetActive(true);
    this.coolDownFill.gameObject.SetActive(true);
    this.particleGlow.SetActive(false);
    if (this.isUsable || this.skillWasSetInactive)
      return;
    if (this.gameObject.activeInHierarchy)
      this.setInactiveCoroutine = this.StartCoroutine(this.PlaySetInactiveCoroutine(this.transitionFadeDuration));
    else
      this.SetInactiveState();
    this.skillWasSetActive = false;
    this.skillWasSetInactive = true;
  }

  private IEnumerator PlayBlinkCoroutine(float duration, int blinkCount)
  {
    this.usedColor.a = 0.0f;
    this.refilledShine.color = this.usedColor;
    this.refilledShineBig.color = this.usedColor;
    for (int k = 0; k < blinkCount; ++k)
    {
      float i;
      for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float from = i / duration;
        this.usedColor.a = from.MapValue(0.0f, 1f, 0.0f, this.shineIntensity);
        this.refilledShine.color = this.usedColor;
        this.usedColor.a = from.MapValue(0.0f, 1f, 0.0f, this.bigShineIntensity);
        this.refilledShineBig.color = this.usedColor;
        yield return (object) null;
      }
      for (i = 0.0f; (double) i <= (double) duration; i += Time.deltaTime)
      {
        float from = (float) (1.0 - (double) i / (double) duration);
        this.usedColor.a = from.MapValue(0.0f, 1f, 0.0f, this.shineIntensity);
        this.refilledShine.color = this.usedColor;
        this.usedColor.a = from.MapValue(0.0f, 1f, 0.0f, this.bigShineIntensity);
        this.refilledShineBig.color = this.usedColor;
        yield return (object) null;
      }
    }
    this.usedColor.a = 0.0f;
    this.refilledShine.color = this.usedColor;
    this.refilledShineBig.color = this.usedColor;
  }

  private void OnDisable()
  {
    if (this.setActiveCoroutine != null)
      this.StopCoroutine(this.setActiveCoroutine);
    if (this.setInactiveCoroutine != null)
      this.StopCoroutine(this.setInactiveCoroutine);
    if (this.blinkCo != null)
      this.StopCoroutine(this.blinkCo);
    this.usedColor.a = 0.0f;
    this.refilledShine.color = this.usedColor;
    this.refilledShineBig.color = this.usedColor;
  }

  public void SetSprite(Sprite sprite) => this.buttonIcon.sprite = sprite;
}
