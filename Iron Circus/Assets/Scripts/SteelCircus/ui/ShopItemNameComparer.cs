// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemNameComparer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace SteelCircus.UI
{
  public class ShopItemNameComparer : IComparer<ShopItem>
  {
    public int Compare(ShopItem x, ShopItem y) => StringComparer.InvariantCultureIgnoreCase.Compare(x.itemDefinition.name, y.itemDefinition.name);
  }
}
