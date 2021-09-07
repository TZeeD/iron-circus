using UnityEngine;

public class MainMenuTurntable : MonoBehaviour
{
	public Camera renderCam;
	public Transform championTurntablePivot;
	[SerializeField]
	private GameObject championTurntablePrefab;
	[SerializeField]
	private MainMenuTurntableConfig mainMenuTurntableConfig;
	[SerializeField]
	private GameObject mainMenuLighting;
}
