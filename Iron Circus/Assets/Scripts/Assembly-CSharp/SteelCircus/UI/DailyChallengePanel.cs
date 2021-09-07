using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.UI
{
	public class DailyChallengePanel : MonoBehaviour
	{
		[SerializeField]
		private List<MenuObject> visibleInMenus;
		[SerializeField]
		private ShopManager shopManager;
		public GameObject dailyChallengeEntryPrefab;
		[SerializeField]
		private float rewardDurationTime;
		[SerializeField]
		private RectTransform challengeParent;
		[SerializeField]
		private RectTransform parentLayoutGroup;
		[SerializeField]
		private RectTransform challengeHeightContainer;
		[SerializeField]
		private RectTransform milestoneRewardParent;
		[SerializeField]
		private RectTransform milestoneHeightContainer;
		[SerializeField]
		private RectTransform tutorialParent;
		[SerializeField]
		private RectTransform tutorialHeightController;
		[SerializeField]
		private GameObject rewardOverlayPanel;
		public List<GameObject> dailyChallengeEntries;
		public List<GameObject> rewardEntries;
		public List<GameObject> milestoneRewardEntries;
		public List<GameObject> tutorialEntries;
		public bool panelVisible;
		[SerializeField]
		private List<Button> challengePanelButtonsToDisable;
		[SerializeField]
		private List<Button> mainMenuButtonsToDisable;
		[SerializeField]
		private GameObject milestonePanel;
		[SerializeField]
		private TextMeshProUGUI milestoneProgress;
		[SerializeField]
		private TextMeshProUGUI milestoneDescription;
		[SerializeField]
		private Image milestoneCompletionCircle;
		[SerializeField]
		private Image milestoneItemImage;
		[SerializeField]
		private Image milestoneBackgroundImage;
		[SerializeField]
		private Image milestoneItemBackgroundImage;
		[SerializeField]
		private Image milestoneRewardProgressBar;
		[SerializeField]
		private TextMeshProUGUI milestoneRewardTypeText;
		[SerializeField]
		private TextMeshProUGUI milestoneCreditsAmountText;
		[SerializeField]
		private GameObject milestoneCreditsObjectParent;
		[SerializeField]
		private TextMeshProUGUI milestoneSteelAmountText;
		[SerializeField]
		private GameObject milestoneSteelObjectParent;
	}
}
