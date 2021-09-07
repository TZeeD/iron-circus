using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints
{
	public class PointPointDistance : Constraint
	{
		public PointPointDistance(JRigidbody body1, JRigidbody body2, JVector anchor1, JVector anchor2) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
