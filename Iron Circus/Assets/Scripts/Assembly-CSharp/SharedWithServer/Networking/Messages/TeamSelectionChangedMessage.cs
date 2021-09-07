using Imi.SharedWithServer.Networking.Messages;
using Imi.Game;

namespace SharedWithServer.Networking.Messages
{
	public class TeamSelectionChangedMessage : Message
	{
		public TeamSelectionChangedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public Team SelectedTeam;
	}
}
