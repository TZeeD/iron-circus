using Imi.SharedWithServer.Game.AI;

namespace Imi.SharedWithServer.Game.AI.States
{
	public class AIStateTeamMateOwnsBall : AIStateBaseWithPositionEvaluator
	{
		public AIStateTeamMateOwnsBall(AIStateMachine owner, AICache cache) : base(default(AIStateMachine), default(AICache))
		{
		}

	}
}
