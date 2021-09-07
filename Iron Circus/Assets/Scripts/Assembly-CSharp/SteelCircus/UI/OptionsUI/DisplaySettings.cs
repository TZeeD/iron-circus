using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
	public class DisplaySettings : ObservedSetting
	{
		[SerializeField]
		private FullScreenMode[] modes;
		[SerializeField]
		private Slider displayModeSlider;
		[SerializeField]
		private Text displayModeText;
		[SerializeField]
		private int minHeight;
		[SerializeField]
		private int minWidth;
		[SerializeField]
		private Slider resolutionSlider;
		[SerializeField]
		private Text resolutionText;
	}
}
