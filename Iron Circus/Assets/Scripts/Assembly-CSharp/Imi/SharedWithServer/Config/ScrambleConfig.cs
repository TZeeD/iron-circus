using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class ScrambleConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float aoeOffset;
		public float sweepWidth;
		public float sweepDistance;
		public float sweepSpeed;
		public float scrambleDuration;
		public float cooldown;
		public VfxPrefab previewPrefab;
		public VfxPrefab scrambleWavePrefab;
	}
}
