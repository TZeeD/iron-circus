using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.UI.OptionsUI
{
	public class OnSelectedOptionsSlider : MonoBehaviour
	{
		[SerializeField]
		private Image sliderBackgroundImage;
		[SerializeField]
		private Sprite deselectedSprite;
		[SerializeField]
		private Sprite selectedSprite;
		[SerializeField]
		private Image sliderBackgroundFillImage;
		[SerializeField]
		private Image sliderFillImage;
		[SerializeField]
		private TextMeshProUGUI optionNameTxt;
		[SerializeField]
		private Text optionValueTxt;
	}
}
