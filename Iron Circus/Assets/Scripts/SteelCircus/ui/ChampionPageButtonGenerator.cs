// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ChampionPageButtonGenerator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ChampionPageButtonGenerator : MonoBehaviour
  {
    [Header("Prefabs")]
    [SerializeField]
    private GameObject itemButtonPrefab;
    [Header("Loadout Page Object References")]
    public ChampionPageButtonGenerator.NavigatorType navigatorType;
    [SerializeField]
    private LoadoutNavigation loadoutPanelNavigator;
    [SerializeField]
    private SubPanelNavigation subPanelNavigator;
    [SerializeField]
    private GameObject layoutContainerParent;
    [SerializeField]
    private TextMeshProUGUI loadingItemsText;
    [SerializeField]
    private TextMeshProUGUI loadingErrorText;
    [SerializeField]
    private ScrollThroughButtons buttonScroller;
    [Header("Loadout Contents")]
    [SerializeField]
    private ShopManager.ShopItemType itemType;
    public ChampionPageButtonGenerator.ChampionPageSortCriteria sortCriteria;
    [SerializeField]
    private List<ShopItem> allPageItems;
    [SerializeField]
    private List<GameObject> allPageButtonObjects;
    public int activeButton;

    private void Start()
    {
      ImiServices.Instance.progressManager.OnItemReceived += new ProgressManager.OnItemsReceivedEventHandler(this.OnGetItemsFromServer);
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.AddListener(new UnityAction(this.OnReturnFromOverlayMenu));
    }

    private void OnDestroy()
    {
      ImiServices.Instance.progressManager.OnItemReceived -= new ProgressManager.OnItemsReceivedEventHandler(this.OnGetItemsFromServer);
      if (!((Object) MenuController.Instance.gameObject != (Object) null) || !((Object) MenuController.Instance.navigator != (Object) null))
        return;
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.RemoveListener(new UnityAction(this.OnReturnFromOverlayMenu));
    }

    public Selectable GetHighlightedButton()
    {
      if (this.allPageButtonObjects == null || this.allPageButtonObjects.Count <= 0)
        return (Selectable) null;
      return this.activeButton >= this.allPageButtonObjects.Count ? this.allPageButtonObjects[this.allPageButtonObjects.Count - 1].GetComponentInChildren<Selectable>() : this.allPageButtonObjects[this.activeButton].GetComponentInChildren<Selectable>();
    }

    public void SetAllPageItems(List<ShopItem> items) => this.allPageItems = items;

    public bool IsInPanel()
    {
      bool flag = false;
      switch (this.navigatorType)
      {
        case ChampionPageButtonGenerator.NavigatorType.loadoutNavigation:
          flag = (Object) this.loadoutPanelNavigator.currentPanel == (Object) this.GetComponent<SubPanelObject>();
          break;
        case ChampionPageButtonGenerator.NavigatorType.subPanelNavigation:
          flag = (Object) this.subPanelNavigator.GetCurrentSubPanelObject() == (Object) this.GetComponent<SubPanelObject>();
          break;
      }
      return flag;
    }

    private void OnGetItemsFromServer()
    {
      if (!this.IsInPanel())
        return;
      int num = (Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.slotEquipMenu ? 1 : ((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.shopBuyPanel ? 1 : 0);
      if (num == 0 || (Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.slotEquipMenu)
        this.GetItemsFromProgressManager();
      this.FillPageButtons(this.activeButton);
      if (num == 0)
        return;
      this.SetButtonNavigation(false);
    }

    private void OnReturnFromOverlayMenu()
    {
      if (this.itemType == ShopManager.ShopItemType.avatarIcon)
      {
        if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
          return;
        MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToMenu);
        this.FillPageButtons();
        this.SetButtonNavigation(true);
        MenuController.Instance.buttonFocusManager.FocusButtonOnPageBuilt();
      }
      else
      {
        if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) || !this.IsInPanel())
          return;
        MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToPanel);
        MenuController.Instance.championPage.GetComponent<MenuObject>().UpdateTurntableRenderTexture();
        this.SetButtonNavigation(true);
        MenuController.Instance.buttonFocusManager.FocusButtonOnPageBuilt();
      }
    }

    public void SetButtonNavigation(bool navigatable)
    {
      Navigation navigation = new Navigation();
      navigation.mode = navigatable ? Navigation.Mode.Automatic : Navigation.Mode.None;
      foreach (GameObject pageButtonObject in this.allPageButtonObjects)
        pageButtonObject.GetComponentInChildren<Selectable>().navigation = navigation;
    }

    private void GetItemsFromProgressManager()
    {
      this.allPageItems = new List<ShopItem>();
      this.allPageItems.AddRange((IEnumerable<ShopItem>) ImiServices.Instance.progressManager.GetNeutralItemsByType(this.itemType));
      this.allPageItems.AddRange((IEnumerable<ShopItem>) ImiServices.Instance.progressManager.GetItemsByTypeAndChampion(this.itemType, MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion));
      List<ShopItemComparerGeneric.CompareParameters> sortPriorities = (List<ShopItemComparerGeneric.CompareParameters>) null;
      switch (this.sortCriteria)
      {
        case ChampionPageButtonGenerator.ChampionPageSortCriteria.rarity:
          sortPriorities = new List<ShopItemComparerGeneric.CompareParameters>()
          {
            ShopItemComparerGeneric.CompareParameters.Rarity,
            ShopItemComparerGeneric.CompareParameters.Name
          };
          break;
        case ChampionPageButtonGenerator.ChampionPageSortCriteria.owned:
          sortPriorities = new List<ShopItemComparerGeneric.CompareParameters>()
          {
            ShopItemComparerGeneric.CompareParameters.EquippedStatus,
            ShopItemComparerGeneric.CompareParameters.OwnedStatus,
            ShopItemComparerGeneric.CompareParameters.Name
          };
          break;
        case ChampionPageButtonGenerator.ChampionPageSortCriteria.nothing:
          sortPriorities = new List<ShopItemComparerGeneric.CompareParameters>();
          break;
      }
      this.allPageItems = ShopItemSortHelper.SortItems(this.allPageItems, sortPriorities, false);
    }

    public void OnEnterLoadoutPage()
    {
      Log.Debug("Calling GetItemsFromProgressManager because Subpanel was entered");
      this.FillPageButtons();
    }

    private void ClearPageButtons()
    {
      foreach (Object pageButtonObject in this.allPageButtonObjects)
        Object.Destroy(pageButtonObject);
      this.allPageButtonObjects = new List<GameObject>();
    }

    public void FillPageButtons(int selectedButton = 0, bool getItems = true)
    {
      this.ClearPageButtons();
      int nButton = 0;
      if (getItems)
        this.GetItemsFromProgressManager();
      if (this.SetLoadingErrorText(this.allPageItems == null || this.allPageItems.Count == 0))
        return;
      foreach (ShopItem allPageItem in this.allPageItems)
      {
        this.allPageButtonObjects.Add(this.InstantiateItemButton(allPageItem, nButton));
        ++nButton;
      }
      MenuController.Instance.ButtonPageGeneratedEvent?.Invoke();
      this.buttonScroller.SetupScrollView(this.allPageButtonObjects.ToArray(), selectedButton);
      this.buttonScroller.ScrollToButton(this.allPageButtonObjects[selectedButton]);
    }

    private GameObject InstantiateItemButton(ShopItem item, int nButton)
    {
      GameObject newButton = Object.Instantiate<GameObject>(this.itemButtonPrefab, this.layoutContainerParent.transform, false);
      newButton.name = item.itemDefinition.name + "_btn";
      this.SetButtonScrollValues(newButton.GetComponentInChildren<ScrollOnSelected>(), nButton / this.buttonScroller.nObjectsPerScrollelement);
      this.SetPageButtonValues(newButton, item, nButton);
      newButton.GetComponent<StyleLoadoutButton>().StyleButton(item, MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion);
      return newButton;
    }

    private void SetPageButtonValues(GameObject newButton, ShopItem item, int buttonID)
    {
      newButton.GetComponent<ChampionPageButton>().item = item;
      newButton.GetComponent<ChampionPageButton>().buttonGenerator = this;
      newButton.GetComponent<ChampionPageButton>().id = buttonID;
    }

    private void SetButtonScrollValues(ScrollOnSelected scrollHelper, int row)
    {
      scrollHelper.buttonScrollController = this.buttonScroller;
      scrollHelper.nRows = 1;
      scrollHelper.rowNumber = row;
    }

    private bool SetLoadingErrorText(bool error)
    {
      if (error)
      {
        if ((Object) this.loadingErrorText != (Object) null)
          this.loadingErrorText.gameObject.SetActive(true);
        if ((bool) (Object) this.loadingItemsText)
          this.loadingItemsText.gameObject.SetActive(false);
        this.layoutContainerParent.SetActive(false);
        return true;
      }
      this.layoutContainerParent.SetActive(true);
      if ((Object) this.loadingErrorText != (Object) null)
        this.loadingErrorText.gameObject.SetActive(false);
      if ((bool) (Object) this.loadingItemsText)
        this.loadingItemsText.gameObject.SetActive(false);
      return false;
    }

    public void ResetChampionTurntableView()
    {
      if ((Object) MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion != (Object) null)
        MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowItem(ImiServices.Instance.progressManager.GetEquippedSkinForChampion(MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion));
      else
        MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().HideAll();
    }

    public enum ChampionPageSortCriteria
    {
      rarity,
      owned,
      nothing,
    }

    public enum NavigatorType
    {
      loadoutNavigation,
      subPanelNavigation,
    }
  }
}
