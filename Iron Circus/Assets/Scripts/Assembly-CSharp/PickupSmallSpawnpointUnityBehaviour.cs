using SteelCircus.GameElements;
using UnityEngine;

public class PickupSmallSpawnpointUnityBehaviour : PickupSpawnpointUnityBehaviourBase
{
	[SerializeField]
	private GameObject spawnPointRing;
	[SerializeField]
	private float minRadius;
	[SerializeField]
	private float maxRadius;
	[SerializeField]
	private float minOpacity;
	[SerializeField]
	private float maxOpacity;
	[SerializeField]
	private float openRingDuration;
	[SerializeField]
	private float closeRingDuration;
}
