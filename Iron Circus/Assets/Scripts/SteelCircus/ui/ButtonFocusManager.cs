// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ButtonFocusManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using SteelCircus.UI.Misc;
using SteelCircus.UI.Popups;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ButtonFocusManager : MonoBehaviour
  {
    public Selectable currenctlyFocusedButton;
    public Selectable currentlySelectedButton;

    private void Start()
    {
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.FocusButtonOnChangeMenu));
      MenuController.Instance.ButtonPageGeneratedEvent.AddListener(new UnityAction(this.FocusButtonOnPageBuilt));
      PopupManager.Instance.OnPopupHideEvent.AddListener(new UnityAction(this.FocusButtonOnPopupClosed));
    }

    private void Update()
    {
      if ((Object) EventSystem.current.currentSelectedGameObject != (Object) null && EventSystem.current.currentSelectedGameObject.activeInHierarchy)
      {
        this.currentlySelectedButton = EventSystem.current.currentSelectedGameObject.GetComponent<Selectable>();
      }
      else
      {
        if (ImiServices.Instance.InputService.GetLastInputSource() == InputSource.Mouse)
          return;
        this.StartCoroutine(this.DelayedFocusOnButton());
      }
    }

    private void OnDestroy()
    {
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.FocusButtonOnChangeMenu));
      MenuController.Instance.ButtonPageGeneratedEvent.RemoveListener(new UnityAction(this.FocusButtonOnPageBuilt));
      PopupManager.Instance.OnPopupHideEvent.RemoveListener(new UnityAction(this.FocusButtonOnPopupClosed));
    }

    public void FocusButtonOnPageBuilt()
    {
      MenuObject currentMenu = MenuController.Instance.currentMenu;
      if (this.HasSubPanelNavigation(currentMenu))
      {
        SubPanelObject activeSubPanelObject = this.GetActiveSubPanelObject(currentMenu.gameObject);
        Selectable button = (Selectable) null;
        if ((Object) activeSubPanelObject.GetComponent<ChampionPageButtonGenerator>() != (Object) null)
          button = activeSubPanelObject.GetComponent<ChampionPageButtonGenerator>().GetHighlightedButton();
        if ((Object) activeSubPanelObject.GetComponent<ShopPage>() != (Object) null)
          button = activeSubPanelObject.GetComponent<ShopPage>().GetHighlightedButton();
        if (!((Object) button != (Object) null))
          return;
        this.FocusOnButton(button);
      }
      else
      {
        if (!this.HasDynamicButtons(currentMenu) || !((Object) currentMenu.GetComponent<PopulateGalleryButtons>() != (Object) null))
          return;
        this.FocusOnButton(currentMenu.GetComponent<PopulateGalleryButtons>().GetActiveChampionButton());
      }
    }

    public void FocusButtonOnPopupClosed() => this.FocusOnButton();

    public void FocusButtonOnChangeMenu()
    {
      if ((Object) EventSystem.current.currentSelectedGameObject != (Object) null)
      {
        OnSmallTileSelected component = EventSystem.current.currentSelectedGameObject.GetComponent<OnSmallTileSelected>();
        if ((Object) component != (Object) null)
          component.SetButtonDeselected();
      }
      MenuObject currentMenu = MenuController.Instance.currentMenu;
      if (this.HasSubPanelNavigation(currentMenu) || this.HasDynamicButtons(currentMenu))
        return;
      if ((Object) currentMenu.GetHighlightedBUtton() != (Object) null)
        this.FocusOnButton(currentMenu.GetHighlightedBUtton());
      else
        this.FocusOnFirstSelectable(currentMenu.gameObject);
    }

    public void FocusButtonOnSubPanelChanged()
    {
      MenuObject currentMenu = MenuController.Instance.currentMenu;
      if (!this.HasSubPanelNavigation(currentMenu))
        return;
      SubPanelObject activeSubPanelObject = this.GetActiveSubPanelObject(currentMenu.gameObject);
      if ((Object) activeSubPanelObject.GetComponent<ScrollThroughButtons>() != (Object) null)
        return;
      if ((Object) activeSubPanelObject.highlightedButton != (Object) null)
        this.FocusOnButton(activeSubPanelObject.highlightedButton);
      else
        this.FocusOnFirstSelectable(currentMenu.gameObject);
    }

    public IEnumerator DelayedFocusOnButton()
    {
      yield return (object) null;
      if ((Object) EventSystem.current.currentSelectedGameObject == (Object) null || !EventSystem.current.currentSelectedGameObject.activeInHierarchy)
        this.FocusOnButton();
    }

    public void FocusOnButton(bool force = false)
    {
      MenuObject currentMenu = MenuController.Instance.currentMenu;
      if ((Object) currentMenu == (Object) null)
        return;
      SubPanelObject activeSubPanelObject = this.GetActiveSubPanelObject(currentMenu.gameObject);
      if ((Object) activeSubPanelObject == (Object) null)
      {
        if ((Object) currentMenu.GetHighlightedBUtton() != (Object) null)
          this.FocusOnButton(currentMenu.GetHighlightedBUtton(), force);
        else
          this.FocusOnFirstSelectable(currentMenu.gameObject, force);
      }
      else
      {
        Selectable button = (Selectable) null;
        if ((Object) activeSubPanelObject.GetComponent<ScrollThroughButtons>() != (Object) null)
        {
          if ((Object) activeSubPanelObject.GetComponent<ChampionPageButtonGenerator>() != (Object) null)
            button = activeSubPanelObject.GetComponent<ChampionPageButtonGenerator>().GetHighlightedButton();
          if ((Object) activeSubPanelObject.GetComponent<ShopPage>() != (Object) null)
            button = activeSubPanelObject.GetComponent<ShopPage>().GetHighlightedButton();
        }
        if ((Object) button == (Object) null && (Object) activeSubPanelObject.highlightedButton != (Object) null)
          button = activeSubPanelObject.highlightedButton;
        if ((Object) button == (Object) null && (Object) activeSubPanelObject.GetComponent<ScrollThroughButtons>() != (Object) null)
        {
          GameObject scrollFieldButton = activeSubPanelObject.GetComponent<ScrollThroughButtons>().allScrollFieldButtons[0];
          if ((Object) scrollFieldButton != (Object) null && (Object) scrollFieldButton.GetComponentInChildren<Selectable>() != (Object) null)
            button = scrollFieldButton.GetComponent<Selectable>();
        }
        if ((Object) button == (Object) null)
          this.FocusOnFirstSelectable(currentMenu.gameObject, force);
        else
          this.FocusOnButton(button, force);
      }
    }

    public bool HasSubPanelNavigation(MenuObject menuObject) => (Object) menuObject.GetComponent<SubPanelNavigation>() != (Object) null || (Object) menuObject.GetComponent<LoadoutNavigation>() != (Object) null;

    public bool HasDynamicButtons(MenuObject menuObject) => (Object) menuObject.GetComponent<PopulateGalleryButtons>() != (Object) null;

    public SubPanelObject GetActiveSubPanelObject(GameObject menuObject)
    {
      SubPanelObject subPanelObject = (SubPanelObject) null;
      if ((Object) menuObject.GetComponent<SubPanelNavigation>() != (Object) null)
        subPanelObject = menuObject.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject();
      if ((Object) menuObject.GetComponent<LoadoutNavigation>() != (Object) null)
        subPanelObject = menuObject.GetComponent<LoadoutNavigation>().currentPanel;
      if (!((Object) subPanelObject != (Object) null))
        return (SubPanelObject) null;
      SubPanelObject activeSubPanelObject = this.GetActiveSubPanelObject(subPanelObject.gameObject);
      return (Object) activeSubPanelObject == (Object) null ? subPanelObject : activeSubPanelObject;
    }

    public void FocusOnFirstSelectable(GameObject currentMenu, bool force = false)
    {
      Selectable button = this.HasSubPanelNavigation(currentMenu.GetComponent<MenuObject>()) ? this.FindSelectableInChildren(this.GetActiveSubPanelObject(currentMenu).gameObject) : this.FindSelectableInChildren(currentMenu);
      if (!((Object) button != (Object) null))
        return;
      this.FocusOnButton(button);
      Debug.Log((object) ("No Button found to focus on. Focusing on first selectable button: " + (object) button));
    }

    public Selectable FindSelectableInChildren(GameObject parent)
    {
      Selectable selectable = (Selectable) null;
      foreach (Selectable componentsInChild in parent.GetComponentsInChildren<Selectable>())
      {
        if (componentsInChild.interactable && componentsInChild.navigation.mode != Navigation.Mode.None)
        {
          selectable = componentsInChild;
          break;
        }
      }
      return selectable;
    }

    public void FocusOnButton(Selectable button, bool force = false)
    {
      if (!(ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse | force))
        return;
      Log.Debug("Focusing on button " + (object) button);
      this.currenctlyFocusedButton = button;
      button.Select();
      button.GetComponent<Selectable>().OnSelect((BaseEventData) null);
      if (!((Object) button.GetComponent<OnChampionSelectedInGallery>() != (Object) null))
        return;
      button.GetComponent<OnChampionSelectedInGallery>().OnSelect((BaseEventData) null);
    }
  }
}
