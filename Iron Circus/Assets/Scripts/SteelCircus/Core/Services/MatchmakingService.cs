// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.MatchmakingService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.AI;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.UI.Popups;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.Core.Services
{
  public class MatchmakingService : AMatchmakingService
  {
    private MatchmakingType type = MatchmakingType.ThreeVsThree;
    private readonly MonoBehaviour coroutineRunner;
    private readonly Action<ConnectionInfo> onSuccessCallback;
    private const string MatchMakingConfigPrefix = "live";
    private readonly List<string> matchMakingConfigs = new List<string>()
    {
      "live-quickmatch-1v1-matchmaker",
      "live-quickmatch-2v2-matchmaker",
      "live-quickmatch-3v3-matchmaker"
    };
    private readonly List<string> matchMakingConfigsSouthAmerica = new List<string>()
    {
      "live-quickmatch-1v1-matchmaker-sa",
      "live-quickmatch-2v2-matchmaker-sa",
      "live-quickmatch-3v3-matchmaker-sa"
    };
    private readonly List<string> allowedRegions = new List<string>()
    {
      "eu-west-1",
      "us-east-1",
      "ap-northeast-1",
      "sa-east-1",
      "ap-southeast-2"
    };
    private const string MmStatusCompleted = "COMPLETED";
    private const string MmStatusTimedOut = "TIMED_OUT";
    private const string MmStatusCancelled = "CANCELLED";
    private string connectedMatchmakingTicket = "";
    private string currentRegion;
    private string matchMakingTicket;
    private bool cancelRequestPending;
    private ulong playerIdWaitingForMatch;
    private JObject matchMakingStatusJson;
    private string currentStatus;
    private double lastMatchmakingUpdate;
    private bool matchmakingWasRequested;
    private MmService mmService;
    private int lastSystemUsed;

    public MatchmakingService(
      MonoBehaviour coroutineRunner,
      Action<ConnectionInfo> onSuccessCallback)
    {
      this.coroutineRunner = coroutineRunner;
      this.onSuccessCallback = onSuccessCallback;
      this.mmService = new MmService(new Action(((AMatchmakingService) this).RaiseOnMatchmakingCancelled), new Action<string, string>(((AMatchmakingService) this).RaiseOnMatchmakingStarted), new Action<ConnectionInfo>(((AMatchmakingService) this).RaiseOnMatchmakingSuccess), new Action<string, string>(((AMatchmakingService) this).RaiseOnMatchmakingStatusChanged), new Action<string>(((AMatchmakingService) this).RaiseOnMatchmakingError));
    }

    public override void SetMatchmakingType(MatchmakingType type)
    {
      this.type = type;
      this.mmService.SetMatchmakingType(type);
    }

    public override void StartTrainingsGround(ulong playerId, string region) => this.coroutineRunner.StartCoroutine(GameLiftHelpers.CreateAndJoinTrainingSession(playerId, region, (Action<string>) (error =>
    {
      Log.Api("Could not start match making: " + error);
      this.RaiseOnMatchmakingError(error);
    }), (Action<string, string, string, int>) ((playerSessionId, ipAddress, gameSessionId, port) =>
    {
      Log.Api("Started training ground making success!");
      ConnectionInfo connectionInfo = new ConnectionInfo()
      {
        ip = IPAddress.Parse(ipAddress),
        port = port,
        username = ImiServices.Instance.LoginService.GetUsername(),
        playerId = playerId,
        gameLiftPlayerSessionId = playerSessionId
      };
      this.AddGameSessionIdToMetaMatchEntity(gameSessionId);
      this.onSuccessCallback(connectionInfo);
      this.RaiseOnMatchmakingSuccess(connectionInfo);
    })));

    public override void StartBasicTraining(ulong playerId, string region) => this.coroutineRunner.StartCoroutine(GameLiftHelpers.CreateAndJoinBasicTraining(playerId, region, (Action<string>) (error =>
    {
      Log.Api("Could not start match making: " + error);
      this.RaiseOnMatchmakingError(error);
    }), (Action<string, string, string, int>) ((playerSessionId, ipAddress, gameSessionId, port) =>
    {
      Log.Api("Started training ground making success!");
      ConnectionInfo connectionInfo = new ConnectionInfo()
      {
        ip = IPAddress.Parse(ipAddress),
        port = port,
        username = ImiServices.Instance.LoginService.GetUsername(),
        playerId = playerId,
        gameLiftPlayerSessionId = playerSessionId
      };
      this.AddGameSessionIdToMetaMatchEntity(gameSessionId);
      this.onSuccessCallback(connectionInfo);
      this.RaiseOnMatchmakingSuccess(connectionInfo);
    })));

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
      Action<bool> hadError)
    {
      List<CustomMatchPlayerInfo> alphaPlayerIds1 = new List<CustomMatchPlayerInfo>();
      foreach (ulong alphaPlayerId in alphaPlayerIds)
        alphaPlayerIds1.Add(new CustomMatchPlayerInfo()
        {
          playerId = alphaPlayerId,
          isBot = false,
          aiDifficulty = 0
        });
      CustomMatchPlayerInfo customMatchPlayerInfo1;
      for (int index = 0; index < nAlphaBots; ++index)
      {
        List<CustomMatchPlayerInfo> customMatchPlayerInfoList = alphaPlayerIds1;
        customMatchPlayerInfo1 = new CustomMatchPlayerInfo();
        customMatchPlayerInfo1.playerId = 0UL;
        customMatchPlayerInfo1.isBot = true;
        customMatchPlayerInfo1.aiDifficulty = (int) difficulty;
        CustomMatchPlayerInfo customMatchPlayerInfo2 = customMatchPlayerInfo1;
        customMatchPlayerInfoList.Add(customMatchPlayerInfo2);
      }
      List<CustomMatchPlayerInfo> betaPlayerIds1 = new List<CustomMatchPlayerInfo>();
      foreach (ulong betaPlayerId in betaPlayerIds)
      {
        List<CustomMatchPlayerInfo> customMatchPlayerInfoList = betaPlayerIds1;
        customMatchPlayerInfo1 = new CustomMatchPlayerInfo();
        customMatchPlayerInfo1.playerId = betaPlayerId;
        customMatchPlayerInfo1.isBot = false;
        customMatchPlayerInfo1.aiDifficulty = 0;
        CustomMatchPlayerInfo customMatchPlayerInfo3 = customMatchPlayerInfo1;
        customMatchPlayerInfoList.Add(customMatchPlayerInfo3);
      }
      for (int index = 0; index < nBetaBots; ++index)
        betaPlayerIds1.Add(new CustomMatchPlayerInfo()
        {
          playerId = 0UL,
          isBot = true,
          aiDifficulty = (int) difficulty
        });
      this.coroutineRunner.StartCoroutine(GameLiftHelpers.CreateAndJoinCustomMatch(ownPlayerId, alphaPlayerIds1, betaPlayerIds1, arena, region, GameType.CustomMatch, regionLatencies, (Action<string>) (error =>
      {
        Log.Api("Could not start custom match: " + error);
        hadError(true);
        this.RaiseOnMatchmakingError(error);
      }), (Action<string, string, string, int>) ((playerSessionId, ipAddress, gameSessionId, port) =>
      {
        Log.Api("Started Custom Match success!");
        hadError(false);
        ConnectionInfo connectionInfo = new ConnectionInfo()
        {
          ip = IPAddress.Parse(ipAddress),
          port = port,
          username = ImiServices.Instance.LoginService.GetUsername(),
          playerId = ownPlayerId,
          gameLiftPlayerSessionId = playerSessionId
        };
        this.AddGameSessionIdToMetaMatchEntity(gameSessionId);
        this.onSuccessCallback(connectionInfo);
        this.RaiseOnMatchmakingSuccess(connectionInfo);
      })));
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
      int num;
      switch (matchType)
      {
        case MatchType.Match1Vs1:
          num = 1;
          break;
        case MatchType.Match2Vs2:
          num = 2;
          break;
        case MatchType.Match3Vs3:
          num = 3;
          break;
        default:
          throw new NotImplementedException();
      }
      List<CustomMatchPlayerInfo> alphaPlayerIds = new List<CustomMatchPlayerInfo>();
      List<CustomMatchPlayerInfo> customMatchPlayerInfoList1 = alphaPlayerIds;
      CustomMatchPlayerInfo customMatchPlayerInfo1 = new CustomMatchPlayerInfo();
      customMatchPlayerInfo1.playerId = ownPlayerId;
      customMatchPlayerInfo1.isBot = false;
      customMatchPlayerInfo1.aiDifficulty = 0;
      CustomMatchPlayerInfo customMatchPlayerInfo2 = customMatchPlayerInfo1;
      customMatchPlayerInfoList1.Add(customMatchPlayerInfo2);
      for (int index = 1; index < num; ++index)
      {
        List<CustomMatchPlayerInfo> customMatchPlayerInfoList2 = alphaPlayerIds;
        customMatchPlayerInfo1 = new CustomMatchPlayerInfo();
        customMatchPlayerInfo1.playerId = 0UL;
        customMatchPlayerInfo1.isBot = true;
        customMatchPlayerInfo1.aiDifficulty = aiDifficultyAlly;
        CustomMatchPlayerInfo customMatchPlayerInfo3 = customMatchPlayerInfo1;
        customMatchPlayerInfoList2.Add(customMatchPlayerInfo3);
      }
      List<CustomMatchPlayerInfo> betaPlayerIds = new List<CustomMatchPlayerInfo>();
      for (int index = 0; index < num; ++index)
      {
        List<CustomMatchPlayerInfo> customMatchPlayerInfoList3 = betaPlayerIds;
        customMatchPlayerInfo1 = new CustomMatchPlayerInfo();
        customMatchPlayerInfo1.playerId = 0UL;
        customMatchPlayerInfo1.isBot = true;
        customMatchPlayerInfo1.aiDifficulty = aiDifficultyEnemy;
        CustomMatchPlayerInfo customMatchPlayerInfo4 = customMatchPlayerInfo1;
        customMatchPlayerInfoList3.Add(customMatchPlayerInfo4);
      }
      this.coroutineRunner.StartCoroutine(GameLiftHelpers.CreateAndJoinCustomMatch(ownPlayerId, alphaPlayerIds, betaPlayerIds, arena, region, gameType, regionLatencies, (Action<string>) (error =>
      {
        Log.Api("Could not start custom match: " + error);
        hadError(true);
        this.RaiseOnMatchmakingError(error);
      }), (Action<string, string, string, int>) ((playerSessionId, ipAddress, gameSessionId, port) =>
      {
        Log.Api("Started Custom Match success!");
        hadError(false);
        ConnectionInfo connectionInfo = new ConnectionInfo()
        {
          ip = IPAddress.Parse(ipAddress),
          port = port,
          username = ImiServices.Instance.LoginService.GetUsername(),
          playerId = ownPlayerId,
          gameLiftPlayerSessionId = playerSessionId
        };
        this.AddGameSessionIdToMetaMatchEntity(gameSessionId);
        this.onSuccessCallback(connectionInfo);
        this.RaiseOnMatchmakingSuccess(connectionInfo);
      })));
    }

    public override void StartMatchmaking(
      int mmSystem,
      ulong playerId,
      string region,
      Dictionary<string, long> regionLatencies)
    {
      int mmSystem1 = mmSystem;
      long num = (long) playerId;
      List<ulong> playerIds = new List<ulong>();
      playerIds.Add(playerId);
      string region1 = region;
      Dictionary<string, long> regionLatencies1 = regionLatencies;
      this.StartMatchmaking(mmSystem1, (ulong) num, playerIds, region1, regionLatencies1);
    }

    public override void StartMatchmaking(
      int mmSystem,
      ulong ownPlayerId,
      List<ulong> playerIds,
      string region,
      Dictionary<string, long> regionLatencies)
    {
      this.lastSystemUsed = mmSystem;
      ImiServices.Instance.Analytics.OnMatchmakingStarted();
      if (regionLatencies != null && regionLatencies.ContainsKey(region))
        ImiServices.Instance.Analytics.OnMatchmakingPlayerLatencyReported((float) regionLatencies[region]);
      else
        ImiServices.Instance.Analytics.OnTrackMatchmakingError("CouldntFindRegionInLatenciesDict");
      this.matchmakingWasRequested = true;
      this.matchMakingStatusJson = (JObject) null;
      int type = (int) this.type;
      this.currentRegion = region;
      List<string> stringList = this.matchMakingConfigs;
      if (region == "sa-east-1")
      {
        this.currentRegion = "us-east-1";
        stringList = this.matchMakingConfigsSouthAmerica;
      }
      if (mmSystem == 2)
      {
        this.mmService.SetRegion(region);
        this.mmService.StartMatchmaking();
      }
      else
      {
        this.mmService.GetState().hasEverBeenExecuted = false;
        this.coroutineRunner.StartCoroutine(GameLiftHelpers.StartMatchmaking(ownPlayerId, playerIds, stringList[type], this.currentRegion, regionLatencies, (Action<string>) (error =>
        {
          this.matchmakingWasRequested = false;
          Log.Api("Could not start match making: " + error);
          this.RaiseOnMatchmakingError(error);
        }), (Action<string>) (ticketId =>
        {
          this.matchmakingWasRequested = false;
          Log.Api("Started Match making success! Ticket = " + ticketId);
          this.SetMatchmakingForPolling(ticketId, ownPlayerId, this.currentRegion);
          this.RaiseOnMatchmakingStarted(ticketId, this.currentRegion);
        })));
      }
    }

    private void SetMatchmakingForPolling(
      string ticketId,
      ulong ownPlayerId,
      string matchmakerRegion)
    {
      this.matchMakingStatusJson = (JObject) null;
      this.matchMakingTicket = ticketId;
      this.currentRegion = matchmakerRegion;
      if (matchmakerRegion == "sa-east-1")
        this.currentRegion = "us-east-1";
      this.playerIdWaitingForMatch = ownPlayerId;
    }

    public override void CancelMatchmaking()
    {
      Log.Debug("in cancel");
      if (this.lastSystemUsed == 2 || this.mmService.GetState().hasEverBeenExecuted)
      {
        Debug.Log((object) "Cancel via system 2");
        if (!this.mmService.GetState().allowCancel)
          return;
        this.mmService.CancelMatchmaking();
      }
      else
      {
        Debug.Log((object) "Cancel via system 1");
        if (this.matchMakingTicket == null || this.cancelRequestPending)
          return;
        this.cancelRequestPending = true;
        this.coroutineRunner.StartCoroutine(GameLiftHelpers.StopMatchmaking(this.matchMakingTicket, this.currentRegion, (Action<string>) (errorString =>
        {
          Log.Error(errorString);
          this.cancelRequestPending = false;
        }), (Action) (() =>
        {
          Log.Debug("Matchmaking was cancelled sucessfully for " + this.matchMakingTicket);
          ImiServices.Instance.PartyService.NotifyGroupMatchmakingCancelled(this.matchMakingTicket, this.currentRegion);
          this.matchMakingTicket = (string) null;
          this.matchmakingWasRequested = false;
          this.cancelRequestPending = false;
          this.RaiseOnMatchmakingCancelled();
          this.RaiseOnMatchmakingStatusChanged("CANCELLED", this.matchMakingTicket);
        })));
      }
    }

    public override void OnGroupMatchmakingCancelReceived()
    {
      this.matchmakingWasRequested = false;
      this.matchMakingTicket = (string) null;
      this.cancelRequestPending = false;
      this.RaiseOnMatchmakingCancelled();
      this.RaiseOnMatchmakingStatusChanged("CANCELLED", this.matchMakingTicket);
    }

    public override List<string> GetRegions() => this.allowedRegions;

    private void ConnectToFoundMatch()
    {
      this.matchmakingWasRequested = false;
      if (this.matchMakingTicket == null)
        return;
      if (this.connectedMatchmakingTicket.Equals(this.matchMakingTicket))
      {
        this.matchMakingTicket = (string) null;
      }
      else
      {
        this.connectedMatchmakingTicket = this.matchMakingTicket;
        this.matchMakingTicket = (string) null;
        Log.Api("Match making completed!");
        JObject jobject = (JObject) this.matchMakingStatusJson["GameSessionConnectionInfo"];
        string playerSessionId;
        if (MatchmakingService.GetSessionIdForPlayer(jobject["MatchedPlayerSessions"].ToArray<JToken>(), this.playerIdWaitingForMatch, out playerSessionId))
        {
          string ipString = jobject["IpAddress"].ToString();
          this.AddGameSessionIdToMetaMatchEntity(jobject["GameSessionArn"].ToString());
          int num = (int) jobject["Port"];
          ConnectionInfo connectionInfo = new ConnectionInfo()
          {
            ip = IPAddress.Parse(ipString),
            port = num,
            username = ImiServices.Instance.LoginService.GetUsername(),
            playerId = this.playerIdWaitingForMatch,
            gameLiftPlayerSessionId = playerSessionId
          };
          this.onSuccessCallback(connectionInfo);
          this.RaiseOnMatchmakingSuccess(connectionInfo);
          ImiServices instance = ImiServices.Instance;
          if (!instance.PartyService.IsInGroup() || (long) instance.PartyService.GetGroupOwner() != (long) instance.LoginService.GetPlayerId())
            return;
          instance.PartyService.NotifyGroupToJoinGame(this.matchMakingStatusJson.ToString());
        }
        else
          Log.Warning("Invalid matchmaking received.");
      }
    }

    public override void ProcessJoinGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId)
    {
      JObject playerSession = (JObject) playerSessions["GameSessionConnectionInfo"];
      string playerSessionId;
      if (!MatchmakingService.GetSessionIdForPlayer(playerSession["MatchedPlayerSessions"].ToArray<JToken>(), playerId, out playerSessionId))
        return;
      string ipString = playerSession["IpAddress"].ToString();
      int num = (int) playerSession["Port"];
      ConnectionInfo connectionInfo = new ConnectionInfo()
      {
        ip = IPAddress.Parse(ipString),
        port = num,
        username = ImiServices.Instance.LoginService.GetUsername(),
        playerId = playerId,
        gameLiftPlayerSessionId = playerSessionId
      };
      this.AddGameSessionIdToMetaMatchEntity(playerSession["GameSessionArn"].ToString());
      this.onSuccessCallback(connectionInfo);
      this.RaiseOnMatchmakingSuccess(connectionInfo);
    }

    public override void ProcessJoinCustomGameRequestFromGroupLeader(
      JObject playerSessions,
      ulong playerId)
    {
      foreach (JToken jtoken in (IEnumerable<JToken>) playerSessions["PlayerSessions"])
      {
        JObject jobject = (JObject) jtoken[(object) "PlayerSession"];
        ulong playerId1 = (ulong) jobject["PlayerId"];
        if ((long) playerId1 == (long) playerId)
        {
          ConnectionInfo connectionInfo = new ConnectionInfo()
          {
            ip = IPAddress.Parse(jobject["IpAddress"].ToString()),
            port = (int) jobject["Port"],
            username = ImiServices.Instance.PartyService.GetGroupMember(playerId1).username,
            playerId = playerId1,
            gameLiftPlayerSessionId = jobject["PlayerSessionId"].ToString()
          };
          this.AddGameSessionIdToMetaMatchEntity(jobject["GameSessionId"].ToString());
          this.onSuccessCallback(connectionInfo);
          this.RaiseOnMatchmakingSuccess(connectionInfo);
        }
      }
    }

    public override void Quit() => this.mmService.OnQuit();

    public override void OnGroupMemberConnectionAck(ulong playerId, JObject latencies) => this.mmService.OnGroupMemberConnectionAck(playerId, latencies);

    public override void OnGroupConnection() => this.mmService.OnGroupConnection();

    public override MmService GetMatchmakingV2() => this.mmService;

    private void AddGameSessionIdToMetaMatchEntity(string gameSessionId)
    {
      if (!Contexts.sharedInstance.meta.hasMetaMatch)
        Contexts.sharedInstance.meta.CreateEntity().AddMetaMatch("", gameSessionId, "", GameType.QuickMatch, false, false);
      else
        Contexts.sharedInstance.meta.metaMatchEntity.metaMatch.gameSessionId = gameSessionId;
    }

    private static bool GetSessionIdForPlayer(
      JToken[] matchedPlayerSessions,
      ulong ownPlayerId,
      out string playerSessionId)
    {
      playerSessionId = string.Empty;
      foreach (JToken matchedPlayerSession in matchedPlayerSessions)
      {
        if (matchedPlayerSession[(object) "PlayerId"].ToString().Equals(ownPlayerId.ToString()))
        {
          playerSessionId = matchedPlayerSession[(object) "PlayerSessionId"].ToString();
          return true;
        }
      }
      return false;
    }

    public override void OnUpdate()
    {
      this.mmService.OnUpdate();
      if (this.matchMakingTicket == null)
        return;
      if ((double) Time.time - this.lastMatchmakingUpdate > 10.0)
      {
        this.GetMatchmakingStatus();
        this.lastMatchmakingUpdate = (double) Time.time;
      }
      if (this.matchMakingStatusJson == null || this.matchMakingStatusJson["Status"] == null)
        return;
      string status = this.matchMakingStatusJson["Status"].ToString();
      if (status == "COMPLETED")
        this.ConnectToFoundMatch();
      else if (this.cancelRequestPending)
        this.RaiseOnMatchmakingStatusChanged("TryingToCancelMatchmaking", this.matchMakingTicket);
      else if (status == "TIMED_OUT")
      {
        this.matchMakingTicket = (string) null;
        this.RaiseOnMatchmakingError("Could not find match. Please try again later.");
      }
      else
        this.RaiseOnMatchmakingStatusChanged(status, this.matchMakingTicket);
    }

    private void GetMatchmakingStatus() => this.coroutineRunner.StartCoroutine(GameLiftHelpers.GetMatchmakingStatus(this.matchMakingTicket, this.currentRegion, (Action<string>) (error =>
    {
      Log.Api("Could not get match making status: " + error);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("Could not get match making status: " + error + ". Matchmaking canceled.", "OK", title: "Matchmaking Failed!"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
      this.matchMakingTicket = (string) null;
      this.matchmakingWasRequested = false;
      this.RaiseOnMatchmakingCancelled();
      this.RaiseOnMatchmakingStatusChanged("CANCELLED", this.matchMakingTicket);
    }), (Action<JObject>) (statusJson =>
    {
      Log.Api(string.Format("Got match making status: {0}", (object) statusJson));
      this.matchMakingStatusJson = statusJson;
    })));

    public override int GetMaxGroupSizeForCurrentMatchmakingType()
    {
      switch (this.type)
      {
        case MatchmakingType.OneVsOne:
          return 1;
        case MatchmakingType.TwoVsTwo:
          return 2;
        case MatchmakingType.ThreeVsThree:
          return 3;
        default:
          throw new ArgumentOutOfRangeException();
      }
    }

    public override bool IsMatchmaking() => this.mmService.GetState().hasEverBeenExecuted ? !this.mmService.GetState().allowStart : !string.IsNullOrEmpty(this.matchMakingTicket) || this.matchmakingWasRequested;

    public override void SetStandaloneIp(IPAddress address) => throw new NotImplementedException("SetStandaloneIp is only usable when in standalone mode.");

    public override void SetMatchmakingRequestedBool(bool wasMatchmakingRequested) => this.matchmakingWasRequested = wasMatchmakingRequested;

    public override bool IsStandaloneIpSet() => throw new NotImplementedException("IsStandaloneIpSet is only usable when in standalone mode.");
  }
}
