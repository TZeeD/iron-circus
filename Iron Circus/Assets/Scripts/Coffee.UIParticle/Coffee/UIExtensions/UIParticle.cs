using UnityEngine.UI;
using System;
using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIParticle : MaskableGraphic
	{
		[Serializable]
		public class AnimatableProperty
		{
			public enum ShaderPropertyType
			{
				Color = 0,
				Vector = 1,
				Float = 2,
				Range = 3,
				Texture = 4,
			}

			[SerializeField]
			private string m_Name;
			[SerializeField]
			private ShaderPropertyType m_Type;
		}

		[SerializeField]
		private ParticleSystem m_ParticleSystem;
		[SerializeField]
		private UIParticle m_TrailParticle;
		[SerializeField]
		private bool m_IsTrail;
		[SerializeField]
		private float m_Scale;
		[SerializeField]
		private bool m_IgnoreParent;
		[SerializeField]
		private AnimatableProperty[] m_AnimatableProperties;
	}
}
