using UnityEngine;

namespace SteelCircus.FX
{
	public class TrailFollowTransform : FollowTransform
	{
		public AnimationCurve moveSpeedToTrailLength;
		[SerializeField]
		private float debugAvgDistance;
	}
}
