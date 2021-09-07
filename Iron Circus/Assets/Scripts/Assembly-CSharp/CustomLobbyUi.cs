using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CustomLobbyUi : MonoBehaviour
{
	[SerializeField]
	private Dropdown arenaDropdown;
	[SerializeField]
	private Dropdown matchmakingDropDown;
	[SerializeField]
	private Dropdown botDifficultyDropdown;
	[SerializeField]
	private TextMeshProUGUI startMatchErrorTxt;
	[SerializeField]
	private Button invitePlayersBtn;
	[SerializeField]
	private GameObject startingGameInfo;
	[SerializeField]
	private Button startMatchBtn;
	[SerializeField]
	private Sprite startMatchBtn_notReady;
	[SerializeField]
	private Sprite startMatchBtn_notReadyHighlighted;
	[SerializeField]
	private Sprite startMatchBtn_ready;
	[SerializeField]
	private Sprite startMatchBtn_readyHighlighted;
	[SerializeField]
	private Button isReadyBtn;
	[SerializeField]
	private Sprite isReadySprite;
	[SerializeField]
	private Sprite isReadyHighlightedSprite;
	[SerializeField]
	private Sprite isNotReadySprite;
	[SerializeField]
	private Sprite isNotReadHighlightedSprite;
	[SerializeField]
	private GameObject groupMemberPrefab;
	[SerializeField]
	private Transform groupMemberListParent;
	[SerializeField]
	private Transform alphaGroupMemberListParent;
	[SerializeField]
	private Transform betaGroupMemberListParent;
	[SerializeField]
	private Image arenaMinimapIcon;
	[SerializeField]
	private Image arenaMinimapIconRightCorner;
	[SerializeField]
	private TextMeshProUGUI arenaTxt;
	[SerializeField]
	private TextMeshProUGUI regionTxt;
	[SerializeField]
	public GameObject botTeamMemberButtonPrefab;
	[SerializeField]
	private Button addBotAlphaButton;
	[SerializeField]
	private Button addBotBetaButton;
}
