namespace Imi.SharedWithServer.Networking.Messages
{
	public class OrientationMessage : Message
	{
		public OrientationMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int id;
	}
}
