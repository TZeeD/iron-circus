// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.VoiceChatOptionsController
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
  public class VoiceChatOptionsController : ObservedSetting
  {
    public static readonly string VoiceChatAutoJoinPref = "VoiceChatAutoJoinSetting";
    public static readonly string VoiceChatPushToTalkPref = "VoiceChatPushToTalkSetting";
    public static readonly string VoiceChatVolumePref = nameof (VoiceChatVolumePref);
    public static readonly string VoiceChatMicVolumePref = nameof (VoiceChatMicVolumePref);
    private static readonly int vcAutojoinPrefDefaultValue = 1;
    private static readonly int vcPttDefaultValue = 1;
    private static readonly int vcVolumeDefaultValue = 0;
    private static readonly int vcMicVolumeDefaultValue = 0;
    [Header("Sliders")]
    [SerializeField]
    private Slider autoJoinSlider;
    [SerializeField]
    private Slider pushToTalkSlider;
    [SerializeField]
    private Slider voiceChatVolumeSlider;
    [SerializeField]
    private Slider microphoneVolumeSlider;
    [Header("Descripitions")]
    [SerializeField]
    private TextMeshProUGUI autoJoinDescription;
    [SerializeField]
    private TextMeshProUGUI pttDescription;
    [SerializeField]
    private Text volumeDescription;
    [SerializeField]
    private Text micVolumeDescription;
    private VoiceChatSetting currentSetting;

    private void Start()
    {
      this.currentSetting = VoiceChatOptionsController.LoadSettingsFromPlayerPrefs();
      int length1 = Enum.GetNames(typeof (VoiceChatOptionsController.VoiceChatJoinMethod)).Length;
      this.autoJoinSlider.minValue = 0.0f;
      this.autoJoinSlider.maxValue = (float) (length1 - 1);
      this.autoJoinSlider.value = (float) this.currentSetting.autoJoinSetting.Clamp<int>(0, length1 - 1);
      int length2 = Enum.GetNames(typeof (VoiceChatOptionsController.PushToTalkSetting)).Length;
      this.pushToTalkSlider.minValue = 0.0f;
      this.pushToTalkSlider.maxValue = (float) (length2 - 1);
      this.pushToTalkSlider.value = (float) this.currentSetting.pushToTalkSetting.Clamp<int>(0, length2 - 1);
      this.voiceChatVolumeSlider.minValue = -100f;
      this.voiceChatVolumeSlider.maxValue = 100f;
      this.voiceChatVolumeSlider.value = (float) this.currentSetting.volume.Clamp<int>(-100, 100);
      this.microphoneVolumeSlider.minValue = -100f;
      this.microphoneVolumeSlider.maxValue = 100f;
      this.microphoneVolumeSlider.value = (float) this.currentSetting.micVolume.Clamp<int>(-100, 100);
      this.UpdateSliderDescriptions();
    }

    public override void ApplySetting(ISetting value)
    {
      PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatAutoJoinPref, this.currentSetting.autoJoinSetting);
      PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatPushToTalkPref, this.currentSetting.pushToTalkSetting);
      PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatVolumePref, this.currentSetting.volume);
      PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatMicVolumePref, this.currentSetting.micVolume);
      ImiServices.Instance.VoiceChatService.UpdateVCSettings(this.currentSetting);
    }

    public void OnAutoJoinSettingSliderValueChanged()
    {
      this.currentSetting.autoJoinSetting = (int) this.autoJoinSlider.value;
      this.ApplySetting((ISetting) this.currentSetting);
      this.UpdateSliderDescriptions();
    }

    public void OnPushToTalkSettingsSliderChanged()
    {
      this.currentSetting.pushToTalkSetting = (int) this.pushToTalkSlider.value;
      this.ApplySetting((ISetting) this.currentSetting);
      this.UpdateSliderDescriptions();
    }

    public void OnVolumeSliderChanged()
    {
      this.currentSetting.volume = (int) this.voiceChatVolumeSlider.value;
      this.ApplySetting((ISetting) this.currentSetting);
      this.UpdateSliderDescriptions();
    }

    public void OnMicVolumeSliderChanged()
    {
      this.currentSetting.micVolume = (int) this.microphoneVolumeSlider.value;
      this.ApplySetting((ISetting) this.currentSetting);
      this.UpdateSliderDescriptions();
    }

    public void UpdateSliderDescriptions()
    {
      this.volumeDescription.text = this.voiceChatVolumeSlider.value.ToString("+ 0;- #");
      this.micVolumeDescription.text = this.microphoneVolumeSlider.value.ToString("+ 0;- #");
      this.autoJoinDescription.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) (VoiceChatOptionsController.VoiceChatJoinMethod) this.autoJoinSlider.value);
      this.pttDescription.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) (VoiceChatOptionsController.PushToTalkSetting) this.pushToTalkSlider.value);
    }

    public override ISetting GetCurrentSetting() => (ISetting) this.currentSetting;

    public static VoiceChatSetting LoadSettingsFromPlayerPrefs() => new VoiceChatSetting()
    {
      autoJoinSetting = !PlayerPrefs.HasKey(VoiceChatOptionsController.VoiceChatAutoJoinPref) ? VoiceChatOptionsController.vcAutojoinPrefDefaultValue : PlayerPrefs.GetInt(VoiceChatOptionsController.VoiceChatAutoJoinPref),
      pushToTalkSetting = !PlayerPrefs.HasKey(VoiceChatOptionsController.VoiceChatPushToTalkPref) ? VoiceChatOptionsController.vcPttDefaultValue : PlayerPrefs.GetInt(VoiceChatOptionsController.VoiceChatPushToTalkPref),
      volume = !PlayerPrefs.HasKey(VoiceChatOptionsController.VoiceChatVolumePref) ? VoiceChatOptionsController.vcVolumeDefaultValue : PlayerPrefs.GetInt(VoiceChatOptionsController.VoiceChatVolumePref),
      micVolume = !PlayerPrefs.HasKey(VoiceChatOptionsController.VoiceChatMicVolumePref) ? VoiceChatOptionsController.vcMicVolumeDefaultValue : PlayerPrefs.GetInt(VoiceChatOptionsController.VoiceChatMicVolumePref)
    };

    public enum VoiceChatJoinMethod
    {
      AlwaysJoin,
      PromptJoin,
      NeverJoin,
    }

    public enum PushToTalkSetting
    {
      OpenMic,
      PushToTalk,
    }
  }
}
