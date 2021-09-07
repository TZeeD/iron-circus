using UnityEngine;
using System.Collections.Generic;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;

public class Pickup : MonoBehaviour
{
	public List<PickupData> spawnData;
	public PickupType activeType;
	public PickupSize pickupSize;
	public bool isActiveOnStart;
	public float respawnDuration;
}
