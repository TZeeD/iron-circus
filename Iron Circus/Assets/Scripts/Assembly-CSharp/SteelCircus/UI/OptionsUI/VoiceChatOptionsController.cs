using UnityEngine.UI;
using UnityEngine;
using TMPro;

namespace SteelCircus.UI.OptionsUI
{
	public class VoiceChatOptionsController : ObservedSetting
	{
		[SerializeField]
		private Slider autoJoinSlider;
		[SerializeField]
		private Slider pushToTalkSlider;
		[SerializeField]
		private Slider voiceChatVolumeSlider;
		[SerializeField]
		private Slider microphoneVolumeSlider;
		[SerializeField]
		private TextMeshProUGUI autoJoinDescription;
		[SerializeField]
		private TextMeshProUGUI pttDescription;
		[SerializeField]
		private Text volumeDescription;
		[SerializeField]
		private Text micVolumeDescription;
	}
}
