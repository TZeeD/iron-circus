namespace Imi.SharedWithServer.Networking.Messages
{
	public class GameStatMatchFinishedMessage : Message
	{
		public GameStatMatchFinishedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string arena;
		public string matchId;
	}
}
