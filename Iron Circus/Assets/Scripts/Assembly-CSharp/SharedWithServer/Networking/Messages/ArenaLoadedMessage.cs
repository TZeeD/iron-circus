using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class ArenaLoadedMessage : Message
	{
		public ArenaLoadedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string arenaName;
		public uint durationInMs;
	}
}
