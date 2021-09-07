using UnityEngine;
using SteelCircus.Core;

namespace SteelCircus.Rendering
{
	public class LimitToQualityLevel : MonoBehaviour
	{
		public enum Mode
		{
			DisableBelowMinQualityLevel = 0,
			DisableAboveMinQualityLevel = 1,
		}

		public Mode mode;
		public QualityManager.Level minQualityLevel;
	}
}
