using UnityEngine;
using UnityEngine.Events;

namespace DiscordOld
{
	public class Discord : MonoBehaviour
	{
		public string applicationId;
		public string optionalSteamId;
		public int clickCounter;
		public DiscordRpc.DiscordUser joinRequest;
		public UnityEvent onConnect;
		public UnityEvent onDisconnect;
		public UnityEvent hasResponded;
		public DiscordJoinEvent onJoin;
		public DiscordJoinEvent onSpectate;
		public DiscordJoinRequestEvent onJoinRequest;
	}
}
