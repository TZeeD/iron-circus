// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MatchFlow.ParticipatingPlayersUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.UI.MatchFlow
{
  public class ParticipatingPlayersUi : MonoBehaviour
  {
    [SerializeField]
    private GameObject playerPrefab;
    [SerializeField]
    private Transform teamAlphaParent;
    [SerializeField]
    private Transform teamBetaParent;
    private Dictionary<ulong, ParticipatingPlayer> players = new Dictionary<ulong, ParticipatingPlayer>();
    private Team localPlayerTeam;

    private void Start() => Events.Global.OnEventPlayerDeath += new Events.EventPlayerDeath(this.OnPlayerDeath);

    private void OnPlayerDeath(ulong playerId, ulong instigatorPlayerId, float respawnDuration)
    {
      if (!this.players.ContainsKey(playerId))
        return;
      this.players[playerId].MarkPlayerDead(respawnDuration);
    }

    private void OnDestroy() => Events.Global.OnEventPlayerDeath -= new Events.EventPlayerDeath(this.OnPlayerDeath);

    public void CreatePlayerAvatars(GameEntity player, Team localTeam)
    {
      if (player.playerTeam.value == Team.Alpha)
      {
        this.CreatePlayerAvatarForTeamAlpha(player, localTeam);
      }
      else
      {
        if (player.playerTeam.value != Team.Beta)
          return;
        this.CreatePlayerAvatarForTeamBeta(player, localTeam);
      }
    }

    private void CreatePlayerAvatarForTeamAlpha(GameEntity player, Team localTeam)
    {
      GameObject avatarGameObject = this.CreateAvatarGameObject();
      avatarGameObject.transform.SetParent(this.teamAlphaParent, false);
      ParticipatingPlayer component = avatarGameObject.GetComponent<ParticipatingPlayer>();
      component.InitializePlayerUi(player.playerTeam.value, player.championConfig.value, localTeam);
      this.players.Add(player.playerId.value, component);
      this.UpdatePlayerVoiceChatIcon(avatarGameObject, player);
    }

    private void CreatePlayerAvatarForTeamBeta(GameEntity player, Team localTeam)
    {
      GameObject avatarGameObject = this.CreateAvatarGameObject();
      avatarGameObject.transform.SetParent(this.teamBetaParent, false);
      ParticipatingPlayer component = avatarGameObject.GetComponent<ParticipatingPlayer>();
      component.InitializePlayerUi(player.playerTeam.value, player.championConfig.value, localTeam);
      this.players.Add(player.playerId.value, component);
      this.UpdatePlayerVoiceChatIcon(avatarGameObject, player);
    }

    private void UpdatePlayerVoiceChatIcon(GameObject playerAvatar, GameEntity player)
    {
      playerAvatar.GetComponentInChildren<VoiceChatMuteButton>().SetPlayerID(player.playerId.value);
      playerAvatar.GetComponentInChildren<VoiceChatMuteButton>().UpdateButtonVisibility();
    }

    private GameObject CreateAvatarGameObject()
    {
      GameObject gameObject = Object.Instantiate<GameObject>(this.playerPrefab);
      gameObject.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
      return gameObject;
    }

    public void SetLocalPlayerTeam(Team team) => this.localPlayerTeam = team;

    public void ResetPlayerUI()
    {
      foreach (KeyValuePair<ulong, ParticipatingPlayer> player in this.players)
        player.Value.MarkPlayerAlive();
    }

    public void UpdateSkillUIForTeamPlayer(GameEntity player)
    {
      if (this.localPlayerTeam == Team.None || this.localPlayerTeam != player.playerTeam.value || !this.players.ContainsKey(player.playerId.value))
        return;
      ParticipatingPlayer player1 = this.players[player.playerId.value];
      foreach (SkillUiStateData skillUiState in player.skillUi.skillUiStates)
      {
        switch (skillUiState.buttonType)
        {
          case Imi.SharedWithServer.ScEntitas.Components.ButtonType.PrimarySkill:
            player1.SetPrimarySkillState((double) skillUiState.fillAmount >= 1.0);
            continue;
          case Imi.SharedWithServer.ScEntitas.Components.ButtonType.SecondarySkill:
            player1.SetSecondarySkillState((double) skillUiState.fillAmount >= 1.0);
            continue;
          default:
            continue;
        }
      }
    }
  }
}
