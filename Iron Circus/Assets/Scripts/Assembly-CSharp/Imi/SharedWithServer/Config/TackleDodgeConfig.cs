using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class TackleDodgeConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldown;
		public float dodgeDistance;
		public float dodgeDuration;
		public float postDodgeSpeed;
		public float staminaCostDodge;
		public float tackleDistance;
		public float tackleDuration;
		public float postTackleSpeed;
		public float staminaCostTackle;
		public float pushDistanceWithBall;
		public float pushDurationWithBall;
		public float stunDurationWithBall;
		public float slowDurationWithBall;
		public float slowAmountWithBall;
		public float pushDistanceNoBall;
		public float pushDurationNoBall;
		public float stunDurationNoBall;
		public float slowDurationNoBall;
		public float slowAmountNoBall;
		public bool showPreviewOnRemoteEntities;
		public VfxPrefab tacklePreviewPrefab;
		public VfxPrefab dodgeVfxPrefab;
	}
}
