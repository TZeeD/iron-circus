using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Audio;
using TMPro;

public class IngameVoiceChatMenu : MonoBehaviour
{
	[SerializeField]
	private Button joinVCButton;
	[SerializeField]
	private GameObject sliderObject;
	[SerializeField]
	private Slider volumeSlider;
	[SerializeField]
	private Slider micVolumeSlider;
	[SerializeField]
	private AudioMixer mixer;
	[SerializeField]
	private Slider masterVolumeSlider;
	[SerializeField]
	private Slider musicVolumeSlider;
	[SerializeField]
	private Slider sfxVolumeSlider;
	[SerializeField]
	private GameObject ownPlayerObject;
	[SerializeField]
	private Button ownPlayerMuteButton;
	[SerializeField]
	private GameObject player2Object;
	[SerializeField]
	private TextMeshProUGUI player2NameText;
	[SerializeField]
	private Button player2MuteButton;
	[SerializeField]
	private GameObject player3Object;
	[SerializeField]
	private TextMeshProUGUI player3NameText;
	[SerializeField]
	private Button player3MuteButton;
}
