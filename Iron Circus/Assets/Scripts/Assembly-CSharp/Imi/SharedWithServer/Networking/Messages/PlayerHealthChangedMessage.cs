namespace Imi.SharedWithServer.Networking.Messages
{
	public class PlayerHealthChangedMessage : Message
	{
		public PlayerHealthChangedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int oldHealth;
		public int currentHealth;
		public bool isDead;
		public int maxHealth;
		public ulong playerId;
	}
}
