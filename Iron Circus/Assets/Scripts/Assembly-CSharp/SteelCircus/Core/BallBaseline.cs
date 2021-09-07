using Jitter.LinearMath;
using Imi.SharedWithServer.Game;

namespace SteelCircus.Core
{
	public class BallBaseline
	{
		public uint tick;
		public JVector velocity;
		public UniqueId owner;
		public float traveledDistance;
		public float flightDuration;
		public bool ballHoldDisabled;
	}
}
