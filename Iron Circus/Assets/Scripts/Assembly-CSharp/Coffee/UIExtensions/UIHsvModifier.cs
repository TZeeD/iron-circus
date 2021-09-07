using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIHsvModifier : UIEffectBase
	{
		[SerializeField]
		private Color m_TargetColor;
		[SerializeField]
		private float m_Range;
		[SerializeField]
		private float m_Hue;
		[SerializeField]
		private float m_Saturation;
		[SerializeField]
		private float m_Value;
	}
}
