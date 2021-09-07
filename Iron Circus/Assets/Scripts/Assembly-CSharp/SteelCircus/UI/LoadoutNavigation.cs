using UnityEngine;

namespace SteelCircus.UI
{
	public class LoadoutNavigation : MonoBehaviour
	{
		public SubPanelObject navigationPanel;
		public SubPanelObject[] subPanels;
		public SubPanelObject currentPanel;
		[SerializeField]
		private SimplePromptSwitch navigator;
	}
}
