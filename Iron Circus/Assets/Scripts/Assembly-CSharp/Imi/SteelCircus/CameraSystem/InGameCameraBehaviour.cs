using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
	public class InGameCameraBehaviour : MonoBehaviour
	{
		[SerializeField]
		private InGameCameraSettings settings;
		[SerializeField]
		private Transform rotationTransform;
		[SerializeField]
		private Transform zoomTransform;
		[SerializeField]
		private SCCamera camera;
	}
}
