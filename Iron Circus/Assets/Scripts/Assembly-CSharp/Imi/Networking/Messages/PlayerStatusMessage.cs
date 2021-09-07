using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class PlayerStatusMessage : Message
	{
		public PlayerStatusMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
	}
}
