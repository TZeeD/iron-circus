// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.MmService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.Networking;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Net;
using System.Timers;
using UnityEngine;

namespace SteelCircus.Core.Services
{
  public class MmService
  {
    private const string MmKeepAlive = "keep-alive";
    private const string MmMmStart = "mm_start";
    private const string MmMmCancel = "mm_cancel";
    private const string MmMmAccept = "mm_accept";
    private const string MmType = "type";
    private const string MmPlayerId = "playerId";
    private const string MmData = "data";
    private const string MmResponse = "response";
    private const string MmCommand = "command";
    private const string MmTicketId = "ticketId";
    private const string MmMatchmaker = "matchmaker";
    private const string MmStartTime = "startTime";
    private const string MmRegion = "region";
    private const string MmEstimatedWaitMillis = "estimatedWaitMillis";
    private const string MmMessage = "message";
    private const string MmTeam = "team";
    private const string MmMatchId = "matchId";
    private const string MmGameSession = "gameSession";
    private const string MmPlayers = "players";
    private const string MmAccepted = "accepted";
    private const string MmPlayerSession = "playerSession";
    private const string MmIpAddress = "ipAddress";
    private const string MmPort = "port";
    private const string MmSendMessage = "sendmessage";
    private const string MmAcceptanceRequired = "acceptanceRequired";
    private const string MmAcceptanceTimeout = "acceptanceTimeout";
    private const string MmAcceptance = "acceptance";
    private const string MmSuccess = "success";
    private const string MmError = "error";
    private const string MmGameSessionArn = "gameSessionArn";
    private const bool MmAutoAcceptanceConfig = true;
    private const bool MmAllowKeepAliveSending = true;
    private bool isSoloMatchmakingPending;
    private bool isGroupMatchmakingPending;
    private Uri url = new Uri("wss://5l4avu0qq7.execute-api.eu-west-1.amazonaws.com/sc-gamelift-mm-live");
    private ScWebsocket client;
    private ulong playerId;
    private Dictionary<ulong, MmPlayer> groupMembers;
    private MmState currentState = new MmState();
    private MatchmakingType mmType = MatchmakingType.ThreeVsThree;
    private string mmRegion;
    private JObject cachedKeepAliveCommand;
    private const float TimeStep = 30f;
    private float lastKeepAliveTime;
    private System.Timers.Timer ackTimeoutTimer;
    private System.Timers.Timer socketConnectionTimeoutTimer;

    public event MmService.OnMatchmakingErrorEventHandler OnMatchmakingError;

    public event MmService.OnMatchmakingStatusChangedEventHandler OnMatchMakingStatusChanged;

    public event MmService.OnMatchmakingCanceledEventHandler OnMatchmakingCancelled;

    public event MmService.OnMatchmakingStartedEventHandler OnMatchmakingStarted;

    public event MmService.OnMatchmakingSuccessfulEventHandler OnMatchmakingSuccessful;

    public MmService() => ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);

    public MmService(
      Action raiseOnMatchmakingCancelled,
      Action<string, string> raiseOnMatchmakingStarted,
      Action<ConnectionInfo> raiseOnMatchmakingSuccess,
      Action<string, string> raiseOnMatchmakingStatusChanged,
      Action<string> raiseOnMatchmakingError)
    {
      ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.OnMetaLoginSuccessful);
      this.OnMatchmakingError += (MmService.OnMatchmakingErrorEventHandler) (error =>
      {
        Action<string> action = raiseOnMatchmakingError;
        if (action == null)
          return;
        action(error);
      });
      this.OnMatchMakingStatusChanged += (MmService.OnMatchmakingStatusChangedEventHandler) ((status, ticket) =>
      {
        Action<string, string> action = raiseOnMatchmakingStatusChanged;
        if (action == null)
          return;
        action(status, ticket);
      });
      this.OnMatchmakingCancelled += (MmService.OnMatchmakingCanceledEventHandler) (() =>
      {
        Action action = raiseOnMatchmakingCancelled;
        if (action == null)
          return;
        action();
      });
      this.OnMatchmakingStarted += (MmService.OnMatchmakingStartedEventHandler) ((ticket, region) =>
      {
        Action<string, string> action = raiseOnMatchmakingStarted;
        if (action == null)
          return;
        action(ticket, region);
      });
      this.OnMatchmakingSuccessful += (MmService.OnMatchmakingSuccessfulEventHandler) (connectionInfo =>
      {
        Action<ConnectionInfo> action = raiseOnMatchmakingSuccess;
        if (action == null)
          return;
        action(connectionInfo);
      });
      this.SetupTimeout();
    }

    private void OnMetaLoginSuccessful(ulong playerId)
    {
      this.playerId = playerId;
      this.client = new ScWebsocket(this.url.ToString(), playerId);
      this.client.OnOpen += new ScWebsocket.ClientOpenHandler(this.ConnectionCallback);
      this.client.OnClose += new ScWebsocket.ClientClosedHandler(this.DisconnectCallback);
      this.client.OnMessageReceived += new ScWebsocket.ClientMessageReceivedHandler(this.MessageCallback);
      this.client.OnError += new ScWebsocket.ClientErrorHandler(this.ErrorCallback);
      this.cachedKeepAliveCommand = MmService.KeepAliveCommandAsJson(playerId);
      this.currentState.allowStart = true;
    }

    private void ErrorCallback(ScWebsocketConnectionException e) => this.DisposeAndResetState(LateCancelState.ERROR);

    private void MessageCallback(string msg)
    {
      try
      {
        this.OnMmMessageReceived(msg);
      }
      catch (MmServiceException ex)
      {
        Log.Error(string.Format("[MmService] We received a malformed response. We reset the current state. /n({0})", (object) ex));
        this.DisconnectClientAndResetState("MmServiceException", LateCancelState.ERROR);
      }
      catch (Exception ex)
      {
        Log.Error("[MmService] Error during OnMmMessageReceived: " + msg + " " + ex.Message + "\n" + ex.StackTrace);
        this.DisconnectClientAndResetState("Resetting due to exception.", LateCancelState.ERROR);
      }
    }

    private void DisconnectCallback()
    {
    }

    private void ConnectionCallback()
    {
      Log.Debug("[MmService] Initial connection for this matchmaking request.");
      if (this.isSoloMatchmakingPending)
      {
        Log.Debug("[MmService] The matchmaking request is a solo-request.");
        JObject latencies = new JObject();
        foreach (KeyValuePair<string, long> regionLatency in AwsPinger.RegionLatencies)
          latencies.Add(regionLatency.Key, (JToken) (int) regionLatency.Value);
        this.client.Send(MmService.SoloStartCommand(this.playerId, this.mmRegion, latencies, MmService.MmTypeToString(this.mmType)));
        this.isSoloMatchmakingPending = false;
      }
      else
      {
        if (!this.isGroupMatchmakingPending)
          return;
        Log.Debug("[MmService] The matchmaking request is a group-request.");
        if (ImiServices.Instance.PartyService.IsGroupOwner())
        {
          Log.Debug("[MmService] The group owner (you) notifies the other players in the group via steam chat.");
          ImiServices.Instance.PartyService.NotifyRequestGroupMatchmaking();
        }
        JObject latencies = new JObject();
        foreach (KeyValuePair<string, long> regionLatency in AwsPinger.RegionLatencies)
          latencies.Add(regionLatency.Key, (JToken) (int) regionLatency.Value);
        Log.Debug("[MmService] Sending a notification ack to the group.");
        this.ackTimeoutTimer.Start();
        if (ImiServices.Instance.IsInMainMenu())
          ImiServices.Instance.PartyService.NotifyAckGroupMatchmaking(this.playerId, latencies);
        this.isGroupMatchmakingPending = false;
      }
    }

    public void OnUpdate()
    {
      if (this.client == null || !this.client.IsRunning || !this.client.IsOpen || (double) this.lastKeepAliveTime + 30.0 >= (double) Time.time)
        return;
      this.lastKeepAliveTime = Time.time;
      this.client.Send(MmService.KeepAliveCommandAsJson(this.playerId).ToString());
    }

    public void OnQuit()
    {
      if (this.client == null)
        return;
      if (this.client.IsRunning || this.client.IsOpen)
      {
        try
        {
          Log.Debug("[MmService] Closing Websocket..");
          this.client.Stop();
          Log.Debug("[MmService] Closing Websocket successful");
        }
        catch (Exception ex)
        {
          Log.Error(ex.ToString());
        }
      }
      this.ackTimeoutTimer.Elapsed -= new ElapsedEventHandler(this.OnAckTimeout);
    }

    public bool StartMatchmaking()
    {
      APartyService partyService = ImiServices.Instance.PartyService;
      if (partyService.IsInGroup() && partyService.GetCurrentGroup().Count > 1)
      {
        if (partyService.IsGroupOwner())
        {
          this.CreateGroupMemberData(partyService.GetCurrentGroup());
          this.isGroupMatchmakingPending = true;
          this.Connect();
        }
      }
      else if (!this.isSoloMatchmakingPending)
      {
        this.currentState.allowStart = false;
        this.isSoloMatchmakingPending = true;
        this.Connect();
      }
      return false;
    }

    private void CreateGroupMemberData(List<APartyService.GroupMember> group)
    {
      this.groupMembers = new Dictionary<ulong, MmPlayer>();
      foreach (APartyService.GroupMember groupMember in group)
      {
        ulong playerId = groupMember.playerId;
        if ((long) playerId == (long) this.playerId)
        {
          this.groupMembers[playerId] = new MmPlayer()
          {
            id = playerId,
            acked = true,
            latencies = (JObject) null
          };
        }
        else
        {
          JObject jobject = new JObject();
          foreach (KeyValuePair<string, long> regionLatency in AwsPinger.RegionLatencies)
            jobject.Add(regionLatency.Key, (JToken) (int) regionLatency.Value);
          this.groupMembers[playerId] = new MmPlayer()
          {
            id = playerId,
            acked = false,
            latencies = jobject
          };
        }
      }
    }

    public void OnGroupMemberConnectionAck(ulong otherPlayerId, JObject otherLatencies)
    {
      Log.Debug(string.Format("[MmService] OnGroupMemberConnectionAck: {0} acked", (object) otherPlayerId));
      this.groupMembers[otherPlayerId].acked = true;
      this.groupMembers[otherPlayerId].latencies = otherLatencies;
      bool flag = true;
      foreach (MmPlayer mmPlayer in this.groupMembers.Values)
      {
        if (!mmPlayer.acked)
        {
          flag = false;
          break;
        }
      }
      if (!flag)
        return;
      this.client.Send(MmService.GroupStartCommand(this.playerId, this.groupMembers, this.mmRegion, MmService.MmTypeToString(this.mmType)));
      this.ackTimeoutTimer.Stop();
    }

    private void OnAckTimeout(object sender, ElapsedEventArgs e)
    {
      Log.Debug("[MmService] OnAckTimeout happened.");
      this.DisconnectClientAndResetState("Resetting due to Timeout while waiting for acks.", LateCancelState.ERROR);
      UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
      {
        MmService.OnMatchmakingCanceledEventHandler matchmakingCancelled = this.OnMatchmakingCancelled;
        if (matchmakingCancelled == null)
          return;
        matchmakingCancelled();
      }));
    }

    private static string MmTypeToString(MatchmakingType matchmakingType)
    {
      switch (matchmakingType)
      {
        case MatchmakingType.OneVsOne:
          return "1v1";
        case MatchmakingType.TwoVsTwo:
          return "2v2";
        case MatchmakingType.ThreeVsThree:
          return "3v3";
        default:
          throw new ArgumentOutOfRangeException(nameof (matchmakingType), (object) matchmakingType, (string) null);
      }
    }

    public void OnGroupConnection()
    {
      if (!ImiServices.Instance.PartyService.IsInGroup())
        Log.Error("[MmService] You are not in a group.");
      this.currentState.allowStart = false;
      this.isGroupMatchmakingPending = true;
      this.Connect();
    }

    public bool CancelMatchmaking()
    {
      if (!this.client.IsRunning || !this.currentState.allowCancel || string.IsNullOrEmpty(this.currentState.ticket))
        return false;
      this.currentState.allowCancel = false;
      this.client.Send(MmService.CancelCommand(this.playerId, !string.IsNullOrEmpty(this.currentState.region) ? this.currentState.region : this.mmRegion, this.currentState.ticket));
      return false;
    }

    public void Connect()
    {
      if (this.client == null)
        Log.Error("Can't establish connection, websocket is null.'");
      else if (this.client.IsRunning)
        Log.Warning("Can't establish connection, websocket is already running.");
      else if (this.client.IsOpen)
        Log.Warning("Can't establish connection, websocket is already open.");
      else
        this.client.Start();
    }

    public MmState GetState() => this.currentState;

    private void SetupTimeout()
    {
      this.ackTimeoutTimer = new System.Timers.Timer();
      this.ackTimeoutTimer.Interval = 5000.0;
      this.ackTimeoutTimer.Elapsed += new ElapsedEventHandler(this.OnAckTimeout);
      this.ackTimeoutTimer.AutoReset = false;
      this.ackTimeoutTimer.Enabled = false;
    }

    private void OnMmMessageReceived(string msg)
    {
      JObject mmJson = JObject.Parse(msg);
      if (!MmService.HasRequiredAttributes(mmJson, this.playerId))
      {
        Log.Error("[MmService] Received malformed json: " + msg);
      }
      else
      {
        string type = mmJson["type"].ToString();
        JObject data = (JObject) mmJson["data"];
        switch (type)
        {
          case "AcceptMatch":
            break;
          case "AcceptMatchCompleted":
            if (!this.HandleMmAcceptMatchCompleted(data, type))
              break;
            this.DisconnectClientAndResetState("Matchmaking rejected/timeout", LateCancelState.CANCEL);
            break;
          case "MatchmakingCancelled":
            if (!this.HandleMmCancel(data, type))
              break;
            this.DisconnectClientAndResetState("Matchmaking has been cancelled", LateCancelState.CANCEL);
            break;
          case "MatchmakingFailed":
          case "MatchmakingTimedOut":
            string errorMessage = this.HandleMmNotSuccessful(data, type);
            this.DisconnectClientAndResetState("Matchmaking unsuccessful", LateCancelState.ERROR);
            UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
            {
              MmService.OnMatchmakingErrorEventHandler matchmakingError = this.OnMatchmakingError;
              if (matchmakingError == null)
                return;
              matchmakingError(errorMessage);
            }));
            break;
          case "MatchmakingSearching":
            this.ackTimeoutTimer.Stop();
            this.HandleMmSearching(data, type);
            UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
            {
              MmService.OnMatchmakingStartedEventHandler matchmakingStarted = this.OnMatchmakingStarted;
              if (matchmakingStarted != null)
                matchmakingStarted(this.currentState.ticket, this.mmRegion);
              MmService.OnMatchmakingStatusChangedEventHandler makingStatusChanged = this.OnMatchMakingStatusChanged;
              if (makingStatusChanged == null)
                return;
              makingStatusChanged("SEARCHING", this.currentState.ticket);
            }));
            break;
          case "MatchmakingSucceeded":
            this.HandleMmSucceededMessage(data, type);
            this.DisconnectClientAndResetState("Matchmaking successful", LateCancelState.SUCCESS);
            break;
          case "PotentialMatchCreated":
            this.HandleMmPotentialMatchCreated(data, type);
            UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
            {
              MmService.OnMatchmakingStatusChangedEventHandler makingStatusChanged = this.OnMatchMakingStatusChanged;
              if (makingStatusChanged == null)
                return;
              makingStatusChanged("PLACING", this.currentState.ticket);
            }));
            break;
          case "response":
            if (!MmService.HandleMmResponseMessage(data))
              break;
            this.DisconnectClientAndResetState("MmService canceled.", LateCancelState.CANCEL);
            break;
          default:
            Log.Error("[MmService] Matchmaking encountered an error. Try again later.");
            break;
        }
      }
    }

    private void DisposeAndResetState(LateCancelState state)
    {
      this.client.Stop();
      this.ResetState(state);
    }

    private void DisconnectClientAndResetState(string msg, LateCancelState state) => this.DisposeAndResetState(state);

    private void ResetState(LateCancelState state)
    {
      Log.Debug(string.Format("[MmService] Current Matchmaking process has finished ({0}). ", (object) state) + "Waiting for new one. ");
      this.currentState.allowStart = true;
      this.currentState.allowCancel = false;
      this.currentState.allowDisplayAcceptance = false;
      this.currentState.type = "NONE";
      this.currentState.ticket = string.Empty;
      this.isSoloMatchmakingPending = false;
      this.isGroupMatchmakingPending = false;
      UnityMainThreadDispatcher.Instance().Enqueue(this.LateCancel(state));
    }

    private IEnumerator LateCancel(LateCancelState state)
    {
      Log.Debug(string.Format("Websocket Closing - Late Cancel State is {0}", (object) state));
      float time = 1f;
      switch (state)
      {
        case LateCancelState.ERROR:
          time = 5f;
          break;
        case LateCancelState.SUCCESS:
          time = 5f;
          break;
        case LateCancelState.CANCEL:
          MmService.OnMatchmakingStatusChangedEventHandler makingStatusChanged = this.OnMatchMakingStatusChanged;
          if (makingStatusChanged != null)
          {
            makingStatusChanged("TryingToCancelMatchmaking", "");
            break;
          }
          break;
        default:
          throw new ArgumentOutOfRangeException(nameof (state), (object) state, (string) null);
      }
      yield return (object) new WaitForSecondsRealtime(time);
      if (state != LateCancelState.SUCCESS)
      {
        MmService.OnMatchmakingCanceledEventHandler matchmakingCancelled = this.OnMatchmakingCancelled;
        if (matchmakingCancelled != null)
          matchmakingCancelled();
      }
    }

    private bool HandleMmCancel(JObject data, string type)
    {
      if (data.ContainsKey("ticketId") && data.ContainsKey("matchmaker") && data.ContainsKey("startTime") && data.ContainsKey("message"))
      {
        string str1 = data["ticketId"].ToString();
        string str2 = data["message"].ToString();
        if (this.currentState.ticket.Equals(str1))
        {
          this.currentState.ticket = string.Empty;
          this.currentState.region = string.Empty;
          this.currentState.type = type;
          this.currentState.allowStart = true;
          this.currentState.allowCancel = false;
          this.currentState.allowDisplayAcceptance = false;
          Log.Error("[MmService] MatchmakingCancel with ticket " + str1 + " -> " + str2);
          return true;
        }
        Log.Debug("[MmService] MatchmakingCancel from a ticket we do not track. Was: " + str1);
      }
      return false;
    }

    private string HandleMmNotSuccessful(JObject data, string type)
    {
      if (!data.ContainsKey("ticketId") || !data.ContainsKey("matchmaker") || !data.ContainsKey("startTime") || !data.ContainsKey("message"))
        return "Malformed";
      string str1 = data["ticketId"].ToString();
      string str2 = data["message"].ToString();
      if (!this.currentState.ticket.Equals(str1))
        Log.Error("[MmService] MatchmakingNotSuccessful with different ticket. Was " + str1 + " Client thinks " + this.currentState.ticket);
      this.currentState.ticket = string.Empty;
      this.currentState.type = type;
      this.currentState.allowStart = true;
      this.currentState.allowCancel = false;
      this.currentState.allowDisplayAcceptance = false;
      Log.Error("[MmService] MatchmakingNotSuccessful -> " + type + " | " + str2);
      return str2;
    }

    private void HandleMmSucceededMessage(JObject data, string type)
    {
      int result;
      if (!data.ContainsKey("team") || !data.ContainsKey("ticketId") || !data.ContainsKey("playerSession") || !data.ContainsKey("matchId") || !data.ContainsKey("ipAddress") || !data.ContainsKey("port") || !int.TryParse(data["port"].ToString(), out result))
        return;
      Log.Debug("[MmService] MatchmakingSucceeded with ticket " + this.currentState.ticket);
      this.currentState.type = type;
      this.currentState.allowStart = true;
      this.currentState.allowCancel = false;
      this.currentState.allowDisplayAcceptance = false;
      this.currentState.ticket = string.Empty;
      Log.Debug(string.Format("The received game session arn: {0}", (object) data["gameSessionArn"]));
      AddGameSessionIdToMetaMatchEntity(data["gameSessionArn"].ToString());
      ConnectionInfo connectionInfo = new ConnectionInfo()
      {
        ip = IPAddress.Parse(data["ipAddress"].ToString()),
        port = result,
        username = ImiServices.Instance.LoginService.GetUsername(),
        playerId = this.playerId,
        gameLiftPlayerSessionId = data["playerSession"].ToString()
      };
      UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
      {
        MmService.OnMatchmakingSuccessfulEventHandler matchmakingSuccessful = this.OnMatchmakingSuccessful;
        if (matchmakingSuccessful != null)
          matchmakingSuccessful(connectionInfo);
        SingletonManager<MetaServiceHelpers>.Instance.GetConnectTokenFromService(connectionInfo, new Action<ConnectionInfo, byte[]>(ImiServices.Instance.ConnectToGameServer), (Action) (() => UnityMainThreadDispatcher.Instance().Enqueue((Action) (() =>
        {
          MmService.OnMatchmakingCanceledEventHandler matchmakingCancelled = this.OnMatchmakingCancelled;
          if (matchmakingCancelled == null)
            return;
          matchmakingCancelled();
        }))));
      }));

      static void AddGameSessionIdToMetaMatchEntity(string gameSessionId)
      {
        if (!Contexts.sharedInstance.meta.hasMetaMatch)
          Contexts.sharedInstance.meta.CreateEntity().AddMetaMatch("", gameSessionId, "", GameType.QuickMatch, false, false);
        else
          Contexts.sharedInstance.meta.metaMatchEntity.metaMatch.gameSessionId = gameSessionId;
      }
    }

    private bool HandleMmAcceptMatchCompleted(JObject data, string type)
    {
      if (data.ContainsKey("acceptance") && data.ContainsKey("gameSession"))
      {
        string str = data["acceptance"].ToString();
        Log.Debug("[MmService] AcceptMatchCompleted received.");
        if (str.Equals("Accepted"))
        {
          this.currentState.allowStart = false;
          this.currentState.allowCancel = false;
          this.currentState.allowDisplayAcceptance = true;
          return false;
        }
        foreach (JObject jobject in (IEnumerable<JToken>) data["gameSession"][(object) "players"])
        {
          ulong num1 = ulong.Parse(jobject["playerId"].ToString());
          int num2 = jobject.ContainsKey("accepted") ? 1 : 0;
          bool flag1 = num2 != 0 && bool.Parse(jobject["accepted"].ToString());
          bool flag2 = num2 == 0 || !flag1;
          if (this.currentState.playerIds.Contains(num1) & flag2)
          {
            this.currentState.allowStart = true;
            this.currentState.allowCancel = false;
            this.currentState.allowDisplayAcceptance = false;
            this.currentState.type = "NONE";
            return true;
          }
        }
      }
      return true;
    }

    private void HandleMmPotentialMatchCreated(JObject data, string type)
    {
      data["team"].ToString();
      bool result;
      int num = bool.TryParse(data["acceptanceRequired"].ToString(), out result) & ulong.TryParse(data["acceptanceTimeout"].ToString(), out ulong _) ? 1 : 0;
      string str = data["ticketId"].ToString();
      if (num != 0 && str.Equals(this.currentState.ticket))
      {
        Log.Debug("[MmService] PotentialMatchCreated with ticket " + str);
        this.currentState.type = type;
        this.currentState.allowStart = false;
        this.currentState.allowCancel = false;
        this.currentState.allowDisplayAcceptance = true;
        if (!result)
          return;
        this.client.Send(MmService.AcceptCommand(this.playerId, this.mmRegion, this.currentState.ticket).ToString());
      }
      else
        Log.Debug("[MmService] PotentialMatchCreated, but the ticket is not tracked by the client Was: " + str + " Client thinks: " + this.currentState.ticket);
    }

    private void HandleMmSearching(JObject data, string type)
    {
      if (!data.ContainsKey("ticketId") || !data.ContainsKey("matchmaker") || !data.ContainsKey("startTime") || !data.ContainsKey("region") || !data.ContainsKey("estimatedWaitMillis") || !data.ContainsKey("gameSession"))
        return;
      Log.Debug("[MmService] MatchmakingSearching with ticket ticketId");
      DateTime utcNow = DateTime.UtcNow;
      try
      {
        utcNow = DateTime.Parse(data["startTime"].ToString(), (IFormatProvider) CultureInfo.InvariantCulture);
      }
      catch (Exception ex)
      {
        Log.Error("Exception parsing DateTime, using DateTime.UtcNow! " + ex.Message);
      }
      if (!string.IsNullOrEmpty(this.currentState.ticket) && this.currentState.startTime < utcNow)
        Log.Debug("[MmService] We received a new MatchmakingService, it is newer than the current state.");
      MmService.AddPlayersToTicket(data["gameSession"], ref this.currentState.playerIds);
      this.currentState.hasEverBeenExecuted = true;
      this.currentState.type = type;
      this.currentState.ticket = data["ticketId"].ToString();
      this.currentState.region = data["region"].ToString();
      this.currentState.startTime = utcNow;
      this.currentState.allowStart = false;
      this.currentState.allowCancel = true;
      this.currentState.allowDisplayAcceptance = false;
      Log.Debug(string.Format("[MmService] MatchmakingSearching with ticket {0}", (object) data["ticketId"]));
    }

    private static void AddPlayersToTicket(
      JToken gameSession,
      ref HashSet<ulong> currentStatePlayerIds)
    {
      currentStatePlayerIds.Clear();
      foreach (JObject jobject in (IEnumerable<JToken>) gameSession[(object) "players"])
      {
        ulong num = ulong.Parse(jobject["playerId"].ToString());
        currentStatePlayerIds.Add(num);
      }
    }

    private static bool HandleMmResponseMessage(JObject data)
    {
      if (data.ContainsKey("command"))
      {
        string str1 = data["command"].ToString();
        string str2 = "";
        if (data.ContainsKey(nameof (data)))
          str2 = data[nameof (data)].ToString();
        string str3 = "";
        if (data.ContainsKey("response"))
          str3 = data["response"].ToString();
        Log.Debug("[MmService] MmResponse received: " + str1 + " - " + str3 + " - " + str2);
        if (str1.Equals("mm_cancel") && str3.Equals("success"))
          return true;
        if (str1.Equals("mm_cancel") || !str3.Equals("error"))
          return false;
        Log.Error("[MmService] We received an error response and reset our current state.");
        return true;
      }
      Log.Error(string.Format("(1) Malformed json: {0}", (object) data));
      throw new MmServiceException();
    }

    private static string KeepAliveCommand(ulong pid) => JObject.FromObject((object) new
    {
      message = "sendmessage",
      data = new
      {
        playerId = pid.ToString(),
        command = "keep-alive"
      }
    }).ToString();

    private static JObject KeepAliveCommandAsJson(ulong pid) => JObject.FromObject((object) new
    {
      message = "sendmessage",
      data = new
      {
        playerId = pid.ToString(),
        command = "keep-alive",
        payload = DateTime.UtcNow
      }
    });

    private static string CancelCommand(ulong pid, string region, string ticketId) => JObject.FromObject((object) new
    {
      message = "sendmessage",
      data = new
      {
        playerId = pid.ToString(),
        command = "mm_cancel",
        payload = new
        {
          ticketId = ticketId,
          region = region
        }
      }
    }).ToString();

    private static string SoloStartCommand(
      ulong pid,
      string region,
      JObject latencies,
      string type)
    {
      return JObject.FromObject((object) new
      {
        message = "sendmessage",
        data = new
        {
          playerId = pid.ToString(),
          command = "mm_start",
          payload = new
          {
            latencies = latencies,
            region = region,
            matchType = type
          }
        }
      }).ToString();
    }

    private static string GroupStartCommand(
      ulong pid,
      Dictionary<ulong, MmPlayer> players,
      string region,
      string type)
    {
      JArray jarray = new JArray();
      foreach (MmPlayer mmPlayer in players.Values)
        jarray.Add((JToken) new JObject()
        {
          {
            "playerId",
            (JToken) mmPlayer.id.ToString()
          },
          {
            "latencies",
            (JToken) mmPlayer.latencies
          }
        });
      return JObject.FromObject((object) new
      {
        message = "sendmessage",
        data = new
        {
          playerId = pid.ToString(),
          command = "mm_group_start",
          payload = new
          {
            players = jarray,
            region = region,
            matchType = type
          }
        }
      }).ToString();
    }

    private static string AcceptCommand(ulong pid, string region, string ticket) => JObject.FromObject((object) new
    {
      message = "sendmessage",
      data = new
      {
        playerId = pid.ToString(),
        command = "mm_accept",
        payload = new{ ticketId = ticket, region = region }
      }
    }).ToString();

    private static bool HasRequiredAttributes(JObject mmJson, ulong pid) => mmJson.ContainsKey("type") && mmJson.ContainsKey("playerId") && mmJson.ContainsKey("data") && ulong.TryParse(mmJson["playerId"].ToString(), out ulong _) && (long) ulong.Parse(mmJson["playerId"].ToString()) == (long) pid;

    public void SetMatchmakingType(MatchmakingType type) => this.mmType = type;

    public void SetRegion(string region) => this.mmRegion = region;

    public delegate void OnMatchmakingStatusChangedEventHandler(string status, string ticketId);

    public delegate void OnMatchmakingCanceledEventHandler();

    public delegate void OnMatchmakingStartedEventHandler(string ticketId, string matchmakerRegion);

    public delegate void OnMatchmakingErrorEventHandler(string errorMessage);

    public delegate void OnMatchmakingSuccessfulEventHandler(ConnectionInfo connectionInfo);
  }
}
