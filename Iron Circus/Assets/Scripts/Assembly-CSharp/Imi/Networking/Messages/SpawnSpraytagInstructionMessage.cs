using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class SpawnSpraytagInstructionMessage : Message
	{
		public SpawnSpraytagInstructionMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int spraytagSlot;
		public ulong playerID;
	}
}
