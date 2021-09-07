using System;
using UnityEngine;

namespace Rewired
{
	[Serializable]
	public class ControllerTemplateElementIdentifier
	{
		[SerializeField]
		private int _id;
		[SerializeField]
		private string _name;
		[SerializeField]
		private string _positiveName;
		[SerializeField]
		private string _negativeName;
		[SerializeField]
		private ControllerTemplateElementType _elementType;
	}
}
