using System;
using UnityEngine.UI;
using UnityEngine;

namespace Imi.SteelCircus.ui
{
	[Serializable]
	public class UIScreenState
	{
		public Button[] enterButtons;
		public AnimationClip animation;
		public Button selectOnEnter;
		public Selectable lastSelected;
	}
}
