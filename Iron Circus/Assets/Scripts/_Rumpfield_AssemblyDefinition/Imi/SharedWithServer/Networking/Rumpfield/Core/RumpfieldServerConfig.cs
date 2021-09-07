using System;

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
	public struct RumpfieldServerConfig
	{
		public RumpfieldServerConfig(int numberOfPeers, string gatewayAddress, string ip, int port, ulong protocolId, byte[] privateKey, int clientDestroyTimeOut) : this()
		{
		}

	}
}
