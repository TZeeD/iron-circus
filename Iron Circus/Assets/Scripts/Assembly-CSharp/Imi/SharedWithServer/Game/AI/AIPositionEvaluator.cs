namespace Imi.SharedWithServer.Game.AI
{
	public class AIPositionEvaluator
	{
		public class Settings
		{
			public float teamMateFullPenaltyPos;
			public float teamMateZeroPenaltyPos;
			public float passLinesToTeamMatesWeight;
		}

		public AIPositionEvaluator(AIPositionEvaluator.Settings settings, BaseAI owner, AICache cache)
		{
		}

	}
}
