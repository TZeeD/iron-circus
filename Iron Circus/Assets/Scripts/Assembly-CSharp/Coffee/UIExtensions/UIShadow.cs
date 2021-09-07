using System;
using UnityEngine;
using System.Collections.Generic;

namespace Coffee.UIExtensions
{
	public class UIShadow : BaseMeshEffect
	{
		[Serializable]
		public class AdditionalShadow
		{
			public float blur;
			public ShadowStyle style;
			public Color effectColor;
			public Vector2 effectDistance;
			public bool useGraphicAlpha;
		}

		[SerializeField]
		private float m_BlurFactor;
		[SerializeField]
		private ShadowStyle m_Style;
		[SerializeField]
		private List<UIShadow.AdditionalShadow> m_AdditionalShadows;
		[SerializeField]
		private Color m_EffectColor;
		[SerializeField]
		private Vector2 m_EffectDistance;
		[SerializeField]
		private bool m_UseGraphicAlpha;
	}
}
