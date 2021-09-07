using UnityEngine;

public class PlayerFloorPingDisplay : MonoBehaviour
{
	public Transform lineParent;
	public Transform lineTransform;
	public SpriteRenderer lineSprite;
	public AnimationCurve linePosCurve;
	public AnimationCurve lineLengthCurve;
	public float lineLengthBase;
	public float lineLengthDistScale;
	public float lineAlpha;
	public MeshRenderer circle;
	public AnimationCurve scaleCurve;
	public AnimationCurve outlineRadiusCurve;
	public AnimationCurve secondaryRadiusCurve;
	public float initialScale;
	public float animationDuration;
	public AnimationCurve outerAlphaCurve;
	public AnimationCurve innerAlphaCurve;
}
