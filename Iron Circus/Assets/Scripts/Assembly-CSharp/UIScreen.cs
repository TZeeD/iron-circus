using UnityEngine;
using UnityEngine.UI;
using Imi.SteelCircus.ui;

public class UIScreen : MonoBehaviour
{
	public bool activeOnStart;
	public bool isDebugMenu;
	public UIScreen parent;
	public float fadeDuration;
	public Selectable selectOnActive;
	public GoToUIScreenButton[] goToUiScreenButtons;
	public GameObject[] hideWhenActive;
	public UIScreenState[] uiScreenState;
	public bool blockReturning;
}
