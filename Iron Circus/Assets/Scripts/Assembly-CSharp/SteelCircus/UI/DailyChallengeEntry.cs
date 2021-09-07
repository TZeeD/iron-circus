using UnityEngine;
using TMPro;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class DailyChallengeEntry : MonoBehaviour
	{
		public enum ChallengeRewardType
		{
			Steel = 0,
			Creds = 1,
			Item = 2,
			XP = 3,
			None = 4,
		}

		[SerializeField]
		private Sprite steelBG;
		[SerializeField]
		private Sprite credsBG;
		[SerializeField]
		private Sprite emptyBG;
		public GameObject dailyChallengePanel;
		[SerializeField]
		private TextMeshProUGUI challengeNameText;
		[SerializeField]
		private TextMeshProUGUI challengeDescriptionText;
		[SerializeField]
		private Image completionCircle;
		[SerializeField]
		private TextMeshProUGUI completionAmountText;
		[SerializeField]
		public TextMeshProUGUI challengeRewardAmountText;
		[SerializeField]
		private Image challengeRewardIcon;
		[SerializeField]
		private TextMeshProUGUI noChallengeText;
		[SerializeField]
		private TextMeshProUGUI noChallengeCountdownText;
		[SerializeField]
		private Image noChallengeTimerFillCircle;
		[SerializeField]
		public Image rewardCurrencyIconImage;
		[SerializeField]
		private Image rewardBackgroundImage;
		[SerializeField]
		public TextMeshProUGUI rewardRewardAmountText;
		[SerializeField]
		public GameObject GetRewardButtonPrompt;
		[SerializeField]
		public Image twitchRewardCurrencyIconImage;
		[SerializeField]
		private Image twitchRewardBackgroundImage;
		[SerializeField]
		public TextMeshProUGUI twitchRewardRewardAmountText;
		[SerializeField]
		public GameObject twitchGetRewardButtonPrompt;
		public int playerQuestId;
		public int rewardId;
		public ChallengeRewardType rewardType;
		public int rewardAmount;
		public GameObject rewardPanelManager;
		public int rewardItemId;
		[SerializeField]
		private GameObject InProgressGroup;
		[SerializeField]
		private GameObject completedGroup;
		[SerializeField]
		private GameObject noChallengeGroup;
		[SerializeField]
		private GameObject rewardsButtonGroup;
		[SerializeField]
		private GameObject twitchDropGroup;
	}
}
