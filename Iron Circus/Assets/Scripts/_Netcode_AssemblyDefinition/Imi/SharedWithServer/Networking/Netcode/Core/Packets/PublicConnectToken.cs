namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class PublicConnectToken
	{
		public byte[] clientToServerKey;
		public ulong createTimestamp;
		public ulong expireTimestamp;
		public uint numServers;
		public byte[] privateConnectToken;
		public ulong protocolId;
		public ulong sequence;
		public byte[] serverToClientKey;
		public int timeoutSeconds;
		public char[] versionInfo;
	}
}
