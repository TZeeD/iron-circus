namespace Imi.SharedWithServer.Game
{
	public enum MatchState
	{
		WaitingForPlayers = 0,
		Intro = 1,
		GetReady = 2,
		StartPoint = 3,
		PointInProgress = 4,
		Goal = 5,
		Overtime = 6,
		MatchOver = 7,
		VictoryScreen = 8,
		VictoryPose = 9,
		StatsScreens = 10,
		CloseGame = 11,
	}
}
