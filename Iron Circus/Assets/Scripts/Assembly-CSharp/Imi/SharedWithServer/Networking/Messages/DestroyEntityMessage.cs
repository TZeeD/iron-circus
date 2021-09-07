namespace Imi.SharedWithServer.Networking.Messages
{
	public class DestroyEntityMessage : Message
	{
		public DestroyEntityMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ushort uniqueId;
	}
}
