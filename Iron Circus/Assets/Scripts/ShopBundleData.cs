// Decompiled with JetBrains decompiler
// Type: ShopBundleData
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class ShopBundleData
{
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

  public ShopBundleData(
    int bundleId,
    GameObject prefab,
    bool cHasDiscount,
    int cPrice,
    int cPriceBeforeDiscount,
    ShopManager.CurrencyType cCurrencyType,
    string isoCurrency,
    List<ShopItem> cItems,
    int cSteelGained,
    int cCreditsGained,
    string cNameLoca,
    string cDescritpionLoca,
    Sprite cIcon,
    bool cHasCountdown,
    int cMinutesLeft,
    uint cAppID = 0,
    List<string> cAdditionalEntries = null)
  {
    this.bundleId = bundleId;
    this.prefab = prefab;
    this.hasDiscount = cHasDiscount;
    this.price = cPrice;
    this.priceBeforeDiscount = cPriceBeforeDiscount;
    this.currencyType = cCurrencyType;
    this.isoCurrency = isoCurrency;
    this.items = cItems;
    this.steelGained = cSteelGained;
    this.creditsGained = cCreditsGained;
    this.nameLoca = cNameLoca;
    this.descriptionLoca = cDescritpionLoca;
    this.icon = cIcon;
    this.hasCountdown = cHasCountdown;
    this.countdownMinutesLeft = cMinutesLeft;
    this.appID = cAppID;
    this.additionalEntries = cAdditionalEntries;
  }
}
