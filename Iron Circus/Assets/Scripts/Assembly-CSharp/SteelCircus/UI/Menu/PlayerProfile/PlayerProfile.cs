using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace SteelCircus.UI.Menu.PlayerProfile
{
	public class PlayerProfile : MonoBehaviour
	{
		public Image avatarPreview;
		public TextMeshProUGUI avatarNameTextLeft;
		public Button avatarBuyButton;
		public GameObject avatarBuyButtonPrompt;
		public Button avatarEquipButton;
		public GameObject avatarEquipButtonPrompt;
		public ShopItem activeAvatarIcon;
		[SerializeField]
		private TextMeshProUGUI avatarNameText;
	}
}
