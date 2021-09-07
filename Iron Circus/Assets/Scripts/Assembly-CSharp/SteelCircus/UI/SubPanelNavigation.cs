using UnityEngine;
using System.Collections.Generic;

namespace SteelCircus.UI
{
	public class SubPanelNavigation : MonoBehaviour
	{
		[SerializeField]
		private GameObject navigationBarButtonPrefab;
		[SerializeField]
		private GameObject navigationBarButtonParent;
		public int currentPanel;
		public SubPanelObjectData[] menuPanels;
		public List<SubPanelObjectData> visibleMenuPanels;
		public GameObject navigatorBarScrollRect;
		public int startPanelNumber;
	}
}
