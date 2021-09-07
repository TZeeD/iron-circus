using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Misc
{
	public class OnSmallTileSelected : MonoBehaviour
	{
		public Color deselectedColor;
		public Color selectedColor;
		[SerializeField]
		private GameObject outline;
		[SerializeField]
		private Text text;
		[SerializeField]
		private RectTransform lockIcon;
		[SerializeField]
		private Font normalFont;
		[SerializeField]
		private Font boldFont;
	}
}
