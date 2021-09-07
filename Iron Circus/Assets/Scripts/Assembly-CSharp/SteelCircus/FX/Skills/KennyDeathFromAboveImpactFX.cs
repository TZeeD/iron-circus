using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class KennyDeathFromAboveImpactFX : MonoBehaviour
	{
		[SerializeField]
		private Renderer shockwaveRenderer;
		[SerializeField]
		private Transform shockwaveParent;
		[SerializeField]
		private Renderer shockwaveFloorRenderer;
		[SerializeField]
		private Transform shockwaveFloorParent;
		[SerializeField]
		private float totalDuration;
		[SerializeField]
		private float shockwaveDuration;
		[SerializeField]
		private float shockwaveFloorDuration;
		[SerializeField]
		private AnimationCurve shockwaveAlpha;
		[SerializeField]
		private float shockwaveAnimPow;
		[SerializeField]
		private float shockwaveAnimDelay;
	}
}
