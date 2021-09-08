// Decompiled with JetBrains decompiler
// Type: ShopPage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using SteelCircus.UI;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class ShopPage : MonoBehaviour
{
  public GameObject itemPanelParent;
  public GameObject itemGroupPrefab;
  [SerializeField]
  private ShopManager.CurrencyType currency;
  [SerializeField]
  private ShopManager.ShopItemType itemType;
  [SerializeField]
  private GameObject itemParentVisibility;
  [SerializeField]
  private List<ShopItem> allShopItems;
  [SerializeField]
  private List<ShopBundleData> allShopBundles;
  [SerializeField]
  private List<ShopRotationData> allShopRotationItems;
  [SerializeField]
  private List<GameObject> allShopContainers;
  [SerializeField]
  private List<GameObject> specialContainerPrefabs;
  [SerializeField]
  private List<ShopItemButtonGroup> allButtonGroups;
  [SerializeField]
  private ShopManager shopManager;
  [SerializeField]
  private ScrollThroughButtons buttonScroller;
  [SerializeField]
  private GameObject LoadingIcon;
  public int nHighlightedButton;
  private bool loadingPageItems;
  private bool rotationLoaded;
  private bool dlcLoaded;

  private void OnEnable()
  {
    MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.AddListener(new UnityAction(this.OnReturnFromShopWindow));
    ImiServices.Instance.progressManager.OnShopPageReceived += new ProgressManager.OnShopPageReceivedEventHandler(this.OnGetShopPageContents);
    ImiServices.Instance.progressManager.OnWeeklyShopRotationUpdated += new ProgressManager.OnWeeklyShopRotationUpdatedHandler(this.OnGetShopRotationDataContents);
    ImiServices.Instance.progressManager.OnShopDlcListReceived += new ProgressManager.OnShopDlcListReceivedEventHandler(this.OnGetDlcInfo);
  }

  private void OnDisable()
  {
    ImiServices.Instance.progressManager.OnShopPageReceived -= new ProgressManager.OnShopPageReceivedEventHandler(this.OnGetShopPageContents);
    ImiServices.Instance.progressManager.OnWeeklyShopRotationUpdated -= new ProgressManager.OnWeeklyShopRotationUpdatedHandler(this.OnGetShopRotationDataContents);
    ImiServices.Instance.progressManager.OnShopDlcListReceived -= new ProgressManager.OnShopDlcListReceivedEventHandler(this.OnGetDlcInfo);
  }

  private void OnDestroy()
  {
    MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.PopulateShopPage));
    if (!((Object) MenuController.Instance.navigator != (Object) null))
      return;
    MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.RemoveListener(new UnityAction(this.OnReturnFromShopWindow));
  }

  public void OnShopPageEntered()
  {
    Imi.Diagnostics.Log.Debug("On Shop Page entered");
    this.ClearShopPage();
    this.rotationLoaded = false;
    this.dlcLoaded = false;
    if (this.itemType != ShopManager.ShopItemType.generic && this.itemType != ShopManager.ShopItemType.currency)
    {
      this.ShowLoadingSymbol();
      ImiServices.Instance.progressManager.FetchShopPage(this.itemType);
    }
    if (this.itemType != ShopManager.ShopItemType.generic)
      return;
    this.ResetItemList();
    this.ResetBundleList();
    this.ShowLoadingSymbol();
    ImiServices.Instance.progressManager.GetWeeklyShopRotation();
    ImiServices.Instance.progressManager.GetShopDlcList();
  }

  private void OnGetShopRotationDataContents(List<ShopRotationData> rotationData)
  {
    if (this.itemType != ShopManager.ShopItemType.generic)
      return;
    this.allShopRotationItems = rotationData;
    this.rotationLoaded = true;
    if (!this.dlcLoaded)
      return;
    this.OnGetFullShopRotationPage();
  }

  private void OnGetDlcInfo(List<ShopBundleData> dlcInfo)
  {
    if (this.itemType != ShopManager.ShopItemType.generic)
      return;
    this.dlcLoaded = true;
    this.ResetBundleList();
    foreach (ShopBundleData newBundle in dlcInfo)
    {
      if (newBundle.bundleId != 1)
        this.AddBundleToList(newBundle);
    }
    if (!this.rotationLoaded)
      return;
    this.OnGetFullShopRotationPage();
  }

  private void OnGetFullShopRotationPage()
  {
    if (this.itemType != ShopManager.ShopItemType.generic)
      return;
    Imi.Diagnostics.Log.Debug("Got full shop rotation page info");
    this.HideLoadingSymbol();
    this.PopulateShopPage();
  }

  private void OnGetShopPageContents(ShopManager.ShopItemType type, List<ShopItem> items)
  {
    if (type != this.itemType)
      return;
    this.ResetItemList();
    this.allShopItems = items;
    this.HideLoadingSymbol();
    this.PopulateShopPage();
  }

  public Selectable GetHighlightedButton()
  {
    if (!(this.allShopContainers != null & this.allShopContainers.Count > 0))
      return (Selectable) null;
    return this.nHighlightedButton >= this.allShopContainers.Count ? this.allShopContainers[this.allShopContainers.Count - 1].GetComponentInChildren<Selectable>() : this.allShopContainers[this.nHighlightedButton].GetComponentInChildren<Selectable>();
  }

  public List<GameObject> GetAllShopContainerObjects() => this.allShopContainers;

  public void OnReturnFromShopWindow()
  {
    if (!((Object) MenuController.Instance.currentMenu == (Object) this.shopManager.gameObject.GetComponent<MenuObject>()) || !((Object) this.shopManager.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject() == (Object) this.GetComponent<SubPanelObject>()))
      return;
    this.SetButtonNavigation(true);
    this.shopManager.shopPanel.GetComponent<ShopPanel>().StopAnimationCoroutines();
    MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().HideSpraytagSprite();
    this.shopManager.gameObject.GetComponent<MenuObject>().UpdateTurntableRenderTexture();
    this.OnShopPageEntered();
  }

  public void AddSpecialContainer(GameObject newContainer) => this.specialContainerPrefabs.Add(newContainer);

  public void ResetSpecialContainers() => this.specialContainerPrefabs = new List<GameObject>();

  public void AddShopRotationItem(ShopRotationData item) => this.allShopRotationItems.Add(item);

  public void ResetShopRotationItems() => this.allShopRotationItems = new List<ShopRotationData>();

  public void SetHighlightedButton(int nButton)
  {
    UnityEngine.Debug.Log((object) ("ShopPage " + this.gameObject.name + " setting highlighted Button to " + (object) nButton));
    this.nHighlightedButton = nButton;
  }

  public void SetButtonNavigation(bool navigatable)
  {
    Navigation navigation = new Navigation();
    navigation.mode = navigatable ? Navigation.Mode.Automatic : Navigation.Mode.None;
    foreach (GameObject allShopContainer in this.allShopContainers)
      allShopContainer.GetComponentInChildren<Selectable>().navigation = navigation;
  }

  public void ResetItemList()
  {
    this.allShopRotationItems = new List<ShopRotationData>();
    this.allShopItems = new List<ShopItem>();
  }

  public void SetItemList(List<ShopItem> newItemList) => this.allShopItems = newItemList;

  public void AddToItemList(ShopItem newItem) => this.allShopItems.Add(newItem);

  public void ResetBundleList() => this.allShopBundles = new List<ShopBundleData>();

  public void SetBundleList(List<ShopBundleData> newBundleList) => this.allShopBundles = newBundleList;

  public void AddBundleToList(ShopBundleData newBundle) => this.allShopBundles.Add(newBundle);

  public GameObject SetupBundleGroup(BaseShopItemContainer shopContainer)
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.itemGroupPrefab);
    gameObject.GetComponent<RectTransform>().SetParent((Transform) this.itemPanelParent.GetComponent<RectTransform>(), false);
    gameObject.GetComponent<VerticalLayoutGroup>().spacing = ShopManager.gutterSize;
    gameObject.GetComponent<ShopItemButtonGroup>().shopContainers.Add(shopContainer.GetComponent<BaseShopItemContainer>());
    gameObject.GetComponent<RectTransform>().sizeDelta = new Vector2(this.SectionsToWidth(gameObject.GetComponent<ShopItemButtonGroup>().GetGroupSectionWidth() + (int) ShopManager.gutterSize), this.SectionsToHeight(gameObject.GetComponent<ShopItemButtonGroup>().GetGroupSectionHeight()) + (float) (int) ShopManager.gutterSize);
    this.SetShopItemGroupValues(gameObject.GetComponent<ShopItemButtonGroup>());
    return gameObject;
  }

  public void PopulateShopPage()
  {
    if ((Object) MenuController.Instance.currentMenu == (Object) this.shopManager.GetComponent<MenuObject>() && (Object) this.shopManager.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject() == (Object) this.GetComponent<SubPanelObject>())
    {
      this.ClearShopPage();
      this.itemPanelParent.GetComponent<HorizontalLayoutGroup>().spacing = ShopManager.gutterSize;
      this.CreateShopItemSpecialContainers();
      this.CreateShopItemDlcBundleContainers(new List<uint>()
      {
        1195110U
      });
      this.CreateShopRotationContainers();
      this.CreateShopItemDlcBundleContainers(new List<uint>()
      {
        1180400U
      });
      this.allShopItems = ShopItemSortHelper.SortItems(this.allShopItems, new List<ShopItemComparerGeneric.CompareParameters>()
      {
        ShopItemComparerGeneric.CompareParameters.Champion,
        ShopItemComparerGeneric.CompareParameters.Rarity,
        ShopItemComparerGeneric.CompareParameters.Name
      }, false);
      this.CreateShopItemContainers();
      MenuController.Instance.buttonFocusManager.FocusButtonOnPageBuilt();
      if (this.gameObject.activeInHierarchy)
        this.StartCoroutine(this.ResetLayoutGroup());
    }
    List<GameObject> gameObjectList = new List<GameObject>();
    foreach (ShopItemButtonGroup allButtonGroup in this.allButtonGroups)
      gameObjectList.Add(allButtonGroup.gameObject);
    this.buttonScroller.SetupScrollView(gameObjectList.ToArray());
    RectTransform component = this.buttonScroller.buttonContainer.GetComponent<RectTransform>();
    if (this.buttonScroller.nTotalSections < this.buttonScroller.nVisibleElements)
      component.sizeDelta = new Vector2((float) ((double) this.buttonScroller.nTotalSections * (double) ShopManager.columnWidth + (double) (this.buttonScroller.nTotalSections - 1) * (double) ShopManager.gutterSize), component.sizeDelta.y);
    else
      component.sizeDelta = new Vector2(component.parent.GetComponent<RectTransform>().sizeDelta.x, component.sizeDelta.y);
  }

  private IEnumerator ResetLayoutGroup()
  {
    yield return (object) null;
    this.itemPanelParent.GetComponent<HorizontalLayoutGroup>();
    LayoutRebuilder.MarkLayoutForRebuild(this.itemPanelParent.GetComponent<RectTransform>());
  }

  public void CreateShopItemSpecialContainers()
  {
    foreach (GameObject specialContainerPrefab in this.specialContainerPrefabs)
    {
      GameObject gameObject1 = Object.Instantiate<GameObject>(specialContainerPrefab);
      BaseShopItemContainer component = gameObject1.GetComponent<BaseShopItemContainer>();
      gameObject1.name = "Container_Special_" + component.name;
      component.shopPage = this;
      component.manager = this.shopManager;
      GameObject gameObject2 = this.SetupBundleGroup(component);
      gameObject1.GetComponent<ScrollOnSelectedRemote>().scrollHelper = gameObject2.GetComponent<ScrollOnSelected>();
      gameObject1.GetComponent<RectTransform>().SetParent((Transform) gameObject2.GetComponent<RectTransform>(), false);
      component.buttonGroup = gameObject2.GetComponent<ShopItemButtonGroup>();
      this.allShopContainers.Add(gameObject1);
      this.allButtonGroups.Add(gameObject2.GetComponent<ShopItemButtonGroup>());
    }
  }

  private void CreateShopItemDlcBundleContainers(List<uint> dlcFilter)
  {
    for (int index = 0; index < this.allShopBundles.Count; ++index)
    {
      if (dlcFilter.Contains(this.allShopBundles[index].appID))
      {
        GameObject gameObject1 = Object.Instantiate<GameObject>(this.allShopBundles[index].prefab);
        gameObject1.name = "Container_Bundle_" + this.allShopBundles[index].nameLoca;
        DLCBundleShopItemContainer component = gameObject1.GetComponent<DLCBundleShopItemContainer>();
        component.shopPage = this;
        component.SetupItemContainerPanel(this.allShopBundles[index]);
        component.manager = this.shopManager;
        GameObject gameObject2 = this.SetupBundleGroup((BaseShopItemContainer) component);
        gameObject1.GetComponent<ScrollOnSelectedRemote>().scrollHelper = gameObject2.GetComponent<ScrollOnSelected>();
        gameObject1.GetComponent<RectTransform>().SetParent((Transform) gameObject2.GetComponent<RectTransform>(), false);
        component.buttonGroup = gameObject2.GetComponent<ShopItemButtonGroup>();
        this.allShopContainers.Add(gameObject1);
        this.allButtonGroups.Add(gameObject2.GetComponent<ShopItemButtonGroup>());
      }
    }
  }

  private GameObject CheckAndCreateNewButtonGroupObject(
    GameObject shopItemButtonGroupObject,
    GameObject newContainer)
  {
    if ((Object) shopItemButtonGroupObject == (Object) null || (double) (shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>().GetGroupSectionHeight() + newContainer.GetComponent<BaseShopItemContainer>().GetHeightInSections()) > (double) ShopManager.verticalSections)
    {
      if ((Object) shopItemButtonGroupObject != (Object) null)
        this.SetShopItemGroupValues(shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>());
      shopItemButtonGroupObject = this.CreateShopItemButtonGroup();
    }
    return shopItemButtonGroupObject;
  }

  private void SetContainerReferences(
    GameObject shopItemButtonGroupObject,
    GameObject newContainer,
    BaseShopItemContainer itemContainer)
  {
    newContainer.GetComponent<ScrollOnSelectedRemote>().scrollHelper = shopItemButtonGroupObject.GetComponent<ScrollOnSelected>();
    itemContainer.buttonGroup = shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>();
    shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>().shopContainers.Add(itemContainer);
  }

  private void SetContainerTransform(GameObject shopItemButtonGroupObject, GameObject newContainer)
  {
    newContainer.GetComponent<RectTransform>().SetParent((Transform) shopItemButtonGroupObject.GetComponent<RectTransform>(), false);
    shopItemButtonGroupObject.GetComponent<RectTransform>().sizeDelta = new Vector2(this.SectionsToWidth(shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>().GetGroupSectionWidth() + (int) ShopManager.gutterSize), this.SectionsToHeight(shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>().GetGroupSectionHeight()) + (float) (int) ShopManager.gutterSize);
  }

  private void CreateShopRotationContainers()
  {
    GameObject shopItemButtonGroupObject = (GameObject) null;
    for (int index = 0; index < this.allShopRotationItems.Count; ++index)
    {
      GameObject newContainer = Object.Instantiate<GameObject>(this.shopManager.GetShopContainerPrefab(this.allShopRotationItems[index].item.itemDefinition.type));
      newContainer.name = "Container_" + this.allShopRotationItems[index].item.itemDefinition.name;
      ShopItemContainer shopItemContainer = this.SetShopItemContainerValues(newContainer, this.allShopRotationItems[index].item, index, true, this.allShopRotationItems[index].countdownInMs, this.allShopRotationItems[index].countdownTimer);
      shopItemButtonGroupObject = this.CheckAndCreateNewButtonGroupObject(shopItemButtonGroupObject, newContainer);
      this.SetContainerReferences(shopItemButtonGroupObject, newContainer, (BaseShopItemContainer) shopItemContainer);
      this.SetContainerTransform(shopItemButtonGroupObject, newContainer);
      this.allShopContainers.Add(newContainer);
    }
    if (!((Object) shopItemButtonGroupObject != (Object) null))
      return;
    this.SetShopItemGroupValues(shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>());
  }

  private void CreateShopItemContainers()
  {
    GameObject shopItemButtonGroupObject = (GameObject) null;
    for (int index = 0; index < this.allShopItems.Count; ++index)
    {
      if (!this.allShopItems[index].ownedByPlayer)
      {
        GameObject newContainer = Object.Instantiate<GameObject>(this.shopManager.GetShopContainerPrefab(this.allShopItems[index].itemDefinition.type));
        newContainer.name = "Container_" + this.allShopItems[index].itemDefinition.name;
        ShopItemContainer shopItemContainer = this.SetShopItemContainerValues(newContainer, this.allShopItems[index], index);
        shopItemButtonGroupObject = this.CheckAndCreateNewButtonGroupObject(shopItemButtonGroupObject, newContainer);
        this.SetContainerReferences(shopItemButtonGroupObject, newContainer, (BaseShopItemContainer) shopItemContainer);
        this.SetContainerTransform(shopItemButtonGroupObject, newContainer);
        this.allShopContainers.Add(newContainer);
      }
    }
    if (!((Object) shopItemButtonGroupObject != (Object) null))
      return;
    this.SetShopItemGroupValues(shopItemButtonGroupObject.GetComponent<ShopItemButtonGroup>());
  }

  private ShopItemContainer SetShopItemContainerValues(
    GameObject newContainer,
    ShopItem item,
    int containerIndex,
    bool hasCountdown = false,
    long countdownInMS = 0,
    Stopwatch timer = null)
  {
    ShopItemContainer component = newContainer.GetComponent<ShopItemContainer>();
    component.shopPage = this;
    component.manager = this.shopManager;
    component.SetupItemContainerPanel(item, this.currency, hasCountdown, countdownInMS, timer);
    component.containerID = containerIndex;
    component.currenyType = this.currency;
    return component;
  }

  private GameObject CreateShopItemButtonGroup()
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.itemGroupPrefab);
    gameObject.GetComponent<RectTransform>().SetParent((Transform) this.itemPanelParent.GetComponent<RectTransform>(), false);
    gameObject.GetComponent<VerticalLayoutGroup>().spacing = ShopManager.gutterSize;
    this.allButtonGroups.Add(gameObject.GetComponent<ShopItemButtonGroup>());
    return gameObject;
  }

  private void SetShopItemGroupValues(ShopItemButtonGroup group)
  {
    group.GetComponent<ShopItemButtonGroup>().widthInSections = group.GetComponent<ShopItemButtonGroup>().GetGroupSectionWidth();
    int num = 0;
    foreach (ShopItemButtonGroup allButtonGroup in this.allButtonGroups)
    {
      if ((Object) allButtonGroup != (Object) group.GetComponent<ShopItemButtonGroup>())
        num += allButtonGroup.widthInSections;
      else
        break;
    }
    group.GetComponent<ShopItemButtonGroup>().startSectionHorizontal = num;
    group.gameObject.GetComponent<ScrollOnSelected>().buttonScrollController = this.buttonScroller;
    group.gameObject.GetComponent<ScrollOnSelected>().scrollBy = ScrollOnSelected.buttonSelectionType.rowNumber;
    group.gameObject.GetComponent<ScrollOnSelected>().rowNumber = num;
    group.gameObject.GetComponent<ScrollOnSelected>().nRows = group.GetComponent<ShopItemButtonGroup>().widthInSections;
  }

  private float SectionsToWidth(int sections) => (float) ((double) sections * (double) ShopManager.columnWidth + (double) (sections - 1) * (double) ShopManager.gutterSize);

  private float SectionsToHeight(int sections) => (float) ((double) sections * (double) ShopManager.lineHeight + (double) (sections - 1) * (double) ShopManager.gutterSize);

  public void ClearShopPage()
  {
    foreach (Object allShopContainer in this.allShopContainers)
      Object.Destroy(allShopContainer);
    this.allShopContainers = new List<GameObject>();
    foreach (Component allButtonGroup in this.allButtonGroups)
      Object.Destroy((Object) allButtonGroup.gameObject);
    this.allButtonGroups = new List<ShopItemButtonGroup>();
  }

  private void ShowLoadingSymbol()
  {
    if (!((Object) this.LoadingIcon != (Object) null))
      return;
    this.LoadingIcon.SetActive(true);
    this.itemParentVisibility.SetActive(false);
  }

  private void HideLoadingSymbol()
  {
    if (!((Object) this.LoadingIcon != (Object) null))
      return;
    this.LoadingIcon.SetActive(false);
    this.itemParentVisibility.SetActive(true);
  }

  private void Start()
  {
    this.allShopContainers = new List<GameObject>();
    this.allButtonGroups = new List<ShopItemButtonGroup>();
  }
}
