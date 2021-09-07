using Jitter;
using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Joints
{
	public class LimitedHingeJoint : Joint
	{
		public LimitedHingeJoint(World world, JRigidbody body1, JRigidbody body2, JVector position, JVector hingeAxis, float hingeFwdAngle, float hingeBckAngle) : base(default(World))
		{
		}

	}
}
