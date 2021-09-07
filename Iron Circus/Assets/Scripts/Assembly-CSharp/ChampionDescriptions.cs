using UnityEngine;
using Imi.SharedWithServer.Config;
using TMPro;
using UnityEngine.UI;

public class ChampionDescriptions : MonoBehaviour
{
	public ChampionConfig activeChampion;
	[SerializeField]
	private GameObject weeklyRotationTextObject;
	[SerializeField]
	private TextMeshProUGUI championNameTxt;
	[SerializeField]
	private TextMeshProUGUI championStoryTxt;
	[SerializeField]
	private TextMeshProUGUI championTrivia1;
	[SerializeField]
	private TextMeshProUGUI championTrivia2;
	[SerializeField]
	private TextMeshProUGUI championTrivia3;
	[SerializeField]
	private TextMeshProUGUI skill1NameTxt;
	[SerializeField]
	private TextMeshProUGUI skill1DescriptionTxt;
	[SerializeField]
	private Image skill1Icon;
	[SerializeField]
	private TextMeshProUGUI skill2NameTxt;
	[SerializeField]
	private TextMeshProUGUI skill2DescriptionTxt;
	[SerializeField]
	private Image skill2Icon;
	[SerializeField]
	private GameObject throwingPowerGroup;
	[SerializeField]
	private GameObject healthGroup;
	[SerializeField]
	private GameObject speedGroup;
	[SerializeField]
	private GameObject sprintGroup;
	[SerializeField]
	private GameObject staminaGroup;
	[SerializeField]
	private ThrowBallConfig[] throwBallConfigs;
	[SerializeField]
	private SprintConfig[] sprintConfigs;
	[SerializeField]
	private StaminaConfig[] staminaConfigs;
	[SerializeField]
	private TextMeshProUGUI factionNameText;
	[SerializeField]
	private Image factionLogoImage;
}
