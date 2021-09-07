using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ForfeitMatchUi : MonoBehaviour
{
	[SerializeField]
	private GameObject forfeitGo;
	[SerializeField]
	private RectTransform countDownTrans;
	[SerializeField]
	private Image forfeitBg;
	[SerializeField]
	private TextMeshProUGUI playersVotesTxt;
	[SerializeField]
	private TextMeshProUGUI countdownTxt;
	[SerializeField]
	private Button voteBtn;
	[SerializeField]
	private SimpleCountDownTextMesh countdown;
}
