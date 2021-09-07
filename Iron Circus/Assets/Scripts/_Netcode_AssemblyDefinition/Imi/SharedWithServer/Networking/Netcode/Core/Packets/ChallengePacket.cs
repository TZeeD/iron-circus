namespace Imi.SharedWithServer.Networking.Netcode.Core.Packets
{
	public class ChallengePacket : Packet
	{
		public byte[] challenge;
		public ulong sequence;
	}
}
