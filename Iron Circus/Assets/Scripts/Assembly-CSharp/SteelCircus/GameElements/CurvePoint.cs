using System;

namespace SteelCircus.GameElements
{
	[Serializable]
	public struct CurvePoint
	{
		public CurvePoint(float time, float value, float inSlope, float outSlope, int leftTangentMode, int rightTangentMode) : this()
		{
		}

		public float time;
		public float value;
		public float inSlope;
		public float outSlope;
		public int leftTangentMode;
		public int rightTangentMode;
	}
}
