using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class VirtualStrikeConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldown;
		public AreaOfEffect aoeExit;
		public float aoeDisplayDuration;
		public float disappearDuration;
		public float hitAppearDuration;
		public float timeUntilFloorEffect;
		public float maxInvisibleDuration;
		public int damage;
		public float initialFloorSpeed;
		public float moveSpeedModifier;
		public float appearSpeedModifier;
		public float appearSpeedModifierDuration;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public float minHopDistance;
		public float hopDuration;
		public VfxPrefab strikeVfxPrefab;
		public VfxPrefab floorVfxPrefab;
	}
}
