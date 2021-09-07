using UnityEngine.UI;
using UnityEngine;

namespace UnityEngine.UI.Extensions
{
	public class CurvedText : BaseMeshEffect
	{
		public override void ModifyMesh(VertexHelper vh)
		{
		}

		[SerializeField]
		private AnimationCurve _curveForText;
		[SerializeField]
		private float _curveMultiplier;
	}
}
