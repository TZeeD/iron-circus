using UnityEngine;

namespace Imi.SteelCircus.FX
{
	public class FloorSpawnFX : MonoBehaviour
	{
		[SerializeField]
		private Transform spawnedObjectPosition;
		[SerializeField]
		private bool debugDontDestroy;
		[SerializeField]
		private Transform normals;
		[SerializeField]
		private Transform tube;
		[SerializeField]
		private Transform stencil;
		[SerializeField]
		private Transform platform;
		public float radius;
		[SerializeField]
		private float timeToOpen;
		[SerializeField]
		private AnimationCurve openAnimationCurve;
		[SerializeField]
		private float timeToSpawn;
		[SerializeField]
		private float timeToClose;
		[SerializeField]
		private AnimationCurve closeAnimationCurve;
		[SerializeField]
		private AnimationCurve platformAnimationCurve;
		[SerializeField]
		private float platformTopPos;
		[SerializeField]
		private float platformBottomPos;
	}
}
