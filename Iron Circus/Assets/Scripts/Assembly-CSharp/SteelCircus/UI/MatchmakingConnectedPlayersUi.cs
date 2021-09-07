using Imi.SteelCircus.Utils;
using UnityEngine;
using Imi.SharedWithServer.Config;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class MatchmakingConnectedPlayersUi : MonoBehaviourWithSetup
	{
		[SerializeField]
		private ChampionTurntableUI turntableUi;
		[SerializeField]
		private Transform playerAvatarsParent;
		[SerializeField]
		private GameObject playerAvatarPrefab;
		[SerializeField]
		private GameObject waitingForPlayersTxt;
		[SerializeField]
		private ArenaLoadingFinishedUi arenaLoadingFinishedUi;
		public ChampionConfig[] configList;
		public Button SelectButton;
		[SerializeField]
		private Text[] teamMemberChampionUsernames;
		[SerializeField]
		private Text teamTxt;
	}
}
