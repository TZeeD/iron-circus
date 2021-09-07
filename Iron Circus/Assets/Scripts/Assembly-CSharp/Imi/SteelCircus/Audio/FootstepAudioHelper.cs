using UnityEngine;

namespace Imi.SteelCircus.Audio
{
	public class FootstepAudioHelper : MonoBehaviour
	{
		[SerializeField]
		private AudioClip rightFootstep;
		[SerializeField]
		private float rightScale;
		[SerializeField]
		private AudioClip leftFootstep;
		[SerializeField]
		private float leftScale;
		[SerializeField]
		private AudioSource playerAudioSource;
	}
}
