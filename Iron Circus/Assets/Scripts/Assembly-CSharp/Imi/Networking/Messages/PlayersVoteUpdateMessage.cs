using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class PlayersVoteUpdateMessage : Message
	{
		public PlayersVoteUpdateMessage() : base(default(RumpfieldMessageType))
		{
		}

	}
}
