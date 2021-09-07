using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class MvpVoteButton : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI voteCountBtnTxt;
	[SerializeField]
	private TextMeshProUGUI voteCountImgTxt;
	[SerializeField]
	private Image voteBtnArrowImg;
	[SerializeField]
	private GameObject voteStateText;
	[SerializeField]
	private GameObject voteStateBG;
	[SerializeField]
	private GameObject voteStateBorder;
	[SerializeField]
	private Image thumbsUpImg;
	[SerializeField]
	private Image thumbsUpImgGlow;
	[SerializeField]
	private GameObject voteSelectedBorder;
}
