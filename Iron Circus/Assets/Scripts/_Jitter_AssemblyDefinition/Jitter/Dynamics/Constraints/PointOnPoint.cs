using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints
{
	public class PointOnPoint : Constraint
	{
		public PointOnPoint(JRigidbody body1, JRigidbody body2, JVector anchor) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
