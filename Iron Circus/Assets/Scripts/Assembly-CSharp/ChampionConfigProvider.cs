using System;
using Imi.SharedWithServer.Config;
using System.Collections.Generic;

public class ChampionConfigProvider : SingletonScriptableObject<ChampionConfigProvider>
{
	[Serializable]
	public class ChampionConfigUiInfo
	{
		public ChampionConfigUiInfo(ChampionConfig championConfig)
		{
		}

		public ChampionConfig ChampionConfig;
		public bool IsActive;
		public ChampionConfigProvider.ChampionButtonUiPosition UiPosition;
	}

	public enum ChampionButtonUiPosition
	{
		dontRender = 0,
		firstRow = 1,
		secondRow = 2,
		thirdRow = 3,
	}

	public List<ChampionConfigProvider.ChampionConfigUiInfo> championConfigs;
	public int highestColumnCount;
}
