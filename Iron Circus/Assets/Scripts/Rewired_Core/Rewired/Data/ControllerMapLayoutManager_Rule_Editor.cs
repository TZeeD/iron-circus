using System;
using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Data
{
	[Serializable]
	public class ControllerMapLayoutManager_Rule_Editor
	{
		[SerializeField]
		private string _tag;
		[SerializeField]
		private List<int> _categoryIds;
		[SerializeField]
		private int _layoutId;
		[SerializeField]
		private ControllerSetSelector_Editor _controllerSetSelector;
	}
}
