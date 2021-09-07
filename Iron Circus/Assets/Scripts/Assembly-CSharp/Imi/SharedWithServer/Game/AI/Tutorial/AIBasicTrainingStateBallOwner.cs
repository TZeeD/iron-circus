using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.Game.AI;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Tutorial
{
	public class AIBasicTrainingStateBallOwner : AIStateBase
	{
		public AIBasicTrainingStateBallOwner(AIStateMachine owner, AICache cache) : base(default(AIStateMachine), default(AICache))
		{
		}

		public JVector targetPos;
		public float innerRange;
		public float outerRange;
	}
}
