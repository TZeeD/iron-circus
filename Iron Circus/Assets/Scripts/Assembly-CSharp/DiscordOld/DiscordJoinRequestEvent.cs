using System;
using UnityEngine.Events;

namespace DiscordOld
{
	[Serializable]
	public class DiscordJoinRequestEvent : UnityEvent<DiscordRpc.DiscordUser>
	{
	}
}
