namespace Imi.SharedWithServer.Networking.Messages
{
	public class RemoteClientStateMessage : Message
	{
		public RemoteClientStateMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ulong id;
		public uint index;
		public bool isConnected;
		public uint rtt;
	}
}
