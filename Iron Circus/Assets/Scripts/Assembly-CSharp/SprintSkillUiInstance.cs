using UnityEngine;
using UnityEngine.UI;

public class SprintSkillUiInstance : MonoBehaviour
{
	[SerializeField]
	private Image chargeIndicatorFg;
	[SerializeField]
	private Image chargeIndicatorBg;
	[SerializeField]
	private Color depletedBlinkColor;
	[SerializeField]
	private float chargeDepletedBlinkDuration;
	[SerializeField]
	private float chargeDepletedBlinkFrequency;
}
