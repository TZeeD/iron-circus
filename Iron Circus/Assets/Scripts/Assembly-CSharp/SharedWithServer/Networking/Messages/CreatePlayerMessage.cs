using Imi.SharedWithServer.Networking.Messages;
using Jitter.LinearMath;

namespace SharedWithServer.Networking.Messages
{
	public class CreatePlayerMessage : Message
	{
		public CreatePlayerMessage() : base(default(RumpfieldMessageType))
		{
		}

		public JVector position;
		public ulong playerId;
	}
}
