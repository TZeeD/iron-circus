using UnityEngine;

namespace Imi.SteelCircus.Utils
{
	public class ButtonAttribute : PropertyAttribute
	{
		public ButtonAttribute(bool isToggle)
		{
		}

		public bool isToggle;
	}
}
