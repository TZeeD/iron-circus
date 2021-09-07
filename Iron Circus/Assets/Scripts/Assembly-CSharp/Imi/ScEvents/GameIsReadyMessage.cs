using Imi.SharedWithServer.Networking.Messages;

namespace Imi.ScEvents
{
	public class GameIsReadyMessage : Message
	{
		public GameIsReadyMessage() : base(default(RumpfieldMessageType))
		{
		}

	}
}
