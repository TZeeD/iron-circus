using Imi.SharedWithServer.ScEntitas.Components;
using SteelCircus.GameElements;

namespace Imi.SharedWithServer.Config
{
	public class RampageConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string skillIcon;
		public float cooldown;
		public float castDuration;
		public float duration;
		public float modelScale;
		public float scaleDuration;
		public Curve scaleCurve;
		public float moveSpeed;
		public float accelerationFactor;
		public float thrusterFraction;
		public float activateRange;
		public float range;
		public float pushDistance;
		public float pushDuration;
		public float stunDuration;
		public float ballPushForce;
		public VfxPrefab trailPrefab;
		public VfxPrefab particlesPrefab;
		public VfxPrefab aoePrefab;
	}
}
