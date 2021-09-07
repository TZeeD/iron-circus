using UnityEngine;
using SteelCircus.UI;

namespace SteelCircus.UI.Menu.ChampionGallery
{
	public class ChampionPage : MonoBehaviour
	{
		public ChampionPageButton activeShopItemButton;
		[SerializeField]
		private GameObject viewInShopPanel;
		[SerializeField]
		private GameObject buyInShopButton;
		[SerializeField]
		private GameObject buyInShopButtonPrompt;
		[SerializeField]
		private GameObject equipNowButton;
		[SerializeField]
		private GameObject equipNowButtonPrompt;
		[SerializeField]
		private MenuObject shopBuyPanel;
		[SerializeField]
		private GameObject championLockedInfoGroup;
		[SerializeField]
		private SubPanelObject unlockChampionSubPanel;
	}
}
