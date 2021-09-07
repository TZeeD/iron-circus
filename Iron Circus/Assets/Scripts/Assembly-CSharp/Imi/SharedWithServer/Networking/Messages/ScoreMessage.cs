using Imi.Game;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class ScoreMessage : Message
	{
		public ScoreMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public Team lastTeamThatScored;
		public bool isReset;
	}
}
