using System;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace SharedWithServer.ScEntitas.Systems.Gameplay
{
	[Serializable]
	public struct ObstacleCheckResult
	{
		public bool collided;
		public JVector projectedPosition;
		public JVector resultDirection;
		public List<SphereCastData> sphereCastResults;
	}
}
