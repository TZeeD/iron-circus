using UnityEngine;
using Imi.SharedWithServer.Game;
using UnityEngine.Rendering.PostProcessing;

public class CutsceneBase : MonoBehaviour
{
	[SerializeField]
	private MatchState cutsceneType;
	[SerializeField]
	protected PostProcessProfile CutsceneProfile;
}
