using System;
using UnityEngine;
using Rewired;

namespace Rewired.Data.Mapping
{
	[Serializable]
	public class AxisCalibrationInfo
	{
		[SerializeField]
		private bool _applyRangeCalibration;
		[SerializeField]
		private bool _invert;
		[SerializeField]
		private float _deadZone;
		[SerializeField]
		private float _zero;
		[SerializeField]
		private float _min;
		[SerializeField]
		private float _max;
		[SerializeField]
		private AxisSensitivityType _sensitivityType;
		[SerializeField]
		private float _sensitivity;
		[SerializeField]
		private AnimationCurve _sensitivityCurve;
	}
}
