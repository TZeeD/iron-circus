// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.PartyService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.UI.Popups;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Core.Services
{
  public class PartyService : APartyService
  {
    private AGroup groupProvider;
    private Dictionary<ulong, APartyService.GroupMember> groupMembers = new Dictionary<ulong, APartyService.GroupMember>();
    private ulong ownPlayerId;
    private bool isInGroup;
    private bool isCustomMatchGroup;
    private bool isGroupCreationPending;

    public PartyService(AGroup groupProvider)
    {
      this.groupProvider = groupProvider;
      ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      groupProvider.OnGroupEntered += new AGroup.GroupEnteredEventHandler(this.OnGroupProviderEntered);
      groupProvider.OnGroupLeft += new AGroup.GroupLeftEventHandler(this.OnGroupProviderLeft);
      groupProvider.OnGroupMemberJoined += new AGroup.GroupMemberJoinedEventHandler(this.OnGroupProviderMemberJoined);
      groupProvider.OnGroupMemberLeft += new AGroup.GroupMemberLeftEventHandler(this.OnGroupProviderMemberLeft);
      groupProvider.OnGroupLobbyOwnerChanged += new AGroup.GroupLobbyOwnerChangedEventHandler(this.OnGroupProviderLobbyOwnerChanged);
      groupProvider.OnGroupChatMessage += new AGroup.GroupChatMessageEventHandler(this.OnGroupProviderChatMessage);
      groupProvider.OnGroupMatchmaking += new AGroup.GroupMatchmakingEventHandler(this.OnGroupProviderMatchmaking);
      groupProvider.OnGroupMatchmakingCanceled += new AGroup.GroupMatchmakingCanceledEventHandler(this.OnGroupProviderMatchmakingCanceled);
      groupProvider.OnGroupCustomMatchLobbyUpdate += new AGroup.GroupCustomMatchLobbyUpdateEventHandler(this.OnGroupProviderCustomMatchLobbyUpdate);
      groupProvider.OnGroupCustomMatchLobbyIsReady += new AGroup.GroupCustomMatchLobbyIsReadyEventHandler(this.OnGroupCustomMatchLobbyReady);
      groupProvider.OnPlayerKick += new AGroup.OnPlayerKickEventHandler(this.OnPlayerWasKicked);
      groupProvider.OnGroupLeftEndScreen += new AGroup.OnGroupLeftEndScreenEventHandler(this.OnGroupProviderLeftEndScreen);
      groupProvider.OnError += new AGroup.OnErrorEventHandler(this.OnError);
      groupProvider.OnRequestGroupMatchmaking += new AGroup.OnRequestGroupMatchmakingHandler(this.OnRequestGroupMatchmaking);
      groupProvider.OnAckGroupMatchmaking += new AGroup.OnAckGroupMatchmakingHandler(this.OnAckGroupMatchmaking);
    }

    private void OnAckGroupMatchmaking(ulong playerId, JObject latencies) => ImiServices.Instance.MatchmakingService.OnGroupMemberConnectionAck(playerId, latencies);

    private void OnRequestGroupMatchmaking() => ImiServices.Instance.MatchmakingService.OnGroupConnection();

    private void OnError(string errormsg)
    {
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("Group does not work now.", "OK", title: "GroupInfo!"), new Action(PopupManager.Instance.ButtonAction1), new Action(PopupManager.Instance.ButtonAction2), (Action) null, (Action) null, (Selectable) null);
      if (!this.isInGroup)
        return;
      this.LeaveGroup();
    }

    private void OnGroupProviderMatchmaking(string gameliftkey, string matchmakerRegion) => this.RaiseOnGroupMatchmakingStarted(gameliftkey, matchmakerRegion);

    private void OnGroupProviderMatchmakingCanceled(string gameliftkey, string matchmakerRegion) => this.RaiseOnGroupMatchmakingCanceled(gameliftkey, matchmakerRegion);

    private void OnGroupProviderCustomMatchLobbyUpdate(JObject lobbyData) => this.RaiseOnGroupCustomMatchLobbyUpdate(lobbyData);

    private void OnGroupCustomMatchLobbyReady(ulong steamId, JObject readydata) => this.RaiseOnGroupCustomMatchLobbyIsReady(steamId, readydata);

    private void OnPlayerWasKicked(ulong playerId) => this.RaiseOnPlayerKick(playerId);

    private void OnGroupProviderLobbyOwnerChanged(ulong playerId) => this.RaiseOnGroupLobbyOwnerChanged(playerId);

    private void OnGroupProviderLeftEndScreen(string msg) => this.RaiseOnGroupLeftEndScreen(msg);

    private void OnGroupProviderChatMessage(ulong playerId, string msg)
    {
      if (!this.groupMembers.ContainsKey(playerId))
        return;
      this.RaiseOnChatMessageReceived(playerId, this.groupMembers[playerId].username, msg);
    }

    private void OnMetaLoginSuccessful(ulong playerId)
    {
      this.ownPlayerId = playerId;
      this.groupProvider.SetOwnPlayerId(this.ownPlayerId);
      this.groupProvider.CheckForStartupArgs();
    }

    private void OnGroupProviderMemberJoined(ulong playerid, CSteamID steamId, string username)
    {
      if (this.groupMembers.ContainsKey(playerid))
        return;
      APartyService.GroupMember groupMember = new APartyService.GroupMember(playerid, steamId, username);
      this.groupMembers[playerid] = groupMember;
      this.RaiseOnGroupMemberJoined(groupMember);
    }

    private void OnGroupProviderMemberLeft(ulong playerid)
    {
      if (!this.groupMembers.ContainsKey(playerid))
        return;
      APartyService.GroupMember groupMember = this.groupMembers[playerid];
      this.groupMembers.Remove(playerid);
      this.RaiseOnGroupMemberLeft(groupMember);
    }

    private void OnGroupProviderLeft()
    {
      this.groupMembers.Clear();
      this.isInGroup = false;
      this.RaiseOnGroupLeft();
    }

    private void OnGroupProviderEntered()
    {
      if (this.ownPlayerId == 0UL && ImiServices.Instance.LoginService.IsLoginOk())
      {
        this.ownPlayerId = ImiServices.Instance.LoginService.GetPlayerId();
        this.groupProvider.SetOwnPlayerId(this.ownPlayerId);
      }
      this.groupMembers[this.ownPlayerId] = new APartyService.GroupMember(this.ownPlayerId, SteamUser.GetSteamID(), ImiServices.Instance.LoginService.GetUsername());
      this.isInGroup = true;
      this.isCustomMatchGroup = CustomLobbyUi.isInitialized;
      this.RaiseOnGroupEntered();
      if (!this.isGroupCreationPending)
        return;
      if (!CustomLobbyUi.isInitialized)
        this.ShowInviteUi();
      this.isGroupCreationPending = false;
    }

    public override void ShowInviteUi() => this.groupProvider.ShowGroupInviteDialog();

    public override bool IsInGroup() => this.isInGroup;

    public override bool IsCustomMatchGroup() => this.isCustomMatchGroup;

    public override void LeaveGroup() => this.groupProvider.LeaveGroup();

    public override ulong GetGroupOwner() => this.groupProvider.GetGroupOwner();

    public override bool IsGroupOwner() => (long) this.GetGroupOwner() == (long) ImiServices.Instance.LoginService.GetPlayerId();

    public override CSteamID GetLobbyId() => this.groupProvider.GetLobbyId();

    public override int GetLobbyMemberLimit() => this.groupProvider.GetLobbyMemberLimit();

    public override List<APartyService.GroupMember> GetCurrentGroup() => this.groupMembers.Values.ToList<APartyService.GroupMember>();

    public override APartyService.GroupMember GetGroupMember(ulong playerId) => this.groupMembers.ContainsKey(playerId) ? this.groupMembers[playerId] : throw new ImiException(string.Format("Player with playerId {0} is not in Group!", (object) playerId));

    public override int GetAvatarItemId(ulong groupMemberId) => this.groupMembers.ContainsKey(groupMemberId) ? this.groupMembers[groupMemberId].playerAvatarItemId : -1;

    public override void SetAvatarItemId(ulong groupMemberId, int avatarId)
    {
      if (!this.groupMembers.ContainsKey(groupMemberId))
        return;
      this.groupMembers[groupMemberId].playerAvatarItemId = avatarId;
    }

    public override APartyService.GroupMember GetGroupMemberViaSteamId(ulong steamId)
    {
      foreach (KeyValuePair<ulong, APartyService.GroupMember> groupMember in this.groupMembers)
      {
        if (groupMember.Value.steamId == (CSteamID) steamId)
          return groupMember.Value;
      }
      throw new ImiException(string.Format("Player with steamId {0} is not in Group!", (object) steamId));
    }

    public override List<ulong> GetCurrentGroupPlayerIds() => this.groupMembers.Keys.ToList<ulong>();

    public override void CreateGroup(int groupSize, ELobbyType lobbyType)
    {
      if (this.isInGroup)
      {
        Log.Debug("Can't create group. Leave before.");
      }
      else
      {
        this.isGroupCreationPending = true;
        this.groupProvider.CreateGroup(groupSize, lobbyType);
      }
    }

    public override void SetLobbyOwner(CSteamID newLobbyOwner) => this.groupProvider.SetLobbyOwner(newLobbyOwner);

    public override void ResizeLobby(int groupSize) => this.groupProvider.ResizeLobby(groupSize);

    public override void ChangeLobbyType(ELobbyType lobbyType) => this.groupProvider.ChangeLobbyType(lobbyType);

    public override void SendMessage(string msg)
    {
      if (!this.isInGroup)
        return;
      this.groupProvider.SendChatMessage(msg);
      Log.Api("Sending random message internal");
    }

    public override void NotifyGroupMatchmaking(string ticketId, string matchmakerRegion)
    {
      if (!this.isInGroup || ImiServices.Instance.MatchmakingService.GetMatchmakingV2().GetState().hasEverBeenExecuted)
        return;
      string ascii = "--start-matchmaking " + ticketId + " " + matchmakerRegion;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyRequestGroupMatchmaking()
    {
      if (!this.isInGroup)
        return;
      string ascii = "--request-group-matchmaking";
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyAckGroupMatchmaking(ulong playerId, JObject latencies)
    {
      if (!this.isInGroup)
        return;
      string ascii = "--ack-group-matchmaking " + (object) playerId + " " + latencies.ToString();
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupToJoinGame(string playerSessions)
    {
      if (!this.isInGroup || ImiServices.Instance.MatchmakingService.GetMatchmakingV2().GetState().hasEverBeenExecuted)
        return;
      string ascii = "--join-game " + playerSessions;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupToJoinCustomGame(string playerSessions)
    {
      if (!this.isInGroup)
        return;
      string ascii = "--join-custom-game " + playerSessions;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupCustomGameLobbyUpdated(string lobbyData)
    {
      if (!this.isInGroup)
        return;
      string ascii = "--custom-game-lobby-update " + lobbyData;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupCustomGameLobbyIsReady(string readyData)
    {
      if (!this.isInGroup)
        return;
      string ascii = "--custom-game-lobby-ready " + readyData;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupMatchmakingCancelled(string ticketId, string matchmakerRegion)
    {
      if (!this.isInGroup)
        return;
      string ascii = "--stop-matchmaking " + ticketId + " " + matchmakerRegion;
      Debug.Log((object) ascii);
      this.groupProvider.SendChatMessage(ascii);
    }

    public override void NotifyGroupKickPlayer(ulong playerId)
    {
      if (!this.isInGroup)
        return;
      this.groupProvider.SendChatMessage("--kick " + (object) playerId);
    }

    public override void NotifyGroupLeaveEndScreen()
    {
      if (!this.isInGroup)
        return;
      this.groupProvider.SendChatMessage("++leaveEndScreen");
    }
  }
}
