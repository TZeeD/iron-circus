using UnityEngine;

namespace Imi.SteelCircus.CameraSystem.Rigs
{
	public class AbstractTargetFollower : MonoBehaviour
	{
		public enum UpdateType
		{
			FixedUpdate = 0,
			LateUpdate = 1,
			Update = 2,
		}

		[SerializeField]
		protected Transform target;
		[SerializeField]
		private UpdateType updateType;
	}
}
