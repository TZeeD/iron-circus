using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.ui
{
	public class BlinkingOutline : MonoBehaviour
	{
		[SerializeField]
		private Outline outlineReference;
		[SerializeField]
		private Color a;
		[SerializeField]
		private Color b;
		[SerializeField]
		private float frequency;
	}
}
