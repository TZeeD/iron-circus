using System;
using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Data
{
	[Serializable]
	public class ControllerMapEnabler_Rule_Editor
	{
		[SerializeField]
		private string _tag;
		[SerializeField]
		private bool _enable;
		[SerializeField]
		private List<int> _categoryIds;
		[SerializeField]
		private List<int> _layoutIds;
		[SerializeField]
		private ControllerSetSelector_Editor _controllerSetSelector;
	}
}
