// Decompiled with JetBrains decompiler
// Type: ShopItem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.ScriptableObjects;
using Newtonsoft.Json.Linq;
using System;

[Serializable]
public class ShopItem
{
  public bool ownedByPlayer;
  public bool buyable;
  public EquipSlot[] equipped;
  public ItemDefinition itemDefinition;

  public ShopItem(ItemDefinition baseDefinition)
  {
    this.itemDefinition = baseDefinition;
    this.equipped = new EquipSlot[0];
    this.ownedByPlayer = false;
    this.buyable = true;
  }

  public ShopItem(
    ItemDefinition baseDefinition,
    string itemStatus,
    JArray equippedByChampions,
    bool buyable = true)
  {
    this.itemDefinition = baseDefinition;
    this.SetValues(itemStatus, equippedByChampions, buyable);
  }

  public ShopItem(int definitionId, string itemStatus, JArray equippedByChampions, bool buyable = true)
  {
    this.itemDefinition = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(definitionId);
    this.SetValues(itemStatus, equippedByChampions, buyable);
  }

  public bool IsEquipped(ChampionConfig champion = null)
  {
    if ((UnityEngine.Object) champion == (UnityEngine.Object) null)
      return (uint) this.equipped.Length > 0U;
    foreach (EquipSlot equipSlot in this.equipped)
    {
      if (champion.championType == equipSlot.champion)
        return true;
    }
    return false;
  }

  private void SetValues(string itemStatus, JArray equippedByChampions, bool buyable = true)
  {
    this.buyable = buyable;
    this.equipped = new EquipSlot[equippedByChampions.Count];
    for (int index = 0; index < equippedByChampions.Count; ++index)
    {
      this.equipped[index] = new EquipSlot();
      this.equipped[index].slot = (int) equippedByChampions[index][(object) "slot"];
      this.equipped[index].champion = (ChampionType) (int) equippedByChampions[index][(object) "champion"];
    }
    if (!(itemStatus == "unlocked"))
    {
      if (itemStatus == "locked")
        this.ownedByPlayer = false;
      else
        this.ownedByPlayer = false;
    }
    else
      this.ownedByPlayer = true;
  }
}
