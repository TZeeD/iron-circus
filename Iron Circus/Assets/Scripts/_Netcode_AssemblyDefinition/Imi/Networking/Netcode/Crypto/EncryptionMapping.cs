namespace Imi.Networking.netcode.crypto
{
	public class EncryptionMapping
	{
		public byte[] clientToServerKey;
		public double expireTime;
		public double lastAccessTime;
		public byte[] serverToClientKey;
		public int timeoutInSeconds;
	}
}
