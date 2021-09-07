using UnityEngine;
using TMPro;

public class LoadPenaltyText : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI playeMenuPenaltyText;
	[SerializeField]
	private GameObject playMenuPanelObject;
	[SerializeField]
	private TextMeshProUGUI mainMenuPenaltyText;
	[SerializeField]
	private GameObject mainMenuPanelObject;
	public bool reloadOnEnable;
}
