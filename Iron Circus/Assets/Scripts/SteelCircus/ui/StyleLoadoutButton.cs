// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.StyleLoadoutButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class StyleLoadoutButton : MonoBehaviour
  {
    public Image infoImage;
    public TextMeshProUGUI infoText;
    public TextMeshProUGUI nameText;
    public TextMeshProUGUI priceText;
    public Image itemImage;
    public Image rarityIndicatorImage;
    public ShopItem item;

    private void SetLockedSymbol()
    {
      if (!((Object) this.infoText != (Object) null))
        return;
      this.infoText.gameObject.SetActive(true);
      this.infoText.text = "\uF023";
    }

    private void StyleRarityIndicator(ShopItem shopItem)
    {
      if (!((Object) this.rarityIndicatorImage != (Object) null))
        return;
      Color color = SingletonScriptableObject<ColorsConfig>.Instance.TierColorLight(shopItem.itemDefinition.tier);
      if (shopItem.ownedByPlayer)
        this.rarityIndicatorImage.color = color;
      else
        this.rarityIndicatorImage.color = new Color(color.r, color.g, color.b, 0.3f);
    }

    private void SetNameText(ShopItem shopItem)
    {
      if (!((Object) this.nameText != (Object) null))
        return;
      Color color = SingletonScriptableObject<ColorsConfig>.Instance.TierColorLight(this.item.itemDefinition.tier);
      this.nameText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + shopItem.itemDefinition.fileName);
      if (shopItem.ownedByPlayer)
      {
        this.nameText.color = color;
        if (shopItem.IsEquipped())
        {
          if (shopItem.itemDefinition.type == ShopManager.ShopItemType.skin)
            this.nameText.text = "\uF00C  " + this.nameText.text;
          this.nameText.fontStyle = FontStyles.Bold;
        }
      }
      else
        this.nameText.color = new Color(color.r, color.g, color.b, 0.3f);
      if (!((Object) this.GetComponent<ChangeTextColorOnSelected>() != (Object) null))
        return;
      this.GetComponent<ChangeTextColorOnSelected>().SaveColors(new Color[2]
      {
        this.nameText.color,
        Color.white
      });
    }

    private void StyleItemImage(ShopItem shopItem)
    {
      if (!((Object) this.itemImage != (Object) null))
        return;
      this.itemImage.sprite = shopItem.itemDefinition.icon;
      this.itemImage.preserveAspect = true;
      if (shopItem.ownedByPlayer)
        this.itemImage.color = new Color(1f, 1f, 1f, 1f);
      else
        this.itemImage.color = new Color(0.8f, 0.8f, 0.8f, 0.5f);
    }

    private void StyleInfoPanel(ShopItem shopItem, ChampionConfig champion)
    {
      if (!((Object) this.infoImage != (Object) null))
        return;
      if (shopItem.ownedByPlayer)
      {
        if (shopItem.IsEquipped(champion))
        {
          if (shopItem.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
          {
            this.infoImage.gameObject.SetActive(false);
            this.infoText.gameObject.SetActive(true);
            this.infoText.text = "\uF00C";
          }
          else
          {
            this.infoImage.gameObject.SetActive(true);
            this.infoText.gameObject.SetActive(true);
            this.infoText.text = this.GetEquippedSlotInfoString(shopItem, champion);
          }
        }
        else
        {
          this.infoImage.gameObject.SetActive(false);
          this.infoText.gameObject.SetActive(false);
        }
      }
      else
      {
        this.infoImage.gameObject.SetActive(false);
        this.infoText.gameObject.SetActive(true);
        this.infoText.text = "\uF023";
        if (shopItem.buyable)
          return;
        this.infoText.color = Color.yellow;
      }
    }

    private string GetEquippedSlotInfoString(ShopItem item, ChampionConfig champion)
    {
      foreach (EquipSlot equipSlot in item.equipped)
      {
        if (equipSlot.champion == champion.championType)
          return equipSlot.slot == -1 ? "\uF00C" : equipSlot.slot.ToString();
      }
      return "-";
    }

    private void StylePriceText(ShopItem shopItem)
    {
      if (!((Object) this.priceText != (Object) null))
        return;
      if (!this.item.ownedByPlayer)
      {
        if (this.item.buyable)
        {
          this.priceText.gameObject.SetActive(true);
          this.priceText.text = shopItem.itemDefinition.priceCreds.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@Creds");
        }
        else
        {
          this.priceText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@CantPurchaseShort");
          this.priceText.color = Color.yellow;
        }
      }
      else
        this.priceText.gameObject.SetActive(false);
    }

    public void StyleButton(ShopItem shopItem, ChampionConfig champion)
    {
      this.item = shopItem;
      this.StyleRarityIndicator(shopItem);
      this.SetNameText(shopItem);
      this.StyleItemImage(shopItem);
      this.StyleInfoPanel(shopItem, champion);
      this.StylePriceText(shopItem);
    }
  }
}
