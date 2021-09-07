using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
	public class AICollisionShapeRectangle : AICollisionShapePolyLine
	{
		public AICollisionShapeRectangle(JVector position, float sizeX, float sizeZ, bool isTrigger, GameEntity entity) : base(default(bool), default(GameEntity))
		{
		}

	}
}
