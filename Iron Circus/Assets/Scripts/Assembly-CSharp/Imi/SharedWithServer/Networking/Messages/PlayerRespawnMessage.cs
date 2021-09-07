using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class PlayerRespawnMessage : Message
	{
		public PlayerRespawnMessage() : base(default(RumpfieldMessageType))
		{
		}

		public JVector position;
	}
}
