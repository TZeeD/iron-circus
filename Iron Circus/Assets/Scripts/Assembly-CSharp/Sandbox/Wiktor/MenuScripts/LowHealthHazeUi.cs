using UnityEngine;
using UnityEngine.UI;

namespace Sandbox.Wiktor.MenuScripts
{
	public class LowHealthHazeUi : MonoBehaviour
	{
		[SerializeField]
		private Image haze;
		[SerializeField]
		private float hazePulseDuration;
		[SerializeField]
		private float hazeBlinkDuration;
		[SerializeField]
		private float hazeFrom;
		[SerializeField]
		private int hazeBlinkCount;
	}
}
