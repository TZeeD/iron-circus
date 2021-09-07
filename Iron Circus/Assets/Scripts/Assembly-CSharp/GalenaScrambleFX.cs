using UnityEngine;

public class GalenaScrambleFX : MonoBehaviour
{
	[SerializeField]
	private Color trailColorAlpha;
	[SerializeField]
	private Color trailColorBeta;
	[SerializeField]
	private Color tubeColorAlpha;
	[SerializeField]
	private Color tubeColorBeta;
	[SerializeField]
	private Transform[] spheres;
	[SerializeField]
	private float rotationSpeed;
	[SerializeField]
	private float oscillationSpeed;
	[SerializeField]
	private MeshRenderer tubeRenderer;
	[SerializeField]
	private AnimationCurve tubeIntensity;
	[SerializeField]
	private Transform tubeParent;
	[SerializeField]
	private MeshRenderer normalsRenderer;
	[SerializeField]
	private float fadeOutDuration;
	public float width;
	public float thickness;
	public float centerY;
	public float lerpPhaseDuration;
	public float tmpSpeed;
	public float tmpDuration;
}
