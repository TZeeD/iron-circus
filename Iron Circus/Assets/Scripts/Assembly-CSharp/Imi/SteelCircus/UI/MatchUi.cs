using UnityEngine;
using UnityEngine.UI;
using SteelCircus.UI.MatchFlow;
using SteelCircus.UI.Misc;

namespace Imi.SteelCircus.UI
{
	public class MatchUi : MonoBehaviour
	{
		[SerializeField]
		private LobbyChampionPickingController lobbyScreen;
		[SerializeField]
		private GameObject scorePanel;
		[SerializeField]
		private Text timeTxt;
		[SerializeField]
		private Text score_alphaTxt;
		[SerializeField]
		private Text score_betaTxt;
		[SerializeField]
		private OvertimeUi overtimeUi;
		[SerializeField]
		private GameObject ballIndicatorPrefab;
		[SerializeField]
		private DeathCounterUi deathCounterUi;
		[SerializeField]
		private PostGoalUiController postGoalUiController;
		[SerializeField]
		private KoListUi killList;
		[SerializeField]
		private LocalPlayerDeathControllerUi localPlayerDeathControllerUi;
		[SerializeField]
		private MatchOutcomeScreen matchOutcomeScreen;
		[SerializeField]
		private float showKoMessageDuration;
		[SerializeField]
		private Text koMessage;
		[SerializeField]
		private GameObject koPanel;
		[SerializeField]
		private Button leaveMatchButton;
		[SerializeField]
		private ScreenFader screenFader;
		[SerializeField]
		private float screenFadeDuration;
		[SerializeField]
		private Transform canvas;
	}
}
