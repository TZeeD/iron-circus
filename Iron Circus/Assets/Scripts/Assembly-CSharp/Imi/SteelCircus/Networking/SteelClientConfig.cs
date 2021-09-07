using UnityEngine;

namespace Imi.SteelCircus.Networking
{
	public class SteelClientConfig : ScriptableObject
	{
		public string clientName;
		public ulong clientId;
		public string serverIp;
		public int port;
	}
}
