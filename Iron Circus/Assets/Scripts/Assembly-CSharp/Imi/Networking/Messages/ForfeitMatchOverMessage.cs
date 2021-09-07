using Imi.SharedWithServer.Networking.Messages;
using Imi.Game;

namespace Imi.Networking.Messages
{
	public class ForfeitMatchOverMessage : Message
	{
		public ForfeitMatchOverMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public Team team;
	}
}
