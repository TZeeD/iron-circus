using UnityEngine;

namespace Imi.SteelCircus.Utils
{
	public class LinkLocalSpace : MonoBehaviour
	{
		public enum Link
		{
			Local = 0,
			World = 1,
			Off = 2,
		}

		public Transform linkedTransform;
		public Link linkLocalPosition;
		public Vector3 localPositionOffset;
		public Link linkLocalRotation;
		public Vector3 localEulerOffset;
		public Link linkLocalScale;
		public Vector3 localScaleMultiplier;
		public bool destroyIfLinkedObjectIsNull;
	}
}
