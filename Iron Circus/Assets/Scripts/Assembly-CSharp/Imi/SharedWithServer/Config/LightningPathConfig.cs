using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class LightningPathConfig : SkillGraphConfig
	{
		public ButtonType buttonType;
		public string skillIconName;
		public float cooldown;
		public float duration;
		public float reapplyDuration;
		public float moveSpeedModifierAllies;
		public AreaOfEffect aoe;
		public float spawnOffset;
	}
}
