// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemSortHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemSortHelper
  {
    public static List<ShopItem> SortItemsByType(List<ShopItem> itemList)
    {
      itemList.Sort(0, itemList.Count, (IComparer<ShopItem>) new ShopItemTypeComparer());
      return itemList;
    }

    public static List<ShopRotationData> SortShopRotationByType(
      List<ShopRotationData> dataList)
    {
      dataList.Sort(0, dataList.Count, (IComparer<ShopRotationData>) new ShopRotationDataTypeComparer());
      return dataList;
    }

    public static List<ShopItem> SortItems(
      List<ShopItem> itemList,
      List<ShopItemComparerGeneric.CompareParameters> sortPriorities,
      bool descending = true)
    {
      itemList.Sort(0, itemList.Count, (IComparer<ShopItem>) new ShopItemComparerGeneric(sortPriorities));
      if (!descending)
        itemList.Reverse();
      return itemList;
    }
  }
}
