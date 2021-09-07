using UnityEngine;

namespace Imi.Sandbox.Niki
{
	public class NikiBloom : MonoBehaviour
	{
		[SerializeField]
		private float _threshold;
		[SerializeField]
		private float _softKnee;
		[SerializeField]
		private float _radius;
		[SerializeField]
		private float _intensity;
		[SerializeField]
		private bool _highQuality;
		[SerializeField]
		private bool _antiFlicker;
		[SerializeField]
		private Shader _shader;
	}
}
