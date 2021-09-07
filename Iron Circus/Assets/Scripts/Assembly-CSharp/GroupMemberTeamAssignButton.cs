using UnityEngine;
using UnityEngine.UI;
using TMPro;
using SteelCircus.Core.Services;
using SteelCircus.UI.Menu;

public class GroupMemberTeamAssignButton : MonoBehaviour
{
	[SerializeField]
	private Button joinRightBtn;
	[SerializeField]
	private Button joinLeftBtn;
	[SerializeField]
	private Button extendUiBtn;
	[SerializeField]
	private Button mutePlayerButton;
	[SerializeField]
	private Button kickBtn;
	[SerializeField]
	private Button makeGroupLeaderButton;
	[SerializeField]
	private GameObject buttonParentLayoutObject;
	[SerializeField]
	private GameObject extendedUi;
	[SerializeField]
	private GameObject groupLeaderIcon;
	[SerializeField]
	private GameObject isReadyIcon;
	[SerializeField]
	private TextMeshProUGUI usernameTxt;
	[SerializeField]
	private TextMeshProUGUI levelTxt;
	[SerializeField]
	private Image selectedBG;
	[SerializeField]
	private Image leftArrowsImage;
	[SerializeField]
	private Image rightArrowsImage;
	[SerializeField]
	private Image rightTriggerImage;
	[SerializeField]
	private Image leftTriggerImage;
	[SerializeField]
	private Image foloutImage;
	[SerializeField]
	private Image foloutShortcutImage;
	[SerializeField]
	private GameObject borderObject;
	[SerializeField]
	private APartyService.GroupMember groupMember;
	[SerializeField]
	private SwitchAvatarIcon avatar;
	public bool isExpanded;
}
