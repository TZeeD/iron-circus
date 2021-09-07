using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class DeltaCompressedInputMessage : Message
	{
		public DeltaCompressedInputMessage() : base(default(RumpfieldMessageType))
		{
		}

	}
}
