using UnityEngine;

namespace Imi.SteelCircus.GameElements
{
	public class BallView : FloorSpawnableObject
	{
		[SerializeField]
		private Transform model;
		[SerializeField]
		private GameObject glowingOutline;
		[SerializeField]
		private ParticleSystem glowingOutlineParticles;
		[SerializeField]
		private MeshRenderer ballModelMeshRenderer;
		public float viewHeightDamping;
		public float viewHeightAngularFrequency;
		public float viewHeightStartVelocity;
		public float hoverHeight;
		public float hoverAmplitude;
		public float hoverFrequency;
		public ParticleSystem chargeParticles;
		[SerializeField]
		private Transform uiParent;
		[SerializeField]
		private Transform uiIndicator;
		[SerializeField]
		private ParticleSystem uiParticles;
		[SerializeField]
		private TrailRenderer uiTrail;
		[SerializeField]
		private TrailRenderer modelTrail;
		public float ballSpeedToTrailAnimationSpeed;
		public AnimationCurve ballSpeedToTrailBrightness;
		public float brightnessAdjustmentDampen;
		public float throwTintDuration;
		public Color throwTint;
		public ParticleSystem sparkParticles;
		public AnimationCurve ballSpeedToEmissionRate;
		public int collisionSparkCount;
		public float collisionSparkSpread;
		public float collisionSparkMinSpeed;
		public float collisionSparkMaxSpeed;
		public float wallCollisionBallSpeedThreshold;
		public Color32 wallCollisionColor;
		public float throwParticleSpread;
		public float throwParticleMinSpeed;
		public float throwParticleMaxSpeed;
		public int throwParticleCount;
		public Color32 throwParticleColor;
		public AnimationCurve ballSpeedToRotationSpeed;
		public Vector3 ballRotationEulerPerSecond;
		public float ballRotationYOscillationSpeed;
		public AnimationCurve ballSpeedToForwardAxis;
		public float glowParticleSizeDefault;
		public float glowParticleSizeHolding;
		public float glowParticleSizeCharging;
	}
}
