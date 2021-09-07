using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class MatchStateMessage : Message
	{
		public MatchStateMessage() : base(default(RumpfieldMessageType))
		{
		}

		public float cutsceneDuration;
		public float remainingMatchTime;
		public MatchState matchState;
	}
}
