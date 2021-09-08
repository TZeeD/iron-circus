﻿// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.OnSelectedOptionsSlider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class OnSelectedOptionsSlider : 
    MonoBehaviour,
    ISelectHandler,
    IEventSystemHandler,
    IDeselectHandler
  {
    [SerializeField]
    private Image sliderBackgroundImage;
    [SerializeField]
    private Sprite deselectedSprite;
    [SerializeField]
    private Sprite selectedSprite;
    [SerializeField]
    private Image sliderBackgroundFillImage;
    [SerializeField]
    private Image sliderFillImage;
    [SerializeField]
    private TextMeshProUGUI optionNameTxt;
    [SerializeField]
    private Text optionValueTxt;

    public void OnSelect(BaseEventData eventData) => this.SelectSlider();

    public void OnDeselect(BaseEventData eventData) => this.DeselectSlider();

    private void SelectSlider()
    {
      this.sliderBackgroundFillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.deselectedHueGray;
      this.sliderFillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.deselectedHueBlack;
      this.sliderBackgroundImage.sprite = this.selectedSprite;
      this.optionNameTxt.color = Color.black;
      this.optionValueTxt.color = Color.black;
    }

    private void DeselectSlider()
    {
      this.sliderBackgroundFillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.selectedHueGray;
      this.sliderFillImage.color = SingletonScriptableObject<ColorsConfig>.Instance.selectedHueOrange;
      this.sliderBackgroundImage.sprite = this.deselectedSprite;
      this.optionNameTxt.color = Color.white;
      this.optionValueTxt.color = Color.white;
    }
  }
}
