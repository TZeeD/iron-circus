namespace Imi.SharedWithServer.Game.AI
{
	public class BaseAI
	{
		public BaseAI(GameEntity playerEntity, AIDifficulty difficulty, AIRole role, AICache cache)
		{
		}

		public bool penalizePassingToBots;
		public bool canSampleGeometryGoals;
		public float scaleGoalPredictionTime;
	}
}
