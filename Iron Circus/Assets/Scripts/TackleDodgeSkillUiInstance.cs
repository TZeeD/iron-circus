// Decompiled with JetBrains decompiler
// Type: TackleDodgeSkillUiInstance
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.UI.SkillInfo;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class TackleDodgeSkillUiInstance : MonoBehaviour
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
  private float inactiveAlpha = 0.1f;
  [SerializeField]
  private float transitionFadeDuration = 0.5f;
  [SerializeField]
  private Sprite tackleIcon;
  [SerializeField]
  private Sprite dodgeIcon;
  [SerializeField]
  private Image buttonIcon;
  private Animator animator;
  private GameEntity player;
  private SkillUiStateData stateData;
  private bool isUsable;
  private bool skillWasSetActive;
  private bool skillWasSetInactive;
  private Coroutine setActiveCoroutine;
  private Coroutine setInactiveCoroutine;
  private Color usedColor;

  private void Awake() => this.animator = this.GetComponent<Animator>();

  private void Start()
  {
    if (Contexts.sharedInstance.game.HasLocalEntity())
      this.player = Contexts.sharedInstance.game.GetFirstLocalEntity();
    this.SetupColors();
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
    this.usedColor = color;
    this.coolDownFill.color = this.usedColor;
  }

  private void UpdateColors()
  {
    if (!this.UseSetupColors)
      return;
    this.SetupColors();
  }

  public void SetUiStateData(SkillUiStateData newStateData)
  {
    this.stateData = newStateData;
    this.coolDownFill.fillAmount = this.stateData.fillAmount;
    this.UpdateColors();
    if ((double) this.stateData.fillAmount >= 0.949999988079071)
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

  private void SetSkillActive()
  {
    GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
    this.skillIcon.sprite = !ballEntity.hasBallOwner || !ballEntity.ballOwner.IsOwner(this.player) ? this.tackleIcon : this.dodgeIcon;
    if (this.gameObject.activeInHierarchy)
      this.animator.SetBool("Extend", true);
    this.coolDownFill.gameObject.SetActive(false);
    if (!this.isUsable || this.skillWasSetActive)
      return;
    if (this.gameObject.activeInHierarchy)
      this.setActiveCoroutine = this.StartCoroutine(this.PlaySetActiveCoroutine(this.transitionFadeDuration));
    else
      this.SetActiveState();
    this.skillWasSetActive = true;
    this.skillWasSetInactive = false;
  }

  private void SetSkillInactive()
  {
    if (this.gameObject.activeInHierarchy)
      this.animator.SetBool("Extend", false);
    this.coolDownFill.gameObject.SetActive(true);
    if (this.isUsable || this.skillWasSetInactive)
      return;
    if (this.gameObject.activeInHierarchy)
      this.setInactiveCoroutine = this.StartCoroutine(this.PlaySetInactiveCoroutine(this.transitionFadeDuration));
    else
      this.SetInactiveState();
    this.skillWasSetActive = false;
    this.skillWasSetInactive = true;
  }

  private void SetActiveState()
  {
    this.skillBox.alpha = 1f;
    foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
      affectedSkillImage.color = this.usedColor;
  }

  private void SetInactiveState()
  {
    this.skillBox.alpha = this.inactiveAlpha;
    foreach (Graphic affectedSkillImage in this.colorAffectedSkillImages)
      affectedSkillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.skillIsInactiveColor;
  }

  public void SetSprite(Sprite sprite) => this.buttonIcon.sprite = sprite;

  private void OnDisable()
  {
    if (this.setActiveCoroutine != null)
      this.StopCoroutine(this.setActiveCoroutine);
    if (this.setInactiveCoroutine == null)
      return;
    this.StopCoroutine(this.setInactiveCoroutine);
  }
}
