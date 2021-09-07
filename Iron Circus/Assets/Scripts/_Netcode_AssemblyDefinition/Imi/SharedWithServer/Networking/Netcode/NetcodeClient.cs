using System;
using System.Net;
using SharedWithServer.Networking.Netcode.Udp;
using Imi.SharedWithServer.Networking.Netcode.Core;

namespace Imi.SharedWithServer.Networking.Netcode
{
	public class NetcodeClient
	{
		public NetcodeClient(ulong clientId, double time, Func<EndPoint, IUdpSocket> socketFactory)
		{
		}

		public int clientIndex;
		public NetcodeClientState ClientState;
		public double time;
	}
}
