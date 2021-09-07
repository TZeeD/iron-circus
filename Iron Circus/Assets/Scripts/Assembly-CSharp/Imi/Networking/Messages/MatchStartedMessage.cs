using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class MatchStartedMessage : Message
	{
		public MatchStartedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public float durationInSeconds;
	}
}
