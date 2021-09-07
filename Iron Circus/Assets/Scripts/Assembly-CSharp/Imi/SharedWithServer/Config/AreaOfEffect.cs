using System;

namespace Imi.SharedWithServer.Config
{
	[Serializable]
	public struct AreaOfEffect
	{
		public AoeShape shape;
		public float radius;
		public float deadZone;
		public float angle;
		public float rectWidth;
		public float rectLength;
		public VfxPrefab vfxPrefab;
	}
}
