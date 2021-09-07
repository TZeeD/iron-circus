namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class ConnectionRequestPacket : Packet
	{
		public ulong connectTokenExpireTimestamp;
		public ulong connectTokenSequenceNumber;
		public byte[] encryptedPrivateConnectTokenData;
		public byte prefixByte;
		public ulong protocolId;
		public char[] versionInfo;
	}
}
