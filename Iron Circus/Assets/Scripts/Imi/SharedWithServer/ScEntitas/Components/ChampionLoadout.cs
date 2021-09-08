// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ChampionLoadout
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.ScriptableObjects;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public class ChampionLoadout
  {
    public int skin;
    public int victoryPose;
    public int[] sprays;
    public int[] emotes;
    public GameObject skinPrefab;
    public GameObject[] sprayPrefabs;
    public AnimationClip[] emoteAssets;
    public AnimationClip victoryPoseAsset;
    public Sprite iconAsset;

    public ChampionLoadout(JObject data)
    {
      Log.Debug(data.ToString());
      this.sprays = new int[4];
      this.emotes = new int[4];
      this.skin = this.ParseSingleLoadout(data, nameof (skin));
      this.victoryPose = this.ParseSingleLoadout(data, "pose");
      this.sprays[0] = this.ParseSingleLoadout(data, "sprayTagSlot1");
      this.sprays[1] = this.ParseSingleLoadout(data, "sprayTagSlot2");
      this.sprays[2] = this.ParseSingleLoadout(data, "sprayTagSlot3");
      this.sprays[3] = this.ParseSingleLoadout(data, "sprayTagSlot4");
      this.emotes[0] = this.ParseSingleLoadout(data, "emoteSlot1");
      this.emotes[1] = this.ParseSingleLoadout(data, "emoteSlot2");
      this.emotes[2] = this.ParseSingleLoadout(data, "emoteSlot3");
      this.emotes[3] = this.ParseSingleLoadout(data, "emoteSlot4");
      this.skinPrefab = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this.skin, ShopManager.ShopItemType.skin).prefab as GameObject;
      this.victoryPoseAsset = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this.victoryPose, ShopManager.ShopItemType.victoryPose)?.prefab as AnimationClip;
      this.sprayPrefabs = new GameObject[this.sprays.Length];
      for (int index = 0; index < this.sprays.Length; ++index)
        this.sprayPrefabs[index] = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this.sprays[index], ShopManager.ShopItemType.spray).prefab as GameObject;
      this.emoteAssets = new AnimationClip[this.emotes.Length];
      for (int index = 0; index < this.sprays.Length; ++index)
      {
        ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this.emotes[index], ShopManager.ShopItemType.emote);
        if (itemById != null)
          this.emoteAssets[index] = itemById.prefab as AnimationClip;
      }
    }

    public ChampionLoadout(LoadoutData data)
    {
      this.skin = data.skinId;
      this.victoryPose = data.victoryPose;
      this.sprays = data.sprays;
      this.emotes = data.emotes;
      this.skinPrefab = data.skinAsset;
      this.sprayPrefabs = data.sprayAssets;
      this.emoteAssets = data.emoteAssets;
      this.victoryPoseAsset = data.victoryPoseAsset;
    }

    private int ParseSingleLoadout(JObject data, string key) => data[key] != null ? int.Parse(data[key].ToString()) : int.MaxValue;
  }
}
