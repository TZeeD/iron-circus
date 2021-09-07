using Rewired;
using UnityEngine;
using System.Collections.Generic;
using Rewired.Components;

namespace Rewired.Integration.UnityUI
{
	public class RewiredStandaloneInputModule : RewiredPointerInputModule
	{
		private RewiredStandaloneInputModule()
		{
		}

		public override void Process()
		{
		}

		[SerializeField]
		private InputManager_Base rewiredInputManager;
		[SerializeField]
		private bool useAllRewiredGamePlayers;
		[SerializeField]
		private bool useRewiredSystemPlayer;
		[SerializeField]
		private int[] rewiredPlayerIds;
		[SerializeField]
		private bool usePlayingPlayersOnly;
		[SerializeField]
		private List<PlayerMouse> playerMice;
		[SerializeField]
		private bool moveOneElementPerAxisPress;
		[SerializeField]
		private bool setActionsById;
		[SerializeField]
		private int horizontalActionId;
		[SerializeField]
		private int verticalActionId;
		[SerializeField]
		private int submitActionId;
		[SerializeField]
		private int cancelActionId;
		[SerializeField]
		private string m_HorizontalAxis;
		[SerializeField]
		private string m_VerticalAxis;
		[SerializeField]
		private string m_SubmitButton;
		[SerializeField]
		private string m_CancelButton;
		[SerializeField]
		private float m_InputActionsPerSecond;
		[SerializeField]
		private float m_RepeatDelay;
		[SerializeField]
		private bool m_allowMouseInput;
		[SerializeField]
		private bool m_allowMouseInputIfTouchSupported;
		[SerializeField]
		private bool m_allowTouchInput;
		[SerializeField]
		private bool m_ForceModuleActive;
	}
}
