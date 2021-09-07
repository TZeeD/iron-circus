using UnityEngine;

public class IngameMenu : MonoBehaviour
{
	[SerializeField]
	private GameObject ingameMenuPanel;
	[SerializeField]
	private GameObject buttonContainer;
	[SerializeField]
	private GameObject controlsPanel;
	[SerializeField]
	private GameObject controlsPanelBody;
	[SerializeField]
	private GameObject voiceChatPanel;
	[SerializeField]
	private GameObject mainPanel;
	[SerializeField]
	private GameObject buttonToSelect;
	[SerializeField]
	private GameObject[] menuButtons;
	[SerializeField]
	private GameObject controlsButtonToSelect;
	[SerializeField]
	private GameObject voiceChatButtonToSelect;
	[SerializeField]
	private GameObject leaveMatchButton;
	[SerializeField]
	private GameObject voiceChatOptionsButton;
	[SerializeField]
	private GameObject joinVoiceChatButton;
	[SerializeField]
	private GameObject forfeitMatchButton;
	[SerializeField]
	private Animator animator;
	[SerializeField]
	private CanvasGroup lobbyButtonsGroup;
}
