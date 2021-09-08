// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.OptionsFieldArrowButtons
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  [RequireComponent(typeof (Slider))]
  public class OptionsFieldArrowButtons : MonoBehaviour
  {
    private Slider optionsEntrySlider;

    private void Start()
    {
      if (!((Object) this.optionsEntrySlider == (Object) null))
        return;
      this.optionsEntrySlider = this.GetComponent<Slider>();
    }

    public void LeftButtonAction()
    {
      if ((double) this.optionsEntrySlider.value > (double) this.optionsEntrySlider.minValue)
        --this.optionsEntrySlider.value;
      else
        this.optionsEntrySlider.value = this.optionsEntrySlider.maxValue;
    }

    public void RightButtonAction()
    {
      if ((double) this.optionsEntrySlider.value < (double) this.optionsEntrySlider.maxValue)
        ++this.optionsEntrySlider.value;
      else
        this.optionsEntrySlider.value = this.optionsEntrySlider.minValue;
    }
  }
}
