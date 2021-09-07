using UnityEngine;

namespace Imi.SteelCircus.CameraSystem.Rigs
{
	public class PivotPositionFollowCamera : PivotBasedCameraRig
	{
		[SerializeField]
		private float moveSpeed;
		[SerializeField]
		private float turnSpeed;
	}
}
