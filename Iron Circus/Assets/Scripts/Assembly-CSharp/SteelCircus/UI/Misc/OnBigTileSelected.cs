using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
	public class OnBigTileSelected : MonoBehaviour
	{
		[SerializeField]
		private Image backgroundSelected;
		[SerializeField]
		private Image backgroundDeselected;
		[SerializeField]
		private RectTransform lockedGroup;
		[SerializeField]
		private RectTransform outline;
		[SerializeField]
		private RectTransform slashes;
		[SerializeField]
		private Text text;
		[SerializeField]
		private float zoomInDuration;
		[SerializeField]
		private float zoomOutDuration;
		[SerializeField]
		private float minScale;
		[SerializeField]
		private float maxScale;
		[SerializeField]
		private Material grayscaleMat;
		[SerializeField]
		private Font normalFont;
		[SerializeField]
		private Font boldFont;
	}
}
