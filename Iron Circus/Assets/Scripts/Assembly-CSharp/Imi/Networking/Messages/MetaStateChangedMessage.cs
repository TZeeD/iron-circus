using Imi.SharedWithServer.Networking.Messages;
using Imi.Game;

namespace Imi.Networking.Messages
{
	public class MetaStateChangedMessage : Message
	{
		public MetaStateChangedMessage() : base(default(RumpfieldMessageType))
		{
		}

		public MetaState state;
	}
}
