// Decompiled with JetBrains decompiler
// Type: ShopItemButtonGroup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

public class ShopItemButtonGroup : MonoBehaviour
{
  public int widthInSections;
  public int startSectionHorizontal;
  public List<BaseShopItemContainer> shopContainers;

  private void Awake() => this.shopContainers = new List<BaseShopItemContainer>();

  public int GetGroupSectionHeight()
  {
    int num = 0;
    foreach (BaseShopItemContainer shopContainer in this.shopContainers)
      num += shopContainer.GetHeightInSections();
    return num;
  }

  public int GetGroupSectionWidth()
  {
    int num = 0;
    foreach (BaseShopItemContainer shopContainer in this.shopContainers)
    {
      if (shopContainer.GetWidthInSections() > num)
        num = shopContainer.GetWidthInSections();
    }
    return num;
  }
}
