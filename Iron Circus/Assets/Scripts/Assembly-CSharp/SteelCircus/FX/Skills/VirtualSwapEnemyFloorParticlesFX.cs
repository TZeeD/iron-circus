using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class VirtualSwapEnemyFloorParticlesFX : MonoBehaviour
	{
		[SerializeField]
		private float emissionEaseCurve;
		[SerializeField]
		private ParticleSystem normalParticles;
		[SerializeField]
		private ParticleSystem emissiveParticles;
		[SerializeField]
		private ParticleSystem inAirParticles;
		[SerializeField]
		private float emissionRateNormals;
		[SerializeField]
		private float scatterRadiusNormals;
		[SerializeField]
		private float emissionRateEmissive;
		[SerializeField]
		private float scatterRadiusEmissive;
		[SerializeField]
		private float emissionRateInAir;
		[SerializeField]
		private float scatterRadiusInAir;
	}
}
