using UnityEngine;

public class KoListUi : MonoBehaviour
{
	[SerializeField]
	private GameObject killEntryPrefab;
	[SerializeField]
	private GameObject alphaKilledPrefab;
	[SerializeField]
	private GameObject betaKilledPrefab;
	[SerializeField]
	private Transform alpha_List;
	[SerializeField]
	private Transform beta_List;
	[SerializeField]
	private Color teamAlphaColor;
	[SerializeField]
	private Color teamBetaColor;
}
