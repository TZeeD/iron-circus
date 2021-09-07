using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MainSkillUiInstance : MonoBehaviour
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
	private Image colorUnaffectedSkillImage;
	[SerializeField]
	private GameObject particleGlow;
	[SerializeField]
	private Image buttonIcon;
	[SerializeField]
	private TextMeshProUGUI coolDownText;
	[SerializeField]
	private Image refilledShine;
	[SerializeField]
	private Image refilledShineBig;
	[SerializeField]
	private float shineIntensity;
	[SerializeField]
	private float bigShineIntensity;
	[SerializeField]
	private float blinkDuration;
	[SerializeField]
	private float inactiveAlpha;
	[SerializeField]
	private float transitionFadeDuration;
}
