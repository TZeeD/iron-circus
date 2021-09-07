using System;
using Jitter.Dynamics;
using Jitter.LinearMath;

public struct JCollision
{
	public JCollision(GameEntity entity1, GameEntity entity2, JRigidbody body1, JRigidbody body2, JVector point1, JVector point2, JVector normal, float penetration) : this()
	{
	}

	public JVector point1;
	public JVector point2;
	public JVector normal;
	public float penetration;
}
