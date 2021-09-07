using System.Collections.Generic;

namespace Imi.SteelCircus.ScriptableObjects
{
	public class ItemsConfig : SingletonScriptableObject<ItemsConfig>
	{
		public ChampionConfigProvider championConfigProvider;
		public StandalonePlayerLoadoutConfig standalonePlayerLoadoutConfig;
		public List<ItemDefinition> spraytags;
		public List<ItemDefinition> skins;
		public List<ItemDefinition> victoryPoses;
		public List<ItemDefinition> emotes;
		public List<ItemDefinition> champions;
		public List<ItemDefinition> avatars;
		public List<ItemDefinition> allItems;
	}
}
