namespace SharedWithServer.ScEvents
{
	public enum GameplayEventType
	{
		BallThrow = 0,
		BallPickup = 1,
		BallDrop = 2,
		Pass = 3,
		Tackle = 4,
		TackleHit = 5,
		Dodge = 6,
		TackleDodged = 7,
		BallToPlayerCollision = 8,
		BallToBoundsCollision = 9,
		BallToBumperCollision = 10,
		GoalNearMiss = 11,
		Goal = 12,
		DamageDone = 13,
		KilledBy = 14,
		StunnedBy = 15,
		PickupCollected = 16,
		BallSteal = 17,
	}
}
