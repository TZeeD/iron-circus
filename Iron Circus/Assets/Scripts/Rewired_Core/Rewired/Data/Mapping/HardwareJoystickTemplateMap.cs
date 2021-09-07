using System;
using System.Collections.Generic;
using UnityEngine;
using Rewired.Data;

namespace Rewired.Data.Mapping
{
	public class HardwareJoystickTemplateMap : HardwareControllerTemplateMap
	{
		[Serializable]
		public class ElementIdentifierMap
		{
			public int templateId;
			public int joystickId;
			public int joystickId2;
			public bool splitAxis;
		}

		[Serializable]
		public class Entry
		{
			public int id;
			public string name;
			public string joystickGuid;
			public string fileGuid;
			public List<HardwareJoystickTemplateMap.ElementIdentifierMap> elementIdentifierMappings;
		}

		[Serializable]
		public class SpecialElementEntry
		{
			public int elementIdentifierId;
			public string data;
		}

		[SerializeField]
		private string controllerName;
		[SerializeField]
		private string description;
		[SerializeField]
		private string templateGuid;
		[SerializeField]
		private string className;
		[SerializeField]
		private ControllerTemplateElementIdentifier_Editor[] elementIdentifiers;
		[SerializeField]
		private List<HardwareJoystickTemplateMap.Entry> joysticks;
		[SerializeField]
		private SpecialElementEntry[] specialElements;
		[SerializeField]
		private int elementIdentifierIdCounter;
		[SerializeField]
		private int joystickIdCounter;
	}
}
