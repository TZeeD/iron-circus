// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.LanguageSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Steamworks;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class LanguageSettings : MonoBehaviour
  {
    [SerializeField]
    private Slider languageSlider;
    [SerializeField]
    private TextMeshProUGUI selectedLanguageText;
    [SerializeField]
    private TextMeshProUGUI restartGameInfoText;
    private ScLanguage[] languages;

    private void Start()
    {
      this.languageSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
      string languageName = !PlayerPrefs.HasKey("SystemLanguage") ? SingletonScriptableObject<LocalizationConfig>.Instance.GetLanguageBySteamAPICode(SteamUtils.GetSteamUILanguage()).ToString() : PlayerPrefs.GetString("SystemLanguage");
      this.selectedLanguageText.text = languageName;
      this.languages = SingletonScriptableObject<LocalizationConfig>.Instance.GetActiveLanguages();
      this.languageSlider.minValue = 0.0f;
      this.languageSlider.maxValue = (float) (this.languages.Length - 1);
      this.languageSlider.value = (float) this.GetLanguageIndex(languageName);
      this.restartGameInfoText.gameObject.SetActive(false);
    }

    public int GetLanguageIndex(string languageName)
    {
      for (int index = 0; index < this.languages.Length; ++index)
      {
        if (languageName == this.languages[index].ToString())
          return index;
      }
      return 0;
    }

    private void OnSliderValueChange()
    {
      this.restartGameInfoText.gameObject.SetActive(true);
      this.selectedLanguageText.text = this.languages[(int) this.languageSlider.value].ToString();
      PlayerPrefs.SetString("SystemLanguage", this.languages[(int) this.languageSlider.value].ToString());
    }

    private void OnDestroy() => this.languageSlider.onValueChanged.RemoveListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
  }
}
