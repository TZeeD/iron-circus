using Imi.SharedWithServer.Networking.Messages;
using Jitter.LinearMath;

namespace Imi.Networking.Messages
{
	public class NikiSnapshotMessage : Message
	{
		public NikiSnapshotMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong playerid;
		public JVector position;
		public JVector velocity;
		public int serverTick;
	}
}
