using UnityEngine;
using UnityEngine.UI;

public class ChampionOverheadUi : MonoBehaviour
{
	[SerializeField]
	private Image ballOwnerNameDecoLeft;
	[SerializeField]
	private Image ballOwnerNameDecoRight;
	public Text overheadUsername;
	public RectTransform overheadRectTrans;
	public RectTransform nameParentRectTrans;
	[SerializeField]
	private Text tfInvalidAction;
	[SerializeField]
	private float invalidActionDuration;
	[SerializeField]
	private float localPlayerYDefault;
	[SerializeField]
	private float localPlayerYInvalidAction;
	[SerializeField]
	private float invalidActionSmoothing;
	public GameObject localPlayerExtras;
	public GameObject localPlayerArrowPrefab;
	public float VictoryScreenOffsetAmount;
	[SerializeField]
	private Color ballOwnershipBlinkColor;
	[SerializeField]
	private float ballOwnershipBlinkDuration;
}
