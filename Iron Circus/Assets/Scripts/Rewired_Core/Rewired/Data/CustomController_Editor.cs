using System;
using Rewired;
using UnityEngine;
using Rewired.Data.Mapping;
using System.Collections.Generic;

namespace Rewired.Data
{
	[Serializable]
	public class CustomController_Editor
	{
		[Serializable]
		public class Element
		{
			public int elementIdentifierId;
			public string name;
		}

		[Serializable]
		public class Axis : Element
		{
			public AxisRange range;
			public bool invert;
			public float deadZone;
			public float zero;
			public float min;
			public float max;
			public bool doNotCalibrateRange;
			public AxisSensitivityType sensitivityType;
			public float sensitivity;
			public AnimationCurve sensitivityCurve;
			public HardwareAxisInfo axisInfo;
		}

		[Serializable]
		public class Button : Element
		{
		}

		[SerializeField]
		private string _name;
		[SerializeField]
		private string _descriptiveName;
		[SerializeField]
		private int _id;
		[SerializeField]
		private string _typeGuidString;
		[SerializeField]
		private List<ControllerElementIdentifier> _elementIdentifiers;
		[SerializeField]
		private List<CustomController_Editor.Axis> _axes;
		[SerializeField]
		private List<CustomController_Editor.Button> _buttons;
		[SerializeField]
		private int _elementIdentifierIdCounter;
	}
}
