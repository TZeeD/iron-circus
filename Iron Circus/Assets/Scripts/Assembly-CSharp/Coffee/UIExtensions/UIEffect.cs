using UnityEngine;
using System.Collections.Generic;

namespace Coffee.UIExtensions
{
	public class UIEffect : UIEffectBase
	{
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
		private bool m_AdvancedBlur;
		[SerializeField]
		private float m_ShadowBlur;
		[SerializeField]
		private ShadowStyle m_ShadowStyle;
		[SerializeField]
		private Color m_ShadowColor;
		[SerializeField]
		private Vector2 m_EffectDistance;
		[SerializeField]
		private bool m_UseGraphicAlpha;
		[SerializeField]
		private Color m_EffectColor;
		[SerializeField]
		private List<UIShadow.AdditionalShadow> m_AdditionalShadows;
	}
}
