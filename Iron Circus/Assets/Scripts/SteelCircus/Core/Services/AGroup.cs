// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.AGroup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Newtonsoft.Json.Linq;
using Steamworks;

namespace SteelCircus.Core.Services
{
  public abstract class AGroup
  {
    public event AGroup.GroupEnteredEventHandler OnGroupEntered;

    public event AGroup.GroupMemberJoinedEventHandler OnGroupMemberJoined;

    public event AGroup.GroupMemberLeftEventHandler OnGroupMemberLeft;

    public event AGroup.GroupLobbyOwnerChangedEventHandler OnGroupLobbyOwnerChanged;

    public event AGroup.GroupLeftEventHandler OnGroupLeft;

    public event AGroup.GroupChatMessageEventHandler OnGroupChatMessage;

    public event AGroup.GroupMatchmakingEventHandler OnGroupMatchmaking;

    public event AGroup.GroupMatchmakingCanceledEventHandler OnGroupMatchmakingCanceled;

    public event AGroup.GroupCustomMatchLobbyUpdateEventHandler OnGroupCustomMatchLobbyUpdate;

    public event AGroup.GroupCustomMatchLobbyIsReadyEventHandler OnGroupCustomMatchLobbyIsReady;

    public event AGroup.OnErrorEventHandler OnError;

    public event AGroup.OnGroupLeftEndScreenEventHandler OnGroupLeftEndScreen;

    public event AGroup.OnPlayerKickEventHandler OnPlayerKick;

    public event AGroup.OnRequestGroupMatchmakingHandler OnRequestGroupMatchmaking;

    public event AGroup.OnAckGroupMatchmakingHandler OnAckGroupMatchmaking;

    protected void RaiseOnGroupEntered()
    {
      AGroup.GroupEnteredEventHandler onGroupEntered = this.OnGroupEntered;
      if (onGroupEntered == null)
        return;
      onGroupEntered();
    }

    protected void RaiseOnLobbyOwnerChanged(ulong playerId)
    {
      AGroup.GroupLobbyOwnerChangedEventHandler lobbyOwnerChanged = this.OnGroupLobbyOwnerChanged;
      if (lobbyOwnerChanged == null)
        return;
      lobbyOwnerChanged(playerId);
    }

    protected void RaiseOnGroupLeft()
    {
      AGroup.GroupLeftEventHandler onGroupLeft = this.OnGroupLeft;
      if (onGroupLeft == null)
        return;
      onGroupLeft();
    }

    protected void RaiseOnGroupMemberEntered(ulong playerId, CSteamID steamId, string username)
    {
      Log.Debug(string.Format("RaiseOnGroupMemberEntered: {0} {1}", (object) playerId, (object) username));
      AGroup.GroupMemberJoinedEventHandler groupMemberJoined = this.OnGroupMemberJoined;
      if (groupMemberJoined == null)
        return;
      groupMemberJoined(playerId, steamId, username);
    }

    protected void RaiseOnGroupMemberLeft(ulong playerId)
    {
      Log.Debug(string.Format("RaiseOnGroupMemberLeft: {0}", (object) playerId));
      AGroup.GroupMemberLeftEventHandler onGroupMemberLeft = this.OnGroupMemberLeft;
      if (onGroupMemberLeft == null)
        return;
      onGroupMemberLeft(playerId);
    }

    protected void RaiseOnGroupChatMessage(ulong playerId, string chatMessage)
    {
      Log.Debug(string.Format("RaiseOnGroupChatMessage: {0}", (object) playerId));
      AGroup.GroupChatMessageEventHandler groupChatMessage = this.OnGroupChatMessage;
      if (groupChatMessage == null)
        return;
      groupChatMessage(playerId, chatMessage);
    }

    protected void RaiseOnGroupMatchmaking(string gameliftKey, string matchmakerRegion)
    {
      Log.Debug("RaiseOnGroupMatchmaking: " + gameliftKey + " - " + matchmakerRegion);
      AGroup.GroupMatchmakingEventHandler groupMatchmaking = this.OnGroupMatchmaking;
      if (groupMatchmaking == null)
        return;
      groupMatchmaking(gameliftKey, matchmakerRegion);
    }

    protected void RaiseOnGroupMatchmakingCanceled(string gameliftKey, string matchmakerRegion)
    {
      Log.Debug("RaiseOnGroupMatchmakingCanceled: " + gameliftKey + " - " + matchmakerRegion);
      AGroup.GroupMatchmakingCanceledEventHandler matchmakingCanceled = this.OnGroupMatchmakingCanceled;
      if (matchmakingCanceled == null)
        return;
      matchmakingCanceled(gameliftKey, matchmakerRegion);
    }

    protected void RaiseOnGroupCustomMatchLobbyUpdate(JObject lobbyData)
    {
      Log.Debug("OnGroupCustomMatchLobbyUpdate: " + lobbyData.ToString());
      AGroup.GroupCustomMatchLobbyUpdateEventHandler matchLobbyUpdate = this.OnGroupCustomMatchLobbyUpdate;
      if (matchLobbyUpdate == null)
        return;
      matchLobbyUpdate(lobbyData);
    }

    protected void RaiseOnGroupCustomMatchLobbyIsReady(ulong steamId, JObject readyData)
    {
      Log.Debug("OnGroupCustomMatchLobbyIsReady: " + readyData.ToString());
      AGroup.GroupCustomMatchLobbyIsReadyEventHandler matchLobbyIsReady = this.OnGroupCustomMatchLobbyIsReady;
      if (matchLobbyIsReady == null)
        return;
      matchLobbyIsReady(steamId, readyData);
    }

    protected void RaiseOnGroupKick(ulong playerId)
    {
      Log.Debug(string.Format("Steam Player kicked: {0}", (object) playerId));
      AGroup.OnPlayerKickEventHandler onPlayerKick = this.OnPlayerKick;
      if (onPlayerKick == null)
        return;
      onPlayerKick(playerId);
    }

    protected void RaiseOnError(string errorMsg)
    {
      Log.Debug("RaiseOnError:");
      AGroup.OnErrorEventHandler onError = this.OnError;
      if (onError == null)
        return;
      onError(errorMsg);
    }

    protected void RaiseOnGroupLeftEndScreen(string msg)
    {
      Log.Debug("RaiseOnGroupLeftEndscreen");
      AGroup.OnGroupLeftEndScreenEventHandler groupLeftEndScreen = this.OnGroupLeftEndScreen;
      if (groupLeftEndScreen == null)
        return;
      groupLeftEndScreen(msg);
    }

    protected void RaiseOnRequestGroupMatchmaking()
    {
      Log.Debug(nameof (RaiseOnRequestGroupMatchmaking));
      AGroup.OnRequestGroupMatchmakingHandler groupMatchmaking = this.OnRequestGroupMatchmaking;
      if (groupMatchmaking == null)
        return;
      groupMatchmaking();
    }

    protected void RaiseOnAckGroupMatchmaking(ulong playerId, JObject latencies)
    {
      Log.Debug(nameof (RaiseOnAckGroupMatchmaking));
      AGroup.OnAckGroupMatchmakingHandler groupMatchmaking = this.OnAckGroupMatchmaking;
      if (groupMatchmaking == null)
        return;
      groupMatchmaking(playerId, latencies);
    }

    public abstract void CreateGroup(int groupSize, ELobbyType lobbyType);

    public abstract void ShowGroupInviteDialog();

    public abstract void LeaveGroup();

    public abstract void CheckForStartupArgs();

    public abstract void SetOwnPlayerId(ulong playerId);

    public abstract void SendChatMessage(string ascii);

    public abstract ulong GetGroupOwner();

    public abstract CSteamID GetLobbyId();

    public abstract int GetLobbyMemberLimit();

    public abstract void ResizeLobby(int groupSize);

    public abstract void ChangeLobbyType(ELobbyType lobbyType);

    public abstract void SetLobbyOwner(CSteamID newLobbyOwner);

    public delegate void GroupEnteredEventHandler();

    public delegate void GroupLeftEventHandler();

    public delegate void GroupMemberJoinedEventHandler(
      ulong playerId,
      CSteamID steamId,
      string username);

    public delegate void GroupMemberLeftEventHandler(ulong playerId);

    public delegate void GroupLobbyOwnerChangedEventHandler(ulong playerId);

    public delegate void GroupChatMessageEventHandler(ulong playerId, string msg);

    public delegate void GroupMatchmakingEventHandler(string gameliftKey, string matchmakerRegion);

    public delegate void GroupMatchmakingCanceledEventHandler(
      string gameliftKey,
      string matchmakerRegion);

    public delegate void GroupCustomMatchLobbyUpdateEventHandler(JObject lobbyData);

    public delegate void GroupCustomMatchLobbyIsReadyEventHandler(ulong steamId, JObject readyData);

    public delegate void OnErrorEventHandler(string errorMsg);

    public delegate void OnGroupLeftEndScreenEventHandler(string msg);

    public delegate void OnPlayerKickEventHandler(ulong playerId);

    public delegate void OnRequestGroupMatchmakingHandler();

    public delegate void OnAckGroupMatchmakingHandler(ulong playerId, JObject latencies);
  }
}
