using UnityEngine;

namespace Imi.SteelCircus.Utils
{
	public class RotateInAxis : MonoBehaviour
	{
		protected enum Axis
		{
			XAxis = 0,
			YAxis = 1,
			ZAxis = 2,
		}

		[SerializeField]
		private Axis axis;
		[SerializeField]
		private float degreesPerSecond;
	}
}
