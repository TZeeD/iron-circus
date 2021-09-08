// Decompiled with JetBrains decompiler
// Type: SprintSkillUiInstance
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.UI;

public class SprintSkillUiInstance : MonoBehaviour
{
  [SerializeField]
  private Image chargeIndicatorFg;
  [SerializeField]
  private Image chargeIndicatorBg;
  [SerializeField]
  private Color depletedBlinkColor = new Color(0.9f, 0.43f, 0.23f, 1f);
  private Color originalBgColor;
  [SerializeField]
  private float chargeDepletedBlinkDuration = 0.6f;
  [SerializeField]
  private float chargeDepletedBlinkFrequency = 6f;
  private float chargeDepletedBlinkCounter;
  private SkillVar<bool> canAffordTackle;
  private SkillVar<bool> canAffordDodge;

  private void Start()
  {
    this.originalBgColor = this.chargeIndicatorBg.color;
    this.chargeDepletedBlinkCounter = this.chargeDepletedBlinkDuration;
  }

  public void SetUiStateData(SkillUiStateData newStateData, GameEntity champEntity)
  {
    this.chargeIndicatorFg.fillAmount = newStateData.fillAmount;
    this.chargeIndicatorBg.fillAmount = 1f - newStateData.fillAmount;
    if (this.canAffordTackle == null || this.canAffordDodge == null)
    {
      this.canAffordTackle = champEntity.skillGraph.GetVar<bool>("CanAffordTackle");
      this.canAffordDodge = champEntity.skillGraph.GetVar<bool>("CanAffordDodge");
    }
    this.chargeIndicatorFg.color = !(bool) this.canAffordTackle || !(bool) this.canAffordDodge ? SingletonScriptableObject<ColorsConfig>.Instance.staminaBarEmpty : SingletonScriptableObject<ColorsConfig>.Instance.stamina;
    double fillAmount = (double) newStateData.fillAmount;
    this.chargeIndicatorBg.color = this.originalBgColor;
    if (fillAmount == 0.0 && newStateData.isButtonDown)
      this.chargeDepletedBlinkCounter = 0.0f;
    if ((double) this.chargeDepletedBlinkCounter >= (double) this.chargeDepletedBlinkDuration)
      return;
    this.chargeDepletedBlinkCounter += Time.deltaTime;
    if ((double) Time.time % (1.0 / (double) this.chargeDepletedBlinkFrequency) >= 0.5 / (double) this.chargeDepletedBlinkFrequency)
      return;
    this.chargeIndicatorBg.color = this.depletedBlinkColor;
  }
}
