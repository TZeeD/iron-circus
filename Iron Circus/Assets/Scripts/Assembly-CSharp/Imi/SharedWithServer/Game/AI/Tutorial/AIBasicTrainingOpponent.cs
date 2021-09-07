using Imi.SharedWithServer.Game.AI;

namespace Imi.SharedWithServer.Game.AI.Tutorial
{
	public class AIBasicTrainingOpponent : AIStateMachine
	{
		public AIBasicTrainingOpponent(GameEntity playerEntity, AIDifficulty difficulty, AIRole role, AICache cache) : base(default(GameEntity), default(AIDifficulty), default(AIRole), default(AICache))
		{
		}

	}
}
