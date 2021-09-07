namespace Imi.SharedWithServer.Networking.Messages
{
	public class VoteForMvpMessage : Message
	{
		public VoteForMvpMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public ulong votedForPlayerId;
	}
}
