using UnityEngine;

namespace Imi.SteelCircus.ui
{
	public class UiScreenStateMachine
	{
		public UiScreenStateMachine(CanvasGroup canvasGroup, Animation animation, UIScreenState[] states, int entryState)
		{
		}

		public Animation animation;
		public UIScreenState[] states;
		public int entryState;
	}
}
