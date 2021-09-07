using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class SprintConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float cooldownDuration;
		public float speed;
		public float accelerationFactor;
		public float thrustContribution;
		public float delayBeforeRecharge;
		public VfxPrefab sprintVfxPrefab;
	}
}
