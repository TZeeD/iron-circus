using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class VortexConfig : SkillGraphConfig
	{
		public ButtonType button;
		public float minThrowDistance;
		public float maxThrowDistance;
		public float throwDuration;
		public float activationDuration;
		public float pullSpeed;
		public float pullDuration;
		public float cooldown;
		public bool showAoePreviewForOtherPlayers;
		public AreaOfEffect aoe;
		public VfxPrefab implosionVfx;
	}
}
