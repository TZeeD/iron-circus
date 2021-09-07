using unittests.server.SharedWithServer.Networking.Netcode.Core;
using SharedWithServer.Networking.Netcode.Udp;
using System.Net;

namespace Imi.SharedWithServer.Networking.Netcode
{
	public class NetcodeServer
	{
		public NetcodeServer(NetcodeServerConfig config, IUdpSocket transport, double serverTime, IPEndPoint gatewayEndPoint)
		{
		}

		public bool debugIgnoreChallengeResponse;
		public bool debugIgnoreConnectionRequest;
	}
}
