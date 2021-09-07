using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class KennyDeathFromAboveSmokeTrailFX : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystem particles;
		[SerializeField]
		private Transform movingTransform;
		[SerializeField]
		private float totalDuration;
		[SerializeField]
		private float totalDelay;
		[SerializeField]
		private float particlesDuration;
		[SerializeField]
		private float particlesYMoveDistance;
		[SerializeField]
		private AnimationCurve particlesYMoveCurve;
	}
}
