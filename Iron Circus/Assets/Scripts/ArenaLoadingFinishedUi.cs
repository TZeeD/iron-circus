// Decompiled with JetBrains decompiler
// Type: ArenaLoadingFinishedUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Entitas.VisualDebugging.Unity;
using Imi.Diagnostics;
using Imi.Game;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class ArenaLoadingFinishedUi : MonoBehaviour
{
  [SerializeField]
  private Transform alphaArenaLoadedInfoParent;
  [SerializeField]
  private Transform betaArenaLoadedInfoParent;
  [SerializeField]
  private Transform alphaArenaLoadedInfoParentBig;
  [SerializeField]
  private Transform betaArenaLoadedInfoParentBig;
  [SerializeField]
  private GameObject arenaLoadedInfoPrefab;
  [SerializeField]
  private GameObject arenaLoadedInfoPrefabBig;
  private Dictionary<ulong, PlayerArenaLoadedInfo> playerArenaLoadedDict = new Dictionary<ulong, PlayerArenaLoadedInfo>();
  private Dictionary<ulong, PlayerArenaLoadedInfoBig> playerArenaLoadedBigDict = new Dictionary<ulong, PlayerArenaLoadedInfoBig>();
  private IGroup<GameEntity> players;

  private void OnDisable() => this.players = (IGroup<GameEntity>) null;

  public void UpdateArenaLoadedInfo(GameEntity entity)
  {
    bool finishedLoading = entity.hasArenaLoaded && entity.arenaLoaded.arenaLoadingFinished;
    if (!this.playerArenaLoadedDict.ContainsKey(entity.playerId.value))
    {
      GameObject go = Object.Instantiate<GameObject>(this.arenaLoadedInfoPrefab);
      this.SetParentForTeam(entity.playerChampionData.value.team, go);
      PlayerArenaLoadedInfo component1 = go.GetComponent<PlayerArenaLoadedInfo>();
      RectTransform component2 = go.GetComponent<RectTransform>();
      component2.localPosition = new Vector3(component2.position.x, component2.position.y, 0.0f);
      component2.localScale = new Vector3(1f, 1f, 1f);
      if ((Object) component1 != (Object) null)
      {
        component1.SetLoadingState(finishedLoading);
        component1.SetPlayerId(entity.playerId.value);
        this.playerArenaLoadedDict[entity.playerId.value] = component1;
      }
      else
        Log.Warning(string.Format("PlayerArenaInfo for Player {0} is null.", (object) entity.playerId.value));
    }
    else
    {
      PlayerArenaLoadedInfo playerArenaLoadedInfo = this.playerArenaLoadedDict[entity.playerId.value];
      playerArenaLoadedInfo.SetLoadingState(finishedLoading);
      playerArenaLoadedInfo.SetPlayerId(entity.playerId.value);
      this.SetParentForTeam(entity.playerChampionData.value.team, playerArenaLoadedInfo.gameObject);
      playerArenaLoadedInfo.SetTeamStyle(entity.playerChampionData.value.team);
    }
  }

  private void SetParentForTeam(Team team, GameObject go)
  {
    if (team == Team.Alpha)
      go.transform.SetParent(this.alphaArenaLoadedInfoParent, false);
    else if (team == Team.Beta)
      go.transform.SetParent(this.betaArenaLoadedInfoParent, false);
    else
      go.transform.SetParent(this.gameObject.transform, false);
  }

  public void UpdateArenaLoadedInfoBig()
  {
    if (this.players == null)
      this.players = Contexts.sharedInstance.game.GetGroup(GameMatcher.PlayerId);
    foreach (GameEntity player in this.players)
    {
      bool flag = player.hasArenaLoaded && player.arenaLoaded.arenaLoadingFinished;
      if (!this.playerArenaLoadedBigDict.ContainsKey(player.playerId.value))
      {
        GameObject go = Object.Instantiate<GameObject>(this.arenaLoadedInfoPrefabBig);
        if (player.hasPlayerChampionData)
          this.SetParentForTeamBig(player.playerChampionData.value.team, go);
        PlayerArenaLoadedInfoBig component = go.GetComponent<PlayerArenaLoadedInfoBig>();
        if ((Object) component != (Object) null)
        {
          component.SetLoadingState(flag);
          component.SetPlayerId(player.playerId.value);
          if (player.hasPlayerUsername && player.playerUsername.isTwitchUser && !player.isFakePlayer)
            component.SetTwitchUIVisible(true, player.playerUsername.twitchViewerCount > 0, player.playerUsername.twitchUsername, player.playerUsername.twitchViewerCount, player.playerId.value);
          else
            component.SetTwitchUIVisible(false, false, "", 0, player.playerId.value);
          this.playerArenaLoadedBigDict[player.playerId.value] = component;
        }
        else
          Log.Warning(string.Format("PlayerArenaInfoBig for Player {0} is null.", (object) player.playerId.value));
      }
      else
      {
        PlayerArenaLoadedInfoBig arenaLoadedInfoBig = this.playerArenaLoadedBigDict[player.playerId.value];
        arenaLoadedInfoBig.SetLoadingState(flag);
        arenaLoadedInfoBig.SetPlayerId(player.playerId.value);
        if (player.hasPlayerChampionData)
        {
          arenaLoadedInfoBig.SetTeamStyle(player.playerChampionData.value.team, flag);
          this.SetParentForTeamBig(player.playerChampionData.value.team, arenaLoadedInfoBig.gameObject);
        }
      }
    }
    foreach (ulong key in this.playerArenaLoadedBigDict.Keys.ToArray<ulong>())
    {
      bool flag = false;
      foreach (GameEntity player in this.players)
      {
        if ((long) key == (long) player.playerId.value)
        {
          flag = true;
          break;
        }
      }
      if (!flag)
      {
        Log.Debug(string.Format("Remove Lobby PlayerInfoCard for player {0}", (object) key));
        this.playerArenaLoadedBigDict[key].gameObject.DestroyGameObject();
        this.playerArenaLoadedBigDict.Remove(key);
      }
    }
  }

  private void SetParentForTeamBig(Team team, GameObject go)
  {
    if (team == Team.Alpha)
      go.transform.SetParent(this.alphaArenaLoadedInfoParentBig, false);
    else if (team == Team.Beta)
      go.transform.SetParent(this.betaArenaLoadedInfoParentBig, false);
    else
      go.transform.SetParent(this.gameObject.transform, false);
  }
}
