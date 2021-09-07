using Imi.ScEvents;

namespace Imi.ScGameStats
{
	public class TrackingEvent
	{
		public TrackingEvent(ulong playerId, Statistics statistics, float value, StatisticsMode mode)
		{
		}

		public ulong playerId;
		public Statistics statistics;
		public float value;
		public StatisticsMode calculationMode;
	}
}
