// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemComparerGeneric
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemComparerGeneric : IComparer<ShopItem>
  {
    private List<ShopItemComparerGeneric.CompareParameters> comparePriorities;

    public ShopItemComparerGeneric(
      List<ShopItemComparerGeneric.CompareParameters> comparePriorities)
    {
      this.comparePriorities = comparePriorities;
    }

    public int Compare(ShopItem x, ShopItem y)
    {
      int num = 0;
      foreach (int comparePriority in this.comparePriorities)
      {
        switch (comparePriority)
        {
          case 0:
            num = new ShopItemTierComparer().Compare(x, y);
            break;
          case 1:
            num = new ShopItemPriceComparer(ShopManager.CurrencyType.credits).Compare(x, y);
            break;
          case 2:
            num = new ShopItemPriceComparer(ShopManager.CurrencyType.steel).Compare(x, y);
            break;
          case 3:
            num = new ShopItemNameComparer().Compare(x, y);
            break;
          case 4:
            num = new ShopItemChampionComparer(this.GetListOfChampions()).Compare(x, y);
            break;
          case 5:
            num = new ShopItemTypeComparer().Compare(x, y);
            break;
          case 6:
            num = new ShopItemEquippedStatusComparer().Compare(x, y);
            break;
          case 7:
            num = new ShopItemOwnedStatusComparer().Compare(x, y);
            break;
          default:
            num = 0;
            break;
        }
        if (num != 0)
          break;
      }
      return num;
    }

    private List<ChampionConfig> GetListOfChampions()
    {
      List<ChampionConfigProvider.ChampionConfigUiInfo> championConfigs = SingletonScriptableObject<ChampionConfigProvider>.Instance.championConfigs;
      List<ChampionConfig> championConfigList = new List<ChampionConfig>();
      foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfigUiInfo in championConfigs)
        championConfigList.Add(championConfigUiInfo.ChampionConfig);
      return championConfigList;
    }

    public enum CompareParameters
    {
      Rarity,
      CostCreds,
      CostSteel,
      Name,
      Champion,
      ItemType,
      EquippedStatus,
      OwnedStatus,
    }
  }
}
