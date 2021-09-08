// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.SteamGroup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.UI.Popups;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Core.Services
{
  public sealed class SteamGroup : AGroup
  {
    private Callback<LobbyCreated_t> callOnLobbyCreated;
    private Callback<LobbyEnter_t> callOnLobbyEntered;
    private Callback<LobbyDataUpdate_t> callOnLobbyData;
    private Callback<LobbyChatUpdate_t> callOnLobbyChatUpdate;
    private Callback<LobbyChatMsg_t> callOnChatMsg;
    private Callback<LobbyInvite_t> callOnLobbyInviteReceived;
    private Callback<GameLobbyJoinRequested_t> callOnJoinRequested;
    private CSteamID localSteamId;
    private ulong localPlayerId;
    private CSteamID currentLobbyId;
    private CSteamID currentLobbyOwner;
    private Dictionary<CSteamID, ulong> lobbyMembers = new Dictionary<CSteamID, ulong>();
    private byte[] lastChatMessageRecv = new byte[4096];
    private byte[] lastChatMessageSend = new byte[4096];

    public SteamGroup()
    {
      if (SteamManager.Initialized)
      {
        this.currentLobbyId = CSteamID.Nil;
        this.currentLobbyOwner = CSteamID.Nil;
        this.callOnLobbyCreated = Callback<LobbyCreated_t>.Create(new Callback<LobbyCreated_t>.DispatchDelegate(this.OnLobbyCreated));
        this.callOnLobbyEntered = Callback<LobbyEnter_t>.Create(new Callback<LobbyEnter_t>.DispatchDelegate(this.OnLobbyEntered));
        this.callOnLobbyData = Callback<LobbyDataUpdate_t>.Create(new Callback<LobbyDataUpdate_t>.DispatchDelegate(this.OnLobbyDataUpdate));
        this.callOnLobbyChatUpdate = Callback<LobbyChatUpdate_t>.Create(new Callback<LobbyChatUpdate_t>.DispatchDelegate(this.OnLobbyChatUpdate));
        this.callOnJoinRequested = Callback<GameLobbyJoinRequested_t>.Create(new Callback<GameLobbyJoinRequested_t>.DispatchDelegate(this.OnJoinRequested));
        this.callOnChatMsg = Callback<LobbyChatMsg_t>.Create(new Callback<LobbyChatMsg_t>.DispatchDelegate(this.OnChatMsg));
        this.callOnLobbyInviteReceived = Callback<LobbyInvite_t>.Create(new Callback<LobbyInvite_t>.DispatchDelegate(this.OnLobbyInviteReceived));
        this.localSteamId = SteamUser.GetSteamID();
        Log.Api(string.Format("Local SteamId {0}", (object) this.localSteamId.m_SteamID));
      }
      else
        Log.Error("Steam not initialized.");
    }

    private void OnChatMsg(LobbyChatMsg_t param)
    {
      string chatMessage = this.GetChatMessage(param);
      if (chatMessage.StartsWith("--"))
      {
        Debug.Log((object) ("Received Message: " + chatMessage));
        if (chatMessage.Contains("start-matchmaking"))
          this.RaiseOnGroupMatchmaking(chatMessage.Split(' ')[1], chatMessage.Split(' ')[2].TrimEnd(new char[1]));
        else if (chatMessage.Contains("request-group-matchmaking"))
        {
          if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.localPlayerId)
            return;
          Log.Debug("Request group Matchmaking received from group leader");
          this.RaiseOnRequestGroupMatchmaking();
        }
        else if (chatMessage.Contains("ack-group-matchmaking"))
        {
          if (!ImiServices.Instance.PartyService.IsGroupOwner())
            return;
          string s = chatMessage.Split(' ')[1];
          int startIndex = chatMessage.IndexOf(' ', chatMessage.IndexOf(' ') + 1);
          JObject latencies = JObject.Parse(chatMessage.Substring(startIndex));
          Log.Debug("Ack received from player " + s);
          this.RaiseOnAckGroupMatchmaking(ulong.Parse(s), latencies);
        }
        else if (chatMessage.Contains("stop-matchmaking"))
        {
          if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.localPlayerId)
            return;
          Log.Debug("Stop Matchmaking received from group leader");
          this.RaiseOnGroupMatchmakingCanceled(chatMessage.Split(' ')[1], chatMessage.Split(' ')[2].TrimEnd(new char[1]));
        }
        else if (chatMessage.Contains("join-game"))
        {
          if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.localPlayerId)
            return;
          ImiServices.Instance.MatchmakingService.ProcessJoinGameRequestFromGroupLeader(JObject.Parse(chatMessage.Remove(0, "--join-game ".Length)), this.localPlayerId);
        }
        else if (chatMessage.Contains("join-custom-game"))
        {
          if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) this.localPlayerId)
            return;
          ImiServices.Instance.MatchmakingService.ProcessJoinCustomGameRequestFromGroupLeader(JObject.Parse(chatMessage.Remove(0, "--join-custom-game ".Length)), this.localPlayerId);
        }
        else if (chatMessage.Contains("custom-game-lobby-update"))
          this.RaiseOnGroupCustomMatchLobbyUpdate(JObject.Parse(chatMessage.Remove(0, "--custom-game-lobby-update ".Length)));
        else if (chatMessage.Contains("custom-game-lobby-ready"))
        {
          JObject readyData = JObject.Parse(chatMessage.Remove(0, "--custom-game-lobby-ready ".Length));
          this.RaiseOnGroupCustomMatchLobbyIsReady(param.m_ulSteamIDUser, readyData);
        }
        else
        {
          if (!chatMessage.Contains("kick"))
            return;
          this.RaiseOnGroupKick(ulong.Parse(chatMessage.Remove(0, "--kick ".Length)));
        }
      }
      else if (chatMessage.StartsWith("++"))
      {
        Debug.Log((object) ("Received Message: " + chatMessage));
        this.RaiseOnGroupLeftEndScreen(chatMessage);
      }
      else
        this.RaiseOnGroupChatMessage(this.lobbyMembers[(CSteamID) param.m_ulSteamIDUser], chatMessage);
    }

    private string GetChatMessage(LobbyChatMsg_t param)
    {
      Array.Clear((Array) this.lastChatMessageRecv, 0, 4096);
      SteamMatchmaking.GetLobbyChatEntry((CSteamID) param.m_ulSteamIDLobby, (int) param.m_iChatID, out CSteamID _, this.lastChatMessageRecv, 4096, out EChatEntryType _);
      return Encoding.ASCII.GetString(this.lastChatMessageRecv).TrimEnd();
    }

    private void OnLobbyInviteReceived(LobbyInvite_t param)
    {
    }

    private void OnJoinRequested(GameLobbyJoinRequested_t param)
    {
      if (!ImiServices.Instance.isInMatchService.IsPlayerInMatch && !ImiServices.Instance.MatchmakingService.IsMatchmaking() && !CustomLobbyUi.isInitialized)
      {
        if (this.currentLobbyId != CSteamID.Nil)
          this.LeaveGroup();
        SteamMatchmaking.JoinLobby(param.m_steamIDLobby);
      }
      else if (ImiServices.Instance.MatchmakingService.IsMatchmaking())
        PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@CannotJoinGroupWhileMatchmakingPopupDescription", "OK", title: "@CannotJoinGroupWhileMatchmakingPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      else if (CustomLobbyUi.isInitialized)
        PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@CannotJoinGroupWhileInCustomMatchPopupDescription", "OK", title: "@CannotJoinGroupWhileInCustomMatchPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      else
        PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@CannotJoinGroupWhileInMatchPopupDescription", "OK", title: "@CannotJoinGroupWhileInMatchPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
    }

    private void OnLobbyChatUpdate(LobbyChatUpdate_t param)
    {
      if ((long) param.m_ulSteamIDLobby != (long) this.currentLobbyId.m_SteamID)
        return;
      Debug.Log((object) string.Format("XXX - {0} - {1} - {2} - {3}", (object) param.m_ulSteamIDLobby, (object) param.m_rgfChatMemberStateChange, (object) param.m_ulSteamIDMakingChange, (object) param.m_ulSteamIDUserChanged));
      switch (param.m_rgfChatMemberStateChange)
      {
        case 1:
          if (this.lobbyMembers.ContainsKey((CSteamID) param.m_ulSteamIDUserChanged))
            break;
          this.lobbyMembers[(CSteamID) param.m_ulSteamIDUserChanged] = 0UL;
          SingletonManager<MetaServiceHelpers>.Instance.GetPlayerIdFromSteamCoroutine(param.m_ulSteamIDUserChanged, (Action<ulong, ulong>) ((steamId, playerId) =>
          {
            this.lobbyMembers[(CSteamID) param.m_ulSteamIDUserChanged] = playerId;
            this.RaiseOnGroupMemberEntered(playerId, (CSteamID) steamId, SteamFriends.GetFriendPersonaName((CSteamID) param.m_ulSteamIDUserChanged));
          }), new Action<ulong>(this.OnErrorGetPlayerId));
          Log.Api(string.Format("Steam user {0} has entered the lobby.", (object) param.m_ulSteamIDUserChanged));
          break;
        case 2:
          if (!this.lobbyMembers.ContainsKey((CSteamID) param.m_ulSteamIDUserChanged))
            break;
          ulong lobbyMember1 = this.lobbyMembers[(CSteamID) param.m_ulSteamIDUserChanged];
          this.lobbyMembers.Remove((CSteamID) param.m_ulSteamIDUserChanged);
          this.RaiseOnGroupMemberLeft(lobbyMember1);
          Log.Api(string.Format("Steam user {0} has left the lobby.", (object) param.m_ulSteamIDUserChanged));
          break;
        case 4:
          if (this.lobbyMembers.ContainsKey((CSteamID) param.m_ulSteamIDUserChanged))
            break;
          ulong lobbyMember2 = this.lobbyMembers[(CSteamID) param.m_ulSteamIDUserChanged];
          this.lobbyMembers.Remove((CSteamID) param.m_ulSteamIDUserChanged);
          this.RaiseOnGroupMemberLeft(lobbyMember2);
          Log.Api(string.Format("Steam user {0} has disconnected.", (object) param.m_ulSteamIDUserChanged));
          break;
        case 8:
          break;
        case 16:
          break;
        default:
          Log.Warning("Chat state change is not valid.");
          break;
      }
    }

    private void OnErrorGetPlayerId(ulong steamId) => this.RaiseOnError("User service not reachable.");

    private void OnLobbyDataUpdate(LobbyDataUpdate_t param)
    {
      Debug.Log((object) string.Format("XXX - {0} - {1}", (object) param.m_ulSteamIDLobby, (object) param.m_ulSteamIDMember));
      if ((long) param.m_ulSteamIDLobby != (long) this.currentLobbyId.m_SteamID)
        return;
      CSteamID lobbyOwner = SteamMatchmaking.GetLobbyOwner((CSteamID) param.m_ulSteamIDLobby);
      if (!(lobbyOwner != this.currentLobbyOwner))
        return;
      this.currentLobbyOwner = lobbyOwner;
      this.RaiseOnLobbyOwnerChanged(this.lobbyMembers[lobbyOwner]);
    }

    private void OnLobbyEntered(LobbyEnter_t param)
    {
      if (param.m_EChatRoomEnterResponse == 1U)
      {
        Log.Api(string.Format("Lobby ({0}) joined.", (object) param.m_ulSteamIDLobby));
        this.currentLobbyId = new CSteamID(param.m_ulSteamIDLobby);
        int numLobbyMembers = SteamMatchmaking.GetNumLobbyMembers(this.currentLobbyId);
        for (int iMember = 0; iMember < numLobbyMembers; ++iMember)
        {
          CSteamID memberSteamId = SteamMatchmaking.GetLobbyMemberByIndex(this.currentLobbyId, iMember);
          if (!this.lobbyMembers.ContainsKey(memberSteamId))
          {
            if (memberSteamId == SteamUser.GetSteamID())
            {
              this.lobbyMembers[memberSteamId] = ImiServices.Instance.LoginService.GetPlayerId();
            }
            else
            {
              this.lobbyMembers[memberSteamId] = 0UL;
              SingletonManager<MetaServiceHelpers>.Instance.GetPlayerIdFromSteamCoroutine(memberSteamId.m_SteamID, (Action<ulong, ulong>) ((steamId, playerId) =>
              {
                this.lobbyMembers[memberSteamId] = playerId;
                if (!(memberSteamId != this.localSteamId))
                  return;
                this.RaiseOnGroupMemberEntered(playerId, memberSteamId, SteamFriends.GetFriendPersonaName(memberSteamId));
              }), new Action<ulong>(this.OnErrorGetPlayerId));
            }
          }
        }
        this.RaiseOnGroupEntered();
      }
      else
      {
        switch (param.m_EChatRoomEnterResponse)
        {
          case 5:
            PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@FailedToJoinLobbyDescription", "OK", title: "@FailedToJoinLobbyTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
            break;
        }
        Log.Error(string.Format("Failed to join lobby ({0}).", (object) param.m_ulSteamIDLobby));
      }
    }

    private void OnLobbyCreated(LobbyCreated_t param)
    {
      if (param.m_eResult == EResult.k_EResultOK)
        return;
      Log.Error("Lobby creation failed.");
    }

    public override void CreateGroup(int groupSize, ELobbyType lobbyType)
    {
      if (!(this.currentLobbyId == CSteamID.Nil))
        return;
      SteamMatchmaking.CreateLobby(lobbyType, groupSize);
    }

    public override void ResizeLobby(int groupSize)
    {
      if (!(this.currentLobbyId != CSteamID.Nil))
        return;
      SteamMatchmaking.SetLobbyMemberLimit(this.currentLobbyId, groupSize);
    }

    public override void ChangeLobbyType(ELobbyType lobbyType)
    {
      if (!(this.currentLobbyId == CSteamID.Nil))
        return;
      SteamMatchmaking.SetLobbyType(this.currentLobbyId, lobbyType);
    }

    public override void ShowGroupInviteDialog()
    {
      if (!(this.currentLobbyId != CSteamID.Nil))
        return;
      SteamFriends.ActivateGameOverlayInviteDialog(this.currentLobbyId);
    }

    public override void SendChatMessage(string ascii)
    {
      if (this.currentLobbyId == CSteamID.Nil)
        return;
      Array.Clear((Array) this.lastChatMessageSend, 0, 4096);
      if (SteamMatchmaking.SendLobbyChatMsg(this.currentLobbyId, this.lastChatMessageSend, Encoding.ASCII.GetBytes(ascii, 0, ascii.Length, this.lastChatMessageSend, 0)))
        return;
      Log.Warning("Could not send chat message.");
    }

    public override ulong GetGroupOwner()
    {
      if (!(this.currentLobbyId == CSteamID.Nil))
        return this.lobbyMembers[SteamMatchmaking.GetLobbyOwner(this.currentLobbyId)];
      Log.Warning("Currently not in a group but requesting group owner.");
      return 0;
    }

    public override void SetLobbyOwner(CSteamID newLobbyOwner)
    {
      if (!(this.currentLobbyId != CSteamID.Nil))
        return;
      SteamMatchmaking.SetLobbyOwner(this.currentLobbyId, newLobbyOwner);
    }

    public override CSteamID GetLobbyId() => this.currentLobbyId;

    public override int GetLobbyMemberLimit() => SteamMatchmaking.GetLobbyMemberLimit(this.currentLobbyId);

    public override void LeaveGroup()
    {
      if (this.currentLobbyId != CSteamID.Nil)
        SteamMatchmaking.LeaveLobby(this.currentLobbyId);
      this.lobbyMembers.Clear();
      this.currentLobbyId = CSteamID.Nil;
      this.RaiseOnGroupLeft();
    }

    public override void CheckForStartupArgs()
    {
      string[] commandLineArgs = Environment.GetCommandLineArgs();
      for (int index = 0; index < commandLineArgs.Length; ++index)
      {
        if (commandLineArgs[index] == "+connect_lobby" && commandLineArgs.Length > index + 1)
        {
          if (this.currentLobbyId != CSteamID.Nil)
            SteamMatchmaking.LeaveLobby(this.currentLobbyId);
          SteamMatchmaking.JoinLobby((CSteamID) ulong.Parse(commandLineArgs[index + 1]));
        }
      }
    }

    public override void SetOwnPlayerId(ulong playerId) => this.localPlayerId = playerId;
  }
}
