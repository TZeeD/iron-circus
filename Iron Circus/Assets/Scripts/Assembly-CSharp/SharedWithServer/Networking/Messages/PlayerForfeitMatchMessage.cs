using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class PlayerForfeitMatchMessage : Message
	{
		public PlayerForfeitMatchMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public bool forfeit;
	}
}
