// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.AudioOptionsSlider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class AudioOptionsSlider : MonoBehaviour
  {
    [SerializeField]
    private AudioMixerGroup audioMixerGroup;
    [SerializeField]
    private Text sliderText;
    private Slider slider;

    public event AudioOptionsSlider.OnAudioOptionsChangedEventHandler OnAudioOptionsChanged;

    private void OnEnable()
    {
      this.slider = this.GetComponent<Slider>();
      if ((Object) this.slider != (Object) null)
        this.slider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      float decibelValue;
      this.audioMixerGroup.audioMixer.GetFloat(this.audioMixerGroup.name, out decibelValue);
      this.slider.value = AudioSettingsController.ConvertDecibelToLinear(decibelValue);
      this.SetSliderValues(this.slider.value);
    }

    private void OnSliderValueChange()
    {
      AudioOptionsSlider.OnAudioOptionsChangedEventHandler audioOptionsChanged = this.OnAudioOptionsChanged;
      if (audioOptionsChanged != null)
        audioOptionsChanged(this.audioMixerGroup, this.slider.value);
      this.SetSliderValues(this.slider.value);
    }

    public void SetSliderValues(float value) => this.sliderText.text = ((int) value).ToString() + "%";

    private void OnDisable() => this.slider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));

    public delegate void OnAudioOptionsChangedEventHandler(AudioMixerGroup mixerGroup, float volume);
  }
}
