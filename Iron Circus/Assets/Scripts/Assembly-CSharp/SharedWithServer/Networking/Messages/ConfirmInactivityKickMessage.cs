using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class ConfirmInactivityKickMessage : Message
	{
		public ConfirmInactivityKickMessage() : base(default(RumpfieldMessageType))
		{
		}

	}
}
