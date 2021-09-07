using UnityEngine.Audio;
using UnityEngine;

namespace SteelCircus.UI.OptionsUI
{
	public class AudioSettingsController : ObservedSetting
	{
		[SerializeField]
		private AudioMixer mixer;
	}
}
