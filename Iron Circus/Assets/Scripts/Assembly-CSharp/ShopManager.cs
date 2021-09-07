using UnityEngine;
using SteelCircus.UI;
using System.Collections.Generic;

public class ShopManager : MonoBehaviour
{
	public enum CurrencyType
	{
		none = 0,
		steel = 1,
		credits = 2,
		realMoney = 3,
		rankedPoints = 4,
	}

	public enum ItemTier
	{
		tier0 = 0,
		tier1 = 1,
		tier2 = 2,
		tier3 = 3,
	}

	public enum ShopItemType
	{
		generic = 0,
		spray = 1,
		goalAnimation = 2,
		skin = 3,
		emote = 4,
		victoryPose = 5,
		champion = 6,
		avatarIcon = 7,
		currency = 8,
	}

	[SerializeField]
	private GameObject shopContainerPrefab_Spraytags;
	[SerializeField]
	private GameObject shopConatinerPrefab_Skins;
	[SerializeField]
	private GameObject shopContainerPrefab_Animations;
	[SerializeField]
	private GameObject shopContainerPrefab_Champions;
	[SerializeField]
	private GameObject shopContainerPrefab_Bundles;
	[SerializeField]
	private GameObject shopContainerPrefab_DLC;
	public GameObject shopContainerPrefab_HalloweenDLC;
	[SerializeField]
	private GameObject shopContainerPrefab_AllChampionsDLC;
	[SerializeField]
	public PopulateCurrencyContainers currencyPage;
	[SerializeField]
	private ShopPage spraytagShopPage;
	[SerializeField]
	private ShopPage skinShopPage;
	[SerializeField]
	private ShopPage emoteShopPage;
	[SerializeField]
	private ShopPage victoryPoseShopPage;
	[SerializeField]
	private ShopPage ChampionShopPage;
	[SerializeField]
	private ShopPage weeklyRotationPage;
	[SerializeField]
	private ShopPanel shopBuyPanel;
	[SerializeField]
	private List<ShopRotationData> shopRotationData;
	public bool errorLoadingShop;
	public Sprite[] tieredBackgrounds;
	public Sprite creditsSprite;
	public Sprite steelSprite;
	public MenuObject shopPanel;
	public Sprite bundleDefaultSprite;
}
