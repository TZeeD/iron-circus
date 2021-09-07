using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.MatchFlow
{
	public class TeamUiSkillState : MonoBehaviour
	{
		public Image PrimarySkill;
		public Image SecondarySkill;
		[SerializeField]
		private Color skillActiveColor;
		[SerializeField]
		private Color skillInactiveColor;
	}
}
