using Imi.SharedWithServer.Networking.Messages;
using Imi.ScEvents;

namespace Imi.Networking.Messages
{
	public class TrackingEventMessage : Message
	{
		public TrackingEventMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public Statistics statistics;
		public float value;
	}
}
