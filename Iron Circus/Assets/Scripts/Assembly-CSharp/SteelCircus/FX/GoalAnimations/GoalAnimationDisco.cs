using SteelCircus.FX.GoalAnimations.Base;
using TMPro;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations
{
	public class GoalAnimationDisco : GoalAnimationWithTeamColors
	{
		[SerializeField]
		private TextMeshPro[] tfGoal;
		[SerializeField]
		private TextMeshPro[] tfTeam;
		[SerializeField]
		private Renderer wave;
		[SerializeField]
		private Renderer floor;
		[SerializeField]
		private Transform textContainer;
		[SerializeField]
		private Transform waveContainer;
		[SerializeField]
		private float buildupDuration;
		[SerializeField]
		private AnimationCurve buildupFloor;
		[SerializeField]
		private AnimationCurve buildupWave;
		[SerializeField]
		private AnimationCurve buildupWaveThreshold;
		[SerializeField]
		private AnimationCurve buildupText;
		[SerializeField]
		private AnimationCurve buildupTextAlpha;
	}
}
