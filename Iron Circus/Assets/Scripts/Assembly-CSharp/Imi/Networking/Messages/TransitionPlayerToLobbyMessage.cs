using Imi.SharedWithServer.Networking.Messages;

namespace Imi.Networking.Messages
{
	public class TransitionPlayerToLobbyMessage : Message
	{
		public TransitionPlayerToLobbyMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong PlayerId;
	}
}
