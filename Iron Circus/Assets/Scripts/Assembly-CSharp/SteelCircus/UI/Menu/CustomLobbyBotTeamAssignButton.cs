using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
	public class CustomLobbyBotTeamAssignButton : MonoBehaviour
	{
		public CustomLobbyUi customLobbyManager;
		public Button removeBotButton;
		public GameObject border;
		[SerializeField]
		private Image teamAlphaImage;
		[SerializeField]
		private Image teamBetaImage;
	}
}
