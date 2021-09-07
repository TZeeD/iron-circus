using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace SharedWithServer.Networking.Messages
{
	public class BumperCollisionEnableMessage : Message
	{
		public BumperCollisionEnableMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId[] BumperIds;
	}
}
