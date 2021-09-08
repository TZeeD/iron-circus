// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScriptableObjects.ItemsConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "ItemsConfig", menuName = "SteelCircus/Configs/ItemsConfig")]
  public class ItemsConfig : SingletonScriptableObject<ItemsConfig>
  {
    public static string resourcesPath = "Assets/Resources/";
    public static string spraytagPrefabsPath = "Prefabs/UI/SprayTags/Prefabs/";
    public static string spraytagIconPath = "Prefabs/UI/Spraytags/Sprites_Highres/";
    public static string avatarIconPath = "UI/UserAvatars/";
    public static string avatarHighResIconPath = "UI/UserAvatars_HighRes/";
    public static string skinsPrefabPath = "Prefabs/ChampionModels/";
    public static string skinsIconPath = "UI/SkinIcons/";
    public static string emoteIconsPath = "UI/EmoteIcons/";
    public static string victoryPoseIconsPath = "UI/VictoryPoseIcons/";
    public static string championAnimationPath = "Animations/";
    private bool itemDefinitionsLoaded;
    public readonly string info = "Use this config to load items from the progression service.";
    public ChampionConfigProvider championConfigProvider;
    public StandalonePlayerLoadoutConfig standalonePlayerLoadoutConfig;
    [Header("Sprays")]
    public List<ItemDefinition> spraytags;
    public List<ItemDefinition> skins;
    public List<ItemDefinition> victoryPoses;
    public List<ItemDefinition> emotes;
    public List<ItemDefinition> champions;
    public List<ItemDefinition> avatars;
    [HideInInspector]
    public List<ItemDefinition> allItems;
    private Dictionary<ShopManager.ShopItemType, Dictionary<int, ItemDefinition>> itemDictionaries;

    public ItemDefinition FindItemByFileName(string fileName)
    {
      foreach (ItemDefinition allItem in this.allItems)
      {
        if (fileName == allItem.fileName)
          return allItem;
      }
      return (ItemDefinition) null;
    }

    public bool AreItemDefinitionsLoaded() => this.itemDefinitionsLoaded;

    public void SetItemDefinitionsLoaded(bool loaded) => this.itemDefinitionsLoaded = loaded;

    public int GetChampionItemId(ChampionType champion)
    {
      foreach (ItemDefinition champion1 in this.champions)
      {
        if (champion1.champion.championType == champion)
          return champion1.definitionId;
      }
      return -1;
    }

    public ItemDefinition GetItemByID(
      int definitionID,
      ShopManager.ShopItemType itemType)
    {
      return this.itemDictionaries.ContainsKey(itemType) && this.itemDictionaries[itemType].ContainsKey(definitionID) ? this.itemDictionaries[itemType][definitionID] : (ItemDefinition) null;
    }

    public ItemDefinition GetItemByName(
      string name,
      ShopManager.ShopItemType itemType)
    {
      if (this.itemDictionaries.ContainsKey(itemType))
      {
        foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[itemType])
        {
          if (keyValuePair.Value.name.Equals(name))
            return keyValuePair.Value;
        }
      }
      return (ItemDefinition) null;
    }

    public ItemDefinition GetItemByID(int definitionID)
    {
      foreach (ItemDefinition allItem in this.allItems)
      {
        if (definitionID == allItem.definitionId)
          return allItem;
      }
      return (ItemDefinition) null;
    }

    public List<ItemDefinition> GetItemsForChampionByType(
      ChampionType type,
      ShopManager.ShopItemType itemType)
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[itemType])
      {
        if (keyValuePair.Value.champion.championType == type)
          itemDefinitionList.Add(keyValuePair.Value);
      }
      return itemDefinitionList;
    }

    public List<ItemDefinition> GetItemsByType(ShopManager.ShopItemType type)
    {
      List<ItemDefinition> itemDefinitionList = new List<ItemDefinition>();
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[type])
        itemDefinitionList.Add(keyValuePair.Value);
      return itemDefinitionList;
    }

    public void CreateDictionaries()
    {
      this.itemDictionaries = new Dictionary<ShopManager.ShopItemType, Dictionary<int, ItemDefinition>>();
      foreach (ItemDefinition allItem in this.allItems)
      {
        if (!this.itemDictionaries.ContainsKey(allItem.type))
          this.itemDictionaries.Add(allItem.type, new Dictionary<int, ItemDefinition>());
        if (!this.itemDictionaries[allItem.type].ContainsKey(allItem.definitionId))
          this.itemDictionaries[allItem.type].Add(allItem.definitionId, allItem);
      }
    }

    public bool AreSkinItemsLoaded() => this.itemDictionaries != null && this.itemDictionaries.ContainsKey(ShopManager.ShopItemType.skin);

    public void OnImportItemDefinitions(JObject jObj, Action<string> onError)
    {
      this.ResetData();
      JArray jarray = (JArray) jObj["itemDefinitions"];
      List<string> stringList = new List<string>();
      bool flag = false;
      foreach (JObject jobject in jarray)
      {
        ItemDefinition itemDefinition = new ItemDefinition(jobject["name"].ToString(), jobject["type"].ToString(), jobject["fileName"].ToString(), jobject["tier"].ToString(), jobject["credValue"].ToString(), jobject["steelValue"].ToString(), jobject["champion"].ToString(), jobject["id"].ToString(), jobject["defaultAccountStatus"].ToString(), this.championConfigProvider);
        if (itemDefinition.prefab == (UnityEngine.Object) null && itemDefinition.type != ShopManager.ShopItemType.avatarIcon)
        {
          flag = true;
          stringList.Add("ERROR (PREFAB): " + itemDefinition.fileName + " has no prefab object.\n");
        }
        if ((UnityEngine.Object) itemDefinition.icon == (UnityEngine.Object) null)
        {
          flag = true;
          stringList.Add("ERROR (ICON): " + itemDefinition.fileName + " has no icon sprite.\n");
        }
        this.allItems.Add(itemDefinition);
        switch (itemDefinition.type)
        {
          case ShopManager.ShopItemType.spray:
            this.spraytags.Add(itemDefinition);
            continue;
          case ShopManager.ShopItemType.skin:
            this.skins.Add(itemDefinition);
            continue;
          case ShopManager.ShopItemType.emote:
            this.emotes.Add(itemDefinition);
            continue;
          case ShopManager.ShopItemType.victoryPose:
            this.victoryPoses.Add(itemDefinition);
            continue;
          case ShopManager.ShopItemType.champion:
            this.champions.Add(itemDefinition);
            continue;
          case ShopManager.ShopItemType.avatarIcon:
            this.avatars.Add(itemDefinition);
            continue;
          default:
            Log.Error("No item type specified when importing item!");
            continue;
        }
      }
      this.itemDefinitionsLoaded = true;
      if (!flag)
        return;
      string str1 = "ItemsConfig has " + (object) stringList.Count + " mismatches: \n";
      foreach (string str2 in stringList)
        str1 += str2;
      onError(str1);
    }

    public void OnErrorLoadingItems(string errors) => Log.Error(errors);

    public void ResetData()
    {
      this.spraytags = new List<ItemDefinition>();
      this.skins = new List<ItemDefinition>();
      this.emotes = new List<ItemDefinition>();
      this.victoryPoses = new List<ItemDefinition>();
      this.allItems = new List<ItemDefinition>();
      this.champions = new List<ItemDefinition>();
      this.avatars = new List<ItemDefinition>();
    }

    public void AddDebugSkin(ItemDefinition item)
    {
      int maxValue = int.MaxValue;
      item.definitionId = maxValue;
      Log.Debug("Lowest Id is: " + (object) maxValue);
    }

    public ChampionLoadout GetFakePlayerLoadoutForChampion(ChampionType type) => this.standalonePlayerLoadoutConfig.GetDefaultLoadoutForChampion(type);

    public ItemDefinition GetMainSkinForChampion(ChampionType type)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.skin])
      {
        if (keyValuePair.Value.champion.championType == type && keyValuePair.Value.prefab.name.Contains("char_"))
          return keyValuePair.Value;
      }
      Log.Error(string.Format("Main Skin for {0} could not be found.", (object) type));
      return (ItemDefinition) null;
    }

    public ItemDefinition GetSkinForChampionWithItemName(
      ChampionType type,
      string itemName)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.skin])
      {
        if (keyValuePair.Value.champion.championType == type && keyValuePair.Value.name.Equals(itemName))
        {
          Log.Debug(string.Format("Got {0} Skin for {1} = {2}", (object) itemName, (object) type, (object) keyValuePair.Value.definitionId));
          return keyValuePair.Value;
        }
      }
      Log.Error(string.Format("{0} Skin for {1} could not be found.", (object) itemName, (object) type));
      return (ItemDefinition) null;
    }

    public ItemDefinition GetFirstVictoryAnimForChampion(ChampionType type)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.victoryPose])
      {
        if (keyValuePair.Value.champion.championType == type)
        {
          Log.Debug(string.Format("Got default VictoryPose for {0} = {1}", (object) type, (object) keyValuePair.Value.definitionId));
          return keyValuePair.Value;
        }
      }
      Log.Error(string.Format("First Victory Animation for {0} could not be found.", (object) type));
      return (ItemDefinition) null;
    }

    public ItemDefinition GetVictoryAnimForChampionWithItemName(
      ChampionType type,
      string itemName)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.victoryPose])
      {
        if (keyValuePair.Value.champion.championType == type)
        {
          Log.Debug(string.Format("Got default VictoryPose for {0} = {1}", (object) type, (object) keyValuePair.Value.definitionId));
          return keyValuePair.Value;
        }
      }
      Log.Error(string.Format("First Victory Animation for {0} could not be found.", (object) type));
      return (ItemDefinition) null;
    }

    public ItemDefinition GetFirstEmoteForChampion(ChampionType type)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.emote])
      {
        if (keyValuePair.Value.champion.championType == type)
        {
          Log.Debug(string.Format("Got default Emote for {0} = {1}", (object) type, (object) keyValuePair.Value.definitionId));
          return keyValuePair.Value;
        }
      }
      Log.Error(string.Format("First Victory Animation for {0} could not be found.", (object) type));
      return (ItemDefinition) null;
    }

    public int[] GetFirstEmotesForChampion(ChampionType type)
    {
      List<int> intList = new List<int>();
      int num = 0;
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.emote])
      {
        if (keyValuePair.Value.champion.championType == type && num < 4)
          intList.Add(keyValuePair.Value.definitionId);
      }
      return intList.ToArray();
    }

    public int GetSpraytagWithItemName(string itemName)
    {
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.spray])
      {
        if (keyValuePair.Value.name.Equals(itemName))
        {
          Log.Debug(string.Format("Got Spraytag with itemName {0} = {1}", (object) itemName, (object) keyValuePair.Value.definitionId));
          return keyValuePair.Value.definitionId;
        }
      }
      Log.Error("Spraytag with " + itemName + " could not be found.");
      return 0;
    }

    public int[] GetFirstSpraytagsForChampion(ChampionType type)
    {
      List<int> intList = new List<int>();
      int num = 0;
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.spray])
      {
        if (num < 4)
        {
          Log.Debug(string.Format("Got default Spray for {0} = {1}", (object) type, (object) keyValuePair.Value.definitionId));
          intList.Add(keyValuePair.Value.definitionId);
          ++num;
        }
      }
      return intList.ToArray();
    }

    public int[] GetSpraytagsForChampion(ChampionType type)
    {
      List<int> intList = new List<int>();
      int num = 0;
      foreach (KeyValuePair<int, ItemDefinition> keyValuePair in this.itemDictionaries[ShopManager.ShopItemType.spray])
      {
        if (keyValuePair.Value.champion.championType == type && num < 4)
        {
          Log.Debug(string.Format("Got default Spray for {0} = {1}", (object) type, (object) keyValuePair.Value.definitionId));
          intList.Add(keyValuePair.Value.definitionId);
          ++num;
        }
      }
      return intList.ToArray();
    }
  }
}
