using UnityEngine;

namespace Imi.SteelCircus.CameraSystem.Rigs
{
	public class PivotRotateCamera : PivotBasedCameraRig
	{
		[SerializeField]
		private float degreesPerSecond;
		[SerializeField]
		private float sineFloat;
	}
}
