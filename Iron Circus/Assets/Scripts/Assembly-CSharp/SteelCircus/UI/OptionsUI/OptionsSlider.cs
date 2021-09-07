using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
	public class OptionsSlider : MonoBehaviour
	{
		[SerializeField]
		private Color lowSettingColor;
		[SerializeField]
		private Color highSettingColor;
		[SerializeField]
		private Slider slider;
		[SerializeField]
		private Text sliderText;
		[SerializeField]
		private Image amountBar;
	}
}
