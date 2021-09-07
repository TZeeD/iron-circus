using UnityEngine;
using TMPro;
using System.Collections.Generic;

namespace SteelCircus.UI
{
	public class ChampionPageButtonGenerator : MonoBehaviour
	{
		public enum NavigatorType
		{
			loadoutNavigation = 0,
			subPanelNavigation = 1,
		}

		public enum ChampionPageSortCriteria
		{
			rarity = 0,
			owned = 1,
			nothing = 2,
		}

		[SerializeField]
		private GameObject itemButtonPrefab;
		public NavigatorType navigatorType;
		[SerializeField]
		private LoadoutNavigation loadoutPanelNavigator;
		[SerializeField]
		private SubPanelNavigation subPanelNavigator;
		[SerializeField]
		private GameObject layoutContainerParent;
		[SerializeField]
		private TextMeshProUGUI loadingItemsText;
		[SerializeField]
		private TextMeshProUGUI loadingErrorText;
		[SerializeField]
		private ScrollThroughButtons buttonScroller;
		[SerializeField]
		private ShopManager.ShopItemType itemType;
		public ChampionPageSortCriteria sortCriteria;
		[SerializeField]
		private List<ShopItem> allPageItems;
		[SerializeField]
		private List<GameObject> allPageButtonObjects;
		public int activeButton;
	}
}
