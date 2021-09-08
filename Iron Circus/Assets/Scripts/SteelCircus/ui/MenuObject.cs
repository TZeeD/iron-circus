// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.MenuObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class MenuObject : MonoBehaviour
  {
    [SerializeField]
    private Selectable highlightedButton;
    public GameObject canvasGroup;
    public MainMenuLightingType lightingType;
    public bool inviteNavigationActive;
    public bool layeredMenu;
    [Header("Navigator Button Functions")]
    [SerializeField]
    public SimplePromptSwitch.ButtonFunction confirmButtonFunction;
    public string confirmButtonLocaOverride;
    public SimplePromptSwitch.ButtonFunction secondaryButtonFunction;
    public string secondaryButtonLocaOverride;
    public SimplePromptSwitch.ButtonFunction backButtonFunction;
    public string backButtonLocaOverride;

    [EnumAction(typeof (MenuObject.animationType))]
    public void ShowMenu(int menuAnimation) => this.ActualShowMenu((MenuObject.animationType) menuAnimation);

    [EnumAction(typeof (MenuObject.animationType))]
    public void ReturnToMenu(int menuAnimation) => this.ActualShowMenu((MenuObject.animationType) menuAnimation, false);

    public void ActualShowMenu(
      MenuObject.animationType menuAnimation,
      bool addPreviousToStack = true,
      bool showOnTopOfOldMenu = false)
    {
      if (showOnTopOfOldMenu & addPreviousToStack)
        MenuController.Instance.AddMenuToStack(MenuController.Instance.currentMenu);
      MenuController.Instance.setInviteButtonNavigationActive(this.inviteNavigationActive);
      this.UpdateTurntableRenderTexture();
      if ((Object) MenuController.Instance.currentMenu != (Object) null && !showOnTopOfOldMenu)
        MenuController.Instance.currentMenu.HideMenu((int) menuAnimation, addPreviousToStack);
      switch (menuAnimation)
      {
        case MenuObject.animationType.swipeToLeft:
          this.GetComponent<Animator>().SetTrigger("EnterRight");
          break;
        case MenuObject.animationType.swipeToRight:
          this.GetComponent<Animator>().SetTrigger("EnterLeft");
          break;
        case MenuObject.animationType.changeInstantly:
          this.GetComponent<Animator>().SetTrigger("Show");
          break;
        default:
          this.GetComponent<Animator>().SetTrigger("Show");
          break;
      }
      if ((Object) this.highlightedButton != (Object) null)
        this.highlightedButton.GetComponent<Selectable>().Select();
      MenuController.Instance.currentMenu = this;
      MenuController.Instance.EnteredMenuEvent.Invoke();
      this.UpdateNavigatorBar();
    }

    public void UpdateTurntableRenderTexture()
    {
      MainMenuLightingConfig menuLightingConfig = UnityEngine.Resources.Load<MainMenuLightingConfig>("Configs/Visual/MainMenuLightingConfig");
      switch (this.lightingType)
      {
        case MainMenuLightingType.MainMenu:
          menuLightingConfig.ApplyLightingForMainMenu();
          break;
        case MainMenuLightingType.Gallery:
          menuLightingConfig.ApplyLightingForGallery();
          break;
        case MainMenuLightingType.Lobby:
          menuLightingConfig.ApplyLightingForLobby();
          break;
        default:
          menuLightingConfig.ApplyLightingForMainMenu();
          break;
      }
    }

    public void HideLayeredMenu(int menuAnimation)
    {
      this.GetComponent<Animator>();
      this.ActualHideMenu((MenuObject.animationType) menuAnimation);
    }

    [EnumAction(typeof (MenuObject.animationType))]
    public void HideMenu(int menuAnimation, bool addToStack)
    {
      Animator component1 = this.GetComponent<Animator>();
      if (!component1.GetCurrentAnimatorStateInfo(0).IsName("ShowInstantly") && !component1.GetCurrentAnimatorStateInfo(0).IsName("DisplayMenu") && !component1.GetCurrentAnimatorStateInfo(0).IsName("EnterLeft") && !component1.GetCurrentAnimatorStateInfo(0).IsName("EnterRight") || component1.GetBool("ExitLeft") || component1.GetBool("ExitRight") || component1.GetBool("Hide"))
        return;
      SubPanelNavigation component2 = this.GetComponent<SubPanelNavigation>();
      if ((Object) component2 != (Object) null)
        component2.OnExitCurrentPanel();
      if (addToStack)
        MenuController.Instance.AddMenuToStack(this);
      this.ActualHideMenu((MenuObject.animationType) menuAnimation);
    }

    public void ActualHideMenu(MenuObject.animationType menuAnimation)
    {
      switch (menuAnimation)
      {
        case MenuObject.animationType.swipeToLeft:
          this.GetComponent<Animator>().SetTrigger("ExitLeft");
          break;
        case MenuObject.animationType.swipeToRight:
          this.GetComponent<Animator>().SetTrigger("ExitRight");
          break;
        case MenuObject.animationType.changeInstantly:
          this.GetComponent<Animator>().SetTrigger("Hide");
          break;
        default:
          this.GetComponent<Animator>().SetTrigger("Hide");
          break;
      }
    }

    public Selectable GetHighlightedBUtton()
    {
      Navigation navigation;
      if ((Object) this.highlightedButton != (Object) null && this.highlightedButton.interactable)
      {
        navigation = this.highlightedButton.navigation;
        if (navigation.mode != Navigation.Mode.None)
          return this.highlightedButton;
      }
      foreach (Selectable componentsInChild in this.GetComponentsInChildren<Selectable>())
      {
        if (componentsInChild.interactable)
        {
          navigation = componentsInChild.navigation;
          if (navigation.mode != Navigation.Mode.None)
            return componentsInChild;
        }
      }
      return (Selectable) null;
    }

    public void SetHighlightedButton(Selectable button) => this.highlightedButton = button;

    public void UpdateNavigatorBar() => MenuController.Instance.UpdateNavigatorBar(this.confirmButtonFunction, this.secondaryButtonFunction, this.backButtonFunction, this.confirmButtonLocaOverride, this.secondaryButtonLocaOverride, this.backButtonLocaOverride);

    public void HideAllOtherMenus() => MenuController.Instance.HideAllButCurrent();

    public void DisableButtonsOnExit()
    {
      Log.Debug("Disabling interactivity for menu: " + (object) this.gameObject);
      foreach (CanvasGroup componentsInDirectChild in this.transform.GetComponentsInDirectChildren<CanvasGroup>(true))
        componentsInDirectChild.interactable = false;
    }

    public void EnableButtonsOnEnter()
    {
      Log.Debug("Enabling interactivity for menu: " + (object) this.gameObject);
      foreach (CanvasGroup componentsInDirectChild in this.transform.GetComponentsInDirectChildren<CanvasGroup>(true))
        componentsInDirectChild.interactable = true;
    }

    public bool IsMenuObjectActive() => this.transform.GetChild(0).gameObject.activeInHierarchy;

    public enum animationType
    {
      swipeToLeft,
      swipeToRight,
      changeInstantly,
    }
  }
}
