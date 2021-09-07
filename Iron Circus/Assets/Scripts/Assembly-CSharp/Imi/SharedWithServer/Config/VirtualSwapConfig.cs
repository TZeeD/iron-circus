using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class VirtualSwapConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldown;
		public AreaOfEffect aoeEnter;
		public float disappearDuration;
		public float hitAppearDuration;
		public float beamingDuration;
		public float maxInvisibleDuration;
		public float moveSpeedModifier;
		public AreaOfEffect aoeTouch;
		public float swapYOffset;
		public float enemyStunDuration;
		public VfxPrefab floorLineVfx;
		public VfxPrefab floorExitVfx;
		public VfxPrefab floorSwapVfx;
	}
}
