using UnityEngine;

namespace SteelCircus.FX.Skills
{
	public class AnimateShader : MonoBehaviour
	{
		[SerializeField]
		private string propertyName;
		[SerializeField]
		private float duration;
		[SerializeField]
		private bool loop;
		[SerializeField]
		private AnimationCurve curve;
		[SerializeField]
		private Renderer renderer;
	}
}
