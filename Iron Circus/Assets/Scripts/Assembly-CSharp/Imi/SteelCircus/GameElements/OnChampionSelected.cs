using UnityEngine;
using Imi.SharedWithServer.Config;
using SteelCircus.UI;

namespace Imi.SteelCircus.GameElements
{
	public class OnChampionSelected : MonoBehaviour
	{
		public ChampionTurntableUI turntableUi;
		public ChampionConfig championConfig;
		public int skinIndex;
		public bool useSavedSkinIndex;
		public bool usePointerEnter;
		public bool SetPlayerReadyOnServer;
		public int pickOrder;
		[SerializeField]
		private DebugLobbySkillDescription champDescription;
		[SerializeField]
		private ChampionDescriptions champDescription2;
	}
}
