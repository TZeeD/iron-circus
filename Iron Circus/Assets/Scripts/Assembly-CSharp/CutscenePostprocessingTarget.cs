using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class CutscenePostprocessingTarget : MonoBehaviour
{
	[SerializeField]
	private string animationEventName;
	[SerializeField]
	private PostProcessProfile profileOverrides;
}
