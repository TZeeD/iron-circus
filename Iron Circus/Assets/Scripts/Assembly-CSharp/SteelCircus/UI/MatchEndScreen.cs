using UnityEngine;
using SteelCircus.UI.MatchFlow;
using TMPro;

namespace SteelCircus.UI
{
	public class MatchEndScreen : MonoBehaviour
	{
		[SerializeField]
		private MVPScreen mvpUi;
		[SerializeField]
		private XPUi xpUi;
		[SerializeField]
		private SimplePromptSwitch navigatorBar;
		public bool inMatchEndScreen;
		[SerializeField]
		private SimpleCountDown gameEndsCountDown;
		[SerializeField]
		private GameObject topPanel;
		[SerializeField]
		private GameObject backGroundImage;
		[SerializeField]
		private MVPPlayerAvatar[] mvpAvatars;
		[SerializeField]
		private GameObject avatarPrefab;
		[SerializeField]
		private Transform alphaAvatarTransform;
		[SerializeField]
		private Transform betaAvatarTransform;
		[SerializeField]
		private TextMeshProUGUI goalScoreTextLeft;
		[SerializeField]
		private TextMeshProUGUI goalScoreTextRight;
		[SerializeField]
		private GameObject infoScreen;
		[SerializeField]
		private GameObject loadingText;
		[SerializeField]
		private GameObject errorText;
	}
}
