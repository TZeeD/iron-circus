namespace Rewired
{
	public class PlayerController
	{
		public class Definition
		{
			public bool enabled;
			public int playerId;
		}

		public class Element
		{
			public class Definition
			{
				public bool enabled;
				public string name;
			}

			internal enum Type
			{
				Button = 0,
				Axis = 1,
				MouseAxis = 2,
				MouseWheelAxis = 3,
				Axis2D = 100,
				MouseAxis2D = 101,
				MouseWheel = 102,
			}

			internal enum TypeWithSource
			{
				Button = 0,
				Axis = 1,
				MouseAxis = 2,
				MouseWheelAxis = 3,
			}

			internal Element(PlayerController parent, PlayerController.Element.Definition definition)
			{
			}

		}

		internal PlayerController(PlayerController.Definition definition)
		{
		}

	}
}
