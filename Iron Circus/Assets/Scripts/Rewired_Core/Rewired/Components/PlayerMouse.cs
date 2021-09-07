using System;
using UnityEngine.Events;
using UnityEngine;
using Rewired;

namespace Rewired.Components
{
	[Serializable]
	public class PlayerMouse : PlayerController
	{
		private class MovementAreaUnit
		{
		}

		[Serializable]
		public class ScreenPositionChangedHandler : UnityEvent<Vector2>
		{
		}

		[SerializeField]
		private bool _defaultToCenter;
		[SerializeField]
		private float _pointerSpeed;
		[SerializeField]
		private bool _useHardwarePointerPosition;
		[SerializeField]
		private Rect _movementArea;
		[SerializeField]
		private PlayerMouse.MovementAreaUnit _movementAreaUnit;
		[SerializeField]
		private ScreenPositionChangedHandler _onScreenPositionChanged;
	}
}
