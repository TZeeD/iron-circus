using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
	public class SCCamera : MonoBehaviour
	{
		[SerializeField]
		private Camera cameraBG;
		[SerializeField]
		private Camera cameraArena;
		[SerializeField]
		private Camera cameraReflection;
		[SerializeField]
		private Camera cameraColorGrading;
		public float nearClip;
		public float farClip;
		public float fov;
	}
}
