using System;

namespace Imi.SteelCircus.Core
{
	public struct ConnectionInfo
	{
		public int port;
		public string username;
		public ulong playerId;
		public byte[] connectToken;
		public string gameLiftPlayerSessionId;
	}
}
