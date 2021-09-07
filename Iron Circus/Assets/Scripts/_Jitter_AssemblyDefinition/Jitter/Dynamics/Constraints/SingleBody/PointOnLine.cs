using Jitter.Dynamics.Constraints;
using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints.SingleBody
{
	public class PointOnLine : Constraint
	{
		public PointOnLine(JRigidbody body, JVector localAnchor, JVector lineDirection) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
