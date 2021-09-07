using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class VATOneShotFX : MonoBehaviour
	{
		[SerializeField]
		protected float duration;
		[SerializeField]
		protected float delay;
		[SerializeField]
		protected Color teamAlphaColor;
		[SerializeField]
		protected Color teamBetaColor;
		[SerializeField]
		protected AnimationCurve alphaScaleOverDuration;
		[SerializeField]
		protected MeshRenderer vatRenderer;
	}
}
