using UnityEngine;
using UnityEngine.Events;
using TMPro;
using UnityEngine.UI;

namespace SteelCircus.UI.Popups
{
	public class PopupManager : MonoBehaviour
	{
		public GameObject PopupButtonPrefab;
		public UnityEvent OnPopupHideEvent;
		public GameObject background;
		public GameObject popup;
		public TextMeshProUGUI title;
		public TextMeshProUGUI information;
		public TextMeshProUGUI txtLeft;
		public TextMeshProUGUI txtRight;
		public GameObject buttonPanel;
		public Button btnLeft;
		public Button btnRight;
		public GameObject verticalButtonPanel;
	}
}
