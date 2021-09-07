using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
	public class BarrierConfig : SkillGraphConfig
	{
		public ButtonType button;
		public string iconName;
		public float duration;
		public float cooldown;
		public JVector barrierDimensions;
		public float barrierOffset;
		public VfxPrefab aoePrefab;
		public GameObject barrierPrefab;
		public VfxPrefab rotationControlsPrefab;
		public VfxPrefab barrierConnectionPrefab;
	}
}
