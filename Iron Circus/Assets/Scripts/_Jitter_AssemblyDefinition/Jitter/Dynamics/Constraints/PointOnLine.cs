using Jitter.Dynamics;
using Jitter.LinearMath;

namespace Jitter.Dynamics.Constraints
{
	public class PointOnLine : Constraint
	{
		public PointOnLine(JRigidbody body1, JRigidbody body2, JVector lineStartPointBody1, JVector pointBody2) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
