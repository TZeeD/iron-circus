namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class PrivateConnectToken
	{
		public ulong clientId;
		public byte[] clientToServerKey;
		public uint numServers;
		public byte[] serverToClientKey;
		public int timeoutSeconds;
		public byte[] userData;
	}
}
