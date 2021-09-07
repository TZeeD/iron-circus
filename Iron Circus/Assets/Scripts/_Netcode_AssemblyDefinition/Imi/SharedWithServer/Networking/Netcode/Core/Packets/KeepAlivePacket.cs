namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class KeepAlivePacket : Packet
	{
		public uint clientIndex;
		public uint maxClients;
	}
}
