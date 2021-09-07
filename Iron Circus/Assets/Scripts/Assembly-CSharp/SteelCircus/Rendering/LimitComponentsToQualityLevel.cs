using UnityEngine;
using System.Collections.Generic;
using SteelCircus.Core;

namespace SteelCircus.Rendering
{
	public class LimitComponentsToQualityLevel : MonoBehaviour
	{
		public enum Mode
		{
			DisableBelowMinQualityLevel = 0,
			DisableAboveMinQualityLevel = 1,
		}

		public enum SettingType
		{
			Vfx = 0,
			ShaderQuality = 1,
			PostProcessing = 2,
			Misc = 3,
		}

		[SerializeField]
		private List<MonoBehaviour> components;
		public Mode mode;
		[SerializeField]
		private SettingType settingType;
		public QualityManager.Level minQualityLevel;
	}
}
