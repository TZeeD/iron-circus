// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.StandaloneMatchmakingService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.AI;
using Imi.SteelCircus.Core;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class StandaloneMatchmakingService : AMatchmakingService
  {
    private MonoBehaviour coroutineRunner;
    private Action<ConnectionInfo, byte[]> onSuccessCallback;
    private IPAddress standaloneIp;
    private bool standaloneIpSet;

    public StandaloneMatchmakingService(
      MonoBehaviour coroutineRunner,
      Action<ConnectionInfo, byte[]> onSuccessCallback)
    {
      this.coroutineRunner = coroutineRunner;
      this.onSuccessCallback = onSuccessCallback;
    }

    public override void StartMatchmaking(
      int mmSystem,
      ulong playerId,
      string region,
      Dictionary<string, long> regionLatencies)
    {
      ConnectionInfo connectionInfo = new ConnectionInfo();
      connectionInfo.port = 7033;
      connectionInfo.playerId = ImiServices.Instance.LoginService.GetPlayerId();
      connectionInfo.ip = this.standaloneIp;
      connectionInfo.username = ImiServices.Instance.LoginService.GetUsername();
      this.RaiseOnMatchmakingSuccess(connectionInfo);
      ImiServices.Instance.ConnectToGameServer(connectionInfo, (byte[]) null);
    }

    public override void StartMatchmaking(
      int mmSystem,
      ulong playerId,
      List<ulong> playerIds,
      string region,
      Dictionary<string, long> regionLatencies)
    {
    }

    public override void StartCustomMatch(
      ulong ownPlayerId,
      List<ulong> alphaPlayerIds,
      List<ulong> betaPlayerIds,
      int nAlphaBots,
      int nBetaBots,
      AIDifficulty difficulty,
      string arena,
      string region,
      Dictionary<string, long> regionLatencies,
      Action<bool> callback)
    {
      throw new NotImplementedException();
    }

    public override void StartBotMatch(
      ulong ownPlayerId,
      string arena,
      int aiDifficultyAlly,
      int aiDifficultyEnemy,
      MatchType matchType,
      GameType gameType,
      string region,
      Dictionary<string, long> regionLatencies,
      Action<bool> hadError)
    {
      throw new NotImplementedException();
    }

    public override void StartTrainingsGround(ulong playerId, string region)
    {
    }

    public override bool IsMatchmaking() => false;

    public override void CancelMatchmaking()
    {
    }

    public override void OnGroupMatchmakingCancelReceived()
    {
    }

    public override void OnUpdate()
    {
    }

    public override List<string> GetRegions() => new List<string>()
    {
      "No"
    };

    public virtual void SetMatchmakingForPolling(
      string ticketId,
      ulong ownPlayerId,
      string matchmakerRegion)
    {
    }

    public override void SetMatchmakingType(MatchmakingType type)
    {
    }

    public override int GetMaxGroupSizeForCurrentMatchmakingType() => 3;

    public override void SetStandaloneIp(IPAddress address)
    {
      this.standaloneIp = address;
      this.standaloneIpSet = true;
    }

    public override void SetMatchmakingRequestedBool(bool wasMatchmakingRequested) => throw new NotImplementedException();

    public override bool IsStandaloneIpSet() => this.standaloneIpSet;

    public override void ProcessJoinGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId)
    {
    }

    public override void ProcessJoinCustomGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId)
    {
      throw new NotImplementedException();
    }

    public override void Quit()
    {
    }

    public override void OnGroupMemberConnectionAck(ulong playerId, JObject latencies)
    {
    }

    public override void OnGroupConnection()
    {
    }

    public override MmService GetMatchmakingV2() => throw new NotImplementedException();

    public override void StartBasicTraining(ulong playerId, string region) => throw new NotImplementedException();
  }
}
