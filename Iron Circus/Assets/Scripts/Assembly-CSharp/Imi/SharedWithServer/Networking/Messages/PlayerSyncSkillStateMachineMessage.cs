using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class PlayerSyncSkillStateMachineMessage : Message
	{
		public PlayerSyncSkillStateMachineMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int instanceIdx;
		public ulong ownerId;
		public List<int> activeStates;
		public byte[] stateData;
	}
}
