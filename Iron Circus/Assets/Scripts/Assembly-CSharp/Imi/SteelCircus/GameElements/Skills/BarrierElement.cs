using UnityEngine;

namespace Imi.SteelCircus.GameElements.Skills
{
	public class BarrierElement : MonoBehaviour
	{
		[SerializeField]
		private AnimationCurve scaleY;
		[SerializeField]
		private MeshRenderer forceField;
		[SerializeField]
		private float spawnPitch;
		[SerializeField]
		private float despawnPitch;
		[SerializeField]
		private float volume;
		public float growDuration;
		public float stayDuration;
		public bool shouldPlaySound;
		public AudioClip despawnClip;
		public AudioClip spawnClip;
	}
}
