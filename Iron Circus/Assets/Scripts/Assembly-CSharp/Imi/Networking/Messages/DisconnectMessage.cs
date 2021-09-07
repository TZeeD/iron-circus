using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class DisconnectMessage : Message
	{
		public DisconnectMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong id;
		public byte index;
	}
}
