using UnityEngine;

namespace SteelCircus.FX
{
	public class FollowTransform : MonoBehaviour
	{
		[SerializeField]
		protected Transform target;
		[SerializeField]
		protected Vector3 rotation;
		[SerializeField]
		protected Vector3 offset;
	}
}
