using System;
using System.Collections.Generic;
using SteelCircus.UI;

namespace SteelCircus.Core.Services
{
	[Serializable]
	public class UIProgressionState
	{
		public UIProgressionState(int stateID, Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> playMenuButtonStates, UIProgressionButtonState challengeMenuState)
		{
		}

		public int stateID;
		public int previosStateID;
		public UIProgressionButtonState challengeMenuState;
		public UIProgressionButtonState inviteButtonState;
		public bool hasReward;
		public DailyChallengeEntry.ChallengeRewardType rewardType;
		public int rewardAmount;
		public string rewardText;
	}
}
