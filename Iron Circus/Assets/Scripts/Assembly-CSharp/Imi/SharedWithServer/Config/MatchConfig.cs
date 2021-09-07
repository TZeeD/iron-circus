using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.Config
{
	public class MatchConfig : GameConfigEntry
	{
		public bool allowServerRandom;
		public int ConnectionWindowDuration;
		public int LoadWindowDuration;
		public int PlayerSelectionWindowDuration;
		public int InitialLobbyEnteredPause;
		public int WaitingForPlayersDuration;
		public int PlayerChampionPickDuration;
		public int PauseBetweenPicks;
		public int GracePeriodWindowDuration;
		public int MaximumChampionPicksPerTeamAllowed;
		public ChampionType[] championsForRandomSelection;
		public int durationInSeconds;
		public int playgroundDurationInSeconds;
		public float gameEndedCutsceneLengthInSeconds;
		public float goalCutsceneLengthInSeconds;
		public float introCutsceneLengthInSeconds;
		public float basicTrainingIntroCutsceneLengthInSeconds;
		public float getReadyCutsceneLengthInSeconds;
		public float startPointCutsceneLengthInSeconds;
		public float victoryScreenLength;
		public float victoryPosesLength;
		public float statsScreenLength;
		public bool overtimeEnabled;
		public float overtimeCutsceneLength;
		public float overtimeDuration;
		public float forfeitStartTime;
		public float forfeitVoteTime;
		public float respawnTime;
		public float addedRespawnTime;
		public float respawnTimeCap;
		public bool enableLoserBall;
		public float loserBallTeamOrange;
		public float loserBallTeamBlue;
		public MatchState playersAllowedToMove;
		public int matchPoint;
		public int matchPointInPlayground;
		public float skillPickupRechargeAmount;
		public float sprintPickupRechargeAmount;
	}
}
