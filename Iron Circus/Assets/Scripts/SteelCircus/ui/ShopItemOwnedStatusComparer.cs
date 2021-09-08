// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemOwnedStatusComparer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemOwnedStatusComparer : IComparer<ShopItem>
  {
    public int Compare(ShopItem x, ShopItem y)
    {
      if (x.ownedByPlayer && !y.ownedByPlayer)
        return 1;
      return !x.ownedByPlayer && y.ownedByPlayer ? -1 : 0;
    }
  }
}
