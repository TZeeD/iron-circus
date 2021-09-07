using System.Collections.Generic;
using System.Collections.ObjectModel;
using JetBrains.Annotations;

namespace Jitter.Collision
{
	internal class IslandManager : ReadOnlyCollection<CollisionIsland>
	{
		public IslandManager([NotNull] IList<CollisionIsland> list) : base(list)
		{
		}
	}
}
