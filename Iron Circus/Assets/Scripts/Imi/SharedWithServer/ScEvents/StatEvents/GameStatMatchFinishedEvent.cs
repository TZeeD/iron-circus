// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEvents.StatEvents.GameStatMatchFinishedEvent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.ScEvents;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEvents.StatEvents
{
  public class GameStatMatchFinishedEvent
  {
    [JsonProperty]
    public readonly string arena;
    [JsonProperty]
    public List<GameStatMatchFinishedEvent.MatchResult> results = new List<GameStatMatchFinishedEvent.MatchResult>();
    [JsonProperty]
    public string matchId;
    [JsonProperty]
    public GameType matchType;
    [JsonProperty]
    public bool wasMatchAborted;
    [JsonProperty]
    public bool overtime;
    [JsonProperty]
    public float matchTimeElapsed;
    [JsonProperty]
    public float matchDuration;

    public GameStatMatchFinishedEvent(
      string arena,
      string matchId,
      GameType matchType,
      bool wasMatchAborted,
      bool overtime,
      float matchDuration,
      float matchTimeElapsed)
    {
      this.arena = arena;
      this.matchId = matchId;
      this.matchType = matchType;
      this.wasMatchAborted = wasMatchAborted;
      this.overtime = overtime;
      this.matchTimeElapsed = matchTimeElapsed;
      this.matchDuration = matchDuration;
    }

    public GameStatMatchFinishedEvent(
      string arena,
      string matchId,
      List<GameStatMatchFinishedEvent.MatchResult> results)
    {
      this.arena = arena;
      this.results = results;
      this.matchId = matchId;
    }

    public void AddResult(
      ulong playerId,
      ChampionType championType,
      Team team,
      MatchOutcome outcome,
      int score,
      Dictionary<Statistics, float> stats,
      bool hasLeftDuringMatch,
      GameType matchType,
      bool overtime)
    {
      this.results.Add(new GameStatMatchFinishedEvent.MatchResult(playerId, championType, team, outcome, score, stats, hasLeftDuringMatch, matchType, overtime));
    }

    public JObject ToJson() => JObject.FromObject((object) this);

    public Message ToMessage() => (Message) new GameStatMatchFinishedMessage(this.arena, this.matchId, this.results);

    public struct MatchResult
    {
      [JsonProperty]
      public ulong playerId;
      [JsonProperty]
      public ChampionType championType;
      [JsonProperty]
      public Team team;
      [JsonProperty]
      public MatchOutcome outcome;
      [JsonProperty]
      public int score;
      [JsonProperty]
      public Dictionary<Statistics, float> stats;
      [JsonProperty]
      public bool hasLeftDuringMatch;
      [JsonProperty]
      public bool overtime;
      [JsonProperty]
      public GameType matchType;

      public MatchResult(
        ulong playerId,
        ChampionType championType,
        Team team,
        MatchOutcome outcome,
        int score)
      {
        this.playerId = playerId;
        this.championType = championType;
        this.team = team;
        this.outcome = outcome;
        this.score = score;
        this.stats = new Dictionary<Statistics, float>();
        this.hasLeftDuringMatch = false;
        this.overtime = false;
        this.matchType = GameType.QuickMatch;
      }

      public MatchResult(
        ulong playerId,
        ChampionType championType,
        Team team,
        MatchOutcome outcome,
        int score,
        Dictionary<Statistics, float> stats,
        bool hasLeftDuringMatch,
        GameType matchType,
        bool overtime)
      {
        this.playerId = playerId;
        this.championType = championType;
        this.team = team;
        this.outcome = outcome;
        this.score = score;
        this.stats = stats;
        this.hasLeftDuringMatch = hasLeftDuringMatch;
        this.overtime = overtime;
        this.matchType = matchType;
      }
    }
  }
}
