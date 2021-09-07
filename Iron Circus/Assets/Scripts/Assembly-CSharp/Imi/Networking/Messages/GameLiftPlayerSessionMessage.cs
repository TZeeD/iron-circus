using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class GameLiftPlayerSessionMessage : Message
	{
		public GameLiftPlayerSessionMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string playerSessionId;
	}
}
