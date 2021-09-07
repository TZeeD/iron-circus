using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class PickupResetMessage : Message
	{
		public PickupResetMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId id;
	}
}
