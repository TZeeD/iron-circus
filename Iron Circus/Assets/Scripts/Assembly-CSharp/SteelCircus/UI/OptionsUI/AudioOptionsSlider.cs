using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
	public class AudioOptionsSlider : MonoBehaviour
	{
		[SerializeField]
		private AudioMixerGroup audioMixerGroup;
		[SerializeField]
		private Text sliderText;
	}
}
