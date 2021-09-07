using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class PlayerFinishedPickingMessage : Message
	{
		public PlayerFinishedPickingMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerId;
		public ChampionType type;
	}
}
