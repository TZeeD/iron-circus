// Decompiled with JetBrains decompiler
// Type: AmplifyBloom.DemoMainUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace AmplifyBloom
{
  public class DemoMainUI : MonoBehaviour
  {
    private const string VERTICAL_GAMEPAD = "Vertical";
    private const string HORIZONTAL_GAMEPAD = "Horizontal";
    private const string SUBMIT_BUTTON = "Submit";
    public Toggle BloomToggle;
    public Toggle HighPrecision;
    public Toggle UpscaleType;
    public Toggle TemporalFilter;
    public Toggle BokehToggle;
    public Toggle LensFlareToggle;
    public Toggle LensGlareToggle;
    public Toggle LensDirtToggle;
    public Toggle LensStarburstToggle;
    public Slider ThresholdSlider;
    public Slider DownscaleAmountSlider;
    public Slider IntensitySlider;
    public Slider ThresholdSizeSlider;
    private AmplifyBloomEffect _amplifyBloomEffect;
    private Camera _camera;
    private DemoUIElement[] m_uiElements;
    private bool m_gamePadMode;
    private int m_currentOption;
    private int m_lastOption;
    private int m_lastAxisValue;

    private void Awake()
    {
      this._camera = Camera.main;
      this._amplifyBloomEffect = this._camera.GetComponent<AmplifyBloomEffect>();
      this.BloomToggle.isOn = this._amplifyBloomEffect.enabled;
      this.HighPrecision.isOn = this._amplifyBloomEffect.HighPrecision;
      this.UpscaleType.isOn = this._amplifyBloomEffect.UpscaleQuality == UpscaleQualityEnum.Realistic;
      this.TemporalFilter.isOn = this._amplifyBloomEffect.TemporalFilteringActive;
      this.BokehToggle.isOn = this._amplifyBloomEffect.BokehFilterInstance.ApplyBokeh;
      this.LensFlareToggle.isOn = this._amplifyBloomEffect.LensFlareInstance.ApplyLensFlare;
      this.LensGlareToggle.isOn = this._amplifyBloomEffect.LensGlareInstance.ApplyLensGlare;
      this.LensDirtToggle.isOn = this._amplifyBloomEffect.ApplyLensDirt;
      this.LensStarburstToggle.isOn = this._amplifyBloomEffect.ApplyLensStardurst;
      this.BloomToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnBloomToggle));
      this.HighPrecision.onValueChanged.AddListener(new UnityAction<bool>(this.OnHighPrecisionToggle));
      this.UpscaleType.onValueChanged.AddListener(new UnityAction<bool>(this.OnUpscaleTypeToogle));
      this.TemporalFilter.onValueChanged.AddListener(new UnityAction<bool>(this.OnTemporalFilterToggle));
      this.BokehToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnBokehFilterToggle));
      this.LensFlareToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnLensFlareToggle));
      this.LensGlareToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnLensGlareToggle));
      this.LensDirtToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnLensDirtToggle));
      this.LensStarburstToggle.onValueChanged.AddListener(new UnityAction<bool>(this.OnLensStarburstToggle));
      this.ThresholdSlider.value = this._amplifyBloomEffect.OverallThreshold;
      this.ThresholdSlider.onValueChanged.AddListener(new UnityAction<float>(this.OnThresholdSlider));
      this.DownscaleAmountSlider.value = (float) this._amplifyBloomEffect.BloomDownsampleCount;
      this.DownscaleAmountSlider.onValueChanged.AddListener(new UnityAction<float>(this.OnDownscaleAmount));
      this.IntensitySlider.value = this._amplifyBloomEffect.OverallIntensity;
      this.IntensitySlider.onValueChanged.AddListener(new UnityAction<float>(this.OnIntensitySlider));
      this.ThresholdSizeSlider.value = (float) this._amplifyBloomEffect.MainThresholdSize;
      this.ThresholdSizeSlider.onValueChanged.AddListener(new UnityAction<float>(this.OnThresholdSize));
      if (Input.GetJoystickNames().Length == 0)
        return;
      this.m_gamePadMode = true;
      this.m_uiElements = new DemoUIElement[13];
      this.m_uiElements[0] = this.BloomToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[1] = this.HighPrecision.GetComponent<DemoUIElement>();
      this.m_uiElements[2] = this.UpscaleType.GetComponent<DemoUIElement>();
      this.m_uiElements[3] = this.TemporalFilter.GetComponent<DemoUIElement>();
      this.m_uiElements[4] = this.BokehToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[5] = this.LensFlareToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[6] = this.LensGlareToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[7] = this.LensDirtToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[8] = this.LensStarburstToggle.GetComponent<DemoUIElement>();
      this.m_uiElements[9] = this.ThresholdSlider.GetComponent<DemoUIElement>();
      this.m_uiElements[10] = this.DownscaleAmountSlider.GetComponent<DemoUIElement>();
      this.m_uiElements[11] = this.IntensitySlider.GetComponent<DemoUIElement>();
      this.m_uiElements[12] = this.ThresholdSizeSlider.GetComponent<DemoUIElement>();
      for (int index = 0; index < this.m_uiElements.Length; ++index)
        this.m_uiElements[index].Init();
      this.m_uiElements[this.m_currentOption].Select = true;
    }

    public void OnThresholdSize(float selection) => this._amplifyBloomEffect.MainThresholdSize = (MainThresholdSizeEnum) selection;

    public void OnThresholdSlider(float value) => this._amplifyBloomEffect.OverallThreshold = value;

    public void OnDownscaleAmount(float value) => this._amplifyBloomEffect.BloomDownsampleCount = (int) value;

    public void OnIntensitySlider(float value) => this._amplifyBloomEffect.OverallIntensity = value;

    public void OnBloomToggle(bool value) => this._amplifyBloomEffect.enabled = this.BloomToggle.isOn;

    public void OnHighPrecisionToggle(bool value) => this._amplifyBloomEffect.HighPrecision = value;

    public void OnUpscaleTypeToogle(bool value) => this._amplifyBloomEffect.UpscaleQuality = value ? UpscaleQualityEnum.Realistic : UpscaleQualityEnum.Natural;

    public void OnTemporalFilterToggle(bool value) => this._amplifyBloomEffect.TemporalFilteringActive = value;

    public void OnBokehFilterToggle(bool value) => this._amplifyBloomEffect.BokehFilterInstance.ApplyBokeh = this.BokehToggle.isOn;

    public void OnLensFlareToggle(bool value) => this._amplifyBloomEffect.LensFlareInstance.ApplyLensFlare = this.LensFlareToggle.isOn;

    public void OnLensGlareToggle(bool value) => this._amplifyBloomEffect.LensGlareInstance.ApplyLensGlare = this.LensGlareToggle.isOn;

    public void OnLensDirtToggle(bool value) => this._amplifyBloomEffect.ApplyLensDirt = this.LensDirtToggle.isOn;

    public void OnLensStarburstToggle(bool value) => this._amplifyBloomEffect.ApplyLensStardurst = this.LensStarburstToggle.isOn;

    public void OnQuitButton() => Application.Quit();

    private void Update()
    {
      if (this.m_gamePadMode)
      {
        int axis1 = (int) Input.GetAxis("Vertical");
        if (axis1 != this.m_lastAxisValue)
        {
          this.m_lastAxisValue = axis1;
          switch (axis1)
          {
            case -1:
              this.m_currentOption = this.m_currentOption == 0 ? this.m_uiElements.Length - 1 : this.m_currentOption - 1;
              break;
            case 1:
              this.m_currentOption = (this.m_currentOption + 1) % this.m_uiElements.Length;
              break;
          }
          this.m_uiElements[this.m_lastOption].Select = false;
          this.m_uiElements[this.m_currentOption].Select = true;
          this.m_lastOption = this.m_currentOption;
        }
        if (Input.GetButtonDown("Submit"))
          this.m_uiElements[this.m_currentOption].DoAction(DemoUIElementAction.Press);
        float axis2 = Input.GetAxis("Horizontal");
        if ((double) Mathf.Abs(axis2) > 0.0)
          this.m_uiElements[this.m_currentOption].DoAction(DemoUIElementAction.Slide, (object) (float) ((double) axis2 * (double) Time.deltaTime));
        else
          this.m_uiElements[this.m_currentOption].Idle();
      }
      if (Input.GetKey(KeyCode.LeftAlt) && Input.GetKey(KeyCode.Q))
        this.OnQuitButton();
      if (Input.GetKeyDown(KeyCode.Alpha0))
        this._camera.orthographic = !this._camera.orthographic;
      if (Input.GetKeyDown(KeyCode.Alpha1))
        this._amplifyBloomEffect.enabled = this.BloomToggle.isOn = !this.BloomToggle.isOn;
      this.BokehToggle.interactable = this.LensFlareToggle.interactable = this.LensGlareToggle.interactable = this.LensDirtToggle.interactable = this.LensStarburstToggle.interactable = this.ThresholdSlider.interactable = this.DownscaleAmountSlider.interactable = this.HighPrecision.interactable = this.IntensitySlider.interactable = this.BloomToggle.isOn;
      if (!this.BloomToggle.isOn)
        return;
      if (Input.GetKeyDown(KeyCode.Alpha2))
        this._amplifyBloomEffect.BokehFilterInstance.ApplyBokeh = this.BokehToggle.isOn = !this.BokehToggle.isOn;
      if (Input.GetKeyDown(KeyCode.Alpha3))
        this._amplifyBloomEffect.LensFlareInstance.ApplyLensFlare = this.LensFlareToggle.isOn = !this.LensFlareToggle.isOn;
      if (Input.GetKeyDown(KeyCode.Alpha4))
        this._amplifyBloomEffect.LensGlareInstance.ApplyLensGlare = this.LensGlareToggle.isOn = !this.LensGlareToggle.isOn;
      if (Input.GetKeyDown(KeyCode.Alpha5))
        this._amplifyBloomEffect.ApplyLensDirt = this.LensDirtToggle.isOn = !this.LensDirtToggle.isOn;
      if (!Input.GetKeyDown(KeyCode.Alpha6))
        return;
      this._amplifyBloomEffect.ApplyLensStardurst = this.LensStarburstToggle.isOn = !this.LensStarburstToggle.isOn;
    }
  }
}
