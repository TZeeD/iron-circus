using UnityEngine;
using UnityEngine.UI;

public class LocalPlayerDeathControllerUi : MonoBehaviour
{
	[SerializeField]
	private GameObject koPanel;
	[SerializeField]
	private Animator koAnimator;
	[SerializeField]
	private Text byMessage;
	[SerializeField]
	private SimpleCountDown respawnCountDown;
}
