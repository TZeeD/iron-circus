using Jitter.Dynamics.Constraints;
using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints.SingleBody
{
	public class PointOnPoint : Constraint
	{
		public PointOnPoint(JRigidbody body, JVector localAnchor) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
