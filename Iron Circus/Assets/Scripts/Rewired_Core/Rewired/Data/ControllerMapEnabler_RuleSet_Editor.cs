using System;
using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Data
{
	[Serializable]
	public class ControllerMapEnabler_RuleSet_Editor
	{
		[SerializeField]
		private int _id;
		[SerializeField]
		private string _name;
		[SerializeField]
		private string _tag;
		[SerializeField]
		private List<ControllerMapEnabler_Rule_Editor> _rules;
	}
}
