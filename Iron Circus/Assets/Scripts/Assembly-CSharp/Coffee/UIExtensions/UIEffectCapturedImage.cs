using UnityEngine.UI;
using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIEffectCapturedImage : RawImage
	{
		public enum DesamplingRate
		{
			None = 0,
			x1 = 1,
			x2 = 2,
			x4 = 4,
			x8 = 8,
		}

		[SerializeField]
		private float m_EffectFactor;
		[SerializeField]
		private float m_ColorFactor;
		[SerializeField]
		private float m_BlurFactor;
		[SerializeField]
		private EffectMode m_EffectMode;
		[SerializeField]
		private ColorMode m_ColorMode;
		[SerializeField]
		private BlurMode m_BlurMode;
		[SerializeField]
		private Color m_EffectColor;
		[SerializeField]
		private DesamplingRate m_DesamplingRate;
		[SerializeField]
		private DesamplingRate m_ReductionRate;
		[SerializeField]
		private FilterMode m_FilterMode;
		[SerializeField]
		private Material m_EffectMaterial;
		[SerializeField]
		private int m_BlurIterations;
		[SerializeField]
		private bool m_FitToScreen;
		[SerializeField]
		private bool m_CaptureOnEnable;
		[SerializeField]
		private bool m_ImmediateCapturing;
	}
}
