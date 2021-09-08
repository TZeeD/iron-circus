// Decompiled with JetBrains decompiler
// Type: ShopItemContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ShopItemContainer : BaseShopItemContainer
{
  public List<ShopItem> containerItems;
  protected string containerName;
  public ShopItem containerItem;

  public new void ShopItemClickAction()
  {
    if (this.containerItem == null || this.containerItem.itemDefinition.definitionId == 0)
      return;
    this.manager.OpenBuyWindow(this.containerItem.itemDefinition.definitionId, this.containerID, this.currenyType);
    this.shopPage.SetButtonNavigation(false);
  }

  public void SetupItemContainerPanel(
    ShopItem item,
    ShopManager.CurrencyType currencyType,
    bool hasTimeLimit = false,
    long timeLeftinMs = 0,
    Stopwatch timer = null)
  {
    this.hasCountdown = hasTimeLimit;
    this.countdownDurationInMS = timeLeftinMs;
    if (this.hasCountdown)
      this.countdownTimer = timer;
    ShopManager.ItemTier tier = item.itemDefinition.tier;
    Color color = SingletonScriptableObject<ColorsConfig>.Instance.TierColorDark(tier);
    if ((UnityEngine.Object) this.borderImage != (UnityEngine.Object) null)
      this.borderImage.color = new Color(color.r, color.g, color.b, 1f);
    if ((UnityEngine.Object) this.panelSeperator != (UnityEngine.Object) null)
      this.panelSeperator.color = new Color(color.r, color.g, color.b, 1f);
    this.GetComponent<Button>().interactable = !item.ownedByPlayer;
    if (tier < ShopManager.ItemTier.tier0)
    {
      Imi.Diagnostics.Log.Error("Something went wrong while setting up the store. Item Tier out of Bounds.");
      tier = ShopManager.ItemTier.tier0;
    }
    if (tier >= (ShopManager.ItemTier) Enum.GetNames(typeof (ShopManager.ItemTier)).Length)
    {
      Imi.Diagnostics.Log.Error("Something went wrong while setting up the store. Item Tier out of Bounds.");
      tier = ShopManager.ItemTier.tier3;
    }
    this.backgroundSprite.sprite = this.manager.tieredBackgrounds[(int) tier];
    this.itemType = item.itemDefinition.type;
    this.SetContainerVisibility(false, item.ownedByPlayer);
    switch (currencyType)
    {
      case ShopManager.CurrencyType.steel:
        this.SetContainerPriceText(item.itemDefinition.priceSteel, ShopManager.CurrencyType.steel);
        break;
      case ShopManager.CurrencyType.credits:
        this.SetContainerPriceText(item.itemDefinition.priceCreds, ShopManager.CurrencyType.credits);
        break;
    }
    this.containerItem = item;
    this.imageObject.sprite = this.containerItem.itemDefinition.icon;
    this.imageObject.preserveAspect = true;
    if (this.containerItem.itemDefinition.type == ShopManager.ShopItemType.skin || this.containerItem.itemDefinition.type == ShopManager.ShopItemType.champion)
    {
      this.imageObject.GetComponent<RectTransform>().localScale = (Vector3) new Vector2(this.containerItem.itemDefinition.champion.shopIconScale, this.containerItem.itemDefinition.champion.shopIconScale);
      this.imageObject.GetComponent<RectTransform>().anchoredPosition = new Vector2(this.containerItem.itemDefinition.champion.shopIconTranslation.x, this.containerItem.itemDefinition.champion.shopIconTranslation.y);
    }
    if ((UnityEngine.Object) this.SecondaryText != (UnityEngine.Object) null)
      this.SecondaryText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.itemDefinition.type.ToString());
    if (!this.containerName.IsNullOrEmpty())
      return;
    if (this.containerItem.itemDefinition.type == ShopManager.ShopItemType.champion)
      this.nameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.containerItem.itemDefinition.champion.displayName);
    else
      this.nameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + this.containerItem.itemDefinition.fileName);
    this.nameText.color = SingletonScriptableObject<ColorsConfig>.Instance.TierColorLight(item.itemDefinition.tier);
  }

  public new void OnSelect(BaseEventData eventData) => base.OnSelect(eventData);

  public new void OnPointerEnter(PointerEventData eventData) => base.OnPointerEnter(eventData);
}
