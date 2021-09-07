using System;

namespace DiscordOld
{
	public class DiscordRpc
	{
		[Serializable]
		public struct DiscordUser
		{
			public string userId;
			public string username;
			public string discriminator;
			public string avatar;
		}

	}
}
