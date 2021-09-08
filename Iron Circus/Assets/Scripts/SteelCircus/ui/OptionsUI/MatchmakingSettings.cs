// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.MatchmakingSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class MatchmakingSettings : MonoBehaviour
  {
    [SerializeField]
    private Slider regionSlider;
    [SerializeField]
    private TextMeshProUGUI selectedRegionText;
    private List<string> matchmakingRegions;

    private void Start()
    {
      this.matchmakingRegions = ImiServices.Instance.MatchmakingService.GetRegions();
      this.regionSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderChanged()));
      string str = !PlayerPrefs.HasKey("MatchmakingRegion") ? "eu-west-1" : PlayerPrefs.GetString("MatchmakingRegion");
      this.selectedRegionText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@MatchmakingRegion_" + str);
      this.regionSlider.minValue = 0.0f;
      this.regionSlider.maxValue = (float) (this.matchmakingRegions.Count - 1);
      this.regionSlider.value = (float) this.matchmakingRegions.IndexOf(str);
    }

    private void OnDestroy() => this.regionSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderChanged()));

    private void OnSliderChanged()
    {
      this.selectedRegionText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@MatchmakingRegion_" + this.matchmakingRegions[(int) this.regionSlider.value].ToString());
      PlayerPrefs.SetString("MatchmakingRegion", this.matchmakingRegions[(int) this.regionSlider.value].ToString());
    }
  }
}
