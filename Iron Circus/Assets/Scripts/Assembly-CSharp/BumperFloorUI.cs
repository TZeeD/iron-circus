using UnityEngine;

public class BumperFloorUI : MonoBehaviour
{
	public Transform hitParent;
	public ParticleSystem particles;
	public float hitAnimationDuration;
	public Transform hitCircle;
	public float hitCircleScale;
	public AnimationCurve hitCircleCurve;
	public Gradient hitCircleGradient;
	public Transform hitArrow;
	public float hitArrowScale;
	public AnimationCurve hitArrowShapeCurve;
	public AnimationCurve hitArrowScaleCurve;
	public Gradient hitArrowGradient;
}
