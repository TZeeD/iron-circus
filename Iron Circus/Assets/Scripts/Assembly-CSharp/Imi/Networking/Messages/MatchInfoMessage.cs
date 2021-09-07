using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class MatchInfoMessage : Message
	{
		public MatchInfoMessage() : base(default(RumpfieldMessageType))
		{
		}

		public string arena;
		public string matchId;
		public GameType gameType;
	}
}
