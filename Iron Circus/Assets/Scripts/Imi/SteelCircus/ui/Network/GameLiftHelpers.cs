// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Network.GameLiftHelpers
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Networking.Messages;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SteelCircus.UI.Network
{
  public static class GameLiftHelpers
  {
    public const string DEFAULT_REGION = "eu-west-1";

    public static IEnumerator CreateAndJoinTrainingSession(
      ulong playerId,
      string region,
      Action<string> OnError,
      Action<string, string, string, int> OnSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/protected/gamelift/gl_spawn_playground", new JObject()
      {
        [nameof (playerId)] = (JToken) playerId.ToString(),
        [nameof (region)] = (JToken) region
      }, (Action<string>) (error =>
      {
        Log.Debug("Could not contact GameLift service: " + error);
        OnError("Could not contact GameLift service: " + error);
      }), GameLiftHelpers.HandleJsonResult((Action<string>) (error =>
      {
        Log.Debug("GameLift service returned error: " + error);
        OnError("GameLift service returned error: " + error);
      }), (Action<JObject>) (jsonResult =>
      {
        Log.Debug(string.Format("GameLift service returned {0}", (object) jsonResult));
        if (MetaServiceHelpers.HasLoginError(jsonResult))
          return;
        JObject jobject = (JObject) jsonResult["PlayerSession"];
        OnSuccess(jobject["PlayerSessionId"].ToString(), jobject["IpAddress"].ToString(), jobject["GameSessionId"].ToString(), (int) jobject["Port"]);
      })));
    }

    public static IEnumerator CreateAndJoinBasicTraining(
      ulong playerId,
      string region,
      Action<string> OnError,
      Action<string, string, string, int> OnSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/protected/gamelift/gl_spawn_basic_training", new JObject()
      {
        [nameof (playerId)] = (JToken) playerId.ToString(),
        [nameof (region)] = (JToken) region
      }, (Action<string>) (error =>
      {
        Log.Debug("Could not contact GameLift service: " + error);
        OnError("Could not contact GameLift service: " + error);
      }), GameLiftHelpers.HandleJsonResult((Action<string>) (error =>
      {
        Log.Debug("GameLift service returned error: " + error);
        OnError("GameLift service returned error: " + error);
      }), (Action<JObject>) (jsonResult =>
      {
        Log.Debug(string.Format("GameLift service returned {0}", (object) jsonResult));
        if (MetaServiceHelpers.HasLoginError(jsonResult))
          return;
        JObject jobject = (JObject) jsonResult["PlayerSession"];
        OnSuccess(jobject["PlayerSessionId"].ToString(), jobject["IpAddress"].ToString(), jobject["GameSessionId"].ToString(), (int) jobject["Port"]);
      })));
    }

    public static IEnumerator CreateAndJoinCustomMatch(
      ulong ownPlayerId,
      List<CustomMatchPlayerInfo> alphaPlayerIds,
      List<CustomMatchPlayerInfo> betaPlayerIds,
      string arena,
      string region,
      GameType gameType,
      Dictionary<string, long> regionLatencies,
      Action<string> OnError,
      Action<string, string, string, int> OnSuccess)
    {
      Log.Api("CreateAndJoinCustomMatch...");
      JObject jsonParams = new JObject();
      jsonParams["playerId"] = (JToken) ownPlayerId.ToString();
      JArray jarray = new JArray();
      JArray playerIdsJson1 = GameLiftHelpers.CreatePlayerIdsJson(ownPlayerId, alphaPlayerIds, regionLatencies);
      JArray playerIdsJson2 = GameLiftHelpers.CreatePlayerIdsJson(ownPlayerId, betaPlayerIds, regionLatencies);
      JObject jobject1 = new JObject();
      jobject1["name"] = (JToken) "alpha";
      jobject1["players"] = (JToken) playerIdsJson1;
      JObject jobject2 = new JObject();
      jobject2["name"] = (JToken) "beta";
      jobject2["players"] = (JToken) playerIdsJson2;
      jarray.Add((JToken) jobject1);
      jarray.Add((JToken) jobject2);
      jsonParams["teams"] = (JToken) jarray;
      jsonParams[nameof (arena)] = (JToken) arena;
      jsonParams[nameof (region)] = (JToken) region;
      jsonParams[nameof (gameType)] = (JToken) (int) gameType;
      Log.Debug(string.Format("------- Sending {0}", (object) jsonParams));
      yield return (object) MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/protected/gamelift/gl_spawn_custom_match", jsonParams, (Action<string>) (error =>
      {
        Log.Debug("GameLift service returned error: " + error);
        OnError("GameLift service returned error: " + error);
      }), (Action<JObject>) (jsonResult =>
      {
        Log.Debug(string.Format("GameLift service returned {0}", (object) jsonResult));
        if (MetaServiceHelpers.HasLoginError(jsonResult))
          return;
        if (ImiServices.Instance.PartyService.IsInGroup() && (long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) ImiServices.Instance.LoginService.GetPlayerId())
          ImiServices.Instance.PartyService.NotifyGroupToJoinCustomGame(jsonResult.ToString());
        foreach (JToken jtoken in (IEnumerable<JToken>) jsonResult["PlayerSessions"])
        {
          JObject jobject3 = (JObject) jtoken[(object) "PlayerSession"];
          ulong num = (ulong) jobject3["PlayerId"];
          if ((long) ImiServices.Instance.PartyService.GetGroupOwner() == (long) ownPlayerId && (long) ownPlayerId == (long) num || jsonResult["PlayerSessions"].Count<JToken>() == 1)
            OnSuccess(jobject3["PlayerSessionId"].ToString(), jobject3["IpAddress"].ToString(), jobject3["GameSessionId"].ToString(), (int) jobject3["Port"]);
        }
      }));
    }

    private static JArray CreatePlayerIdsJson(
      ulong ownPlayerId,
      List<CustomMatchPlayerInfo> playerInfos,
      Dictionary<string, long> regionLatencies)
    {
      JArray jarray = new JArray();
      foreach (CustomMatchPlayerInfo playerInfo in playerInfos)
      {
        JObject jobject = new JObject();
        jobject["playerId"] = (JToken) playerInfo.playerId.ToString();
        if ((long) playerInfo.playerId == (long) ownPlayerId && regionLatencies != null)
          jobject["latencyInMs"] = (JToken) GameLiftHelpers.LatenciesJson(regionLatencies);
        jobject["isBot"] = (JToken) playerInfo.isBot;
        jobject["aiDifficulty"] = (JToken) playerInfo.aiDifficulty;
        jarray.Add((JToken) jobject);
      }
      return jarray;
    }

    public static IEnumerator StartMatchmaking(
      ulong ownPlayerId,
      List<ulong> playerIds,
      string config,
      string region,
      Dictionary<string, long> regionLatencies,
      Action<string> OnError,
      Action<string> OnSuccess)
    {
      Log.Api("Starting match making ..");
      JObject jsonParams = new JObject();
      JArray jarray = new JArray();
      foreach (ulong playerId in playerIds)
      {
        JObject jobject = new JObject();
        jobject["playerId"] = (JToken) playerId.ToString();
        if ((long) playerId == (long) ownPlayerId && regionLatencies != null)
          jobject["latencyInMs"] = (JToken) GameLiftHelpers.LatenciesJson(regionLatencies);
        jarray.Add((JToken) jobject);
      }
      jsonParams["players"] = (JToken) jarray;
      jsonParams["configurationName"] = (JToken) config;
      jsonParams[nameof (region)] = (JToken) region;
      Log.Debug(string.Format("------- Sending {0}", (object) jsonParams));
      yield return (object) MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/protected/gamelift/gl_start_matchmaking", jsonParams, OnError, GameLiftHelpers.HandleJsonResult(OnError, (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        OnSuccess(resultJson["MatchmakingTicket"][(object) "TicketId"].ToString());
      })));
    }

    private static JObject LatenciesJson(Dictionary<string, long> regionLatencies)
    {
      JObject jobject = new JObject();
      foreach (KeyValuePair<string, long> regionLatency in regionLatencies)
        jobject[regionLatency.Key] = (JToken) regionLatency.Value;
      return jobject;
    }

    public static IEnumerator StopMatchmaking(
      string ticketId,
      string region,
      Action<string> onError,
      Action onSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpPostJsonWithAuth("https://sc-live-progression.steelcircus.net/protected/gamelift/gl_stop_matchmaking", new JObject()
      {
        [nameof (ticketId)] = (JToken) ticketId,
        [nameof (region)] = (JToken) region
      }, (Action<string>) (error => Log.Debug("StopMatchMaking: Could not contact GameLift service: " + error)), GameLiftHelpers.HandleJsonResult(onError, (Action<JObject>) (resultJson =>
      {
        if (MetaServiceHelpers.HasLoginError(resultJson))
          return;
        onSuccess();
      })));
    }

    public static IEnumerator GetMatchmakingStatus(
      string ticketId,
      string region,
      Action<string> OnError,
      Action<JObject> OnSuccess)
    {
      yield return (object) MetaServiceHelpers.HttpGetJsonWithAuth("https://sc-live-progression.steelcircus.net/public/gamelift/gl_get_matchmaking_status", new JObject()
      {
        [nameof (ticketId)] = (JToken) ticketId,
        [nameof (region)] = (JToken) region
      }, OnError, GameLiftHelpers.HandleJsonResult(OnError, OnSuccess));
    }

    private static Action<JObject> HandleJsonResult(
      Action<string> OnError,
      Action<JObject> OnSuccess)
    {
      return (Action<JObject>) (jsonResult =>
      {
        if (jsonResult["error"] != null)
          OnError(jsonResult["error"].ToString());
        else
          OnSuccess(jsonResult);
      });
    }

    public static void SendPlayerSession(string playerSessionId)
    {
      if (playerSessionId == null)
        return;
      Log.Debug("Sending GL PlayerSessionId " + playerSessionId);
      Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new GameLiftPlayerSessionMessage(playerSessionId));
    }
  }
}
