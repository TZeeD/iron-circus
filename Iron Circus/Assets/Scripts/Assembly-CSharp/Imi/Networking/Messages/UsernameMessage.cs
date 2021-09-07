using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class UsernameMessage : Message
	{
		public UsernameMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public string username;
		public bool isTwitchUser;
		public string twitchUsername;
		public int twitchViewerCount;
	}
}
