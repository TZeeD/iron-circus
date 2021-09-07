namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class ChallengeResponsePacket : Packet
	{
		public byte[] challenge;
		public ulong sequence;
	}
}
