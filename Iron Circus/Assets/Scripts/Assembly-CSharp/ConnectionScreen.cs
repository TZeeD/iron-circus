using UnityEngine;
using UnityEngine.Audio;

public class ConnectionScreen : MonoBehaviour
{
	public float timeToWaitBeforeTransition;
	[SerializeField]
	private LoggingInUi loginScreen;
	[SerializeField]
	private MaintenanceUi maintanaceScreen;
	[SerializeField]
	private string customerSupportUrl;
	[SerializeField]
	private GameObject Camera;
	[SerializeField]
	private GameObject ExitBtn;
	[SerializeField]
	private Animator connectionScreenAnimator;
	[SerializeField]
	private AudioMixer audioMixer;
}
