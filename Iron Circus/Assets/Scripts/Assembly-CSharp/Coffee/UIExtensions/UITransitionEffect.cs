using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UITransitionEffect : UIEffectBase
	{
		public enum EffectMode
		{
			Fade = 1,
			Cutoff = 2,
			Dissolve = 3,
		}

		[SerializeField]
		private EffectMode m_EffectMode;
		[SerializeField]
		private float m_EffectFactor;
		[SerializeField]
		private Texture m_TransitionTexture;
		[SerializeField]
		private EffectArea m_EffectArea;
		[SerializeField]
		private bool m_KeepAspectRatio;
		[SerializeField]
		private float m_DissolveWidth;
		[SerializeField]
		private float m_DissolveSoftness;
		[SerializeField]
		private Color m_DissolveColor;
		[SerializeField]
		private bool m_PassRayOnHidden;
		[SerializeField]
		private EffectPlayer m_Player;
	}
}
