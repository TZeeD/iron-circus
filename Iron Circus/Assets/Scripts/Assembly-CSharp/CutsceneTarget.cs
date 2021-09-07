using UnityEngine;
using Imi.SharedWithServer.Game;

public class CutsceneTarget : MonoBehaviour
{
	[SerializeField]
	private string animationEventName;
	[SerializeField]
	private MatchState cleanupAfterMatchstate;
}
