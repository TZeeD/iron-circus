// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemTierComparer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemTierComparer : IComparer<ShopItem>
  {
    public List<ShopManager.ItemTier> tierInDescendingRarity = new List<ShopManager.ItemTier>()
    {
      ShopManager.ItemTier.tier3,
      ShopManager.ItemTier.tier2,
      ShopManager.ItemTier.tier1,
      ShopManager.ItemTier.tier0
    };

    public int Compare(ShopItem x, ShopItem y)
    {
      if (x.itemDefinition.tier == y.itemDefinition.tier)
        return 0;
      int num1 = this.tierInDescendingRarity.IndexOf(x.itemDefinition.tier);
      int num2 = this.tierInDescendingRarity.IndexOf(y.itemDefinition.tier);
      if (num1 == -1 && num2 == -1)
        return 0;
      if (num1 == -1 || num1 < num2)
        return -1;
      return num2 == -1 || num2 < num1 ? 1 : 0;
    }
  }
}
