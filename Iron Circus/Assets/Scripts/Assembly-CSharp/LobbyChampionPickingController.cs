using UnityEngine;
using TMPro;
using UnityEngine.UI;
using SteelCircus.UI;
using SteelCircus.UI.Lobby;

public class LobbyChampionPickingController : MonoBehaviour
{
	public GUIStyle guiStyle;
	[SerializeField]
	private GameObject progressBarPrefab;
	[SerializeField]
	private Transform pickingBarParent;
	[SerializeField]
	private bool isDev;
	[SerializeField]
	private TextMeshProUGUI YourTurnTxt;
	[SerializeField]
	private TextMeshProUGUI countDownTxt;
	[SerializeField]
	private TextMeshProUGUI waitingForAdditionalPlayersTxt;
	[SerializeField]
	private Text YouPickTxt;
	[SerializeField]
	private MatchmakingConnectedPlayersUi matchmakingConnectedPlayersUi;
	[SerializeField]
	private PopulateStageLobbyChampionButtons defaultButtonScript;
	[SerializeField]
	private Text arenaText;
	[SerializeField]
	private Image arenaMinimapIcon;
	[SerializeField]
	private GameObject[] alphaPedestals;
	[SerializeField]
	private GameObject[] betaPedestals;
}
