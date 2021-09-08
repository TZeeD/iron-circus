// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ChampionOverheadSkillUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.ScriptableObjects;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ChampionOverheadSkillUI : MonoBehaviour
  {
    [Header("Stamina Bar")]
    [SerializeField]
    private RectTransform staminaBarParent;
    [SerializeField]
    private float tacklePartPadding = 10f;
    [FormerlySerializedAs("tackleParentFG")]
    [SerializeField]
    private RectTransform tackleParentFill;
    [SerializeField]
    private RectTransform tackleParentDiff;
    [SerializeField]
    private RectTransform tackleParentBG;
    [FormerlySerializedAs("sprintParentFG")]
    [SerializeField]
    private RectTransform sprintParentFill;
    [SerializeField]
    private RectTransform sprintParentDiff;
    [SerializeField]
    private RectTransform sprintParentBG;
    private readonly float leftSideMinFill = 0.46f;
    private readonly float rightSideMaxFill = 0.45f;
    [SerializeField]
    private List<Image> staminaSlicesBG;
    [FormerlySerializedAs("staminaSlicesFG")]
    [SerializeField]
    private List<Image> staminaSlicesFill;
    [SerializeField]
    private List<Image> staminaSlicesDiff;
    [SerializeField]
    private Color staminaBGColor = Color.gray;
    [SerializeField]
    private Color staminaDiffColor = Color.red;
    [SerializeField]
    private float staminaDepletedBlinkDuration = 0.4f;
    [SerializeField]
    private float staminaDepletedBlinkFrequency = 4f;
    [SerializeField]
    private Image staminaReplenishedGlow;
    [SerializeField]
    private float staminaReplenishedGlowDuration = 0.6f;
    private float staminaDepletedBlinkCounter;
    private float staminaReplenishedGlowCounter;
    private Player player;
    private float[] staminaPercentPerSlice;
    private float currentDiffValue;
    private float currentTargetValue = 1f;
    [SerializeField]
    private float diffDelayAfterTackle = 0.2f;
    private float diffDelayCounter;
    [SerializeField]
    private float diffSmoothing = 0.2f;
    private SkillVar<bool> canAffordTackle;
    private SkillVar<bool> canAffordDodge;
    private bool prevCanAffordTackle = true;

    private void Start() => this.InitStaminaBar(0.25f);

    public void Init(Player player)
    {
      this.player = player;
      this.staminaDepletedBlinkCounter = this.staminaDepletedBlinkDuration;
      this.staminaReplenishedGlowCounter = this.staminaReplenishedGlowDuration;
      this.SetStaminaBarColor(this.staminaBGColor, this.staminaSlicesBG);
      this.SetStaminaBarColor(this.staminaDiffColor, this.staminaSlicesDiff);
      float minTackleValue = 0.0f;
      float amount = player.Config.stamina.amount;
      foreach (SkillGraphConfig skillGraphConfig in player.GameEntity.skillGraph.skillGraphConfigs)
      {
        if (skillGraphConfig is TackleDodgeConfig)
          minTackleValue = ((TackleDodgeConfig) skillGraphConfig).staminaCostTackle / amount;
      }
      this.InitStaminaBar(minTackleValue);
      this.SetStaminaBarFill(0.0f, this.staminaSlicesDiff);
    }

    private void InitStaminaBar(float minTackleValue)
    {
      float x = this.staminaBarParent.sizeDelta.x;
      float num1 = (1f - minTackleValue) * x - this.tacklePartPadding;
      float num2 = minTackleValue * x + this.tacklePartPadding;
      Vector2 offsetMax = this.tackleParentBG.offsetMax;
      offsetMax.x = -num1;
      this.tackleParentBG.offsetMax = this.tackleParentFill.offsetMax = this.tackleParentDiff.offsetMax = offsetMax;
      Vector2 offsetMin = this.sprintParentBG.offsetMin;
      offsetMin.x = num2;
      this.sprintParentBG.offsetMin = this.sprintParentFill.offsetMin = this.sprintParentDiff.offsetMin = offsetMin;
      this.staminaPercentPerSlice = new float[this.staminaSlicesBG.Count];
      float num3 = (float) (0.0 + (double) this.staminaSlicesBG[0].GetComponent<RectTransform>().rect.width * (1.0 - (double) this.leftSideMinFill));
      for (int index = 1; index < this.staminaSlicesBG.Count - 1; ++index)
        num3 += this.staminaSlicesBG[index].GetComponent<RectTransform>().rect.width;
      float num4 = num3 + this.staminaSlicesBG[this.staminaSlicesBG.Count - 1].GetComponent<RectTransform>().rect.width * this.rightSideMaxFill;
      this.staminaPercentPerSlice[0] = this.staminaSlicesBG[0].GetComponent<RectTransform>().rect.width * (1f - this.leftSideMinFill) / num4;
      for (int index = 1; index < this.staminaSlicesBG.Count - 1; ++index)
      {
        float width = this.staminaSlicesBG[index].GetComponent<RectTransform>().rect.width;
        this.staminaPercentPerSlice[index] = width / num4;
      }
      this.staminaPercentPerSlice[this.staminaSlicesBG.Count - 1] = this.staminaSlicesBG[this.staminaSlicesBG.Count - 1].GetComponent<RectTransform>().rect.width * this.rightSideMaxFill / num4;
    }

    private void SetStaminaBarFill(float v, List<Image> bar)
    {
      float a1 = 0.0f;
      for (int index = 0; index < this.staminaPercentPerSlice.Length; ++index)
      {
        float a2 = index > 0 ? 0.0f : this.leftSideMinFill;
        float b = index < this.staminaPercentPerSlice.Length - 1 ? 1f : this.rightSideMaxFill;
        float num1 = this.staminaPercentPerSlice[index];
        float t = Mathf.InverseLerp(a1, a1 + num1, v);
        float num2 = Mathf.Lerp(a2, b, t);
        bar[index].fillAmount = num2;
        a1 += num1;
      }
    }

    private void SetStaminaBarColor(Color col, List<Image> bar)
    {
      foreach (Graphic graphic in bar)
        graphic.color = col;
    }

    private void Update()
    {
      if ((Object) this.player == (Object) null)
        return;
      GameEntity gameEntity = this.player.GameEntity;
      if (gameEntity == null || !gameEntity.hasSkillUi || gameEntity.skillUi.skillUiStates == null)
        return;
      if (this.canAffordTackle == null || this.canAffordDodge == null)
      {
        this.canAffordTackle = gameEntity.skillGraph.GetVar<bool>("CanAffordTackle");
        this.canAffordDodge = gameEntity.skillGraph.GetVar<bool>("CanAffordDodge");
      }
      this.SetStaminaBarColor(!(bool) this.canAffordTackle || !(bool) this.canAffordDodge ? SingletonScriptableObject<ColorsConfig>.Instance.staminaBarEmpty : SingletonScriptableObject<ColorsConfig>.Instance.stamina, this.staminaSlicesFill);
      float v = 0.0f;
      foreach (SkillUiStateData skillUiState in gameEntity.skillUi.skillUiStates)
      {
        switch (skillUiState.buttonType)
        {
          case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Sprint:
            v = skillUiState.fillAmount;
            this.SetStaminaBarFill(v, this.staminaSlicesFill);
            this.currentTargetValue = v;
            if ((double) v == 0.0 && skillUiState.isButtonDown)
            {
              this.staminaDepletedBlinkCounter = 0.0f;
              continue;
            }
            continue;
          case Imi.SharedWithServer.ScEntitas.Components.ButtonType.Tackle:
            if (skillUiState.isButtonDown)
            {
              if (!(bool) this.canAffordTackle)
              {
                this.staminaDepletedBlinkCounter = 0.0f;
                continue;
              }
              this.diffDelayCounter = this.diffDelayAfterTackle;
              continue;
            }
            continue;
          default:
            continue;
        }
      }
      if (!this.prevCanAffordTackle && (bool) this.canAffordTackle && (double) v < 1.0)
        this.staminaReplenishedGlowCounter = 0.0f;
      this.prevCanAffordTackle = (bool) this.canAffordTackle;
      if ((double) this.staminaDepletedBlinkCounter < (double) this.staminaDepletedBlinkDuration)
      {
        this.staminaDepletedBlinkCounter += Time.deltaTime;
        if ((double) Time.time % (1.0 / (double) this.staminaDepletedBlinkFrequency) < 0.5 / (double) this.staminaDepletedBlinkFrequency)
          this.SetStaminaBarColor(SingletonScriptableObject<ColorsConfig>.Instance.staminaEmptyBlinkColor, this.staminaSlicesBG);
        else
          this.SetStaminaBarColor(this.staminaBGColor, this.staminaSlicesBG);
      }
      else
        this.SetStaminaBarColor(this.staminaBGColor, this.staminaSlicesBG);
      float num = 0.0f;
      if ((double) this.staminaReplenishedGlowCounter < (double) this.staminaReplenishedGlowDuration)
      {
        this.staminaReplenishedGlowCounter += Time.deltaTime;
        num = Mathf.Clamp01((float) (1.0 - (double) this.staminaReplenishedGlowCounter / (double) this.staminaReplenishedGlowDuration));
      }
      Color stamina = SingletonScriptableObject<ColorsConfig>.Instance.stamina;
      stamina.a = num;
      this.staminaReplenishedGlow.color = stamina;
      this.diffDelayCounter = Mathf.Max(this.diffDelayCounter - Time.deltaTime, 0.0f);
      if ((double) this.currentDiffValue < (double) this.currentTargetValue)
      {
        this.currentDiffValue = this.currentTargetValue;
        this.diffDelayCounter = 0.0f;
      }
      else if ((double) this.diffDelayCounter == 0.0)
        this.currentDiffValue = Mathf.Lerp(this.currentDiffValue, this.currentTargetValue, 1f - Mathf.Pow(this.diffSmoothing, Time.deltaTime));
      this.SetStaminaBarFill(this.currentDiffValue, this.staminaSlicesDiff);
    }
  }
}
