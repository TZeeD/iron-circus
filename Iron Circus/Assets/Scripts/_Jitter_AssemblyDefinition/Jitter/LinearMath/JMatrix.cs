using System;

namespace Jitter.LinearMath
{
	public struct JMatrix
	{
		public JMatrix(JVector side, JVector up, JVector fwd) : this()
		{
		}

		public float M11;
		public float M12;
		public float M13;
		public float M21;
		public float M22;
		public float M23;
		public float M31;
		public float M32;
		public float M33;
	}
}
