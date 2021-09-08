// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.PlayerUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Utils.Extensions;
using SteelCircus.UI.Menu;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Utils
{
  public static class PlayerUtils
  {
    public static GameObject CreateTurntableModel(
      GameObject turntableContainerPrefab,
      ChampionConfig config,
      int skinIndex,
      Transform parent)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(turntableContainerPrefab, parent);
      gameObject.transform.SetToIdentity();
      gameObject.GetComponent<TurntableChampionContainer>().CreateChampion(config, skinIndex);
      Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
      if (!((Object) componentInChildren != (Object) null))
        return gameObject;
      componentInChildren.gameObject.AddComponent<AnimationEventHandler>();
      return gameObject;
    }

    public static GameObject CreateTurntableModel(
      GameObject turntableContainerPrefab,
      ChampionConfig config,
      GameObject skin,
      Transform parent)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(turntableContainerPrefab, parent);
      gameObject.transform.SetToIdentity();
      gameObject.GetComponent<TurntableChampionContainer>().CreateChampionFromPrefab(config, skin);
      Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
      if (!((Object) componentInChildren != (Object) null))
        return gameObject;
      componentInChildren.gameObject.AddComponent<AnimationEventHandler>();
      return gameObject;
    }

    public static GameObject CreateIngameModel(
      ChampionConfig config,
      int skinIndex,
      Transform parent)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(config.skins[skinIndex].prefab, parent);
      gameObject.transform.SetToIdentity();
      gameObject.transform.localScale = Vector3.one * config.inGameModelScale;
      Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
      if ((Object) componentInChildren != (Object) null)
      {
        componentInChildren.gameObject.AddComponent<AnimationEventHandler>();
        return gameObject;
      }
      Log.Error("NO ANIMATOR FOUND ON PLAYER!");
      return gameObject;
    }

    public static GameObject CreateIngameModelFromLoadout(
      ChampionConfig config,
      Dictionary<ChampionType, ChampionLoadout> playerLoadout,
      Transform parent,
      Team team)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(PlayerUtils.GetSkinPrefabFromLoadout(playerLoadout, config, team), parent);
      gameObject.transform.SetToIdentity();
      gameObject.transform.localScale = Vector3.one * config.inGameModelScale;
      Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
      if ((Object) componentInChildren != (Object) null)
      {
        componentInChildren.gameObject.AddComponent<AnimationEventHandler>();
        return gameObject;
      }
      Log.Error("NO ANIMATOR FOUND ON PLAYER!");
      return gameObject;
    }

    public static GameObject GetSkinPrefabFromLoadout(
      Dictionary<ChampionType, ChampionLoadout> playerLoadout,
      ChampionConfig config,
      Team team)
    {
      return config.championType == ChampionType.Robot ? config.skins[(int) (team - 1)].prefab : playerLoadout[config.championType].skinPrefab;
    }

    public static (GameObject, Animator, PlayerSpawnView) CreateCutsceneModel(
      ChampionConfig config,
      Dictionary<ChampionType, ChampionLoadout> playerLoadout,
      Team team)
    {
      GameObject gameObject = Object.Instantiate<GameObject>(PlayerUtils.GetSkinPrefabFromLoadout(playerLoadout, config, team), (Transform) null);
      gameObject.transform.SetToIdentity();
      gameObject.transform.localScale = Vector3.one * config.inGameModelScale;
      gameObject.SetActive(false);
      PlayerSpawnView playerSpawnView = gameObject.AddComponent<PlayerSpawnView>();
      return (gameObject, gameObject.GetComponentInChildren<Animator>(), playerSpawnView);
    }

    public static void OverrideAnimationsForPlayer(GameEntity player, GameObject championModel)
    {
      ChampionType type = player.playerChampionData.value.type;
      Animator componentInChildren = championModel.GetComponentInChildren<Animator>();
      AnimatorOverrideController overrideController = new AnimatorOverrideController(componentInChildren.runtimeAnimatorController);
      List<KeyValuePair<AnimationClip, AnimationClip>> keyValuePairList = new List<KeyValuePair<AnimationClip, AnimationClip>>();
      Log.Debug(string.Format("Overriding Animations for {0}", (object) player.playerId.value));
      AnimationClip[] animationClipArray1 = new AnimationClip[4];
      AnimationClip animationClip1 = new AnimationClip();
      int num = player.playerLoadout.itemLoadouts[type].emoteAssets.Length;
      if (num > 4)
        num = 4;
      for (int index = 0; index < num; ++index)
        animationClipArray1[index] = player.playerLoadout.itemLoadouts[type].emoteAssets[index];
      AnimationClip victoryPoseAsset;
      if (type != ChampionType.Robot)
      {
        victoryPoseAsset = player.playerLoadout.itemLoadouts[type].victoryPoseAsset;
      }
      else
      {
        AnimationClip[] animationClipArray2 = Resources.LoadAll<AnimationClip>("Animations/Robot/victory");
        victoryPoseAsset = animationClipArray2[Random.Range(0, animationClipArray2.Length - 1)];
      }
      foreach (AnimationClip animationClip2 in overrideController.animationClips)
      {
        if (animationClip2.name.Contains("emote_001"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, animationClipArray1[0]));
        if (animationClip2.name.Contains("emote_002"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, animationClipArray1[1]));
        if (animationClip2.name.Contains("emote_003"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, animationClipArray1[2]));
        if (animationClip2.name.Contains("emote_004"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, animationClipArray1[3]));
        if (animationClip2.name.Contains("victory_001"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, victoryPoseAsset));
        if (animationClip2.name.Contains("victory_002"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, victoryPoseAsset));
        if (animationClip2.name.Contains("victory_003"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, victoryPoseAsset));
        if (animationClip2.name.Contains("victory_004"))
          keyValuePairList.Add(new KeyValuePair<AnimationClip, AnimationClip>(animationClip2, victoryPoseAsset));
      }
      overrideController.ApplyOverrides((IList<KeyValuePair<AnimationClip, AnimationClip>>) keyValuePairList);
      componentInChildren.runtimeAnimatorController = (RuntimeAnimatorController) overrideController;
    }
  }
}
