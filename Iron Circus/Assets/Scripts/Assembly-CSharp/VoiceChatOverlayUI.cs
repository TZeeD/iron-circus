using UnityEngine;
using TMPro;

public class VoiceChatOverlayUI : MonoBehaviour
{
	[SerializeField]
	private GameObject playerVCNamePrefab;
	[SerializeField]
	private GameObject playerVCContainerParent;
	[SerializeField]
	private GameObject connectionHelperTextObject;
	[SerializeField]
	private GameObject participantCountTextObject;
	[SerializeField]
	private GameObject joinButtonPrompt;
	[SerializeField]
	private GameObject pushToTalkPrompt;
	[SerializeField]
	private SwitchButtonSprite pushToTalkPromptSprite;
	[SerializeField]
	private TextMeshProUGUI pushToTalkPromtText;
}
