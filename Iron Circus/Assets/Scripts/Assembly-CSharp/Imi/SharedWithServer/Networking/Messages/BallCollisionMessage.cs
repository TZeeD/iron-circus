using Imi.SharedWithServer.Game;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class BallCollisionMessage : Message
	{
		public BallCollisionMessage() : base(default(RumpfieldMessageType))
		{
		}

		public UniqueId collideeUniqueId;
		public JVector position;
		public JVector normal;
	}
}
