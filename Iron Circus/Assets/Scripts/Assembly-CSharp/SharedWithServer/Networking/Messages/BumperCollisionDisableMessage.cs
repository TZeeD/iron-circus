using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace SharedWithServer.Networking.Messages
{
	public class BumperCollisionDisableMessage : Message
	{
		public BumperCollisionDisableMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId[] BumperIds;
	}
}
