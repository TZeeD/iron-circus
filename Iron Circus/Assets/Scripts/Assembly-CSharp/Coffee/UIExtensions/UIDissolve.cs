using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIDissolve : UIEffectBase
	{
		[SerializeField]
		private float m_EffectFactor;
		[SerializeField]
		private float m_Width;
		[SerializeField]
		private float m_Softness;
		[SerializeField]
		private Color m_Color;
		[SerializeField]
		private ColorMode m_ColorMode;
		[SerializeField]
		private Texture m_NoiseTexture;
		[SerializeField]
		protected EffectArea m_EffectArea;
		[SerializeField]
		private bool m_KeepAspectRatio;
		[SerializeField]
		private EffectPlayer m_Player;
		[SerializeField]
		private bool m_ReverseAnimation;
		[SerializeField]
		private float m_Duration;
		[SerializeField]
		private AnimatorUpdateMode m_UpdateMode;
	}
}
