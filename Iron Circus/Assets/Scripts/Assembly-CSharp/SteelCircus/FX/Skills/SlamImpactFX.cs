using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class SlamImpactFX : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystem sparkParticles;
		[SerializeField]
		private Animator stompAnimator;
		[SerializeField]
		private MeshRenderer smokeRenderer;
		[SerializeField]
		private MeshRenderer shockwaveRenderer;
		public bool debugDontDestroy;
	}
}
