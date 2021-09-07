using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class WarsongConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldown;
		public float reapplyDuration;
		public float moveSpeedModifierEnemies;
		public float moveSpeedModifierAllies;
		public float moveSpeedModifierOwn;
		public float castDuration;
		public float effectDuration;
		public AreaOfEffect aoe;
		public VfxPrefab vfxPrefab;
	}
}
