using UnityEngine;

namespace SteelCircus.FX
{
	public class KennyFlame : MonoBehaviour
	{
		[SerializeField]
		private MeshRenderer[] meshes;
		[SerializeField]
		private Transform scaleTransform;
		[SerializeField]
		private AnimationCurve intensityToScale;
		[SerializeField]
		private AnimationCurve intensityToYScale;
	}
}
