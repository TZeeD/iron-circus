using UnityEngine;
using Imi.SharedWithServer.Config;
using SteelCircus.UI;

namespace SteelCircus.UI.Lobby
{
	public class PopulateStageLobbyChampionButtons : MonoBehaviour
	{
		[SerializeField]
		protected ConfigProvider configProvider;
		[SerializeField]
		protected ChampionTurntableUI turntableUi;
		[SerializeField]
		protected MatchmakingConnectedPlayersUi matchmakingUi;
		[SerializeField]
		protected GameObject championButtonPrefab;
		public int localPickOrder;
		[SerializeField]
		private RectTransform background;
		[SerializeField]
		private float buttonWidth;
		[SerializeField]
		private float additionalWidth;
		public bool UseDevSkip;
		[SerializeField]
		private Transform championButtonFirstRow;
		[SerializeField]
		private Transform championButtonSecondRow;
		[SerializeField]
		private Transform championButtonThirdRow;
	}
}
