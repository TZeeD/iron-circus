using Rewired.Utils.Classes.Data;

namespace Rewired
{
	public class PlayerMouse : PlayerController
	{
		public class Definition : PlayerController.Definition
		{
			public bool defaultToCenter;
			public ScreenRect movementArea;
			public PlayerMouse.MovementAreaUnit movementAreaUnit;
			public float pointerSpeed;
			public bool useHardwarePointerPosition;
		}

		public enum MovementAreaUnit
		{
			Screen = 0,
			Pixel = 1,
		}

		private PlayerMouse(PlayerMouse.Definition definition) : base(default(PlayerController.Definition))
		{
		}

	}
}
