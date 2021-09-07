namespace Imi.SharedWithServer.Networking.Messages
{
	public class LoadArenaMessage : Message
	{
		public LoadArenaMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string arenaName;
		public int numPlayers;
	}
}
