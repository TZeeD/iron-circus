using Jitter.LinearMath;

namespace Imi.SharedWithServer.Config
{
	public class ShieldThrowConfig : SkillGraphConfig
	{
		public string iconName;
		public AreaOfEffect shape;
		public float cooldown;
		public bool showPreviewOnRemoteEntities;
		public float maxAirTimeFallback;
		public float durationUntilHideShield;
		public float aimMovementFactor;
		public string shieldInChampionName;
		public float shieldSpeed;
		public float shieldRotationSpeed;
		public JVector spawnOffset;
		public float shieldCollisionRadius;
		public float shieldCollisionHeight;
		public int damage;
		public float pushDistance;
		public float stunDuration;
		public float pushDuration;
		public int destroyAfterImpactCount;
		public float minDistanceBetweenImpactCount;
		public float maxTravelDistanceUntilImpact;
		public VfxPrefab shieldPrefab;
		public VfxPrefab impactVfxPrefab;
		public VfxPrefab dissolveVfxPrefab;
	}
}
