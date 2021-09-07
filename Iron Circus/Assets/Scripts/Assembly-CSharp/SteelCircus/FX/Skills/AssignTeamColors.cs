using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class AssignTeamColors : MonoBehaviour
	{
		private enum TeamColor
		{
			Dark = 0,
			Middle = 1,
			Light = 2,
			MiddleHdr = 3,
			DarkAoe = 4,
			MiddleAoe = 5,
		}

		[SerializeField]
		private TeamColor color;
		[SerializeField]
		private Renderer[] renderers;
		[SerializeField]
		private ParticleSystem[] particleSystems;
	}
}
