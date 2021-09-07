using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class ElectrobaticsConfig : SkillGraphConfig
	{
		public ButtonType button;
		public float cooldown;
		public float hopDuration;
		public float postHopFreeze;
		public float hopDistanceMin;
		public float hopDistanceMax;
		public float hopDistanceChargeDuration;
		public AreaOfEffect aoe;
		public bool showAoePreviewForOtherPlayers;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public float slowAmount;
		public float slowDuration;
		public int damage;
		public VfxPrefab impactVfxPrefab;
		public VfxPrefab lightningTrailVfxPrefab;
	}
}
