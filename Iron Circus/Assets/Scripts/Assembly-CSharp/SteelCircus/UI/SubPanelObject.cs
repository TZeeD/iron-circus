using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
	public class SubPanelObject : MonoBehaviour
	{
		[SerializeField]
		public string panelName;
		public Selectable highlightedButton;
		public CanvasGroup canvasGrp;
		public SubPanelNavigation panelManager;
	}
}
