using UnityEngine.UI;
using UnityEngine;

namespace UnityEngine.UI.Extensions
{
	public class CUIGraphic : BaseMeshEffect
	{
		public override void ModifyMesh(VertexHelper _vh)
		{
		}

		[SerializeField]
		protected bool isCurved;
		[SerializeField]
		protected bool isLockWithRatio;
		[SerializeField]
		protected float resolution;
		[SerializeField]
		protected Graphic uiGraphic;
		[SerializeField]
		protected CUIGraphic refCUIGraphic;
		[SerializeField]
		protected CUIBezierCurve[] refCurves;
		[SerializeField]
		protected Vector3_Array2D[] refCurvesControlRatioPoints;
	}
}
