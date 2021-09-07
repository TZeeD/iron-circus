using UnityEngine;

namespace SteelCircus.UI.SkillInfo
{
	public class SkillHud : MonoBehaviour
	{
		[SerializeField]
		private bool useTeamColors;
		[SerializeField]
		private SprintSkillUiInstance sprintSkillInstance;
		[SerializeField]
		private TackleDodgeSkillUiInstance tackleDodgeSkillInstance;
		[SerializeField]
		private MainSkillUiInstance primaryMainSkillInstance;
		[SerializeField]
		private MainSkillUiInstance secondaryMainSkillInstance;
		[SerializeField]
		private SkillHudHealthContainerUi healthHud;
	}
}
