using System;

namespace Rewired.Utils.Classes.Data
{
	[Serializable]
	public struct ScreenRect
	{
		public ScreenRect(float left, float bottom, float width, float height) : this()
		{
		}

		public float xMin;
		public float yMin;
		public float width;
		public float height;
	}
}
