// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.GraphicsSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class GraphicsSettings : ObservedSetting
  {
    [Header("Vsync and FPS cap Settings")]
    [SerializeField]
    private Slider vsyncSlider;
    [SerializeField]
    private Text vsyncText;
    private bool[] vsyncOptions = new bool[2]{ false, true };
    [SerializeField]
    private Slider fpsCapSlider;
    [SerializeField]
    private Text fpsCapText;
    private bool[] fpsCapOptions = new bool[2]
    {
      false,
      true
    };
    [SerializeField]
    private Slider fpsCapLimitSlider;
    [SerializeField]
    private Text fpsCapLimitText;
    private int[] fpsCapLimitOptions;
    [Header("QualityLevel")]
    [SerializeField]
    private Slider qualityLevelSlider;
    [SerializeField]
    private Text qualityLevelText;
    private string[] qualityLevels = new string[4]
    {
      "Lowest",
      "Low",
      "Mid",
      "High"
    };
    [Header("Custom Settings")]
    [SerializeField]
    private Slider vfxSlider;
    [SerializeField]
    private Text vfxText;
    private string[] vfxOptions = new string[4]
    {
      "Lowest",
      "Low",
      "Mid",
      "High"
    };
    [SerializeField]
    private Slider shaderQualitySlider;
    [SerializeField]
    private Text shaderQualityText;
    private string[] shaderQualityOptions = new string[2]
    {
      "Low",
      "High"
    };
    [SerializeField]
    private Slider postProcessingSlider;
    [SerializeField]
    private Text postProcessingText;
    private string[] postProcessingOptions = new string[2]
    {
      "Low",
      "High"
    };
    [SerializeField]
    private Slider antialiasingSlider;
    [SerializeField]
    private Text antialiasingText;
    private string[] antialiasingOptions = new string[3]
    {
      "Off",
      "2x",
      "4x"
    };
    [SerializeField]
    private Slider miscSlider;
    [SerializeField]
    private Text miscText;
    private string[] miscOptions = new string[4]
    {
      "Lowest",
      "Low",
      "Mid",
      "High"
    };
    private bool sliderValuesUpdating;

    private QualityManager qualityManager => ImiServices.Instance.QualityManager;

    private void Start()
    {
      List<int> intList = new List<int>();
      for (int index = 30; index < 60; index += 5)
        intList.Add(index);
      intList.Add(60);
      intList.Add(75);
      intList.Add(90);
      intList.Add(120);
      intList.Add(144);
      intList.Add(240);
      this.fpsCapLimitOptions = intList.ToArray();
      this.vsyncSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.fpsCapSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.fpsCapLimitSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.qualityLevelSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnBaseQualitySliderChange()));
      this.vfxSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.shaderQualitySlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.postProcessingSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.antialiasingSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.miscSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.vsyncSlider.minValue = 0.0f;
      this.vsyncSlider.maxValue = (float) (this.vsyncOptions.Length - 1);
      this.vsyncSlider.value = 0.0f;
      this.fpsCapSlider.minValue = 0.0f;
      this.fpsCapSlider.maxValue = (float) (this.fpsCapOptions.Length - 1);
      this.fpsCapSlider.value = 0.0f;
      this.fpsCapLimitSlider.minValue = 0.0f;
      this.fpsCapLimitSlider.maxValue = (float) (this.fpsCapLimitOptions.Length - 1);
      this.fpsCapLimitSlider.value = 0.0f;
      this.vfxSlider.minValue = 0.0f;
      this.vfxSlider.maxValue = (float) (this.vfxOptions.Length - 1);
      this.vfxSlider.value = 0.0f;
      this.shaderQualitySlider.minValue = 0.0f;
      this.shaderQualitySlider.maxValue = (float) (this.shaderQualityOptions.Length - 1);
      this.shaderQualitySlider.value = 0.0f;
      this.postProcessingSlider.minValue = 0.0f;
      this.postProcessingSlider.maxValue = (float) (this.postProcessingOptions.Length - 1);
      this.postProcessingSlider.value = 0.0f;
      this.antialiasingSlider.minValue = 0.0f;
      this.antialiasingSlider.maxValue = (float) (this.antialiasingOptions.Length - 1);
      this.antialiasingSlider.value = 0.0f;
      this.miscSlider.minValue = 0.0f;
      this.miscSlider.maxValue = (float) (this.miscOptions.Length - 1);
      this.miscSlider.value = 0.0f;
      this.qualityLevelSlider.minValue = 0.0f;
      this.qualityLevelSlider.maxValue = (float) (this.qualityLevels.Length - 1);
      this.qualityLevelSlider.value = 0.0f;
      this.UpdateSliderValues(this.qualityManager.CurrentRenderSettings);
      this.UpdateSliderValues(this.qualityManager.CurrentFrameRateSettings);
      this.UpdateVSyncText();
      this.UpdateFPSCapText();
      this.UpdateFPSCapFramesText();
      this.UpdateQualityLevelText();
      this.UpdateVfxText();
      this.UpdateShaderQualityText();
      this.UpdatePostProcessingText();
      this.UpdateAntialiasingText();
      this.UpdateMiscText();
      ImiServices.Instance.Analytics.OnEnteredGfxSettings();
    }

    private void UpdateSliderValues(QualityManager.FrameRateSettings frameRateSettings)
    {
      this.sliderValuesUpdating = true;
      this.vsyncSlider.value = frameRateSettings.vsync ? 1f : 0.0f;
      this.fpsCapSlider.value = frameRateSettings.fpsCap ? 1f : 0.0f;
      int fpsCapLimit = frameRateSettings.fpsCapLimit;
      int num = this.fpsCapLimitOptions.Length - 1;
      for (int index = 0; index < this.fpsCapLimitOptions.Length; ++index)
      {
        if (this.fpsCapLimitOptions[index] >= fpsCapLimit)
        {
          num = index;
          break;
        }
      }
      this.fpsCapLimitSlider.value = (float) num;
      this.sliderValuesUpdating = false;
    }

    private void UpdateSliderValues(QualityManager.RenderSettings renderSettings)
    {
      this.sliderValuesUpdating = true;
      this.qualityLevelSlider.value = (float) renderSettings.baseQuality;
      this.vfxSlider.value = (float) renderSettings.vfx;
      this.shaderQualitySlider.value = (float) renderSettings.shaderQuality;
      this.postProcessingSlider.value = (float) renderSettings.postProcessing;
      this.antialiasingSlider.value = (float) renderSettings.antialiasing;
      this.miscSlider.value = (float) renderSettings.miscSettings;
      this.sliderValuesUpdating = false;
    }

    private void OnDestroy()
    {
      this.vsyncSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.fpsCapSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.fpsCapLimitSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.qualityLevelSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnBaseQualitySliderChange()));
      this.vfxSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.shaderQualitySlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.postProcessingSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.antialiasingSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      this.miscSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
    }

    public void UpdateVSyncText() => this.vsyncText.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.vsyncOptions[(int) this.vsyncSlider.value] ? "@Setting_On" : "@Setting_Off");

    public void UpdateFPSCapText()
    {
      bool fpsCapOption = this.fpsCapOptions[(int) this.fpsCapSlider.value];
      this.fpsCapText.text = ImiServices.Instance.LocaService.GetLocalizedValue(fpsCapOption ? "@Setting_On" : "@Setting_Off");
      this.fpsCapLimitSlider.gameObject.SetActive(fpsCapOption);
    }

    public void UpdateFPSCapFramesText() => this.fpsCapLimitText.text = this.fpsCapLimitOptions[(int) this.fpsCapLimitSlider.value].ToString();

    public void UpdateQualityLevelText() => this.qualityLevelText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Setting_" + this.qualityLevels[(int) this.qualityLevelSlider.value]);

    public void UpdateVfxText() => this.vfxText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Setting_" + this.vfxOptions[(int) this.vfxSlider.value]);

    public void UpdateShaderQualityText() => this.shaderQualityText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Setting_" + this.shaderQualityOptions[(int) this.shaderQualitySlider.value]);

    public void UpdatePostProcessingText() => this.postProcessingText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Setting_" + this.postProcessingOptions[(int) this.postProcessingSlider.value]);

    public void UpdateAntialiasingText() => this.antialiasingText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Antialiasing_" + this.antialiasingOptions[(int) this.antialiasingSlider.value]);

    public void UpdateMiscText() => this.miscText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Setting_" + this.miscOptions[(int) this.miscSlider.value]);

    private void OnBaseQualitySliderChange()
    {
      if (this.sliderValuesUpdating)
        return;
      this.UpdateSliderValues(this.qualityManager.GetPreset((QualityManager.Level) this.qualityLevelSlider.value));
      this.OnSliderValueChange();
    }

    private void OnSliderValueChange()
    {
      if (this.sliderValuesUpdating)
        return;
      this.UpdateQualityLevelText();
      this.UpdateVSyncText();
      this.UpdateFPSCapText();
      this.UpdateFPSCapFramesText();
      this.UpdateVfxText();
      this.UpdateShaderQualityText();
      this.UpdatePostProcessingText();
      this.UpdateAntialiasingText();
      this.UpdateMiscText();
      QualityManager.RenderSettings renderSettings = new QualityManager.RenderSettings();
      QualityManager.FrameRateSettings frameRateSettings = new QualityManager.FrameRateSettings();
      renderSettings.baseQuality = (QualityManager.Level) this.qualityLevelSlider.value;
      renderSettings.vfx = (QualityManager.Level) this.vfxSlider.value;
      renderSettings.shaderQuality = (QualityManager.Level) this.shaderQualitySlider.value;
      renderSettings.postProcessing = (QualityManager.Level) this.postProcessingSlider.value;
      renderSettings.antialiasing = (QualityManager.Level) this.antialiasingSlider.value;
      renderSettings.miscSettings = (QualityManager.Level) this.miscSlider.value;
      frameRateSettings.vsync = (double) this.vsyncSlider.value == 1.0;
      frameRateSettings.fpsCap = (double) this.fpsCapSlider.value == 1.0;
      frameRateSettings.fpsCapLimit = this.fpsCapLimitOptions[(int) this.fpsCapLimitSlider.value];
      this.Notify((ISetting) new GraphicsTierSetting(renderSettings, frameRateSettings), this.SettingType);
    }

    public override ISetting GetCurrentSetting() => (ISetting) new GraphicsTierSetting(this.qualityManager.CurrentRenderSettings, this.qualityManager.CurrentFrameRateSettings);

    public override void ApplySetting(ISetting value)
    {
      GraphicsTierSetting graphicsTierSetting = (GraphicsTierSetting) value;
      Log.Debug(string.Format("Applying Graphics Settings. {0}", (object) graphicsTierSetting.renderSettings));
      this.qualityManager.SetRenderSettings(graphicsTierSetting.renderSettings);
      this.qualityManager.SetFrameRateSettings(graphicsTierSetting.frameRateSettings);
      this.qualityManager.StoreSettingsInPlayerPrefs();
    }
  }
}
