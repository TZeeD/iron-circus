using UnityEngine;

namespace SteelCircus.UI
{
	public class ScrollOnSelected : MonoBehaviour
	{
		public enum buttonSelectionType
		{
			gameObject = 0,
			rowNumber = 1,
		}

		public ScrollThroughButtons buttonScrollController;
		public buttonSelectionType scrollBy;
		public int rowNumber;
		public int nRows;
	}
}
