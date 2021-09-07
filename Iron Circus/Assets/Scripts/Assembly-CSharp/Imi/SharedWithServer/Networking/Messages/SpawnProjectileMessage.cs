using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
	public class SpawnProjectileMessage : Message
	{
		public SpawnProjectileMessage() : base(default(RumpfieldMessageType))
		{
		}

		public ushort uniqueId;
		public ulong owner;
		public int projectileType;
		public float radius;
		public float height;
		public JVector position;
		public JVector velocity;
		public int areaOfEffectShape;
		public float aoeRadius;
		public float aoeDeadzone;
		public float aoeAngle;
		public int projectileDmg;
		public float projectilePushback;
	}
}
