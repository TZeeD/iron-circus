// Decompiled with JetBrains decompiler
// Type: PlayerUiController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SharedWithServer.ScEvents.StatEvents;
using Imi.SteelCircus.GameElements;
using SharedWithServer.ScEvents;
using SteelCircus.UI.MatchFlow;
using SteelCircus.UI.SkillInfo;
using System;
using System.Collections.Generic;
using UnityEngine;

public class PlayerUiController : MonoBehaviour
{
  [SerializeField]
  private GameObject skillHUDPrefab;
  [SerializeField]
  private GameObject participatingPlayersUiPrefab;
  public GameObject playerHUDprefab;
  private Dictionary<ulong, Player> players;
  private Dictionary<ulong, PlayerUiController.PlayerUiObjects> playerUIs;
  private IGroup<GameEntity> skillUientities;
  private SkillHud skillHud;
  private ParticipatingPlayersUi participatingPlayersUi;
  private bool introDone;

  private void Start()
  {
    this.players = new Dictionary<ulong, Player>();
    this.playerUIs = new Dictionary<ulong, PlayerUiController.PlayerUiObjects>();
    this.skillUientities = Contexts.sharedInstance.game.GetGroup(GameMatcher.SkillUi);
    this.InstantiateParticipatingPlayersUi();
    foreach (Player playerView in Player.playerViews)
      this.Init(playerView);
    Player.onPlayerStart += new Action<Player>(this.Init);
    Player.onPlayerDestroy += new Action<Player>(this.OnPlayerDestroy);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChanged);
    Events.Global.OnEventPlayerHealthChanged += new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
    Events.Global.OnEventShowHidePlayerUi += new Events.EventShowHidePlayerUi(this.OnShowHideEvent);
    this.InstantiateSkillHUD();
  }

  private void InstantiateSkillHUD()
  {
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.skillHUDPrefab, this.transform, true);
    this.skillHud = gameObject.GetComponent<SkillHud>();
    gameObject.SetActive(false);
    RectTransform component = gameObject.GetComponent<RectTransform>();
    component.localPosition = new Vector3(0.0f, -495f, 0.0f);
    component.localScale = new Vector3(1f, 1f, 1f);
  }

  private void InstantiateParticipatingPlayersUi()
  {
    GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.participatingPlayersUiPrefab, this.transform, true);
    this.participatingPlayersUi = gameObject.GetComponent<ParticipatingPlayersUi>();
    gameObject.SetActive(false);
    RectTransform component = gameObject.GetComponent<RectTransform>();
    component.localPosition = new Vector3(0.0f, 490f, 0.0f);
    component.localScale = new Vector3(1f, 1f, 1f);
  }

  private void OnDestroy()
  {
    Player.onPlayerStart -= new Action<Player>(this.Init);
    Player.onPlayerDestroy -= new Action<Player>(this.OnPlayerDestroy);
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChanged);
    Events.Global.OnEventPlayerHealthChanged -= new Events.EventPlayerHealthChanged(this.OnPlayerHealthChanged);
    Events.Global.OnEventShowHidePlayerUi -= new Events.EventShowHidePlayerUi(this.OnShowHideEvent);
  }

  private void Update()
  {
    foreach (GameEntity skillUientity in this.skillUientities)
      this.UpdateSkillUi(skillUientity);
  }

  private void UpdateSkillUi(GameEntity player)
  {
    if (player.isLocalEntity)
    {
      foreach (SkillUiStateData skillUiState in player.skillUi.skillUiStates)
        this.skillHud.UpdateUi(skillUiState, player);
    }
    this.participatingPlayersUi.UpdateSkillUIForTeamPlayer(player);
  }

  private void OnShowHideEvent(ulong playerId, bool showFloorUi, bool showOverhead) => this.SetPlayerUiActive(playerId, showOverhead);

  private void Init(Player player)
  {
    if (!this.players.ContainsKey(player.PlayerId))
      this.players.Add(player.PlayerId, player);
    Contexts.sharedInstance.meta.metaNetwork.value.ExecuteOnConnect((Action) (() => this.InitWithPlayerId(player.PlayerId)));
  }

  private void OnPlayerHealthChanged(
    ulong playerId,
    int oldHealth,
    int currentHealth,
    int maxHealth,
    bool isDead)
  {
    this.SetPlayerUiActive(playerId, !isDead && this.introDone);
    if (!this.GetPlayerEntity(playerId).isLocalEntity)
      return;
    this.skillHud.SetHealth(currentHealth, maxHealth);
  }

  private void OnGameStateChanged(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    this.SetUiActive(matchState);
    if (matchState == Imi.SharedWithServer.Game.MatchState.Intro)
    {
      GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
      this.skillHud.InitializeChampionHealthPoints(firstLocalEntity.championConfig.value, firstLocalEntity.playerHealth.value);
      this.skillHud.InitializeChampionSkills(firstLocalEntity.championConfig.value);
      GameEntity[] entities = Contexts.sharedInstance.game.GetGroup(GameMatcher.PlayerId).GetEntities();
      this.participatingPlayersUi.SetLocalPlayerTeam(firstLocalEntity.playerTeam.value);
      foreach (GameEntity player in entities)
        this.participatingPlayersUi.CreatePlayerAvatars(player, firstLocalEntity.playerTeam.value);
    }
    if (matchState == Imi.SharedWithServer.Game.MatchState.GetReady)
      this.introDone = true;
    if (matchState == Imi.SharedWithServer.Game.MatchState.StartPoint)
      this.participatingPlayersUi.ResetPlayerUI();
    if (matchState == Imi.SharedWithServer.Game.MatchState.PointInProgress)
      this.participatingPlayersUi.gameObject.SetActive(true);
    if (matchState == Imi.SharedWithServer.Game.MatchState.Goal || matchState == Imi.SharedWithServer.Game.MatchState.MatchOver || matchState == Imi.SharedWithServer.Game.MatchState.VictoryPose)
      this.participatingPlayersUi.gameObject.SetActive(false);
    if (matchState != Imi.SharedWithServer.Game.MatchState.VictoryPose)
      return;
    Contexts.sharedInstance.game.GetGroup(GameMatcher.PlayerId).GetEntities();
  }

  private void OnPlayerDestroy(Player player) => this.RemovePlayerUi(player);

  private void RemovePlayerUi(Player player)
  {
    ulong playerId = player.PlayerId;
    if (this.players.ContainsKey(playerId))
      this.players.Remove(playerId);
    if (!this.playerUIs.ContainsKey(playerId))
      return;
    PlayerUiController.PlayerUiObjects playerUi = this.playerUIs[playerId];
    this.playerUIs.Remove(playerId);
    UnityEngine.Object.Destroy((UnityEngine.Object) playerUi.playerHud);
  }

  private void InitWithPlayerId(ulong playerId)
  {
    playerId = playerId != ulong.MaxValue ? playerId : 0UL;
    if (!this.players.ContainsKey(playerId))
      return;
    this.CreateUi(this.players[playerId]);
  }

  private void CreateUi(Player player)
  {
    ulong playerId = player.PlayerId;
    PlayerUiController.PlayerUiObjects playerUiObjects = new PlayerUiController.PlayerUiObjects()
    {
      playerHud = UnityEngine.Object.Instantiate<GameObject>(this.playerHUDprefab, this.transform, false)
    };
    playerUiObjects.playerHudScript = playerUiObjects.playerHud.GetComponent<ChampionOverheadUi>();
    this.playerUIs[playerId] = playerUiObjects;
    this.InitUi(player);
    this.SetPlayerUiActive(playerId, false);
  }

  private void InitUi(Player player) => this.playerUIs[player.PlayerId].playerHud.GetComponentInChildren<ChampionOverheadUi>(true).Init(player);

  private void SetUiActive(Imi.SharedWithServer.Game.MatchState matchState)
  {
    bool flag = matchState == Imi.SharedWithServer.Game.MatchState.PointInProgress || matchState == Imi.SharedWithServer.Game.MatchState.StartPoint || matchState == Imi.SharedWithServer.Game.MatchState.GetReady || matchState == Imi.SharedWithServer.Game.MatchState.VictoryPose;
    bool show = matchState == Imi.SharedWithServer.Game.MatchState.PointInProgress || matchState == Imi.SharedWithServer.Game.MatchState.StartPoint || matchState == Imi.SharedWithServer.Game.MatchState.GetReady;
    foreach (ulong key in this.players.Keys)
    {
      GameEntity playerEntity = this.GetPlayerEntity(key);
      if (playerEntity != null)
      {
        if (matchState == Imi.SharedWithServer.Game.MatchState.VictoryPose)
        {
          this.EnablePlayerHudForVictoryScreen(flag, key);
        }
        else
        {
          this.SetPlayerUiActive(key, flag);
          this.ShowSkillHud(playerEntity, show);
        }
      }
    }
  }

  private GameEntity GetPlayerEntity(ulong playerId) => Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);

  private void SetPlayerUiActive(ulong playerId, bool showUi)
  {
    if (!this.playerUIs.ContainsKey(playerId))
      return;
    this.playerUIs[playerId].playerHudScript.SetupUsernameFormatForIngame();
    GameEntity playerEntity = this.GetPlayerEntity(playerId);
    bool flag = playerEntity != null && playerEntity.hasUnityView && playerEntity.unityView.gameObject.activeSelf;
    this.EnablePlayerHud(showUi & flag, playerId);
  }

  private void ShowSkillHud(GameEntity player, bool show)
  {
    if (player == null || !player.isLocalEntity)
      return;
    this.skillHud.gameObject.SetActive(show);
  }

  private void EnablePlayerHudForVictoryScreen(bool active, ulong playerId)
  {
    if (TeamExtensions.GetMatchOutcomeForTeam(this.GetPlayerEntity(playerId).playerTeam.value).IsWin())
    {
      this.playerUIs[playerId].playerHud.SetActive(active);
      this.playerUIs[playerId].playerHudScript.DisablePlayerArrow();
      this.playerUIs[playerId].playerHudScript.SetupUsernameFormatForVictoryScreen((GameObject) null);
    }
    else
      this.playerUIs[playerId].playerHud.SetActive(false);
  }

  public void EnablePlayerHudForVictoryScreenFake(ulong playerId, GameObject newPlayerView)
  {
    if (TeamExtensions.GetMatchOutcomeForTeam(this.GetPlayerEntity(playerId).playerTeam.value).IsWin())
    {
      Log.Debug("Fake Victory: " + (object) playerId);
      this.playerUIs[playerId].playerHud.SetActive(true);
      this.playerUIs[playerId].playerHudScript.DisablePlayerArrow();
      this.playerUIs[playerId].playerHudScript.SetupUsernameFormatForVictoryScreen(newPlayerView);
    }
    else
      this.playerUIs[playerId].playerHud.SetActive(false);
  }

  private void EnablePlayerHud(bool active, ulong playerId) => this.playerUIs[playerId].playerHud.SetActive(active);

  private class PlayerUiObjects
  {
    public GameObject playerHud;
    public ChampionOverheadUi playerHudScript;
  }
}
