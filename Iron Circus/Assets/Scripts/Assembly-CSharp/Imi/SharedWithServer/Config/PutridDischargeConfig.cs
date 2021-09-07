using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class PutridDischargeConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string skillIcon;
		public float cooldown;
		public float castDuration;
		public float applyEffectAt;
		public AreaOfEffect aoe;
		public float aoeOffset;
		public float duration;
		public float moveSpeedDuringHold;
		public float initialPushDuration;
		public float initialPushDistance;
		public int damage;
		public float slowAmount;
		public float slowDuration;
		public VfxPrefab puddlePrefab;
		public VfxPrefab pukePrefab;
	}
}
