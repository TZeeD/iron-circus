using System;
using UnityEngine;

namespace Rewired
{
	[Serializable]
	public class Axis2DCalibration
	{
		[SerializeField]
		private DeadZone2DType _deadZoneType;
		[SerializeField]
		private AxisSensitivity2DType _sensitivityType;
	}
}
