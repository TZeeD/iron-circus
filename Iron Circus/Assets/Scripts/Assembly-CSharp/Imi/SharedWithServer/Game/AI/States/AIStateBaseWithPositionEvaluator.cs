using Imi.SharedWithServer.Game.AI;

namespace Imi.SharedWithServer.Game.AI.States
{
	public class AIStateBaseWithPositionEvaluator : AIStateBase
	{
		protected AIStateBaseWithPositionEvaluator(AIStateMachine owner, AICache cache) : base(default(AIStateMachine), default(AICache))
		{
		}

	}
}
