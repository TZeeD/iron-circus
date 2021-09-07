using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System.Collections.Generic;

namespace SteelCircus.UI
{
	public class ShopPanel : MonoBehaviour
	{
		private enum EquipButtonState
		{
			hidden = 0,
			active = 1,
			loading = 2,
			equipped = 3,
		}

		public int activeItem;
		public TextMeshProUGUI notEnoughCreditsText;
		[SerializeField]
		private Animator buyAnimationController;
		[SerializeField]
		private ChampionConfigProvider champConfigProvider;
		[SerializeField]
		private Image buttonPromptImg;
		[SerializeField]
		private Button buyButton;
		public TextMeshProUGUI buyText;
		[SerializeField]
		private Animator buyButtonAnimator;
		[SerializeField]
		private GameObject infoPanel;
		[SerializeField]
		private GameObject turntableRenderPandel;
		[SerializeField]
		private GameObject turntableLoadingIcon;
		[SerializeField]
		private TextMeshProUGUI itemBoughtNameText;
		[SerializeField]
		private Image itemIconImage;
		[SerializeField]
		private Image itemBackgroundImage;
		[SerializeField]
		private Sprite[] creditsShopSprites;
		public TextMeshProUGUI itemNameText;
		public TextMeshProUGUI itemTypeText;
		public TextMeshProUGUI itemDescriptionText;
		public TextMeshProUGUI itemChampionText;
		public TextMeshProUGUI itempriceText;
		public TextMeshProUGUI itemOldPriceText;
		[SerializeField]
		private GameObject oldPriceContainer;
		[SerializeField]
		private Image currencyImage;
		[SerializeField]
		private GameObject infoPanel_minimal;
		public TextMeshProUGUI itemNameText_minimalPanel;
		[SerializeField]
		private TextMeshProUGUI infoText_minimalPanel;
		[SerializeField]
		private GameObject infoTextBG_minimalPanel;
		[SerializeField]
		private GameObject bundleParentObject;
		[SerializeField]
		private GameObject contentListPrefab;
		[SerializeField]
		private GameObject contentListParent;
		[SerializeField]
		private List<ItemDefinition> displayItems;
		[SerializeField]
		private TextMeshProUGUI currentActiveItemText;
		[SerializeField]
		private Button leftArrowButton;
		[SerializeField]
		private Button rightArrowButton;
		[SerializeField]
		private GameObject EquipButton;
		[SerializeField]
		private EquipButtonState equipButtonState;
		[SerializeField]
		private TextMeshProUGUI EquipButtonPromptText;
		[SerializeField]
		private TextMeshProUGUI EquipButtonEquippedText;
		[SerializeField]
		private GameObject EquipButtonPromptImage;
		[SerializeField]
		private Animator EquipButtonVisibilityAnimator;
		[SerializeField]
		private Animator EquipButtonLoadingStateAnimator;
		[SerializeField]
		private ShopManager shopManager;
		[SerializeField]
		private GameObject dlcLoadingPanel;
		[SerializeField]
		private CanvasGroup parentCanvasGroup;
	}
}
