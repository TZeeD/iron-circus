using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class MineTriggeredMessage : Message
	{
		public MineTriggeredMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int mineId;
		public JVector minePosition;
		public ulong playerId;
		public float timeToDetonation;
	}
}
