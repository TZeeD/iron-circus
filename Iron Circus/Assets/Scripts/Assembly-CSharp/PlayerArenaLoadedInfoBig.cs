using UnityEngine;
using SteelCircus.UI.Menu;
using UnityEngine.UI;
using TMPro;

public class PlayerArenaLoadedInfoBig : MonoBehaviour
{
	[SerializeField]
	private GameObject loadingGroup;
	[SerializeField]
	private GameObject loadingFinishedGroup;
	[SerializeField]
	private RectTransform playerAvatar;
	[SerializeField]
	private SwitchAvatarIcon avatarIconObject;
	[SerializeField]
	private Image loadingBackground;
	[SerializeField]
	private Image usernameBackground;
	[SerializeField]
	private TextMeshProUGUI usernameTxt;
	[SerializeField]
	private TextMeshProUGUI playerLvlTxt;
	[SerializeField]
	private Sprite alphaBG;
	[SerializeField]
	private Sprite betaBg;
	[SerializeField]
	private GameObject twitchLogo;
	[SerializeField]
	private GameObject viewerCountObject;
	[SerializeField]
	private TextMeshProUGUI viewerCountText;
	[SerializeField]
	private LayoutGroup nameLayoutGroup;
	[SerializeField]
	private LayoutGroup parentLayoutGroup;
	[SerializeField]
	private LayoutGroup viewerCountLayoutGroup;
}
