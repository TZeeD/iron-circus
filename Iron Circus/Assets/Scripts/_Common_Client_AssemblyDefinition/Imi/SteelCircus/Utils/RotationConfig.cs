using System;
using UnityEngine;

namespace Imi.SteelCircus.Utils
{
	[Serializable]
	public class RotationConfig
	{
		public enum Mode
		{
			Loop = 0,
			PingPong = 1,
		}

		public Mode mode;
		public Vector3 axis;
		public float duration;
		public float degreesRange;
		public float rotationProgress;
	}
}
