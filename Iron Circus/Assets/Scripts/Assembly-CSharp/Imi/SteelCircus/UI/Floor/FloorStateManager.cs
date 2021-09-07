using UnityEngine;
using Imi.SteelCircus.UI.Floor;
using SteelCircus.UI.Floor;

namespace Imi.SteelCircus.ui.Floor
{
	public class FloorStateManager : MonoBehaviour
	{
		[SerializeField]
		private GameObject fieldLines;
		[SerializeField]
		private GameObject introAnimationPrefab;
		[SerializeField]
		private Transform introAnimationParent;
		[SerializeField]
		private FloorCenterDisplay centerDisplay;
		[SerializeField]
		private FloorMatchBallDisplay matchBallDisplay;
		[SerializeField]
		private MeshRenderer floorNormalsBase;
		[SerializeField]
		private Transform goalAnimationParent;
		[SerializeField]
		private GameObject[] goalAnimationPrefabs;
		[SerializeField]
		private AudioSource videoAudio;
	}
}
