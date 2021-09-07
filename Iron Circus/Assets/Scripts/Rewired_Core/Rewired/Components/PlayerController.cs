using System;
using Rewired;
using UnityEngine;
using UnityEngine.Events;
using System.Collections.Generic;

namespace Rewired.Components
{
	[Serializable]
	public class PlayerController : ComponentWrapper<PlayerController>
	{
		[Serializable]
		internal class ElementWithSourceInfo
		{
			[SerializeField]
			private string _name;
			[SerializeField]
			private PlayerController.Element.TypeWithSource _elementType;
			[SerializeField]
			private bool _enabled;
			[SerializeField]
			private int _actionId;
			[SerializeField]
			private AxisCoordinateMode _coordinateMode;
			[SerializeField]
			private float _absoluteToRelativeSensitivity;
			[SerializeField]
			private float _repeatRate;
		}

		private class Element
		{
			public class TypeWithSource
			{
			}

			public class Type
			{
			}
		}

		[Serializable]
		internal class ElementInfo
		{
			[SerializeField]
			private string _name;
			[SerializeField]
			private PlayerController.Element.Type _elementType;
			[SerializeField]
			private bool _enabled;
			[SerializeField]
			private PlayerController.ElementWithSourceInfo[] _elements;
		}

		[Serializable]
		public class ButtonStateChangedHandler : UnityEvent<int, bool>
		{
		}

		[Serializable]
		public class AxisValueChangedHandler : UnityEvent<int, float>
		{
		}

		[Serializable]
		public class EnabledStateChangedHandler : UnityEvent<bool>
		{
		}

		[SerializeField]
		private InputManager_Base _rewiredInputManager;
		[SerializeField]
		private int _playerId;
		[SerializeField]
		private List<PlayerController.ElementInfo> _elements;
		[SerializeField]
		private ButtonStateChangedHandler _onButtonStateChanged;
		[SerializeField]
		private AxisValueChangedHandler _onAxisValueChanged;
		[SerializeField]
		private EnabledStateChangedHandler _onEnabledStateChanged;
	}
}
