using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class LobbyProgressBar : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI usernameTxt;
	[SerializeField]
	private TextMeshProUGUI pickOrderTxt;
	[SerializeField]
	private Image currentOutline;
	[SerializeField]
	private Image currentProgressBar;
	[SerializeField]
	private Image progressBarBG;
	[SerializeField]
	private Image progressBarHeader;
	[SerializeField]
	private Image localPlayerIndicator;
	[SerializeField]
	private Image localPlayerSpeechBubble;
	[SerializeField]
	private Animation localPlayerIndicatorAnim;
	[SerializeField]
	private Animation localPlayerSpeechBubbleAnim;
	[SerializeField]
	private int pickingDoneDelay;
	[SerializeField]
	private Color activePickingColorAlpha;
	[SerializeField]
	private Color activePickingColorBeta;
}
