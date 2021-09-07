using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class QuickChatMessage : Message
	{
		public QuickChatMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong PlayerId;
		public int MsgType;
	}
}
