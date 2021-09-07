using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Imi.SharedWithServer.Config;

namespace SteelCircus.UI
{
	public class DebugLobbySkillDescription : MonoBehaviour
	{
		[SerializeField]
		private Animator anim;
		[SerializeField]
		private Image championAvatar;
		[SerializeField]
		private TextMeshProUGUI championNameTxt;
		[SerializeField]
		private TextMeshProUGUI championDescriptionTxt;
		[SerializeField]
		private TextMeshProUGUI skill1NameTxt;
		[SerializeField]
		private TextMeshProUGUI skill1DescriptionTxt;
		[SerializeField]
		private Image skill1Icon;
		[SerializeField]
		private Image skill1ButtonIcon;
		[SerializeField]
		private TextMeshProUGUI skill2NameTxt;
		[SerializeField]
		private TextMeshProUGUI skill2DescriptionTxt;
		[SerializeField]
		private Image skill2Icon;
		[SerializeField]
		private Image skill2ButtonIcon;
		[SerializeField]
		private GameObject healthGroup;
		[SerializeField]
		private GameObject speedGroup;
		[SerializeField]
		private GameObject throwingPowerGroup;
		[SerializeField]
		private GameObject sprintGroup;
		[SerializeField]
		private ThrowBallConfig[] throwBallConfigs;
		[SerializeField]
		private SprintConfig[] sprintConfigs;
		[SerializeField]
		private Sprite enforcerSprite;
		[SerializeField]
		private Sprite specialistSprite;
		[SerializeField]
		private Sprite strikerSprite;
	}
}
