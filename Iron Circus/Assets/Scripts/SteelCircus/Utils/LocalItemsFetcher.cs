// Decompiled with JetBrains decompiler
// Type: SteelCircus.Utils.LocalItemsFetcher
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.Utils
{
  public static class LocalItemsFetcher
  {
    private static string ressourcesPath = "Assets/Resources/";
    private static string skinPrefabsPath = "Prefabs/ChampionModels/";

    public static List<ShopItem> GetDebugShopItemList(
      ChampionConfig champion,
      ShopManager.ShopItemType itemType)
    {
      List<ShopItem> shopItemList = new List<ShopItem>();
      switch (itemType)
      {
        case ShopManager.ShopItemType.skin:
          using (List<ItemDefinition>.Enumerator enumerator = LocalItemsFetcher.GetLocalSkins(champion).GetEnumerator())
          {
            while (enumerator.MoveNext())
            {
              ShopItem shopItem = new ShopItem(enumerator.Current);
              shopItemList.Add(shopItem);
            }
            break;
          }
        case ShopManager.ShopItemType.avatarIcon:
          using (List<ItemDefinition>.Enumerator enumerator = LocalItemsFetcher.GetLocalAvatars().GetEnumerator())
          {
            while (enumerator.MoveNext())
            {
              ShopItem shopItem = new ShopItem(enumerator.Current);
              shopItemList.Add(shopItem);
            }
            break;
          }
        default:
          return (List<ShopItem>) null;
      }
      return shopItemList;
    }

    public static List<ItemDefinition> GetLocalAvatars()
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (Sprite sprite in Resources.LoadAll<Sprite>(ItemsConfig.avatarIconPath))
      {
        string name = sprite.name;
        string championName = name.Split('_')[0];
        ItemDefinition fakeItem = LocalItemsFetcher.CreateFakeItem(name, championName, (Object) null, sprite, ShopManager.ShopItemType.avatarIcon);
        itemDefinitionList.Add(fakeItem);
      }
      return itemDefinitionList;
    }

    public static List<ItemDefinition> GetLocalSkins(ChampionConfig champion)
    {
      List<ItemDefinition> localSkins = LocalItemsFetcher.GetLocalSkins();
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (ItemDefinition itemDefinition in localSkins)
      {
        if ((Object) itemDefinition.champion == (Object) champion)
          itemDefinitionList.Add(itemDefinition);
      }
      return itemDefinitionList;
    }

    public static List<ItemDefinition> GetLocalVictoryPoses()
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig in SingletonScriptableObject<ChampionConfigProvider>.Instance.championConfigs)
      {
        foreach (AnimationClip animationClip in Resources.LoadAll<AnimationClip>(ItemsConfig.championAnimationPath + (object) championConfig.ChampionConfig.championType + "/victory/"))
        {
          string name = animationClip.name;
          string championName = name.Split('_')[1];
          if (championName != "robot")
          {
            Sprite sprite = Resources.Load(ItemsConfig.victoryPoseIconsPath + name) as Sprite;
            ItemDefinition fakeItem = LocalItemsFetcher.CreateFakeItem(name, championName, (Object) animationClip, sprite, ShopManager.ShopItemType.victoryPose);
            itemDefinitionList.Add(fakeItem);
          }
        }
      }
      return itemDefinitionList;
    }

    public static List<ItemDefinition> GetLocalEmotes()
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (ChampionConfigProvider.ChampionConfigUiInfo championConfig in SingletonScriptableObject<ChampionConfigProvider>.Instance.championConfigs)
      {
        foreach (AnimationClip animationClip in Resources.LoadAll<AnimationClip>(ItemsConfig.championAnimationPath + (object) championConfig.ChampionConfig.championType + "/emote/"))
        {
          string name = animationClip.name;
          string championName = name.Split('_')[1];
          if (championName != "robot")
          {
            Sprite sprite = Resources.Load(ItemsConfig.emoteIconsPath + name) as Sprite;
            ItemDefinition fakeItem = LocalItemsFetcher.CreateFakeItem(name, championName, (Object) animationClip, sprite, ShopManager.ShopItemType.emote);
            itemDefinitionList.Add(fakeItem);
          }
        }
      }
      return itemDefinitionList;
    }

    public static List<ItemDefinition> GetLocalSpraytags()
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (Sprite sprite in Resources.LoadAll<Sprite>(ItemsConfig.spraytagIconPath))
      {
        if ((Object) sprite != (Object) null)
        {
          string name = sprite.name;
          string championName = name.Split('_')[0];
          Object prefab = (Object) (Resources.Load(ItemsConfig.spraytagPrefabsPath + name) as GameObject);
          ItemDefinition fakeItem = LocalItemsFetcher.CreateFakeItem(name, championName, prefab, sprite, ShopManager.ShopItemType.spray);
          itemDefinitionList.Add(fakeItem);
        }
      }
      return itemDefinitionList;
    }

    public static ItemDefinition CreateFakeItem(
      string fileName,
      string championName,
      Object prefab,
      Sprite sprite,
      ShopManager.ShopItemType itemType)
    {
      return new ItemDefinition(fileName, itemType, fileName, ShopManager.ItemTier.tier0, 10, 0, SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(championName), -1, true, prefab, sprite);
    }

    public static List<ItemDefinition> GetLocalSkins()
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (GameObject gameObject in Resources.LoadAll<GameObject>(LocalItemsFetcher.skinPrefabsPath))
      {
        string name = gameObject.name;
        string[] strArray = name.Split('_');
        Log.Debug("Getting local skin " + name);
        if (strArray.Length > 1 && strArray[0] != "char" && strArray[0] != "cos" || strArray.Length < 2)
        {
          Log.Error("Could not parse skin name. Do you have a rogue file in the skin prefab folder?");
        }
        else
        {
          string championName = strArray[1];
          if (championName != "robot")
          {
            string itemName;
            if (strArray[0] == "char")
            {
              itemName = "main";
            }
            else
            {
              itemName = strArray[2];
              for (int index = 3; index < strArray.Length; ++index)
                itemName = itemName + "_" + strArray[index];
            }
            Sprite sprite = Resources.Load(ItemsConfig.skinsIconPath + name) as Sprite;
            ItemDefinition itemDefinition = new ItemDefinition(itemName, ShopManager.ShopItemType.skin, name, ShopManager.ItemTier.tier0, 10, 0, SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(championName), -1, true, (Object) gameObject, sprite);
            itemDefinitionList.Add(itemDefinition);
          }
        }
      }
      return itemDefinitionList;
    }

    public static List<T> GetResourcesAtPath<T>(string path) where T : Object => (List<T>) null;
  }
}
