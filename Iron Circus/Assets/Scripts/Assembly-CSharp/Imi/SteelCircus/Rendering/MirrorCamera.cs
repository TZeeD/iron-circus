using UnityEngine;

namespace Imi.SteelCircus.Rendering
{
	public class MirrorCamera : MonoBehaviour
	{
		public float clipPlaneOffset;
		public float resolutionScale;
		public string rtGlobalShaderPropertyName;
		public bool applyBlur;
		public float minBlurDepth;
		public float maxBlurDepth;
		public float maxBlur;
	}
}
