// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.AudioSettingsController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;
using UnityEngine.Audio;

namespace SteelCircus.UI.OptionsUI
{
  public class AudioSettingsController : ObservedSetting
  {
    [SerializeField]
    private AudioMixer mixer;
    private AudioOptionsSlider[] sliders;

    private void Awake() => this.SettingType = Settings.SettingType.AudioSettings;

    private void OnEnable()
    {
      this.sliders = this.GetComponentsInChildren<AudioOptionsSlider>();
      foreach (AudioOptionsSlider slider in this.sliders)
        slider.OnAudioOptionsChanged += new AudioOptionsSlider.OnAudioOptionsChangedEventHandler(this.SetGroupVolume);
    }

    private void OnDisable()
    {
      foreach (AudioOptionsSlider slider in this.sliders)
        slider.OnAudioOptionsChanged -= new AudioOptionsSlider.OnAudioOptionsChangedEventHandler(this.SetGroupVolume);
    }

    public void SetGroupVolume(AudioMixerGroup mixerGroup, float volume)
    {
      float num = 0.0f;
      mixerGroup.audioMixer.GetFloat(mixerGroup.name, out num);
      mixerGroup.audioMixer.SetFloat(mixerGroup.name, AudioSettingsController.ConvertLinearToDecibel(volume));
      Log.Debug(string.Format("Changed AudioSetting: {0} to: {1} db. Was {2}", (object) mixerGroup.name, (object) AudioSettingsController.ConvertLinearToDecibel(volume), (object) num));
      this.Notify(this.GetCurrentSetting(), this.SettingType);
    }

    public static float ConvertLinearToDecibel(float linearValue)
    {
      float num = -80f;
      if ((double) linearValue > 0.0)
        num = Mathf.Log(linearValue / 100f, 10f) * 17f;
      return num;
    }

    public static float ConvertDecibelToLinear(float decibelValue) => Mathf.Pow(10f, decibelValue / 17f) * 100f;

    public override void ApplySetting(ISetting settings)
    {
      SC_AudioSettings scAudioSettings = (SC_AudioSettings) settings;
      Debug.Log((object) string.Format("Apply {0} MasterVolume:{1} - MusicVolume:{2} - SFXVolume:{3}", (object) this.SettingType, (object) scAudioSettings.MasterVolume, (object) scAudioSettings.MusicVolume, (object) scAudioSettings.SfxVolume));
      PlayerPrefs.SetFloat("MasterVolume", scAudioSettings.MasterVolume);
      this.mixer.SetFloat("Master", AudioSettingsController.ConvertLinearToDecibel(scAudioSettings.MasterVolume));
      PlayerPrefs.SetFloat("MusicVolume", scAudioSettings.MusicVolume);
      this.mixer.SetFloat("MUSIC", AudioSettingsController.ConvertLinearToDecibel(scAudioSettings.MusicVolume));
      PlayerPrefs.SetFloat("SFXVolume", scAudioSettings.SfxVolume);
      this.mixer.SetFloat("SFX ALL", AudioSettingsController.ConvertLinearToDecibel(scAudioSettings.SfxVolume));
      PlayerPrefs.Save();
    }

    public override ISetting GetCurrentSetting()
    {
      float decibelValue1;
      this.mixer.GetFloat("Master", out decibelValue1);
      float decibelValue2;
      this.mixer.GetFloat("MUSIC", out decibelValue2);
      float decibelValue3;
      this.mixer.GetFloat("SFX ALL", out decibelValue3);
      return (ISetting) new SC_AudioSettings(AudioSettingsController.ConvertDecibelToLinear(decibelValue1), AudioSettingsController.ConvertDecibelToLinear(decibelValue2), AudioSettingsController.ConvertDecibelToLinear(decibelValue3));
    }
  }
}
