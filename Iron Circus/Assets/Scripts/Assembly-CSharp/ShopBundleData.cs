using System;
using UnityEngine;
using System.Collections.Generic;

[Serializable]
public class ShopBundleData
{
	public ShopBundleData(int bundleId, GameObject prefab, bool cHasDiscount, int cPrice, int cPriceBeforeDiscount, ShopManager.CurrencyType cCurrencyType, string isoCurrency, List<ShopItem> cItems, int cSteelGained, int cCreditsGained, string cNameLoca, string cDescritpionLoca, Sprite cIcon, bool cHasCountdown, int cMinutesLeft, uint cAppID, List<string> cAdditionalEntries)
	{
	}

	public int bundleId;
	public bool hasDiscount;
	public int price;
	public int priceBeforeDiscount;
	public ShopManager.CurrencyType currencyType;
	public string isoCurrency;
	public List<ShopItem> items;
	public int steelGained;
	public int creditsGained;
	public string nameLoca;
	public string descriptionLoca;
	public List<string> additionalEntries;
	public Sprite icon;
	public bool hasCountdown;
	public int countdownMinutesLeft;
	public uint appID;
	public GameObject prefab;
}
