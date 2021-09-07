using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Config
{
	public class LightningStrike : SkillGraphConfig
	{
		public ButtonType buttonType;
		public string skillIconName;
		public float cooldown;
		public float maxThrowDist;
		public float spearCollisionHeight;
		public float spearCollisionRadius;
		public float spearSpeed;
		public JVector spawnOffset;
		public float canTeleportDelay;
		public float duration;
		public float teleportSpeed;
		public float pushDurationOnHit;
		public float pushDistanceOnHit;
		public int damage;
		public AreaOfEffect aoe;
		public float pushDuration;
		public float pushDistance;
		public float stunDuration;
		public float slowAmount;
		public float slowDuration;
		public VfxPrefab spearProjectilePrefab;
		public VfxPrefab impactVfxPrefab;
		public VfxPrefab throwPreviewPrefab;
		public VfxPrefab connectionPrefab;
	}
}
