using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class SpawnSpraytagMessage : Message
	{
		public SpawnSpraytagMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int spraytagSlot;
		public ulong playerID;
		public float x;
		public float z;
	}
}
