using UnityEngine;
using Imi.SteelCircus.Networking;
using Imi.SharedWithServer.Config;

namespace Imi.SteelCircus.ScriptableObjects
{
	public class SetupConfig : ScriptableObject
	{
		public GameObject[] dontDestroyOnLoad;
		public string multiplayerScene;
		public string localScene;
		public SteelClientConfig steelClientConfig;
		public ConfigProvider configProvider;
		public ChampionConfigProvider championConfigProvider;
		public ItemsConfig itemsConfig;
		public PickupConfig pickupConfig;
		public StandaloneConfig standaloneConfig;
	}
}
