using System;
using UnityEngine;

namespace Rewired
{
	[Serializable]
	public class ControllerSetSelector
	{
		public enum Type
		{
			All = 0,
			ControllerType = 1,
			HardwareType = 2,
			ControllerTemplateType = 3,
			PersistentControllerInstance = 4,
			SessionControllerInstance = 5,
		}

		[SerializeField]
		private Type _type;
		[SerializeField]
		private ControllerType _controllerType;
		[SerializeField]
		private string _guid;
		[SerializeField]
		private string _hardwareIdentifier;
		[SerializeField]
		private int _controllerId;
	}
}
