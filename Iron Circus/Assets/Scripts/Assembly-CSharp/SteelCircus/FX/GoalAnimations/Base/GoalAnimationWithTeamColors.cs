using UnityEngine;

namespace SteelCircus.FX.GoalAnimations.Base
{
	public class GoalAnimationWithTeamColors : GoalAnimationBase
	{
		[SerializeField]
		protected Renderer[] teamColorRenderers;
		[SerializeField]
		protected ParticleSystem[] teamColorParticles;
	}
}
