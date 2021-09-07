namespace Imi.SharedWithServer.Networking.Messages
{
	public class PlayerDeathMessage : Message
	{
		public PlayerDeathMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public ulong instigatorPlayerId;
		public float respawnDuration;
	}
}
