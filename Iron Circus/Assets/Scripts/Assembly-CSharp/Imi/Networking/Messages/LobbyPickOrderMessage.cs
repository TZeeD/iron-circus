using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Game;

namespace Imi.Networking.Messages
{
	public class LobbyPickOrderMessage : Message
	{
		public LobbyPickOrderMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId[] alphaPickOrder;
		public UniqueId[] betaPickOrder;
	}
}
