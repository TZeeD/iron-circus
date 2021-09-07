using UnityEngine.UI;
using UnityEngine;
using TMPro;

namespace SteelCircus.UI.OptionsUI
{
	public class RumbleSettings : ObservedSetting
	{
		[SerializeField]
		private Slider slider;
		[SerializeField]
		private TextMeshProUGUI optionsDisplayText;
	}
}
