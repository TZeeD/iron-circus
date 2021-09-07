using UnityEngine;
using System.Collections.Generic;
using SteelCircus.UI;

public class ShopPage : MonoBehaviour
{
	public GameObject itemPanelParent;
	public GameObject itemGroupPrefab;
	[SerializeField]
	private ShopManager.CurrencyType currency;
	[SerializeField]
	private ShopManager.ShopItemType itemType;
	[SerializeField]
	private GameObject itemParentVisibility;
	[SerializeField]
	private List<ShopItem> allShopItems;
	[SerializeField]
	private List<ShopBundleData> allShopBundles;
	[SerializeField]
	private List<ShopRotationData> allShopRotationItems;
	[SerializeField]
	private List<GameObject> allShopContainers;
	[SerializeField]
	private List<GameObject> specialContainerPrefabs;
	[SerializeField]
	private List<ShopItemButtonGroup> allButtonGroups;
	[SerializeField]
	private ShopManager shopManager;
	[SerializeField]
	private ScrollThroughButtons buttonScroller;
	[SerializeField]
	private GameObject LoadingIcon;
	public int nHighlightedButton;
}
