using UnityEngine;

namespace SteelCircus.UI
{
	public class ShowSpraytagsInChampionGallery : MonoBehaviour
	{
		public GameObject spraytagLayoutContainer;
		public GameObject spraytagButtonPrefab;
		public MenuObject championPageMenu;
		public GameObject activeSpraytag;
		[SerializeField]
		private GameObject loadingSpraytagsText;
		[SerializeField]
		private GameObject loadingErrorText;
		[SerializeField]
		private ScrollThroughButtons buttonScroller;
		[SerializeField]
		private GameObject[] allSprayButtons;
		[SerializeField]
		private int activeSprayButton;
		[SerializeField]
		private ChampionDescriptions championPage;
		public MenuObject sprayEquipMenu;
		public MenuObject shopBuyPanel;
		public GameObject buyItemPanel;
		public bool menuInteractable;
		public ShopManager shopManager;
		[SerializeField]
		private LoadoutNavigation subPanelNavigator;
	}
}
