using System;
using Imi.SharedWithServer.Config;

namespace Imi.SteelCircus.FX
{
	[Serializable]
	public class PlayerSelectedChampion
	{
		public ChampionConfig championConfig;
		public int skin;
		public ulong playerId;
	}
}
