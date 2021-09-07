using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIShiny : UIEffectBase
	{
		[SerializeField]
		private float m_EffectFactor;
		[SerializeField]
		private float m_Width;
		[SerializeField]
		private float m_Rotation;
		[SerializeField]
		private float m_Softness;
		[SerializeField]
		private float m_Brightness;
		[SerializeField]
		private float m_Gloss;
		[SerializeField]
		protected EffectArea m_EffectArea;
		[SerializeField]
		private EffectPlayer m_Player;
		[SerializeField]
		private bool m_Play;
		[SerializeField]
		private bool m_Loop;
		[SerializeField]
		private float m_Duration;
		[SerializeField]
		private float m_LoopDelay;
		[SerializeField]
		private AnimatorUpdateMode m_UpdateMode;
	}
}
