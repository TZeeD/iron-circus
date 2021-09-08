// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemPriceComparer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemPriceComparer : IComparer<ShopItem>
  {
    private ShopManager.CurrencyType currencyType = ShopManager.CurrencyType.credits;

    public ShopItemPriceComparer(ShopManager.CurrencyType currencyType) => this.currencyType = currencyType;

    public int Compare(ShopItem x, ShopItem y)
    {
      switch (this.currencyType)
      {
        case ShopManager.CurrencyType.steel:
          if (x.itemDefinition.priceSteel == y.itemDefinition.priceSteel)
            return 0;
          if (x.itemDefinition.priceSteel < y.itemDefinition.priceSteel)
            return -1;
          if (x.itemDefinition.priceSteel > y.itemDefinition.priceSteel)
            return 1;
          break;
        case ShopManager.CurrencyType.credits:
          if (x.itemDefinition.priceCreds == y.itemDefinition.priceCreds)
            return 0;
          if (x.itemDefinition.priceCreds < y.itemDefinition.priceCreds)
            return -1;
          if (x.itemDefinition.priceCreds > y.itemDefinition.priceCreds)
            return 1;
          break;
        default:
          return 0;
      }
      return 0;
    }
  }
}
