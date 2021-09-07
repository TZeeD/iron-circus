using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.UI.MatchFlow
{
	public class XPUi : MonoBehaviour
	{
		[SerializeField]
		private GameObject XPPanel;
		[SerializeField]
		private Text matchOutcomeTxt;
		[SerializeField]
		private TextMeshProUGUI currentLevelTxt;
		[SerializeField]
		private TextMeshProUGUI nextLevelTxt;
		[SerializeField]
		private Image XPBar;
		[SerializeField]
		private TextMeshProUGUI totalEarnedXPTxt;
		[SerializeField]
		private TextMeshProUGUI currentXPProgressTxt;
		[SerializeField]
		private TextMeshProUGUI nextLevelXPText;
		[SerializeField]
		private TextMeshProUGUI rewardText;
		[SerializeField]
		private Transform xpArrowParent;
		[SerializeField]
		private GameObject achievementGroup;
		[SerializeField]
		private GameObject creditsRewardImage;
		[SerializeField]
		private GameObject steelRewardImage;
		[SerializeField]
		private GameObject itemRewardImage;
		[SerializeField]
		private GameObject itemRewardIconImage;
		public Sprite debugSpriteA;
		public Sprite debugSpriteB;
		public Sprite debugSpriteC;
		[SerializeField]
		private Sprite bonusIcon;
		[SerializeField]
		private Sprite mvpIcon;
		[SerializeField]
		private Sprite participantIcon;
		[SerializeField]
		private Sprite rewardIcon;
		[SerializeField]
		private Sprite winIcon;
		[SerializeField]
		private Sprite penaltyIcon;
		[SerializeField]
		private GameObject achievementPanelPrefab;
		[SerializeField]
		private GameObject matchEndXPRewardPrefab;
		[SerializeField]
		private Animator levelUpRewardAnimator;
		[SerializeField]
		private Animator levelUpDisplayAnimator;
		public bool animFinished;
		public bool animStarted;
		public bool skipTrigger;
		public bool rewardPanelActive;
	}
}
