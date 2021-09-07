using Imi.SharedWithServer.Game.AI;

namespace Imi.SharedWithServer.Game.AI.States
{
	public class AIStateOpponentOwnsBall : AIStateBaseWithPositionEvaluator
	{
		public AIStateOpponentOwnsBall(AIStateMachine owner, AICache cache) : base(default(AIStateMachine), default(AICache))
		{
		}

	}
}
