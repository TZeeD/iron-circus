// Decompiled with JetBrains decompiler
// Type: VictoryAnimationEvents
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.FX;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.Utils;
using Imi.Utils.Common;
using SharedWithServer.Game;
using SteelCircus.Client_Components;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class VictoryAnimationEvents : MonoBehaviour
{
  [SerializeField]
  private bool fakeSpawnCutscene = true;
  [SerializeField]
  private Animator victoryAlphaAnimator;
  [SerializeField]
  private Animator victoryBetaAnimator;
  [SerializeField]
  private Animator drawAnimator;
  public PlayerSelectedChampion[] champions = new PlayerSelectedChampion[6];
  public List<FakeChampionView> championViews;
  [Readonly]
  public int playerCount;
  public VictorySpawnPoint[] victorySpawnPoints;
  private List<GameEntity> players;

  public void Setup()
  {
    this.fakeSpawnCutscene = false;
    if (Contexts.sharedInstance.game == null || !Contexts.sharedInstance.game.hasMatchData)
    {
      if (!this.fakeSpawnCutscene)
        return;
      this.FindSpawnPointsForEditor();
      this.InstantiateFakeVictoryPlayers();
      this.DistributeChampionsToSpawnpoints();
    }
    else
    {
      this.playerCount = Contexts.sharedInstance.game.matchData.numPlayers;
      this.GetPlayerChampions();
      this.InstantiateFakeVictoryPlayers();
      this.DistributeChampionsToSpawnpoints();
    }
  }

  private void GetPlayerChampions()
  {
    this.players = new List<GameEntity>();
    foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities())
      this.players.Add(entity);
    this.players.Sort((Comparison<GameEntity>) ((a, b) => a.playerTeam.value - b.playerTeam.value));
    this.champions = new PlayerSelectedChampion[this.players.Count];
    for (int index = 0; index < this.players.Count; ++index)
    {
      PlayerSelectedChampion selectedChampion = new PlayerSelectedChampion();
      selectedChampion.championConfig = this.players[index].championConfig.value;
      selectedChampion.playerId = this.players[index].playerId.value;
      int skin = this.players[index].playerLoadout.itemLoadouts[this.players[index].championConfig.value.championType].skin;
      selectedChampion.skin = skin;
      this.champions[index] = selectedChampion;
    }
  }

  public void ShowFakeVictoryChampions()
  {
    Log.Debug("Show Fake Victory Pose Players!");
    foreach (FakeChampionView championView in this.championViews)
    {
      championView.championView.SetActive((bool) (UnityEngine.Object) this.transform);
      championView.championAnimator.SetInteger("victoryPose", 1);
    }
  }

  public void HidePlayerChampions()
  {
    foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities())
    {
      if (entity.hasUnityView)
      {
        entity.unityView.gameObject.SetActive(false);
        entity.unityView.gameObject.GetComponent<Player>().FloorUI.gameObject.SetActive(false);
      }
    }
  }

  public void ProvideSpawnPoints(VictorySpawnPoint[] spawnPoints) => this.victorySpawnPoints = spawnPoints;

  private void DistributeChampionsToSpawnpoints()
  {
    Log.Debug(string.Format("DistributeChampionsToSpawnpoints: We have {0} players. {1} championViews and {2} spawnpoints.", (object) this.playerCount, (object) this.championViews.Count, (object) this.victorySpawnPoints.Length));
    if (this.playerCount < 3)
    {
      this.championViews[0].spawnPoint = this.victorySpawnPoints[0].transform;
      this.championViews[0].championView.transform.position = this.victorySpawnPoints[1].transform.position;
      this.championViews[0].championView.transform.rotation = this.victorySpawnPoints[1].transform.rotation;
      this.championViews[1].spawnPoint = this.victorySpawnPoints[4].transform;
      this.championViews[1].championView.transform.position = this.victorySpawnPoints[4].transform.position;
      this.championViews[1].championView.transform.rotation = this.victorySpawnPoints[4].transform.rotation;
    }
    else if (this.playerCount == 4)
    {
      this.championViews[0].spawnPoint = this.victorySpawnPoints[0].transform;
      this.championViews[0].championView.transform.position = this.victorySpawnPoints[0].transform.position;
      this.championViews[0].championView.transform.rotation = this.victorySpawnPoints[0].transform.rotation;
      this.championViews[1].spawnPoint = this.victorySpawnPoints[2].transform;
      this.championViews[1].championView.transform.position = this.victorySpawnPoints[2].transform.position;
      this.championViews[1].championView.transform.rotation = this.victorySpawnPoints[2].transform.rotation;
      this.championViews[2].spawnPoint = this.victorySpawnPoints[3].transform;
      this.championViews[2].championView.transform.position = this.victorySpawnPoints[3].transform.position;
      this.championViews[2].championView.transform.rotation = this.victorySpawnPoints[3].transform.rotation;
      this.championViews[3].spawnPoint = this.victorySpawnPoints[5].transform;
      this.championViews[3].championView.transform.position = this.victorySpawnPoints[5].transform.position;
      this.championViews[3].championView.transform.rotation = this.victorySpawnPoints[5].transform.rotation;
    }
    else
    {
      for (int index = 0; index < this.victorySpawnPoints.Length; ++index)
      {
        if (this.championViews.Count >= index && index < this.playerCount)
        {
          this.championViews[index].spawnPoint = this.victorySpawnPoints[index].transform;
          this.championViews[index].championView.transform.position = this.victorySpawnPoints[index].transform.position;
          this.championViews[index].championView.transform.rotation = this.victorySpawnPoints[index].transform.rotation;
        }
      }
    }
  }

  private void InstantiateFakeVictoryPlayers()
  {
    Log.Debug(string.Format("Create Fake Victory Pose Players! {0}", (object) this.champions.Length));
    this.championViews = new List<FakeChampionView>();
    foreach (PlayerSelectedChampion champion in this.champions)
    {
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(champion.playerId);
      FakeChampionView fakeChampionView1 = new FakeChampionView();
      FakeChampionView fakeChampionView2 = fakeChampionView1;
      FakeChampionView fakeChampionView3 = fakeChampionView1;
      FakeChampionView fakeChampionView4 = fakeChampionView1;
      (GameObject, Animator, PlayerSpawnView) cutsceneModel = PlayerUtils.CreateCutsceneModel(champion.championConfig, entityWithPlayerId.playerLoadout.itemLoadouts, entityWithPlayerId.playerTeam.value);
      // ISSUE: variable of the null type
      __Null local = cutsceneModel.Item1;
      fakeChampionView2.championView = (GameObject) local;
      fakeChampionView3.championAnimator = (Animator) cutsceneModel.Item2;
      fakeChampionView4.ChampionSpawnView = (PlayerSpawnView) cutsceneModel.Item3;
      fakeChampionView1.playerId = champion.playerId;
      PlayerUtils.OverrideAnimationsForPlayer(Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(champion.playerId), fakeChampionView1.championView);
      this.championViews.Add(fakeChampionView1);
    }
  }

  private void FindSpawnPointsForEditor()
  {
    this.victorySpawnPoints = UnityEngine.Object.FindObjectsOfType<VictorySpawnPoint>();
    this.victorySpawnPoints = ((IEnumerable<VictorySpawnPoint>) this.victorySpawnPoints).OrderBy<VictorySpawnPoint, Team>((Func<VictorySpawnPoint, Team>) (sp => sp.team)).ThenBy<VictorySpawnPoint, SpawnPositionType>((Func<VictorySpawnPoint, SpawnPositionType>) (pos => pos.spawnPosition)).ToArray<VictorySpawnPoint>();
  }

  [EditorButton]
  private void ShowTeams()
  {
    foreach (FakeChampionView championView in this.championViews)
    {
      championView.championView.SetActive(true);
      championView.championAnimator.SetInteger("victoryPose", 1);
    }
  }

  [EditorButton]
  private void HideTeams()
  {
    foreach (FakeChampionView championView in this.championViews)
      championView.championView.SetActive(false);
  }

  [EditorButton]
  private void UpdatePositions()
  {
    foreach (FakeChampionView championView in this.championViews)
    {
      championView.championView.transform.position = championView.spawnPoint.position;
      championView.championView.transform.rotation = championView.spawnPoint.rotation;
    }
  }
}
