namespace Imi.SharedWithServer.Game
{
	public enum CollisionLayer
	{
		None = 0,
		Default = 1,
		LvlBorder = 2,
		TeamA = 4,
		TeamB = 8,
		ProjectilesTeamA = 16,
		ProjectilesTeamB = 32,
		Pickups = 64,
		Dodging = 128,
		Bumper = 256,
		Ball = 512,
		Forcefield = 1024,
		Barrier = 2048,
		Goal = 4096,
		Everything = 2147483647,
	}
}
