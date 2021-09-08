// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.APartyService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Newtonsoft.Json.Linq;
using Steamworks;
using System;
using System.Collections.Generic;

namespace SteelCircus.Core.Services
{
  public abstract class APartyService
  {
    public event APartyService.OnGroupEnteredEventHandler OnGroupEntered;

    public event APartyService.OnGroupMemberJoinedEventHandler OnGroupMemberJoined;

    public event APartyService.OnGroupMemberLeftEventHandler OnGroupMemberLeft;

    public event APartyService.OnGroupLeftEventHandler OnGroupLeft;

    public event APartyService.OnChatMessageReceivedEventHandler OnChatMessageReceived;

    public event APartyService.OnGroupMatchmakingStartedEventHandler OnGroupMatchmakingStarted;

    public event APartyService.OnGroupMatchmakingCanceledEventHandler OnGroupMatchmakingCanceled;

    public event APartyService.GroupCustomMatchLobbyUpdateEventHandler OnGroupCustomMatchLobbyUpdate;

    public event APartyService.GroupCustomMatchLobbyIsReadyEventHandler OnGroupCustomMatchLobbyIsReady;

    public event APartyService.OnGroupLeftEndScreenEventHandler OnGroupLeftEndScreen;

    public event APartyService.OnPlayerKickEventHandler OnPlayerKick;

    public event APartyService.OnGroupLobbyOwnerChangedEventHandler OnGroupLobbyOwnerChanged;

    public event APartyService.OnCustomLobbyEnteredEventHandler OnCustomLobbyEntered;

    public event APartyService.OnCustomLobbyLeftEventHandler OnCustomLobbyLeft;

    protected void RaiseOnGroupEntered()
    {
      APartyService.OnGroupEnteredEventHandler onGroupEntered = this.OnGroupEntered;
      if (onGroupEntered == null)
        return;
      onGroupEntered();
    }

    protected void RaiseOnGroupMemberJoined(APartyService.GroupMember groupMember)
    {
      APartyService.OnGroupMemberJoinedEventHandler groupMemberJoined = this.OnGroupMemberJoined;
      if (groupMemberJoined == null)
        return;
      groupMemberJoined(groupMember);
    }

    protected void RaiseOnGroupMemberLeft(APartyService.GroupMember groupMember)
    {
      APartyService.OnGroupMemberLeftEventHandler onGroupMemberLeft = this.OnGroupMemberLeft;
      if (onGroupMemberLeft == null)
        return;
      onGroupMemberLeft(groupMember);
    }

    protected void RaiseOnChatMessageReceived(ulong playerId, string username, string message)
    {
      APartyService.OnChatMessageReceivedEventHandler chatMessageReceived = this.OnChatMessageReceived;
      if (chatMessageReceived == null)
        return;
      chatMessageReceived(playerId, username, message);
    }

    protected void RaiseOnGroupLeft()
    {
      APartyService.OnGroupLeftEventHandler onGroupLeft = this.OnGroupLeft;
      if (onGroupLeft == null)
        return;
      onGroupLeft();
    }

    protected void RaiseOnGroupMatchmakingStarted(string gameliftKey, string matchmakerRegion)
    {
      APartyService.OnGroupMatchmakingStartedEventHandler matchmakingStarted = this.OnGroupMatchmakingStarted;
      if (matchmakingStarted == null)
        return;
      matchmakingStarted(gameliftKey, matchmakerRegion);
    }

    protected void RaiseOnGroupMatchmakingCanceled(string gameliftKey, string matchmakerRegion)
    {
      APartyService.OnGroupMatchmakingCanceledEventHandler matchmakingCanceled = this.OnGroupMatchmakingCanceled;
      if (matchmakingCanceled == null)
        return;
      matchmakingCanceled(gameliftKey, matchmakerRegion);
    }

    protected void RaiseOnGroupCustomMatchLobbyUpdate(JObject lobbyData)
    {
      APartyService.GroupCustomMatchLobbyUpdateEventHandler matchLobbyUpdate = this.OnGroupCustomMatchLobbyUpdate;
      if (matchLobbyUpdate == null)
        return;
      matchLobbyUpdate(lobbyData);
    }

    protected void RaiseOnGroupCustomMatchLobbyIsReady(ulong steamId, JObject readyData)
    {
      APartyService.GroupCustomMatchLobbyIsReadyEventHandler matchLobbyIsReady = this.OnGroupCustomMatchLobbyIsReady;
      if (matchLobbyIsReady == null)
        return;
      matchLobbyIsReady(steamId, readyData);
    }

    protected void RaiseOnGroupLobbyOwnerChanged(ulong playerId)
    {
      APartyService.OnGroupLobbyOwnerChangedEventHandler lobbyOwnerChanged = this.OnGroupLobbyOwnerChanged;
      if (lobbyOwnerChanged == null)
        return;
      lobbyOwnerChanged(playerId);
    }

    protected void RaiseOnPlayerKick(ulong playerId)
    {
      APartyService.OnPlayerKickEventHandler onPlayerKick = this.OnPlayerKick;
      if (onPlayerKick == null)
        return;
      onPlayerKick(playerId);
    }

    protected void RaiseOnGroupLeftEndScreen(string msg)
    {
      APartyService.OnGroupLeftEndScreenEventHandler groupLeftEndScreen = this.OnGroupLeftEndScreen;
      if (groupLeftEndScreen == null)
        return;
      groupLeftEndScreen(msg);
    }

    public void RaiseOnCustomLobbyEntered()
    {
      APartyService.OnCustomLobbyEnteredEventHandler customLobbyEntered = this.OnCustomLobbyEntered;
      if (customLobbyEntered == null)
        return;
      customLobbyEntered();
    }

    public void RaiseOnCustomLobbyLeft()
    {
      APartyService.OnCustomLobbyLeftEventHandler onCustomLobbyLeft = this.OnCustomLobbyLeft;
      if (onCustomLobbyLeft == null)
        return;
      onCustomLobbyLeft();
    }

    public abstract void ShowInviteUi();

    public abstract bool IsInGroup();

    public abstract void LeaveGroup();

    public abstract ulong GetGroupOwner();

    public abstract List<APartyService.GroupMember> GetCurrentGroup();

    public abstract void CreateGroup(int groupSize, ELobbyType lobbyType);

    public abstract void SendMessage(string msg);

    public abstract void NotifyGroupMatchmaking(string gameliftkey, string matchmakerRegion);

    public abstract void NotifyGroupMatchmakingCancelled(
      string gameliftkey,
      string matchmakerRegion);

    public abstract void NotifyGroupLeaveEndScreen();

    public abstract List<ulong> GetCurrentGroupPlayerIds();

    public abstract void NotifyGroupToJoinGame(string playerSessions);

    public abstract APartyService.GroupMember GetGroupMember(ulong playerId);

    public abstract int GetAvatarItemId(ulong groupMemberId);

    public abstract void SetAvatarItemId(ulong groupMemberId, int avatarId);

    public abstract APartyService.GroupMember GetGroupMemberViaSteamId(ulong steamId);

    public abstract void NotifyGroupToJoinCustomGame(string playerSessions);

    public abstract CSteamID GetLobbyId();

    public abstract int GetLobbyMemberLimit();

    public abstract void ResizeLobby(int groupSize);

    public abstract void ChangeLobbyType(ELobbyType lobbyType);

    public abstract void SetLobbyOwner(CSteamID newLobbyOwner);

    public abstract void NotifyGroupCustomGameLobbyUpdated(string lobbyData);

    public abstract void NotifyGroupCustomGameLobbyIsReady(string readyData);

    public abstract bool IsCustomMatchGroup();

    public abstract bool IsGroupOwner();

    public abstract void NotifyGroupKickPlayer(ulong playerId);

    public abstract void NotifyRequestGroupMatchmaking();

    public abstract void NotifyAckGroupMatchmaking(ulong playerId, JObject latencies);

    [Serializable]
    public class GroupMember
    {
      public ulong playerId;
      public string username;
      public CSteamID steamId;
      public Team team;
      public string level;
      public bool isCustomLobbyReady;
      public int playerAvatarItemId;

      public GroupMember(ulong playerId, CSteamID steamId, string username)
      {
        this.playerId = playerId;
        this.username = username;
        this.steamId = steamId;
        this.level = "?";
        this.team = Team.None;
        this.isCustomLobbyReady = false;
        this.playerAvatarItemId = -1;
      }
    }

    public delegate void OnGroupEnteredEventHandler();

    public delegate void OnGroupMemberLeftEventHandler(APartyService.GroupMember groupMember);

    public delegate void OnGroupMemberJoinedEventHandler(APartyService.GroupMember groupMember);

    public delegate void OnGroupLeftEventHandler();

    public delegate void OnChatMessageReceivedEventHandler(
      ulong playerId,
      string username,
      string message);

    public delegate void OnGroupMatchmakingStartedEventHandler(
      string gameliftKey,
      string matchmakerRegion);

    public delegate void OnGroupMatchmakingCanceledEventHandler(
      string gameliftKey,
      string matchmakerRegion);

    public delegate void GroupCustomMatchLobbyUpdateEventHandler(JObject lobbyData);

    public delegate void GroupCustomMatchLobbyIsReadyEventHandler(ulong steamId, JObject readyData);

    public delegate void OnGroupLeftEndScreenEventHandler(string msg);

    public delegate void OnPlayerKickEventHandler(ulong playerId);

    public delegate void OnGroupLobbyOwnerChangedEventHandler(ulong playerId);

    public delegate void OnCustomLobbyEnteredEventHandler();

    public delegate void OnCustomLobbyLeftEventHandler();
  }
}
