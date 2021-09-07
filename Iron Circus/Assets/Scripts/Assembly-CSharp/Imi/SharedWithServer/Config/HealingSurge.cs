using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class HealingSurge : SkillGraphConfig
	{
		public ButtonType button;
		public string uiIconName;
		public float minRadius;
		public float maxRadius;
		public float chargeDuration;
		public int heal;
		public float cooldown;
	}
}
