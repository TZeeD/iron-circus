// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.MockPartyService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using Newtonsoft.Json.Linq;
using Steamworks;
using System;
using System.Collections.Generic;

namespace SteelCircus.Core.Services
{
  public class MockPartyService : APartyService
  {
    public override void ShowInviteUi()
    {
    }

    public override bool IsInGroup() => false;

    public override void LeaveGroup()
    {
    }

    public override ulong GetGroupOwner() => 0;

    public override List<APartyService.GroupMember> GetCurrentGroup() => new List<APartyService.GroupMember>();

    public override void CreateGroup(int groupSize, ELobbyType lobbyType)
    {
    }

    public override void SendMessage(string msg)
    {
    }

    public override void NotifyGroupMatchmaking(string gameliftkey, string matchmakerRegion)
    {
    }

    public override void NotifyGroupMatchmakingCancelled(
      string gameliftkey,
      string matchmakerRegion)
    {
    }

    public override void NotifyGroupLeaveEndScreen()
    {
    }

    public override List<ulong> GetCurrentGroupPlayerIds() => new List<ulong>();

    public override void NotifyGroupToJoinGame(string playerSessions)
    {
    }

    public override APartyService.GroupMember GetGroupMember(ulong playerId) => throw new NotImplementedException();

    public override int GetAvatarItemId(ulong groupMemberId) => SingletonScriptableObject<ItemsConfig>.Instance.GetItemsByType(ShopManager.ShopItemType.avatarIcon)[0].definitionId;

    public override void SetAvatarItemId(ulong groupMemberId, int avatarId)
    {
    }

    public override APartyService.GroupMember GetGroupMemberViaSteamId(ulong steamId) => throw new NotImplementedException();

    public override void NotifyGroupToJoinCustomGame(string playerSessions) => throw new NotImplementedException();

    public override CSteamID GetLobbyId() => throw new NotImplementedException();

    public override int GetLobbyMemberLimit() => throw new NotImplementedException();

    public override void ResizeLobby(int groupSize) => throw new NotImplementedException();

    public override void ChangeLobbyType(ELobbyType lobbyType) => throw new NotImplementedException();

    public override void SetLobbyOwner(CSteamID newLobbyOwner) => throw new NotImplementedException();

    public override void NotifyGroupCustomGameLobbyUpdated(string lobbyData) => throw new NotImplementedException();

    public override void NotifyGroupCustomGameLobbyIsReady(string readyData) => throw new NotImplementedException();

    public override bool IsCustomMatchGroup() => throw new NotImplementedException();

    public override bool IsGroupOwner() => throw new NotImplementedException();

    public override void NotifyGroupKickPlayer(ulong playerId) => throw new NotImplementedException();

    public override void NotifyRequestGroupMatchmaking() => throw new NotImplementedException();

    public override void NotifyAckGroupMatchmaking(ulong playerId, JObject latencies) => throw new NotImplementedException();
  }
}
