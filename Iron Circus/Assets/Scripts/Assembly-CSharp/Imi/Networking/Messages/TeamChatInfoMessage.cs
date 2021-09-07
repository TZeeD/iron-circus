using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class TeamChatInfoMessage : Message
	{
		public TeamChatInfoMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string chatServerAddress;
		public string roomId;
	}
}
