using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class PickupConsumedMessage : Message
	{
		public PickupConsumedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId id;
		public UniqueId playerUniqueId;
	}
}
