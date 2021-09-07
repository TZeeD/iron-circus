using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class PickupWillSpawnMessage : Message
	{
		public PickupWillSpawnMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId id;
		public PickupType pickupType;
		public float duration;
	}
}
