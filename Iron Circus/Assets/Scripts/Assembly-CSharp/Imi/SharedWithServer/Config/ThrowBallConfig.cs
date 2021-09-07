using SteelCircus.GameElements;

namespace Imi.SharedWithServer.Config
{
	public class ThrowBallConfig : SkillGraphConfig
	{
		public float chargeDuration;
		public float prechargeTimeout;
		public Curve chargeCurve;
		public float turnSnapAngle;
		public float turnSpeed;
		public float ballHitVelocityMin;
		public float ballHitVelocityMax;
		public float throwAnimDuration;
	}
}
