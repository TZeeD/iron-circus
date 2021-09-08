// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.FX.IntroAnimationEvents
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.ui.Floor;
using Imi.SteelCircus.Utils;
using Imi.Utils.Common;
using SharedWithServer.Game;
using SteelCircus.Client_Components;
using SteelCircus.Core;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Imi.SteelCircus.FX
{
  public class IntroAnimationEvents : MonoBehaviour
  {
    [SerializeField]
    private bool fakeSpawnCutscene = true;
    public PlayerSelectedChampion[] champions = new PlayerSelectedChampion[6];
    public List<FakeChampionView> championViews;
    private List<GameEntity> players;
    [Readonly]
    public int playerCount;
    private Animator cameraAnimator;
    public IntroSpawnPoint[] introSpawnPoints;

    private void OnValidate() => this.cameraAnimator = this.GetComponent<Animator>();

    private void Start()
    {
      if (!StartupSetup.configProvider.debugConfig.skipCutscenes)
        return;
      Log.Debug("Skipping intro, part 1 of 2");
      this.StartCoroutine(this.DebugSkip());
    }

    private IEnumerator DebugSkip()
    {
      yield return (object) null;
      Log.Debug("Skipping intro, part 2 of 2");
      for (int index = 0; index < this.playerCount; ++index)
        this.SpawnPlayer(index);
    }

    public void Setup()
    {
      if (Contexts.sharedInstance.meta.metaState.value == MetaState.Game || Contexts.sharedInstance.meta.metaState.value == MetaState.PostGame)
        this.fakeSpawnCutscene = false;
      if (this.fakeSpawnCutscene)
      {
        this.playerCount = this.champions.Length;
        this.FindSpawnPointsForEditor();
        this.InstantiateFakeIntroPlayersForEditor();
        this.DistributeChampionsToSpawnpoints();
      }
      else
      {
        this.playerCount = Contexts.sharedInstance.game.matchData.numPlayers;
        this.GetPlayers();
        this.InstantiateFakeIntroPlayers();
        this.DistributeChampionsToSpawnpoints();
      }
    }

    [EditorButton]
    private void SetupEditor()
    {
      this.fakeSpawnCutscene = true;
      this.Setup();
    }

    private void OnDisable()
    {
      if (Contexts.sharedInstance.game != null && Contexts.sharedInstance.game.hasMatchData)
      {
        foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities())
        {
          if (entity.hasUnityView)
          {
            Player component = entity.unityView.gameObject.GetComponent<Player>();
            component.ViewContainer.SetActive(true);
            component.FloorUI.gameObject.SetActive(true);
          }
        }
      }
      foreach (FakeChampionView championView in this.championViews)
        UnityEngine.Object.Destroy((UnityEngine.Object) championView.championView);
    }

    public void ProvideIntroSpawnPoints(IntroSpawnPoint[] spawnPoints) => this.introSpawnPoints = spawnPoints;

    private void InstantiateFakeIntroPlayers()
    {
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
        this.championViews.Add(fakeChampionView1);
        fakeChampionView1.playerId = champion.playerId;
      }
    }

    private void InstantiateFakeIntroPlayersForEditor()
    {
      foreach (FakeChampionView championView in this.championViews)
        UnityEngine.Object.Destroy((UnityEngine.Object) championView.championView);
      this.championViews = new List<FakeChampionView>();
      foreach (PlayerSelectedChampion champion in this.champions)
      {
        FakeChampionView fakeChampionView1 = new FakeChampionView();
        if ((UnityEngine.Object) champion.championConfig == (UnityEngine.Object) null)
          champion.championConfig = SingletonScriptableObject<ChampionConfigProvider>.Instance.GetChampionConfigFor(ChampionType.Li);
        ChampionType championType = champion.championConfig.championType;
        ChampionLoadout defaultLoadoutForChamp = StandalonePlayerLoadoutConfig.GetDefaultLoadoutForChamp(championType);
        Dictionary<ChampionType, ChampionLoadout> playerLoadout = new Dictionary<ChampionType, ChampionLoadout>()
        {
          {
            championType,
            defaultLoadoutForChamp
          }
        };
        FakeChampionView fakeChampionView2 = fakeChampionView1;
        FakeChampionView fakeChampionView3 = fakeChampionView1;
        FakeChampionView fakeChampionView4 = fakeChampionView1;
        (GameObject, Animator, PlayerSpawnView) cutsceneModel = PlayerUtils.CreateCutsceneModel(champion.championConfig, playerLoadout, Team.None);
        // ISSUE: variable of the null type
        __Null local = cutsceneModel.Item1;
        fakeChampionView2.championView = (GameObject) local;
        fakeChampionView3.championAnimator = (Animator) cutsceneModel.Item2;
        fakeChampionView4.ChampionSpawnView = (PlayerSpawnView) cutsceneModel.Item3;
        this.championViews.Add(fakeChampionView1);
        fakeChampionView1.playerId = champion.playerId;
      }
    }

    private void DistributeChampionsToSpawnpoints()
    {
      if (this.playerCount < 3)
      {
        this.championViews[0].spawnPoint = this.introSpawnPoints[0].transform;
        this.championViews[0].championView.transform.position = this.introSpawnPoints[1].transform.position;
        this.championViews[0].championView.transform.rotation = this.introSpawnPoints[1].transform.rotation;
        if (this.championViews.Count <= 1)
          return;
        this.championViews[1].spawnPoint = this.introSpawnPoints[4].transform;
        this.championViews[1].championView.transform.position = this.introSpawnPoints[4].transform.position;
        this.championViews[1].championView.transform.rotation = this.introSpawnPoints[4].transform.rotation;
      }
      else if (this.playerCount == 4)
      {
        this.championViews[0].spawnPoint = this.introSpawnPoints[0].transform;
        this.championViews[0].championView.transform.position = this.introSpawnPoints[0].transform.position;
        this.championViews[0].championView.transform.rotation = this.introSpawnPoints[0].transform.rotation;
        this.championViews[1].spawnPoint = this.introSpawnPoints[2].transform;
        this.championViews[1].championView.transform.position = this.introSpawnPoints[2].transform.position;
        this.championViews[1].championView.transform.rotation = this.introSpawnPoints[2].transform.rotation;
        this.championViews[2].spawnPoint = this.introSpawnPoints[3].transform;
        this.championViews[2].championView.transform.position = this.introSpawnPoints[3].transform.position;
        this.championViews[2].championView.transform.rotation = this.introSpawnPoints[3].transform.rotation;
        this.championViews[3].spawnPoint = this.introSpawnPoints[5].transform;
        this.championViews[3].championView.transform.position = this.introSpawnPoints[5].transform.position;
        this.championViews[3].championView.transform.rotation = this.introSpawnPoints[5].transform.rotation;
      }
      else
      {
        for (int index = 0; index < this.introSpawnPoints.Length; ++index)
        {
          if (this.championViews.Count > index)
          {
            this.championViews[index].spawnPoint = this.introSpawnPoints[index].transform;
            this.championViews[index].championView.transform.position = this.introSpawnPoints[index].transform.position;
            this.championViews[index].championView.transform.rotation = this.introSpawnPoints[index].transform.rotation;
          }
        }
      }
    }

    private void FindSpawnPointsForEditor()
    {
      this.introSpawnPoints = UnityEngine.Object.FindObjectsOfType<IntroSpawnPoint>();
      this.introSpawnPoints = ((IEnumerable<IntroSpawnPoint>) this.introSpawnPoints).OrderBy<IntroSpawnPoint, Team>((Func<IntroSpawnPoint, Team>) (sp => sp.team)).ThenBy<IntroSpawnPoint, SpawnPositionType>((Func<IntroSpawnPoint, SpawnPositionType>) (pos => pos.spawnPosition)).ToArray<IntroSpawnPoint>();
    }

    private void StartIntro2()
    {
      Log.Debug("Starting intro part 2");
      MatchObjectsParent.FloorStateManager.SetState(FloorStateManager.State.IntroPart2);
    }

    private void SpawnPlayer(int index)
    {
      if (this.fakeSpawnCutscene)
      {
        this.SpawnFakeIntroPlayer(index);
      }
      else
      {
        if (Contexts.sharedInstance.game == null || !Contexts.sharedInstance.game.hasMatchData)
          this.SpawnFakeIntroPlayer(index);
        if (index >= this.playerCount)
          return;
        if (this.players.Count < this.playerCount)
          this.GetPlayers();
        this.SpawnFakeIntroPlayer(index);
      }
    }

    private void SpawnFakeIntroPlayer(int index)
    {
      this.championViews[index].championView.transform.position = this.championViews[index].spawnPoint.position;
      this.championViews[index].championView.transform.rotation = this.championViews[index].spawnPoint.rotation;
      this.championViews[index].championView.SetActive(true);
      this.championViews[index].ChampionSpawnView.RespawnPlayerEffect();
      this.championViews[index].championAnimator.SetTrigger("intro");
      this.championViews[index].championAnimator.SetInteger("champIntro", 1);
    }

    private void DisableAllPlayerRenderers()
    {
      foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities())
      {
        Player component = entity.unityView.gameObject.GetComponent<Player>();
        component.ViewContainer.SetActive(false);
        component.FloorUI.gameObject.SetActive(false);
      }
    }

    private void DisableAllIntroPlayerRenderers()
    {
      foreach (FakeChampionView championView in this.championViews)
        championView.championView.SetActive(false);
    }

    private void GetPlayers()
    {
      this.players = new List<GameEntity>();
      foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.Player).GetEntities())
        this.players.Add(entity);
      this.players.Sort((Comparison<GameEntity>) ((a, b) => a.playerTeam.value - b.playerTeam.value));
      this.GetComponent<Animator>().SetInteger("NumPlayers", this.playerCount);
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

    [EditorButton]
    private void FullIntro()
    {
      foreach (FakeChampionView championView in this.championViews)
        championView.championView.SetActive(false);
      this.cameraAnimator.SetTrigger("fullIntro");
    }

    [EditorButton]
    private void PresentTeams()
    {
      foreach (FakeChampionView championView in this.championViews)
        championView.championView.SetActive(false);
      this.cameraAnimator.SetTrigger("playIntros");
    }

    [EditorButton]
    private void LoopPresentTeams1()
    {
      this.cameraAnimator.SetBool("loopPresentTeam01", false);
      this.cameraAnimator.SetBool("loopPresentTeam02", false);
      this.cameraAnimator.SetBool("loopPresentTeam01", true);
    }

    [EditorButton]
    private void LoopPresentTeams2()
    {
      this.cameraAnimator.SetBool("loopPresentTeam01", false);
      this.cameraAnimator.SetBool("loopPresentTeam02", false);
      this.cameraAnimator.SetBool("loopPresentTeam02", true);
    }
  }
}
