namespace Imi.SharedWithServer.Networking.Messages
{
	public class GenericMessage : Message
	{
		public GenericMessage() : base(default(RumpfieldMessageType))
		{
		}

		public byte[] buffer32;
	}
}
