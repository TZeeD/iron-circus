// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.DisplaySettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class DisplaySettings : ObservedSetting
  {
    [Header("Display Settings")]
    [SerializeField]
    private FullScreenMode[] modes = (FullScreenMode[]) Enum.GetValues(typeof (FullScreenMode));
    [SerializeField]
    private Slider displayModeSlider;
    [SerializeField]
    private Text displayModeText;
    [Header("Resolution Settings")]
    [SerializeField]
    private int minHeight = 720;
    private DisplaySetting currentSetting;
    [SerializeField]
    private int minWidth = 1280;
    [SerializeField]
    private Slider resolutionSlider;
    [SerializeField]
    private Text resolutionText;
    [SerializeField]
    private Resolution[] resolutions;
    private bool updateSettingsOnSliderChange;

    private void Start()
    {
      this.updateSettingsOnSliderChange = false;
      this.displayModeSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnResolutionSliderValueChange()));
      this.resolutionSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnResolutionSliderValueChange()));
      this.currentSetting = (DisplaySetting) this.GetCurrentSetting();
      this.resolutions = this.RemoveUnwantedResolutions();
      this.resolutions = this.RemoveDoubles(this.resolutions);
      this.resolutionText.text = Screen.width.ToString() + "x" + (object) Screen.height;
      this.displayModeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@WindowMode_" + (object) Screen.fullScreenMode);
      this.resolutionSlider.minValue = 0.0f;
      this.resolutionSlider.maxValue = (float) (this.resolutions.Length - 1);
      this.resolutionSlider.value = (float) this.GetResolutionIndex(this.currentSetting.resolution);
      this.displayModeSlider.minValue = 0.0f;
      this.displayModeSlider.maxValue = (float) (this.modes.Length - 1);
      this.displayModeSlider.value = (float) Array.IndexOf<FullScreenMode>(this.modes, this.currentSetting.fullScreenMode);
      this.StartCoroutine(this.ResetUpdateSettingsBool());
    }

    private IEnumerator ResetUpdateSettingsBool()
    {
      yield return (object) null;
      this.updateSettingsOnSliderChange = true;
    }

    private void OnDestroy()
    {
      this.displayModeSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnResolutionSliderValueChange()));
      this.resolutionSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnResolutionSliderValueChange()));
    }

    public void UpdateResolutionText() => this.resolutionText.text = this.resolutions[(int) this.resolutionSlider.value].width.ToString() + "x" + (object) this.resolutions[(int) this.resolutionSlider.value].height;

    public void UpdateDisplayModeText() => this.displayModeText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@WindowMode_" + this.modes[(int) this.displayModeSlider.value].ToString());

    private int GetResolutionIndex(Resolution resolution)
    {
      for (int index = 0; index < this.resolutions.Length; ++index)
      {
        if (resolution.width == this.resolutions[index].width && resolution.height == this.resolutions[index].height)
          return index;
      }
      return 0;
    }

    private int GetHighestRefreshRateForResolution(int width, int height)
    {
      Resolution[] resolutions = Screen.resolutions;
      int num1 = int.MaxValue;
      int num2 = 0;
      foreach (Resolution resolution in resolutions)
      {
        if (resolution.refreshRate < num1)
          num1 = resolution.refreshRate;
        if (resolution.width == width && resolution.height == height && resolution.refreshRate > num2)
          num2 = resolution.refreshRate;
      }
      return num2 > 0 ? num2 : num1;
    }

    private Resolution[] RemoveUnwantedResolutions()
    {
      List<Resolution> resolutionList = new List<Resolution>();
      foreach (Resolution resolution in Screen.resolutions)
      {
        if (resolution.height >= this.minHeight && resolution.width >= this.minWidth)
          resolutionList.Add(resolution);
      }
      return resolutionList.ToArray();
    }

    private int[] GetRefreshRates(Resolution[] resolutions)
    {
      List<int> intList = new List<int>();
      foreach (Resolution resolution in resolutions)
      {
        if (!intList.Contains(resolution.refreshRate))
          intList.Add(resolution.refreshRate);
      }
      return intList.ToArray();
    }

    private Resolution[] RemoveDoubles(Resolution[] resolutions)
    {
      List<Resolution> resolutionList = new List<Resolution>();
      foreach (Resolution resolution1 in resolutions)
      {
        bool flag = false;
        foreach (Resolution resolution2 in resolutionList)
        {
          if (resolution1.width == resolution2.width && resolution1.height == resolution2.height)
            flag = true;
        }
        if (!flag)
          resolutionList.Add(resolution1);
      }
      return resolutionList.ToArray();
    }

    public void OnDisplayModeSliderValueChange()
    {
      Log.Debug("Display Mode Slider Changed: " + (object) this.modes[(int) this.displayModeSlider.value]);
      this.UpdateDisplayModeText();
      if (!this.updateSettingsOnSliderChange)
        return;
      Log.Debug("Display Mode Setting Changed");
      this.CheckForResolutionChange();
    }

    public void OnResolutionSliderValueChange()
    {
      Log.Debug("Resolution Slider Changed to " + (object) this.resolutions[(int) this.resolutionSlider.value].width + "/" + (object) this.resolutions[(int) this.resolutionSlider.value].height);
      this.UpdateResolutionText();
      if (!this.updateSettingsOnSliderChange)
        return;
      Log.Debug("Resolution Setting Changed");
      this.CheckForResolutionChange();
    }

    private void CheckForResolutionChange()
    {
      Log.Debug("");
      Resolution resolution = new Resolution();
      resolution.width = this.resolutions[(int) this.resolutionSlider.value].width;
      resolution.height = this.resolutions[(int) this.resolutionSlider.value].height;
      if (resolution.width == Screen.currentResolution.width)
      {
        int height1 = resolution.height;
        Resolution currentResolution = Screen.currentResolution;
        int height2 = currentResolution.height;
        if (height1 == height2)
        {
          int refreshRate1 = resolution.refreshRate;
          currentResolution = Screen.currentResolution;
          int refreshRate2 = currentResolution.refreshRate;
          if (refreshRate1 == refreshRate2 && this.modes[(int) this.displayModeSlider.value] == Screen.fullScreenMode)
            return;
        }
      }
      this.Notify((ISetting) new DisplaySetting(resolution, this.modes[(int) this.displayModeSlider.value]), Settings.SettingType.DisplaySettings);
    }

    public override void ApplySetting(ISetting value)
    {
      DisplaySetting displaySetting = (DisplaySetting) value;
      Log.Debug(string.Format("Applying resolution to {0}/{1} and {2}", (object) displaySetting.resolution.width, (object) displaySetting.resolution.height, (object) displaySetting.fullScreenMode));
      int rateForResolution = this.GetHighestRefreshRateForResolution(displaySetting.resolution.width, displaySetting.resolution.height);
      Screen.fullScreenMode = displaySetting.fullScreenMode;
      Screen.SetResolution(1000, 1000, displaySetting.fullScreenMode);
      Screen.SetResolution(displaySetting.resolution.width, displaySetting.resolution.height, displaySetting.fullScreenMode, rateForResolution);
      Debug.Log((object) string.Format("Apply {0} =  {1} - {2}.", (object) this.SettingType, (object) displaySetting.resolution.ToString(), (object) displaySetting.fullScreenMode));
      this.currentSetting = displaySetting;
    }

    public void StoreDisplaySettingsToPlayerPrefs()
    {
      Log.Debug(string.Format("Setting resolution prefs to {0}/{1} and {2}", (object) this.currentSetting.resolution.width, (object) this.currentSetting.resolution.height, (object) this.currentSetting.fullScreenMode));
      PlayerPrefs.SetInt("resolutionX", this.currentSetting.resolution.width);
      PlayerPrefs.SetInt("resolutionY", this.currentSetting.resolution.height);
      PlayerPrefs.SetInt("screenMode", (int) this.currentSetting.fullScreenMode);
    }

    public override ISetting GetCurrentSetting()
    {
      if (this.currentSetting.resolution.width > 0 && this.currentSetting.resolution.height > 0)
        return (ISetting) this.currentSetting;
      DisplaySetting displaySetting = new DisplaySetting();
      if (PlayerPrefs.HasKey("resolutionX") && PlayerPrefs.HasKey("resolutionY"))
      {
        displaySetting.resolution.width = PlayerPrefs.GetInt("resolutionX");
        displaySetting.resolution.height = PlayerPrefs.GetInt("resolutionY");
        displaySetting.resolution.refreshRate = Screen.currentResolution.refreshRate;
      }
      else
      {
        displaySetting.resolution.width = Screen.currentResolution.width;
        ref Resolution local1 = ref displaySetting.resolution;
        Resolution currentResolution = Screen.currentResolution;
        int height = currentResolution.height;
        local1.height = height;
        ref Resolution local2 = ref displaySetting.resolution;
        currentResolution = Screen.currentResolution;
        int refreshRate = currentResolution.refreshRate;
        local2.refreshRate = refreshRate;
      }
      displaySetting.fullScreenMode = Screen.fullScreenMode;
      return (ISetting) displaySetting;
    }

    public void ResetSliders(DisplaySetting setting)
    {
      int num = 0;
      for (int index = 0; index < this.resolutions.Length; ++index)
      {
        if (this.resolutions[index].width == setting.resolution.width && this.resolutions[index].height == setting.resolution.height)
          num = index;
        int refreshRate1 = this.resolutions[index].refreshRate;
        int refreshRate2 = setting.resolution.refreshRate;
      }
      this.displayModeSlider.value = (float) setting.fullScreenMode;
      this.resolutionSlider.value = (float) num;
    }

    public static void LoadDisplaySettingsFromPlayerPrefs()
    {
      int fullScreenMode = (int) Screen.fullScreenMode;
      if (PlayerPrefs.HasKey("screenMode"))
        fullScreenMode = PlayerPrefs.GetInt("screenMode");
      Screen.fullScreenMode = (FullScreenMode) fullScreenMode;
      if (!PlayerPrefs.HasKey("resolutionX") || !PlayerPrefs.HasKey("resolutionY"))
        return;
      Screen.SetResolution(PlayerPrefs.GetInt("resolutionX"), PlayerPrefs.GetInt("resolutionY"), (FullScreenMode) fullScreenMode);
    }
  }
}
