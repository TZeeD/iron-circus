using SteelCircus.FX.GoalAnimations.Base;
using TMPro;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations
{
	public class GoalAnimationDefault : GoalAnimationWithCustomTeamColors
	{
		[SerializeField]
		private TextMeshPro[] tfGoal;
		[SerializeField]
		private TextMeshPro[] tfTeam;
	}
}
