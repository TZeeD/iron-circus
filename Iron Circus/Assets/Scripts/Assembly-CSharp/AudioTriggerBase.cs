using UnityEngine;

public class AudioTriggerBase : MonoBehaviour
{
	public enum EventType
	{
		Start = 0,
		Awake = 1,
		OnDestroy = 2,
		OnCollisionEnter = 3,
		OnCollisionExit = 4,
		OnEnable = 5,
		OnDisable = 6,
	}

	public EventType triggerEvent;
}
