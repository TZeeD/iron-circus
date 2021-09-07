namespace Imi.SharedWithServer.Networking.reliable.core
{
	public class ReliableFragmentReassemblyData
	{
		public uint ackBits;
		public bool[] fragmentReceived;
		public ushort mostRecentAcknowledgedSequence;
		public int numberOfFragmentsReceived;
		public int numberOfFragmentsTotal;
		public int packetBytes;
		public byte[] packetData;
		public int packetHeaderBytes;
		public ushort sequence;
	}
}
