using System;
using UnityEngine;

namespace SteelCircus.UI
{
	[Serializable]
	public class SubPanelObjectData
	{
		public SubPanelObject panel;
		public bool isVisible;
		public bool isActive;
		public bool isHighlighted;
		public GameObject navigatorButton;
	}
}
