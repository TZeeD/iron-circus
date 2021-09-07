using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class VortexFX : MonoBehaviour
	{
		public Transform[] marbles;
		public float parabolaHeight;
		public float marbleRadiansPerSecond;
		public float marbleYHoverFrequency;
		public float marbleYHoverCenterHeight;
		public float marbleYHoverAmplitude;
		public float marbleXZHoverFrequency;
		public float marbleXZHoverCenterHeight;
		public float marbleXZHoverAmplitude;
		public float marbleSpreadOutDuration;
		public GameObject maelstroemEffect;
		public ParticleSystem rings;
		public ParticleSystem sparks;
		public GameObject floorAoe;
		public Renderer floorAoeRenderer;
		public float floorAoeAlpha;
		public float floorAoeTilingAlpha;
		public float floorAoeTilingFadeDuration;
		public Vector3 startPos;
		public Vector3 implosionPosition;
		public float flightDuration;
		public float activationDuration;
		public float effectDuration;
		public float range;
		public float currentT;
	}
}
