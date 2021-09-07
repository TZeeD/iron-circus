using UnityEngine;
using Imi.SteelCircus.Networking;
using Imi.SharedWithServer.Config;
using Imi.SteelCircus.Core;
using UnityEngine.UI;

namespace SteelCircus.Core
{
	public class MetaController : MonoBehaviour
	{
		[SerializeField]
		private int tickRate;
		[SerializeField]
		private ClockSync clockSync;
		[SerializeField]
		private ConfigProvider configProvider;
		[SerializeField]
		private MatchResourcesInitializer matchResourcesInitializer;
		public Text text;
		public bool showDebugText;
	}
}
