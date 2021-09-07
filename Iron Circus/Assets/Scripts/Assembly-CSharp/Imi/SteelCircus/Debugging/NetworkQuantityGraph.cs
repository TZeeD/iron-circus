using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.Debugging
{
	public class NetworkQuantityGraph : MonoBehaviour
	{
		public Image graphImage;
		public Text quantityValueText;
		public int graphResolution;
		public float lowThreshold;
		public float highThreshold;
		public bool fitHeight;
		public float maxValue;
	}
}
