namespace Imi.SharedWithServer.Networking.Messages
{
	public class TackleHitPlayerMessage : Message
	{
		public TackleHitPlayerMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong skillOwner;
		public ulong tackledPlayer;
	}
}
