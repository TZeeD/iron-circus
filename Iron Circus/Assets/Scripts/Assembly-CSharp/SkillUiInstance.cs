using UnityEngine;
using UnityEngine.UI;

public class SkillUiInstance : MonoBehaviour
{
	[SerializeField]
	private Image chargeIndicatorFg;
	[SerializeField]
	private Image chargeIndicatorBg;
	[SerializeField]
	private Image refilledShine;
	[SerializeField]
	private Image refilledShineBig;
	[SerializeField]
	private Image buttonIcon;
	[SerializeField]
	private GameObject particles;
	[SerializeField]
	private float shineIntensity;
	[SerializeField]
	private float bigShineIntensity;
	[SerializeField]
	private float blinkDuration;
}
