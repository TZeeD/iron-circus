using UnityEngine;
using SteelCircus.UI;
using Rewired.UI.ControlMapper;
using SteelCircus.UI.Menu;

namespace SteelCircus.UI.OptionsUI
{
	public class OptionsMenuScript : MonoBehaviour
	{
		[SerializeField]
		private SubPanelNavigation navigator;
		[SerializeField]
		private Settings settingsMaster;
		[SerializeField]
		private bool controlMapperPopupActive;
		[SerializeField]
		public ControlMapper controlMapper;
		[SerializeField]
		private OptionsMenuSubPanelObject controlsPanel;
		public bool popupIsActive;
		public bool popupIsActive2;
	}
}
