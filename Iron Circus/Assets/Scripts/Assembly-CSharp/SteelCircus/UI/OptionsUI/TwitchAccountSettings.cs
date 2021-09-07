using UnityEngine.UI;
using UnityEngine;
using TMPro;

namespace SteelCircus.UI.OptionsUI
{
	public class TwitchAccountSettings : ObservedSetting
	{
		[SerializeField]
		private Button connectButton;
		[SerializeField]
		private TextMeshProUGUI buttonText;
		[SerializeField]
		private Animator buttonAnimator;
		[SerializeField]
		private Toggle twitchNameToggle;
		[SerializeField]
		private Toggle twitchViewerCountToggle;
		[SerializeField]
		private GameObject connectedInfo;
		[SerializeField]
		private TextMeshProUGUI showNameOptionsText;
		[SerializeField]
		private TextMeshProUGUI showViewerCountOptionsText;
		[SerializeField]
		private GameObject restartToApplyInfoObject;
	}
}
