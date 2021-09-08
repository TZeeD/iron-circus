// Decompiled with JetBrains decompiler
// Type: BundleShopItemContainer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;

public class BundleShopItemContainer : BaseShopItemContainer
{
  public ShopBundleData containerBundle;

  public new void ShopItemClickAction()
  {
    if (this.containerBundle == null)
      return;
    this.manager.OpenBuyWindow(this.containerBundle, this.containerID);
    this.shopPage.SetButtonNavigation(false);
  }

  public void SetupItemContainerPanel(ShopBundleData bundleData)
  {
    this.SetContainerVisibility(bundleData.hasDiscount);
    this.SetContainerPriceText(bundleData.price, bundleData.currencyType, bundleData.isoCurrency);
    this.containerBundle = bundleData;
    this.imageObject.sprite = bundleData.icon;
    this.imageObject.preserveAspect = true;
    this.nameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + bundleData.nameLoca);
    this.countDownPanel.SetActive(bundleData.hasCountdown);
    this.discountBackground.SetActive(bundleData.hasDiscount);
    if (!bundleData.hasDiscount)
      return;
    this.discountText.text = "-" + (object) Mathf.RoundToInt((float) ((1.0 - (double) bundleData.price / (double) bundleData.priceBeforeDiscount) * 100.0)) + "%";
  }

  public new void OnSelect(BaseEventData eventData) => base.OnSelect(eventData);

  public new void OnPointerEnter(PointerEventData eventData) => base.OnPointerEnter(eventData);
}
