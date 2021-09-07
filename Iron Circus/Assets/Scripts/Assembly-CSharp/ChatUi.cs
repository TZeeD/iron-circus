using UnityEngine;
using System.Collections.Generic;

public class ChatUi : MonoBehaviour
{
	public Transform content;
	public GameObject chatMessageObjPrefab;
	public float timeToFadeAway;
	public float fadeOutTime;
	[SerializeField]
	private bool usePooling;
	[SerializeField]
	private int poolSize;
	public List<ChatMessageObj> chatData;
}
