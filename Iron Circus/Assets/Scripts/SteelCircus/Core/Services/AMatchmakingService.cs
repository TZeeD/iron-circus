// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.AMatchmakingService
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

namespace SteelCircus.Core.Services
{
  public abstract class AMatchmakingService
  {
    public event AMatchmakingService.OnMatchmakingErrorEventHandler OnMatchmakingError;

    public event AMatchmakingService.OnMatchmakingStatusChangedEventHandler OnMatchMakingStatusChanged;

    public event AMatchmakingService.OnMatchmakingCanceledEventHandler OnMatchmakingCancelled;

    public event AMatchmakingService.OnMatchmakingStartedEventHandler OnMatchmakingStarted;

    public event AMatchmakingService.OnMatchmakingSuccessfulEventHandler OnMatchmakingSuccessful;

    protected void RaiseOnMatchmakingError(string error)
    {
      AMatchmakingService.OnMatchmakingErrorEventHandler matchmakingError = this.OnMatchmakingError;
      if (matchmakingError == null)
        return;
      matchmakingError(error);
    }

    protected void RaiseOnMatchmakingSuccess(ConnectionInfo connectionInfo)
    {
      AMatchmakingService.OnMatchmakingSuccessfulEventHandler matchmakingSuccessful = this.OnMatchmakingSuccessful;
      if (matchmakingSuccessful == null)
        return;
      matchmakingSuccessful(connectionInfo);
    }

    protected void RaiseOnMatchmakingStarted(string ticketId, string matchmakerRegion)
    {
      AMatchmakingService.OnMatchmakingStartedEventHandler matchmakingStarted = this.OnMatchmakingStarted;
      if (matchmakingStarted == null)
        return;
      matchmakingStarted(ticketId, matchmakerRegion);
    }

    public void RaiseOnMatchmakingCancelled()
    {
      AMatchmakingService.OnMatchmakingCanceledEventHandler matchmakingCancelled = this.OnMatchmakingCancelled;
      if (matchmakingCancelled == null)
        return;
      matchmakingCancelled();
    }

    protected void RaiseOnMatchmakingStatusChanged(string status, string ticketId)
    {
      AMatchmakingService.OnMatchmakingStatusChangedEventHandler makingStatusChanged = this.OnMatchMakingStatusChanged;
      if (makingStatusChanged == null)
        return;
      makingStatusChanged(status, ticketId);
    }

    public abstract void StartMatchmaking(
      int mmSystem,
      ulong playerId,
      string region,
      Dictionary<string, long> regionLatencies);

    public abstract void StartMatchmaking(
      int mmSystem,
      ulong playerId,
      List<ulong> playerIds,
      string region,
      Dictionary<string, long> regionLatencies);

    public abstract void StartCustomMatch(
      ulong ownPlayerId,
      List<ulong> alphaPlayerIds,
      List<ulong> betaPlayerIds,
      int nAlphaBots,
      int nBetaBots,
      AIDifficulty difficulty,
      string arena,
      string region,
      Dictionary<string, long> regionLatencies,
      Action<bool> callback);

    public abstract void StartBotMatch(
      ulong ownPlayerId,
      string arena,
      int aiDifficultyAlly,
      int aiDifficultyEnemy,
      MatchType matchType,
      GameType gameType,
      string region,
      Dictionary<string, long> regionLatencies,
      Action<bool> hadError);

    public abstract void StartTrainingsGround(ulong playerId, string region);

    public abstract bool IsMatchmaking();

    public abstract void CancelMatchmaking();

    public abstract void OnGroupMatchmakingCancelReceived();

    public abstract void OnUpdate();

    public abstract List<string> GetRegions();

    public abstract void SetMatchmakingType(MatchmakingType type);

    public abstract int GetMaxGroupSizeForCurrentMatchmakingType();

    public abstract void SetStandaloneIp(IPAddress address);

    public abstract void SetMatchmakingRequestedBool(bool wasMatchmakingRequested);

    public abstract bool IsStandaloneIpSet();

    public abstract void ProcessJoinGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId);

    public abstract void ProcessJoinCustomGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId);

    public abstract void Quit();

    public abstract void OnGroupMemberConnectionAck(ulong playerId, JObject latencies);

    public abstract void OnGroupConnection();

    public abstract MmService GetMatchmakingV2();

    public abstract void StartBasicTraining(ulong playerId, string region);

    public delegate void OnMatchmakingStatusChangedEventHandler(string status, string ticketId);

    public delegate void OnMatchmakingCanceledEventHandler();

    public delegate void OnMatchmakingStartedEventHandler(string ticketId, string matchmakerRegion);

    public delegate void OnMatchmakingErrorEventHandler(string errorMessage);

    public delegate void OnMatchmakingSuccessfulEventHandler(ConnectionInfo connectionInfo);
  }
}
