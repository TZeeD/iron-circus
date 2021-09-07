using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class VoteForRematchMessage : Message
	{
		public VoteForRematchMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public bool wantsRematch;
	}
}
