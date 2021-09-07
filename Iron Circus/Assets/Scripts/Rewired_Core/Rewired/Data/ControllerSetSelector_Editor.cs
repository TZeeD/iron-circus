using System;
using Rewired;
using UnityEngine;

namespace Rewired.Data
{
	[Serializable]
	public class ControllerSetSelector_Editor
	{
		[SerializeField]
		private ControllerSetSelector.Type _type;
		[SerializeField]
		private ControllerType _controllerType;
		[SerializeField]
		private string _hardwareTypeGuidString;
		[SerializeField]
		private string _hardwareIdentifier;
		[SerializeField]
		private string _controllerTemplateTypeGuidString;
		[SerializeField]
		private string _deviceInstanceGuidString;
		[SerializeField]
		private int _customControllerSourceId;
		[SerializeField]
		private int _controllerId;
	}
}
