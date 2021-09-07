using Imi.SharedWithServer.Networking.Messages;
using Imi.Game;

namespace Imi.Networking.Messages
{
	public class SelectTeamMessage : Message
	{
		public SelectTeamMessage() : base(default(RumpfieldMessageType))
		{
		}

		public Team team;
	}
}
