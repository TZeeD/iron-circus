using UnityEngine;

namespace Imi.SteelCircus.Audio
{
	public class GameAudio : MonoBehaviour
	{
		[SerializeField]
		private AudioWithVolume[] introAudios;
		[SerializeField]
		private AudioWithVolume[] cheeringVariants;
		[SerializeField]
		private AudioWithVolume goalModerator;
		[SerializeField]
		private AudioWithVolume goalSiren;
		[SerializeField]
		private AudioWithVolume onThree;
		[SerializeField]
		private AudioWithVolume onTwo;
		[SerializeField]
		private AudioWithVolume onOne;
		[SerializeField]
		private AudioWithVolume onGo;
		[SerializeField]
		private float transitionThreeToTwo;
		[SerializeField]
		private float transitionTwoToOne;
		[SerializeField]
		private float transitionOneToGo;
		[SerializeField]
		private AudioWithVolume[] gameOverAudios;
		[SerializeField]
		private AudioWithVolume backgroundNoise;
		[SerializeField]
		private AudioSource backgroundNoiseSource;
	}
}
