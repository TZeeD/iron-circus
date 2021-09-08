// Decompiled with JetBrains decompiler
// Type: StandalonePlayerLoadoutConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScriptableObjects;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "StandalonePlayerLoadoutConfig", menuName = "SteelCircus/Configs/StandalonePlayerLoadoutConfig")]
public class StandalonePlayerLoadoutConfig : ScriptableObject
{
  public int defaultAvatar;
  public ulong[] defaultSprays = new ulong[4];
  public List<LoadoutData> defaultItemList;
  public LoadoutData robotLoadout;

  public ChampionLoadout GetDefaultLoadoutForChampion(ChampionType type) => type == ChampionType.Robot ? new ChampionLoadout(this.robotLoadout) : StandalonePlayerLoadoutConfig.GetDefaultLoadoutForChamp(type);

  public static ChampionLoadout GetDefaultLoadoutForChamp(ChampionType type)
  {
    Debug.Log((object) string.Format("Create default loadout for {0}", (object) type));
    LoadoutData data = new LoadoutData();
    data.type = type;
    data.emotes = new int[4]
    {
      int.MaxValue,
      int.MaxValue,
      int.MaxValue,
      int.MaxValue
    };
    ItemDefinition mainSkinForChampion = SingletonScriptableObject<ItemsConfig>.Instance.GetMainSkinForChampion(data.type);
    data.skinId = mainSkinForChampion.definitionId;
    data.skinAsset = mainSkinForChampion.prefab as GameObject;
    ItemDefinition victoryAnimForChampion = SingletonScriptableObject<ItemsConfig>.Instance.GetFirstVictoryAnimForChampion(data.type);
    data.victoryPose = victoryAnimForChampion.definitionId;
    data.victoryPoseAsset = victoryAnimForChampion.prefab as AnimationClip;
    data.emotes = SingletonScriptableObject<ItemsConfig>.Instance.GetFirstEmotesForChampion(data.type);
    data.sprays = SingletonScriptableObject<ItemsConfig>.Instance.GetSpraytagsForChampion(data.type);
    data.sprayAssets = new GameObject[data.sprays.Length];
    for (int index = 0; index < data.sprays.Length; ++index)
      data.sprayAssets[index] = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(data.sprays[index], ShopManager.ShopItemType.spray).prefab as GameObject;
    data.emoteAssets = new AnimationClip[data.emotes.Length];
    for (int index = 0; index < data.sprays.Length; ++index)
    {
      ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(data.emotes[index], ShopManager.ShopItemType.emote);
      if (itemById != null)
        data.emoteAssets[index] = itemById.prefab as AnimationClip;
    }
    return new ChampionLoadout(data);
  }

  public void CreateStandaloneJson()
  {
  }

  public void PopulateDefaultData()
  {
    foreach (LoadoutData defaultItem in this.defaultItemList)
    {
      Debug.Log((object) string.Format("Setting default Standalone config For {0}", (object) defaultItem.type));
      defaultItem.emotes = new int[4]
      {
        int.MaxValue,
        int.MaxValue,
        int.MaxValue,
        int.MaxValue
      };
      ItemDefinition mainSkinForChampion = SingletonScriptableObject<ItemsConfig>.Instance.GetMainSkinForChampion(defaultItem.type);
      defaultItem.skinId = mainSkinForChampion.definitionId;
      defaultItem.skinAsset = mainSkinForChampion.prefab as GameObject;
      ItemDefinition victoryAnimForChampion = SingletonScriptableObject<ItemsConfig>.Instance.GetFirstVictoryAnimForChampion(defaultItem.type);
      defaultItem.victoryPose = victoryAnimForChampion.definitionId;
      defaultItem.victoryPoseAsset = victoryAnimForChampion.prefab as AnimationClip;
      defaultItem.emotes = SingletonScriptableObject<ItemsConfig>.Instance.GetFirstEmotesForChampion(defaultItem.type);
      defaultItem.sprays = SingletonScriptableObject<ItemsConfig>.Instance.GetSpraytagsForChampion(defaultItem.type);
      defaultItem.sprayAssets = new GameObject[defaultItem.sprays.Length];
      for (int index = 0; index < defaultItem.sprays.Length; ++index)
        defaultItem.sprayAssets[index] = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(defaultItem.sprays[index], ShopManager.ShopItemType.spray).prefab as GameObject;
      defaultItem.emoteAssets = new AnimationClip[defaultItem.emotes.Length];
      for (int index = 0; index < defaultItem.sprays.Length; ++index)
      {
        ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(defaultItem.emotes[index], ShopManager.ShopItemType.emote);
        if (itemById != null)
          defaultItem.emoteAssets[index] = itemById.prefab as AnimationClip;
      }
    }
  }
}
