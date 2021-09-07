using UnityEngine;

namespace Coffee.UIExtensions
{
	public class UIGradient : BaseMeshEffect
	{
		public enum Direction
		{
			Horizontal = 0,
			Vertical = 1,
			Angle = 2,
			Diagonal = 3,
		}

		public enum GradientStyle
		{
			Rect = 0,
			Fit = 1,
			Split = 2,
		}

		[SerializeField]
		private Direction m_Direction;
		[SerializeField]
		private Color m_Color1;
		[SerializeField]
		private Color m_Color2;
		[SerializeField]
		private Color m_Color3;
		[SerializeField]
		private Color m_Color4;
		[SerializeField]
		private float m_Rotation;
		[SerializeField]
		private float m_Offset1;
		[SerializeField]
		private float m_Offset2;
		[SerializeField]
		private GradientStyle m_GradientStyle;
		[SerializeField]
		private ColorSpace m_ColorSpace;
		[SerializeField]
		private bool m_IgnoreAspectRatio;
	}
}
