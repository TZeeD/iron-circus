using Imi.SharedWithServer.Networking.Messages;
using Imi.Game;

namespace Imi.ScEntitas
{
	public class PreMatchChangedMessage : Message
	{
		public PreMatchChangedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public float matchStartCountdown;
		public LobbyState lobbyState;
		public bool startGame;
	}
}
