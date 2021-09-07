namespace Imi.SharedWithServer.Networking.Messages
{
	public class RematchMessage : Message
	{
		public RematchMessage() : base(default(RumpfieldMessageType))
		{
		}

		public bool rematch;
	}
}
