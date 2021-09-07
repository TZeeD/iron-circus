using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class OvertimeUi : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI overtimeTxt;
	[SerializeField]
	private TextMeshProUGUI goldenGoalTxt;
	[SerializeField]
	private TextMeshProUGUI infoTxt;
	[SerializeField]
	private Image background;
	[SerializeField]
	private Image scoreBorder;
	[SerializeField]
	private Transform animationParent;
	[SerializeField]
	private GameObject animationPrefab;
}
