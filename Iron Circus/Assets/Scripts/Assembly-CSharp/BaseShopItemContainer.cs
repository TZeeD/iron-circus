using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BaseShopItemContainer : MonoBehaviour
{
	public int containerID;
	public Vector2Int gridDimensions;
	[SerializeField]
	protected ShopManager.ShopItemType itemType;
	public ShopPage shopPage;
	public ShopManager manager;
	public ShopItemButtonGroup buttonGroup;
	public ShopManager.CurrencyType currenyType;
	public bool hasCountdown;
	[SerializeField]
	protected GameObject buttonParent;
	[SerializeField]
	protected Image backgroundSprite;
	[SerializeField]
	protected Image borderImage;
	[SerializeField]
	protected Image panelSeperator;
	[SerializeField]
	protected Image imageObject;
	[SerializeField]
	protected Button buttonObject;
	[SerializeField]
	protected GameObject discountBackground;
	[SerializeField]
	protected GameObject oldPriceStrikethrough;
	[SerializeField]
	protected GameObject countDownPanel;
	[SerializeField]
	protected Image currencySymbol;
	[SerializeField]
	public bool showPriceText;
	[SerializeField]
	protected TextMeshProUGUI nameText;
	[SerializeField]
	protected TextMeshProUGUI SecondaryText;
	[SerializeField]
	protected TextMeshProUGUI priceText;
	[SerializeField]
	protected TextMeshProUGUI priceTextNoDiscount;
	[SerializeField]
	protected TextMeshProUGUI priceBeforeDiscountText;
	[SerializeField]
	protected TextMeshProUGUI countdownText;
	[SerializeField]
	protected TextMeshProUGUI discountText;
	[SerializeField]
	protected GameObject alreadyOwnedGrp;
}
