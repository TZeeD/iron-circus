using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class AfterBurner : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldown;
		public VfxPrefab dashPreviewPrefab;
		public float dashDistance;
		public float dashDuration;
		public float postDashSpeed;
		public float pushBallForce;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public float slowAmount;
		public float slowDuration;
		public int numAoes;
		public float fireWidth;
		public float fireDuration;
		public int fireDamage;
		public float reapplyInterval;
		public VfxPrefab fireTrailPrefab;
		public VfxPrefab smokePrefab;
	}
}
