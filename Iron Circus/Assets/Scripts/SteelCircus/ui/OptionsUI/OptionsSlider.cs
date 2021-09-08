// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.OptionsSlider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class OptionsSlider : MonoBehaviour
  {
    [SerializeField]
    private Color lowSettingColor;
    [SerializeField]
    private Color highSettingColor;
    [SerializeField]
    private Slider slider;
    [SerializeField]
    private Text sliderText;
    [SerializeField]
    private Image amountBar;

    private void Start() => this.SetSliderValues(this.slider.value);

    public void SetSliderValues(float value) => this.sliderText.text = ((int) value).ToString() + "%";
  }
}
