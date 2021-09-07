using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.EntitasShared.Components.Pickup
{
	public class SpawnPickupComponent : ImiComponent
	{
		public JVector position;
		public PickupType type;
		public UniqueId idOfSpawnedPickup;
	}
}
