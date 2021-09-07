using UnityEngine;
using TMPro;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
	public class MatchmakingServiceUi : MonoBehaviour
	{
		[SerializeField]
		private GameObject steelCircusHeader;
		[SerializeField]
		private GameObject cancelButton;
		[SerializeField]
		private GameObject cancelButtonContent;
		[SerializeField]
		private GameObject connectingInfoObject;
		[SerializeField]
		private GameObject cancellingInfoObject;
		[SerializeField]
		private GameObject successfulInfoObject;
		[SerializeField]
		private GameObject matchmakingPanel;
		[SerializeField]
		private Animator matchmakingPanelAnimator;
		[SerializeField]
		private TextMeshProUGUI matchmakingStatus;
		[SerializeField]
		private Dropdown regionDropdown;
		[SerializeField]
		private Dropdown matchmakingTypeDropdown;
		[SerializeField]
		private Button quickMatchButton;
		[SerializeField]
		private Button trainingsGroundButton;
		[SerializeField]
		private Button rankedMatchButton;
		[SerializeField]
		private Button customMatchButton;
		[SerializeField]
		private Button botMatchButton;
		[SerializeField]
		private Button freeTrainingsButton;
	}
}
