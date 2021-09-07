using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace unittests.server.SharedWithServer.Networking.Messages
{
	public class VelocityMessage : Message
	{
		public VelocityMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId id;
		public float x;
		public float y;
		public float z;
	}
}
