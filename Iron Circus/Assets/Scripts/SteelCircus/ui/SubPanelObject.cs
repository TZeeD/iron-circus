// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SubPanelObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.UI.OptionsUI;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
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
    protected List<Button> buttonsToDisable;

    private void Start() => this.buttonsToDisable = new List<Button>();

    public virtual bool IsAllowedToExit() => true;

    public virtual void ExitPanel(MenuObject.animationType animationType)
    {
      this.OnExitPanel();
      switch (animationType)
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
      }
    }

    public virtual void EnterPanel(MenuObject.animationType animationType)
    {
      switch (animationType)
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
      }
      this.OnEnterPanel();
    }

    public virtual void OnExitPanel(bool force = false)
    {
      SubPanelObject subPanelObject = (SubPanelObject) null;
      if ((Object) this.panelManager != (Object) null)
        subPanelObject = this.panelManager.GetPreviousSubPanelObject();
      if (!force && (!((Object) subPanelObject != (Object) null) || !((Object) subPanelObject == (Object) this)))
        return;
      LoadoutNavigation component1 = this.gameObject.GetComponent<LoadoutNavigation>();
      if ((Object) component1 != (Object) null)
        component1.BackToNavigation(false);
      ChampionPageButtonGenerator component2 = this.GetComponent<ChampionPageButtonGenerator>();
      if ((Object) component2 != (Object) null)
      {
        Log.Debug("ResetTurntable");
        component2.ResetChampionTurntableView();
        component2.activeButton = 0;
      }
      CustomLobbySettings component3 = this.GetComponent<CustomLobbySettings>();
      if ((Object) component3 != (Object) null)
        component3.ApplySettings();
      ShopPage component4 = this.GetComponent<ShopPage>();
      if (!((Object) component4 != (Object) null))
        return;
      component4.ClearShopPage();
    }

    public virtual void OnEnterPanel()
    {
      LoadoutNavigation component1 = this.gameObject.GetComponent<LoadoutNavigation>();
      if ((Object) component1 != (Object) null)
        component1.ShowNavigationPanel();
      if ((Object) this.panelManager != (Object) null && (Object) MenuController.Instance.currentMenu == (Object) this.panelManager.GetComponent<MenuObject>() || (Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage)
        MenuController.Instance.gameObject.GetComponent<ButtonFocusManager>().FocusButtonOnSubPanelChanged();
      ChampionPageButtonGenerator component2 = this.GetComponent<ChampionPageButtonGenerator>();
      if ((Object) component2 != (Object) null)
        component2.OnEnterLoadoutPage();
      ShopPage component3 = this.GetComponent<ShopPage>();
      if ((Object) component3 != (Object) null)
        component3.OnShopPageEntered();
      PopulateCurrencyContainers component4 = this.GetComponent<PopulateCurrencyContainers>();
      if (!((Object) component4 != (Object) null))
        return;
      component4.OnPageEntered();
    }

    public void HighlightButton(Selectable highlightedButton)
    {
      if (!(MenuController.Instance.gameObject.GetComponent<LastActiveController>().controllerName != "Mouse"))
        return;
      highlightedButton.Select();
      highlightedButton.OnSelect((BaseEventData) null);
    }

    public void DisableButtonsOnExit()
    {
      foreach (Button componentsInChild in this.gameObject.GetComponentsInChildren<Button>())
      {
        if (componentsInChild.interactable)
        {
          this.buttonsToDisable.Add(componentsInChild);
          componentsInChild.interactable = false;
        }
      }
      ShowSpraytagsInChampionGallery component = this.GetComponent<ShowSpraytagsInChampionGallery>();
      if (!((Object) component != (Object) null))
        return;
      component.menuInteractable = false;
    }

    public void EnableButtonsOnEnter()
    {
      foreach (Button button in this.buttonsToDisable)
      {
        if ((Object) button != (Object) null)
          button.interactable = true;
      }
      this.buttonsToDisable = new List<Button>();
    }

    public void HideAllOtherMenus()
    {
    }
  }
}
