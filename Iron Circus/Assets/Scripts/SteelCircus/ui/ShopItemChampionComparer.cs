// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopItemChampionComparer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.UI
{
  public class ShopItemChampionComparer : IComparer<ShopItem>
  {
    private List<ChampionConfig> champions = new List<ChampionConfig>();

    public ShopItemChampionComparer(List<ChampionConfig> champions) => this.champions = champions;

    public int Compare(ShopItem x, ShopItem y)
    {
      if ((Object) x.itemDefinition.champion == (Object) y.itemDefinition.champion)
        return 0;
      if (this.champions.IndexOf(x.itemDefinition.champion) < this.champions.IndexOf(y.itemDefinition.champion))
        return -1;
      return this.champions.IndexOf(x.itemDefinition.champion) > this.champions.IndexOf(y.itemDefinition.champion) ? 1 : 0;
    }
  }
}
