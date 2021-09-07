using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class InputMessage : Message
	{
		public InputMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int clientTick;
	}
}
