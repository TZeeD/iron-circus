using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MVPPlayerAvatar : MonoBehaviour
{
	[SerializeField]
	private Image champIcon;
	[SerializeField]
	private Image outineBg;
	[SerializeField]
	private Image glowBg;
	[SerializeField]
	private TextMeshProUGUI usernameTxt;
	[SerializeField]
	private TextMeshProUGUI lvlText;
	[SerializeField]
	private GameObject alphaMvpParticles;
	[SerializeField]
	private GameObject betaMvpParticles;
	[SerializeField]
	private GameObject twitchViewerCountObject;
	public ulong PlayerId;
}
