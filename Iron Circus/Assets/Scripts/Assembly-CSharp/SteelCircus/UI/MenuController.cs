using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;
using UnityEngine.Audio;

namespace SteelCircus.UI
{
	public class MenuController : MonoBehaviour
	{
		public UnityEvent EnteredMenuEvent;
		public UnityEvent ButtonPageGeneratedEvent;
		[SerializeField]
		private GameObject background;
		[SerializeField]
		private GameObject userProfile;
		[SerializeField]
		public GameObject navigator;
		[SerializeField]
		public GameObject mainMenuTurntable;
		public GameObject championGalleryTurntable;
		public MenuObject mainMenuPanel;
		public MenuObject championGallery;
		public MenuObject championPage;
		public MenuObject optionsMenu;
		public MenuObject controlsView;
		public MenuObject shopMenu;
		public MenuObject shopBuyPanel;
		public MenuObject playMenu;
		public MenuObject slotEquipMenu;
		public MenuObject playerProfile;
		public LoadoutNavigation LoadoutNavigation;
		[SerializeField]
		private GameObject specialUi;
		public ButtonFocusManager buttonFocusManager;
		[SerializeField]
		private Button inviteButton;
		[SerializeField]
		private Animator champInfoAnimator;
		[SerializeField]
		private AudioMixer audioMixer;
		public bool logMenuPass;
		public MenuObject[] debugMenuStackDisplay;
		public MenuObject currentMenu;
	}
}
