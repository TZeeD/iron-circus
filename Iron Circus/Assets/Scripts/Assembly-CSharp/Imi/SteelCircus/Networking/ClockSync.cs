using System;

namespace Imi.SteelCircus.Networking
{
	[Serializable]
	public class ClockSync
	{
		public int MinimumJitterBuffer;
		public int Past;
		public int Future;
		public float smoothedOffset;
		public float defaultSmoothing;
		public float targetOffset;
		public float adjustedTargetOffset;
		public float softSmoothIntervall;
		public float softSmoothValue;
		public float hardSmoothIntervall;
		public float hardSmoothValue;
		public float upscalingPerLoss;
		public float downscalingRate;
		public int MaxLossDetected;
		public float lossDetected;
		public float tickSlowerThreshold;
		public int tickSlowerOffset;
		public float tickFasterThreshold;
		public int tickFasterOffset;
		public int defaultTickRate;
	}
}
