namespace Imi.SharedWithServer.Networking.Messages
{
	public class RumbleControllerMessage : Message
	{
		public RumbleControllerMessage() : base(default(RumpfieldMessageType))
		{
		}

		public float duration;
		public ulong playerToRumbleId;
		public float strength;
	}
}
