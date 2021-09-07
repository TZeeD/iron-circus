using Imi.SharedWithServer.Game.AI;

namespace Imi.SharedWithServer.Game.AI.States
{
	public class AIStateBallOwner : AIStateBaseWithPositionEvaluator
	{
		public AIStateBallOwner(AIStateMachine owner, AICache cache) : base(default(AIStateMachine), default(AICache))
		{
		}

		public bool debugDisableShooting;
		public bool debugDisableMovement;
		public bool debugDisableDodge;
	}
}
