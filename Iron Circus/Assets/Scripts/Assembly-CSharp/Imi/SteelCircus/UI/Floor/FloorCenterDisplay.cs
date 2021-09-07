using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI.Floor
{
	public class FloorCenterDisplay : MonoBehaviour
	{
		public GameObject timeDisplayPrefab;
		public GameObject getReadyDisplayPrefab;
		public Transform timeDisplayParent;
		public float timeDisplayRotationSpeed;
		public int numTimeDisplays;
		public Transform timeDisplayBG;
		public AnimationCurve timeDisplayBGAnimation;
		public bool useSimpleTimeDisplay;
		public Text simpleTime;
		public Text teamAlphaScore;
		public Text teamBetaScore;
		public Text countdownText;
	}
}
