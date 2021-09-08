// Decompiled with JetBrains decompiler
// Type: ItemDefinition
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.ScriptableObjects;
using System;
using UnityEngine;

[Serializable]
public class ItemDefinition
{
  public string name;
  public ShopManager.ShopItemType type;
  public string fileName;
  public ShopManager.ItemTier tier;
  public int priceCreds;
  public int priceSteel;
  public ChampionConfig champion;
  public int definitionId;
  public bool unlockedByDefault;
  public Sprite icon;
  public UnityEngine.Object prefab;

  public ItemDefinition(
    string itemName,
    ShopManager.ShopItemType itemType,
    string itemFileName,
    ShopManager.ItemTier itemTier,
    int itemCredValue,
    int itemSteelValue,
    ChampionConfig itemChampion,
    int itemID,
    bool defaultAccountStatus,
    UnityEngine.Object prefab,
    Sprite sprite)
  {
    this.name = itemName;
    this.type = itemType;
    this.fileName = itemFileName;
    this.tier = itemTier;
    this.priceCreds = itemCredValue;
    this.priceSteel = itemSteelValue;
    this.champion = itemChampion;
    this.definitionId = itemID;
    this.unlockedByDefault = defaultAccountStatus;
    this.prefab = prefab;
    this.icon = sprite;
  }

  public ItemDefinition(int definitionId)
  {
    ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(definitionId);
    if (itemById == null)
    {
      this.name = "Error";
      Log.Error(string.Format("Item with Definition ID {0} not found on client!", (object) this.definitionId));
    }
    this.name = itemById.name;
    this.type = itemById.type;
    this.fileName = itemById.fileName;
    this.tier = itemById.tier;
    this.priceCreds = itemById.priceCreds;
    this.priceSteel = itemById.priceSteel;
    this.champion = itemById.champion;
    this.definitionId = itemById.definitionId;
    this.unlockedByDefault = itemById.unlockedByDefault;
    this.prefab = itemById.prefab;
    this.icon = itemById.icon;
  }

  public ItemDefinition(
    string itemName,
    string itemType,
    string itemFileName,
    string itemTier,
    string itemCredValue,
    string itemSteelValue,
    string itemChampion,
    string itemId,
    string defaultAccountStatus,
    ChampionConfigProvider championConfigProvider)
  {
    this.name = itemName;
    this.fileName = itemFileName;
    this.priceCreds = int.Parse(itemCredValue);
    this.priceSteel = int.Parse(itemSteelValue);
    int num = int.Parse(itemChampion);
    this.champion = num != -1 ? championConfigProvider.GetChampionConfigFor((ChampionType) num) : (ChampionConfig) null;
    this.definitionId = int.Parse(itemId);
    this.unlockedByDefault = !(defaultAccountStatus == "locked") && defaultAccountStatus == "unlocked";
    switch (itemType)
    {
      case "avatarIcon":
        this.type = ShopManager.ShopItemType.avatarIcon;
        this.icon = Resources.Load<Sprite>(ItemsConfig.avatarIconPath + itemFileName);
        break;
      case nameof (champion):
        this.type = ShopManager.ShopItemType.champion;
        this.prefab = Resources.Load(ItemsConfig.skinsPrefabPath + itemFileName);
        this.icon = Resources.Load<Sprite>(ItemsConfig.skinsIconPath + itemFileName);
        break;
      case "currency":
        this.type = ShopManager.ShopItemType.currency;
        break;
      case "emote":
        this.type = ShopManager.ShopItemType.emote;
        this.prefab = (UnityEngine.Object) Resources.Load<AnimationClip>(ItemsConfig.championAnimationPath + (object) this.champion.championType + "/emote/" + itemFileName);
        this.icon = Resources.Load<Sprite>(ItemsConfig.emoteIconsPath + itemFileName.Replace("_anim", ""));
        break;
      case "goalAnimation":
        this.type = ShopManager.ShopItemType.goalAnimation;
        break;
      case "pose":
        this.type = ShopManager.ShopItemType.victoryPose;
        this.prefab = (UnityEngine.Object) Resources.Load<AnimationClip>(ItemsConfig.championAnimationPath + (object) this.champion.championType + "/victory/" + itemFileName);
        this.icon = Resources.Load<Sprite>(ItemsConfig.victoryPoseIconsPath + itemFileName.Replace("_anim", ""));
        break;
      case "skin":
        this.type = ShopManager.ShopItemType.skin;
        this.prefab = Resources.Load(ItemsConfig.skinsPrefabPath + itemFileName);
        this.icon = Resources.Load<Sprite>(ItemsConfig.skinsIconPath + itemFileName);
        break;
      case "sprayTag":
        this.type = ShopManager.ShopItemType.spray;
        this.prefab = Resources.Load(ItemsConfig.spraytagPrefabsPath + itemFileName);
        this.icon = Resources.Load<Sprite>(ItemsConfig.spraytagIconPath + itemFileName);
        break;
      default:
        this.type = ShopManager.ShopItemType.generic;
        break;
    }
    if (!(itemTier == "T0"))
    {
      if (!(itemTier == "T1"))
      {
        if (!(itemTier == "T2"))
        {
          if (itemTier == "T3")
            this.tier = ShopManager.ItemTier.tier3;
          else
            this.tier = ShopManager.ItemTier.tier0;
        }
        else
          this.tier = ShopManager.ItemTier.tier2;
      }
      else
        this.tier = ShopManager.ItemTier.tier1;
    }
    else
      this.tier = ShopManager.ItemTier.tier0;
  }

  public bool Equals(ItemDefinition compareTo) => this.definitionId == compareTo.definitionId;
}
