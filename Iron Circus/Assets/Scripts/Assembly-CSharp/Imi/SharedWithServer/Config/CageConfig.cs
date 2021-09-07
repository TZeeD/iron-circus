using Jitter.LinearMath;

namespace Imi.SharedWithServer.Config
{
	public class CageConfig : SkillGraphConfig
	{
		public string iconName;
		public float wallThickness;
		public float maxRadius;
		public float minRadius;
		public float shrinkDuration;
		public float cooldown;
		public bool showPreviewOnRemoteEntities;
		public float duration;
		public float aimMovementFactor;
		public JVector barrierDimensions;
		public float barrierOffset;
		public VfxPrefab barrierPrefab;
		public VfxPrefab aoePrefab;
	}
}
