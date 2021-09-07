using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class ProjectileImpactMessage : Message
	{
		public ProjectileImpactMessage() : base(default(RumpfieldMessageType))
		{
		}

		public int projectileType;
		public JVector position;
		public int aoeShape;
		public float aoeRadius;
		public float aoeAngle;
		public float aoeDeadZone;
	}
}
