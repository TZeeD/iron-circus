using Jitter.Dynamics.Constraints;
using Jitter.Dynamics;

namespace Jitter.Dynamics.Constraints.SingleBody
{
	public class FixedAngle : Constraint
	{
		public FixedAngle(JRigidbody body1) : base(default(JRigidbody), default(JRigidbody))
		{
		}

	}
}
