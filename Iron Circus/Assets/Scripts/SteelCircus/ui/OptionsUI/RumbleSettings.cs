// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.RumbleSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class RumbleSettings : ObservedSetting
  {
    public static RumbleSettings.RumbleStates RumbleSetting;
    [SerializeField]
    private Slider slider;
    [SerializeField]
    private TextMeshProUGUI optionsDisplayText;

    private void Start()
    {
      this.slider.minValue = 0.0f;
      this.slider.maxValue = (float) (Enum.GetValues(typeof (RumbleSettings.RumbleStates)).Length - 1);
      if (PlayerPrefs.HasKey(nameof (RumbleSettings)))
      {
        int val = PlayerPrefs.GetInt(nameof (RumbleSettings));
        val.Clamp<int>(0, Enum.GetValues(typeof (RumbleSettings.RumbleStates)).Length - 1);
        this.slider.value = (float) val;
      }
      else
        this.slider.value = 0.0f;
      this.OnSliderValueChanged();
    }

    public void OnSliderValueChanged()
    {
      this.ApplySetting((ISetting) new SteelCircus.UI.OptionsUI.RumbleSetting((RumbleSettings.RumbleStates) this.slider.value));
      this.optionsDisplayText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) (RumbleSettings.RumbleStates) this.slider.value).ToString();
    }

    public override void ApplySetting(ISetting value)
    {
      SteelCircus.UI.OptionsUI.RumbleSetting rumbleSetting = (SteelCircus.UI.OptionsUI.RumbleSetting) value;
      PlayerPrefs.SetInt(nameof (RumbleSettings), (int) rumbleSetting.rumbleState);
      RumbleSettings.RumbleSetting = rumbleSetting.rumbleState;
    }

    public override ISetting GetCurrentSetting() => (ISetting) new SteelCircus.UI.OptionsUI.RumbleSetting((RumbleSettings.RumbleStates) this.slider.value);

    public static void LoadRumbleSettings()
    {
      if (PlayerPrefs.HasKey(nameof (RumbleSettings)))
        RumbleSettings.RumbleSetting = (RumbleSettings.RumbleStates) PlayerPrefs.GetInt(nameof (RumbleSettings));
      else
        RumbleSettings.RumbleSetting = RumbleSettings.RumbleStates.RumbleOn;
    }

    public enum RumbleStates
    {
      RumbleOn,
      RumbleOff,
    }
  }
}
