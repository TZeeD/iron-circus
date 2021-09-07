using SteelCircus.GameElements;
using UnityEngine;

public class PickupSpawnpointUnityBehaviour : PickupSpawnpointUnityBehaviourBase
{
	[SerializeField]
	private bool fillRingContinously;
	[SerializeField]
	private GameObject spawnPointRing;
	[SerializeField]
	private float maxRadius;
}
