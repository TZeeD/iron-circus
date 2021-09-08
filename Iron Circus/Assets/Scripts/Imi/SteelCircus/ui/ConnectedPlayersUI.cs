// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.ConnectedPlayersUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.Utils;
using SharedWithServer.ScEvents;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI
{
  public class ConnectedPlayersUI : MonoBehaviourWithSetup
  {
    public GridLayoutGroup team1Grid;
    public GridLayoutGroup team2Grid;
    public GridLayoutGroup teamNoneGrid;
    public Text team1Header;
    public Text team2Header;
    public TeamMemberUI teamMemberPrefab;
    public ChampionConfig[] configList;
    public ColorsConfig colors;
    public Button readyButton;
    private Dictionary<Team, Dictionary<ulong, TeamMemberUI>> teams = new Dictionary<Team, Dictionary<ulong, TeamMemberUI>>();
    private Dictionary<ulong, Team> playerIdToTeam = new Dictionary<ulong, Team>();
    private float timeStamp;

    private void Start()
    {
      this.teams.Add(Team.None, new Dictionary<ulong, TeamMemberUI>());
      this.teams.Add(Team.Alpha, new Dictionary<ulong, TeamMemberUI>());
      this.teams.Add(Team.Beta, new Dictionary<ulong, TeamMemberUI>());
      this.team1Header.color = this.colors.team1ColorLight;
      this.team2Header.color = this.colors.team2ColorLight;
    }

    private Transform GetTeamTransform(Team team)
    {
      switch (team)
      {
        case Team.None:
          return this.teamNoneGrid.transform;
        case Team.Alpha:
          return this.team1Grid.transform;
        case Team.Beta:
          return this.team2Grid.transform;
        default:
          throw new InvalidOperationException();
      }
    }

    public void Update()
    {
      if ((double) this.timeStamp + 0.5 >= (double) Time.realtimeSinceStartup)
        return;
      foreach (GameEntity entity in Contexts.sharedInstance.game.GetGroup(GameMatcher.PlayerChampionData).GetEntities())
        this.ChangeEntry(entity.playerId.value, entity.playerChampionData.value);
      this.UpdateReadyButton();
      this.timeStamp = Time.realtimeSinceStartup;
    }

    public void ChangeEntry(ulong playerId, PlayerChampionData data)
    {
      if (this.teams[data.team].ContainsKey(playerId))
      {
        this.teams[data.team][playerId].SetData(this.GetConfigForChampType(data.type), data.team);
      }
      else
      {
        this.RemoveEntry(playerId);
        this.AddEntry(playerId, data);
      }
    }

    public void AddEntry(ulong playerId, PlayerChampionData data)
    {
      Team team = data.team;
      this.teams[team][playerId] = UnityEngine.Object.Instantiate<TeamMemberUI>(this.teamMemberPrefab, this.GetTeamTransform(team));
      ChampionType type = data.type;
      this.playerIdToTeam[playerId] = team;
      ChampionConfig configForChampType = this.GetConfigForChampType(type);
      if (Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId).hasPlayerUsername)
        this.teams[team][playerId].setUsername(Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId).playerUsername.username);
      else
        this.teams[team][playerId].setUsername("NO USERNAME");
      this.teams[team][playerId].SetData(configForChampType, team);
    }

    public void RemoveEntry(ulong playerId)
    {
      if (!this.playerIdToTeam.ContainsKey(playerId))
        return;
      Team key = this.playerIdToTeam[playerId];
      UnityEngine.Object.Destroy((UnityEngine.Object) this.teams[key][playerId].gameObject);
      this.teams[key].Remove(playerId);
      this.playerIdToTeam.Remove(playerId);
    }

    private ChampionConfig GetConfigForChampType(ChampionType champType)
    {
      foreach (ChampionConfig config in this.configList)
      {
        if (config.championType == champType)
          return config;
      }
      Debug.LogError((object) string.Format("No ChampionConfig found for type '{0}'! Did you forget to set one in the list of the ConnectedPlayersUI?", (object) champType), (UnityEngine.Object) this.gameObject);
      return (ChampionConfig) null;
    }

    public void StartReadyCoroutine(float time)
    {
      Log.Debug(string.Format("StartReadyCoroutine started {0}", (object) this));
      this.StartCoroutine(this.ReadyCoroutine(time));
    }

    private IEnumerator ReadyCoroutine(float time)
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      ConnectedPlayersUI connectedPlayersUi = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        Events.Global.FireEventChampionSelectionReady();
        Log.Debug(string.Format("ChampionSelectionReadyEvent {0}", (object) connectedPlayersUi));
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) new WaitForSeconds(time);
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    public void IsReadyClicked() => Events.Global.FireEventChampionSelectionReady();

    private void UpdateReadyButton(bool forceEnable = false)
    {
      if (Contexts.sharedInstance.game.HasLocalEntity())
      {
        PlayerChampionData playerChampionData = Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value;
        bool flag = forceEnable || playerChampionData.type != ChampionType.Invalid && (uint) playerChampionData.team > 0U;
        this.readyButton.interactable = flag;
        if (!flag)
          return;
        this.readyButton.Select();
      }
      else
        Debug.Log((object) "No Local Entity found");
    }

    private void OnEnable() => AudioController.PlayMusic("MusicLobby");
  }
}
