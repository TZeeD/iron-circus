using System;
using Imi.SharedWithServer.Game;
using Imi.Game;
using System.Collections.Generic;

namespace Imi.SharedWithServer.ScEvents.StatEvents
{
	public class GameStatMatchFinishedEvent
	{
		public struct MatchResult
		{
			public MatchResult(ulong playerId, ChampionType championType, Team team, MatchOutcome outcome, int score) : this()
			{
			}

			public ulong playerId;
			public ChampionType championType;
			public Team team;
			public MatchOutcome outcome;
			public int score;
			public bool hasLeftDuringMatch;
			public bool overtime;
			public GameType matchType;
		}

		public GameStatMatchFinishedEvent(string arena, string matchId, List<GameStatMatchFinishedEvent.MatchResult> results)
		{
		}

		public string matchId;
		public GameType matchType;
		public bool wasMatchAborted;
		public bool overtime;
		public float matchTimeElapsed;
		public float matchDuration;
	}
}
