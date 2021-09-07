using Imi.SharedWithServer.Networking.Messages;

namespace SharedWithServer.Networking.Messages
{
	public class AverageFpsMessage : Message
	{
		public AverageFpsMessage() : base(default(RumpfieldMessageType))
		{
		}

		public float averageFps;
		public string deviceName;
	}
}
