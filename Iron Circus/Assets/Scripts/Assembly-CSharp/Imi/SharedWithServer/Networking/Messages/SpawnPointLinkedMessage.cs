using Imi.Game;
using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class SpawnPointLinkedMessage : Message
	{
		public SpawnPointLinkedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int matchType;
		public ulong playerId;
		public Team team;
		public UniqueId uniqueId;
	}
}
