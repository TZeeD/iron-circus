using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class SpawnPickupMessage : Message
	{
		public SpawnPickupMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId id;
		public int pickupType;
		public float x;
		public float y;
		public float z;
	}
}
