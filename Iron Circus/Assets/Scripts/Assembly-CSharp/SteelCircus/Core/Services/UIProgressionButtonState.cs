using System;

namespace SteelCircus.Core.Services
{
	[Serializable]
	public class UIProgressionButtonState
	{
		public UIProgressionButtonState(bool enabled, bool highlighted, bool newlyUnlocked)
		{
		}

		public bool enabled;
		public bool highlighted;
		public bool newlyUnlocked;
	}
}
