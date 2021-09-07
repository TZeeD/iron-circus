using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class SlamConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public AreaOfEffect aoe;
		public float aoeOffset;
		public int damage;
		public float cooldown;
		public float hopDuration;
		public float postHopFreeze;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public float speedModDuration;
		public float speedModAmount;
		public float pushSidewaysPercent;
		public bool showAoePreviewOnlyForLocalPlayer;
		public VfxPrefab impactVfxPrefab;
	}
}
