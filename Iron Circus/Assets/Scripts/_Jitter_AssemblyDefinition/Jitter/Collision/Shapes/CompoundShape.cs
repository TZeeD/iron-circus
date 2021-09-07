using System;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Jitter.Collision.Shapes
{
	public class CompoundShape : Multishape
	{
		public struct TransformedShape
		{
			public TransformedShape(Shape shape, JMatrix orientation, JVector position) : this()
			{
			}

		}

		public CompoundShape(List<CompoundShape.TransformedShape> shapes)
		{
		}

	}
}
