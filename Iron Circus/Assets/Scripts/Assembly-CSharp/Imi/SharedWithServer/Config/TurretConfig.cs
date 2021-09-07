using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SharedWithServer.Config
{
	public class TurretConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string skillIconName;
		public float cooldown;
		public float rangeMin;
		public float rangeMax;
		public float rangeChangePerSecond;
		public float activationDuration;
		public float delayToImpact;
		public float standUpDuration;
		public float stunDuration;
		public float pushDuration;
		public float pushDistance;
		public int damage;
		public AreaOfEffect aoe;
		public float cameraSpeed;
		public float cameraStickAtTargetDuration;
		public VfxPrefab impactVfxPrefab;
		public VfxPrefab muzzleFlashVfxPrefab;
		public VfxPrefab flightVfxPrefab;
		public VfxPrefab chargeUpPrefab;
	}
}
