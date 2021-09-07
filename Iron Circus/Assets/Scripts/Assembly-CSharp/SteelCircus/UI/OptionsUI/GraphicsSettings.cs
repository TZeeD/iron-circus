using UnityEngine.UI;
using UnityEngine;

namespace SteelCircus.UI.OptionsUI
{
	public class GraphicsSettings : ObservedSetting
	{
		[SerializeField]
		private Slider vsyncSlider;
		[SerializeField]
		private Text vsyncText;
		[SerializeField]
		private Slider fpsCapSlider;
		[SerializeField]
		private Text fpsCapText;
		[SerializeField]
		private Slider fpsCapLimitSlider;
		[SerializeField]
		private Text fpsCapLimitText;
		[SerializeField]
		private Slider qualityLevelSlider;
		[SerializeField]
		private Text qualityLevelText;
		[SerializeField]
		private Slider vfxSlider;
		[SerializeField]
		private Text vfxText;
		[SerializeField]
		private Slider shaderQualitySlider;
		[SerializeField]
		private Text shaderQualityText;
		[SerializeField]
		private Slider postProcessingSlider;
		[SerializeField]
		private Text postProcessingText;
		[SerializeField]
		private Slider antialiasingSlider;
		[SerializeField]
		private Text antialiasingText;
		[SerializeField]
		private Slider miscSlider;
		[SerializeField]
		private Text miscText;
	}
}
