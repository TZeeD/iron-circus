namespace Imi.Networking.Messages
{
	public enum DisconnectReason
	{
		ConnectionWindowTimeout = 0,
		MatchAborted = 1,
		PlayerDisconnectInLobby = 2,
		PlayerFailedToLoad = 3,
		PlayerNotAcknowledgingBaseline = 4,
		PlayerFailedToGetUnlockedChampions = 5,
		AFK = 6,
		UnkownPlayer = 7,
		BackfillFailed = 8,
	}
}
