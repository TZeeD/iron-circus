using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class ResetToMainMenuMessage : Message
	{
		public ResetToMainMenuMessage() : base(default(RumpfieldMessageType))
		{
		}

	}
}
