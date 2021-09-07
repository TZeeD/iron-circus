using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class MenuObject : MonoBehaviour
	{
		[SerializeField]
		private Selectable highlightedButton;
		public GameObject canvasGroup;
		public MainMenuLightingType lightingType;
		public bool inviteNavigationActive;
		public bool layeredMenu;
		[SerializeField]
		public SimplePromptSwitch.ButtonFunction confirmButtonFunction;
		public string confirmButtonLocaOverride;
		public SimplePromptSwitch.ButtonFunction secondaryButtonFunction;
		public string secondaryButtonLocaOverride;
		public SimplePromptSwitch.ButtonFunction backButtonFunction;
		public string backButtonLocaOverride;
	}
}
