using SteelCircus.GameElements;

namespace Imi.SharedWithServer.Config
{
	public class BallConfig : GameConfigEntry
	{
		public float ballColliderRadius;
		public float ballPickupRadius;
		public float ballLowSpeedPickupRadius;
		public float ballLowSpeedFullEffectThreshold;
		public float ballLowSpeedStartEffectThreshold;
		public float blockPickupTravelDistance;
		public float blockPickupSpeedThreshold;
		public float takeBallInterpolationDuration;
		public float defaultFlightDrag;
		public float dragAfterForce;
		public Curve dragAfterForceCurve;
		public float dragAfterForceDuration;
		public float restThresholdVelocity;
	}
}
