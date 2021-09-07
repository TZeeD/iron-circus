using UnityEngine;

public class PickupConfig : SingletonScriptableObject<PickupConfig>
{
	public GameObject healthPickupPrefab;
	public GameObject refreshPickupPrefab;
	public GameObject sprintPickupPrefab;
	public GameObject healthSmallPickupPrefab;
	public GameObject refreshSmallPickupPrefab;
	public GameObject sprintSmallPickupPrefab;
}
