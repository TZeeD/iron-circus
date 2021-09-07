using UnityEngine;
using UnityEngine.UI;
using TMPro;

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
	}
}
