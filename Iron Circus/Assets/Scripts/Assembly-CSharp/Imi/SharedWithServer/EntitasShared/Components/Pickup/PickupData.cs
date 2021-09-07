using System;
using Imi.SharedWithServer.Game;

namespace Imi.SharedWithServer.EntitasShared.Components.Pickup
{
	[Serializable]
	public class PickupData
	{
		public PickupType type;
		public int spawnChance;
	}
}
