using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class ScrollThroughButtons : MonoBehaviour
	{
		public enum ScrollAxis
		{
			scrollX = 0,
			scrollY = 1,
		}

		[SerializeField]
		private float scrollPositionOffset;
		[SerializeField]
		private int nButtons;
		[SerializeField]
		public int nScrollElements;
		[SerializeField]
		public int nTotalSections;
		[SerializeField]
		private int currentFirstElement;
		public ScrollAxis scrollAxis;
		[SerializeField]
		private float buttonSpacing;
		public GameObject[] allScrollFieldButtons;
		public int nObjectsPerScrollelement;
		public int nVisibleElements;
		public Button forwardButton;
		public Button backwardButton;
		public Scrollbar scrollbar;
		public GameObject buttonContainer;
	}
}
