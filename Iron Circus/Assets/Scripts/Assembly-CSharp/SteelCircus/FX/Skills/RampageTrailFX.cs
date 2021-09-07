using UnityEngine;
using SteelCircus.FX;

namespace SteelCircus.FX.Skills
{
	public class RampageTrailFX : MonoBehaviour
	{
		[SerializeField]
		private TrailFollowTransform leftHand;
		[SerializeField]
		private TrailFollowTransform rightHand;
		[SerializeField]
		private string leftHandBoneName;
		[SerializeField]
		private string rightHandBoneName;
		public AnimationCurve moveSpeedToTrailLength;
	}
}
