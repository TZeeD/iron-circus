using System;
using Steamworks;
using Imi.Game;

namespace SteelCircus.Core.Services
{
	public class APartyService
	{
		[Serializable]
		public class GroupMember
		{
			public GroupMember(ulong playerId, CSteamID steamId, string username)
			{
			}

			public ulong playerId;
			public string username;
			public CSteamID steamId;
			public Team team;
			public string level;
			public bool isCustomLobbyReady;
			public int playerAvatarItemId;
		}

	}
}
