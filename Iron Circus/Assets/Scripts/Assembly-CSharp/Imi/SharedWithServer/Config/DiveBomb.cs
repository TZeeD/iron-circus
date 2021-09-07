using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class DiveBomb : SkillGraphConfig
	{
		public ButtonType button;
		public string skillIconName;
		public float cooldown;
		public float activationDuration;
		public float interruptWindow;
		public float delayToInvisible;
		public float targetMoveSpeed;
		public float maxAimDuration;
		public float delayToPlayLandingAnim;
		public float delayToImpact;
		public float standUpDuration;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public int damage;
		public AreaOfEffect aoe;
		public VfxPrefab impactVfxPrefab;
		public VfxPrefab launchTrailVfxPrefab;
	}
}
