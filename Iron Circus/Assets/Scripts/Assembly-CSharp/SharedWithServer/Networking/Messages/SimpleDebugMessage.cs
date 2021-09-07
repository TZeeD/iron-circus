using Imi.SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;

namespace SharedWithServer.Networking.Messages
{
	public class SimpleDebugMessage : Message
	{
		public SimpleDebugMessage() : base(default(RumpfieldMessageType))
		{
		}

		public DebugEventType debugEventType;
	}
}
