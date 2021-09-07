using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

namespace SteelCircus.UI
{
	public class SimplePromptSwitch : MonoBehaviour
	{
		public enum ButtonFunction
		{
			disabled = 0,
			goBackToMenu = 1,
			goBackToPanel = 2,
			submit = 3,
			optionApply = 4,
			optionRevert = 5,
			championGalleryShortcut = 6,
			lobbyShortcut = 7,
			hideLayeredMenu = 8,
			skipAll = 9,
			leaveSteamGroup = 10,
			skipStep = 11,
		}

		[SerializeField]
		private MenuController menuController;
		[SerializeField]
		private Button confirmButton;
		public ButtonFunction confirmButtonFunction;
		[SerializeField]
		private Button secondaryButton;
		public ButtonFunction secondaryButtonFunction;
		[SerializeField]
		private Button leaveMatchmakingButton;
		[SerializeField]
		private Button backButton;
		public ButtonFunction backButtonFunction;
		public UnityEvent goBackToMenuEvent;
		public UnityEvent goBackToPanelEvent;
		public UnityEvent optionApplyEvent;
		public UnityEvent optionRevertEvent;
		public UnityEvent championGalleryShortcutEvent;
		public UnityEvent lobbyShortcutEvent;
		public UnityEvent hideLayeredMenuEvent;
		public UnityEvent optionSkipAllEvent;
		public UnityEvent optionSkipStepEvent;
	}
}
