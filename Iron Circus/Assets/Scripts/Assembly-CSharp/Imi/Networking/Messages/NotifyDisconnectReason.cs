using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class NotifyDisconnectReason : Message
	{
		public NotifyDisconnectReason() : base(default(RumpfieldMessageType))
		{
		}

		public DisconnectReason reason;
	}
}
