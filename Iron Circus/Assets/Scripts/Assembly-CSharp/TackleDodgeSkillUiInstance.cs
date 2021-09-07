using UnityEngine;
using UnityEngine.UI;

public class TackleDodgeSkillUiInstance : MonoBehaviour
{
	public bool UseSetupColors;
	[SerializeField]
	private Image skillIcon;
	[SerializeField]
	private CanvasGroup skillBox;
	[SerializeField]
	private Image coolDownFill;
	[SerializeField]
	private Image[] colorAffectedSkillImages;
	[SerializeField]
	private float inactiveAlpha;
	[SerializeField]
	private float transitionFadeDuration;
	[SerializeField]
	private Sprite tackleIcon;
	[SerializeField]
	private Sprite dodgeIcon;
	[SerializeField]
	private Image buttonIcon;
}
