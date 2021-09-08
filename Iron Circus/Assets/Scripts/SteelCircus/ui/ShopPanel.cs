// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShopPanel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.Utils.Extensions;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ShopPanel : MonoBehaviour
  {
    public int activeItem;
    private ShopManager.CurrencyType currencyType;
    public TextMeshProUGUI notEnoughCreditsText;
    [SerializeField]
    private Animator buyAnimationController;
    [SerializeField]
    private ChampionConfigProvider champConfigProvider;
    [Header("Buy Button UI Elements")]
    [SerializeField]
    private Image buttonPromptImg;
    [SerializeField]
    private Button buyButton;
    public TextMeshProUGUI buyText;
    [SerializeField]
    private Animator buyButtonAnimator;
    [SerializeField]
    private GameObject infoPanel;
    [SerializeField]
    private GameObject turntableRenderPandel;
    [SerializeField]
    private GameObject turntableLoadingIcon;
    private int _itemId;
    private ShopBundleData bundle;
    [Header("Success Panel Elements")]
    [SerializeField]
    private TextMeshProUGUI itemBoughtNameText;
    [SerializeField]
    private Image itemIconImage;
    [SerializeField]
    private Image itemBackgroundImage;
    [SerializeField]
    private Sprite[] creditsShopSprites;
    [Header("Standard Info Panel Elements")]
    public TextMeshProUGUI itemNameText;
    public TextMeshProUGUI itemTypeText;
    public TextMeshProUGUI itemDescriptionText;
    public TextMeshProUGUI itemChampionText;
    public TextMeshProUGUI itempriceText;
    public TextMeshProUGUI itemOldPriceText;
    [SerializeField]
    private GameObject oldPriceContainer;
    [SerializeField]
    private Image currencyImage;
    [Header("Minimal Info Panel")]
    [SerializeField]
    private GameObject infoPanel_minimal;
    public TextMeshProUGUI itemNameText_minimalPanel;
    [SerializeField]
    private TextMeshProUGUI infoText_minimalPanel;
    [SerializeField]
    private GameObject infoTextBG_minimalPanel;
    [Header("Bundle Panels")]
    [SerializeField]
    private GameObject bundleParentObject;
    [SerializeField]
    private GameObject contentListPrefab;
    [SerializeField]
    private GameObject contentListParent;
    [SerializeField]
    private List<ItemDefinition> displayItems;
    [SerializeField]
    private TextMeshProUGUI currentActiveItemText;
    [SerializeField]
    private Button leftArrowButton;
    [SerializeField]
    private Button rightArrowButton;
    [Header("EquipButton")]
    [SerializeField]
    private GameObject EquipButton;
    [SerializeField]
    private ShopPanel.EquipButtonState equipButtonState;
    [SerializeField]
    private TextMeshProUGUI EquipButtonPromptText;
    [SerializeField]
    private TextMeshProUGUI EquipButtonEquippedText;
    [SerializeField]
    private GameObject EquipButtonPromptImage;
    [SerializeField]
    private Animator EquipButtonVisibilityAnimator;
    [SerializeField]
    private Animator EquipButtonLoadingStateAnimator;
    [Header("External References")]
    [SerializeField]
    private ShopManager shopManager;
    [Header("DLC Loading Panel")]
    private bool openedSteamOverlayThroughShop;
    [SerializeField]
    private GameObject dlcLoadingPanel;
    [SerializeField]
    private CanvasGroup parentCanvasGroup;
    protected Callback<GameOverlayActivated_t> m_gameOverlayActivated;

    private void Start()
    {
      ImiServices.Instance.progressManager.OnItemUnlockFailure += new ProgressManager.OnItemUnlockFailureEventHandler(this.OnErrorPurchasingItems);
      ImiServices.Instance.progressManager.OnDlcItemListReceived += new ProgressManager.OnDlcItemListReceivedEventHanlder(this.OnDlcItemListReceived);
      ImiServices.Instance.progressManager.onPlayerAvatarEquipped += new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnEquipAvatar);
    }

    private void OnDestroy()
    {
      ImiServices.Instance.progressManager.OnItemUnlockFailure -= new ProgressManager.OnItemUnlockFailureEventHandler(this.OnErrorPurchasingItems);
      ImiServices.Instance.progressManager.OnDlcItemListReceived -= new ProgressManager.OnDlcItemListReceivedEventHanlder(this.OnDlcItemListReceived);
      ImiServices.Instance.progressManager.onPlayerAvatarEquipped -= new ProgressManager.OnPlayerAvatarChangedEventHandler(this.OnEquipAvatar);
    }

    private void Update()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.shopBuyPanel))
        return;
      if (this.equipButtonState == ShopPanel.EquipButtonState.active && ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UISubmit))
        this.EquipButtonAction();
      if (this.equipButtonState == ShopPanel.EquipButtonState.equipped && ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UISubmit))
        this.ReturnToShop();
      if (this.bundle == null)
        return;
      if (ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIPrevious))
      {
        this.ShowPreviousItem();
      }
      else
      {
        if (!ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UINext))
          return;
        this.ShowNextItem();
      }
    }

    public void OnErrorPurchasingItems(string info) => PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("@ErrorPurchasingItemPopupDescription", "OK", title: "@ErrorPurchasingItemPopupTitle"), (Action) (() =>
    {
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent?.Invoke();
      PopupManager.Instance.HidePopup();
    }), (Action) null, (Action) null, (Action) null, (Selectable) null);

    public void EquipButtonAction()
    {
      ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this._itemId);
      switch (itemById.type)
      {
        case ShopManager.ShopItemType.spray:
          if (itemById.champion.championType == ChampionType.Invalid)
          {
            if ((UnityEngine.Object) MenuController.Instance.MenuStackPeek() == (UnityEngine.Object) MenuController.Instance.championPage)
            {
              this.OpenEquipMenu(MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion);
              break;
            }
            this.OpenChampionSelection();
            break;
          }
          this.OpenEquipMenu();
          break;
        case ShopManager.ShopItemType.skin:
        case ShopManager.ShopItemType.victoryPose:
        case ShopManager.ShopItemType.avatarIcon:
          this.InstantlyEquip(itemById);
          break;
        case ShopManager.ShopItemType.emote:
          this.OpenEquipMenu();
          break;
        default:
          this.OpenChampionSelection();
          break;
      }
    }

    private void InstantlyEquip(ItemDefinition item)
    {
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.loading);
      if (item.type != ShopManager.ShopItemType.avatarIcon)
        ImiServices.Instance.progressManager.EquipItem(ImiServices.Instance.LoginService.GetPlayerId(), item.definitionId, item.champion.championType, -1, new Action<JObject, int>(this.OnInstantEquip));
      else
        ImiServices.Instance.progressManager.EquipAvatar(ImiServices.Instance.LoginService.GetPlayerId(), item.definitionId);
    }

    private void OnEquipAvatar(ulong playerId, int avatarItemId) => this.SetEquipButtonsState(ShopPanel.EquipButtonState.equipped);

    private void OnInstantEquip(JObject Jobj, int itemId)
    {
      if (!(Jobj["result"].ToString() == "OK"))
        return;
      ImiServices.Instance.progressManager.FetchItemSubset(ImiServices.Instance.progressManager.GetItemByDefinitionId(itemId).itemDefinition.type);
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.equipped);
    }

    private void OpenEquipMenu(ChampionConfig activeChampion = null)
    {
      ShopItem itemByDefinitionId = ImiServices.Instance.progressManager.GetItemByDefinitionId(this._itemId);
      if ((UnityEngine.Object) activeChampion == (UnityEngine.Object) null || activeChampion.championType == ChampionType.Invalid)
        MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion = itemByDefinitionId.itemDefinition.champion;
      else
        MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion = activeChampion;
      MenuController.Instance.shopBuyPanel.ActualHideMenu(MenuObject.animationType.changeInstantly);
      MenuController.Instance.slotEquipMenu.GetComponent<ItemSlotEquipPage>().ShowItemSlotEquipPage(itemByDefinitionId, false);
    }

    private void OpenChampionSelection() => MenuController.Instance.championGallery.ActualShowMenu(MenuObject.animationType.changeInstantly, false);

    public void DisableAllPanels()
    {
      this.infoPanel.SetActive(false);
      this.infoPanel_minimal.SetActive(false);
      this.bundleParentObject.SetActive(false);
      this.turntableRenderPandel.SetActive(false);
    }

    public void SetTurntableLoading(bool loading)
    {
      this.currentActiveItemText.text = "";
      this.turntableRenderPandel.SetActive(!loading);
      this.leftArrowButton.interactable = !loading;
      this.rightArrowButton.interactable = !loading;
      this.turntableLoadingIcon.SetActive(loading);
    }

    public void ShowCreditsPurchased(int nCredits, int shopSpriteIndex)
    {
      this.DisableAllPanels();
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.hidden);
      if (shopSpriteIndex >= this.creditsShopSprites.Length)
        shopSpriteIndex = this.creditsShopSprites.Length - 1;
      if (shopSpriteIndex < 0)
        shopSpriteIndex = 0;
      this.itemNameText.text = nCredits.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@Credits");
      this.itemBoughtNameText.text = nCredits.ToString() + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@Credits");
      this.itemIconImage.transform.localScale = new Vector3(2f, 2f, 2f);
      this.itemIconImage.sprite = this.creditsShopSprites[shopSpriteIndex];
      this.itemIconImage.preserveAspect = true;
      this.StartCoroutine(this.SetBuyTrigger());
    }

    public IEnumerator SetBuyTrigger()
    {
      yield return (object) null;
      this.buyAnimationController.SetTrigger("buy");
    }

    private bool IsEquipButtonShown()
    {
      bool flag = true;
      ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(this._itemId);
      if (itemById.type == ShopManager.ShopItemType.champion)
        flag = false;
      if (itemById.type == ShopManager.ShopItemType.spray && itemById.champion.championType == ChampionType.Invalid && (UnityEngine.Object) MenuController.Instance.MenuStackPeek() != (UnityEngine.Object) MenuController.Instance.championPage)
        flag = false;
      return flag;
    }

    private void SetEquipButtonsState(ShopPanel.EquipButtonState state)
    {
      this.equipButtonState = state;
      this.EquipButton.SetActive(true);
      switch (state)
      {
        case ShopPanel.EquipButtonState.hidden:
          this.EquipButtonVisibilityAnimator.gameObject.GetComponent<CanvasGroup>().blocksRaycasts = false;
          this.EquipButtonVisibilityAnimator.SetTrigger("hide");
          this.EquipButton.GetComponent<Button>().interactable = false;
          break;
        case ShopPanel.EquipButtonState.active:
          this.EquipButtonVisibilityAnimator.gameObject.GetComponent<CanvasGroup>().blocksRaycasts = true;
          this.EquipButtonLoadingStateAnimator.SetTrigger("stopLoad");
          this.EquipButtonVisibilityAnimator.SetTrigger("show");
          this.EquipButtonPromptText.gameObject.SetActive(true);
          this.EquipButtonPromptImage.SetActive(true);
          this.EquipButtonEquippedText.gameObject.SetActive(false);
          this.EquipButton.GetComponent<Button>().interactable = true;
          break;
        case ShopPanel.EquipButtonState.loading:
          this.EquipButtonLoadingStateAnimator.SetTrigger("load");
          this.EquipButtonPromptText.gameObject.SetActive(false);
          this.EquipButtonPromptImage.SetActive(false);
          this.EquipButtonEquippedText.gameObject.SetActive(false);
          this.EquipButton.GetComponent<Button>().interactable = false;
          break;
        case ShopPanel.EquipButtonState.equipped:
          this.EquipButtonLoadingStateAnimator.SetTrigger("stopLoad");
          this.EquipButtonPromptText.gameObject.SetActive(false);
          this.EquipButtonPromptImage.SetActive(false);
          this.EquipButtonEquippedText.gameObject.SetActive(true);
          this.EquipButton.GetComponent<Button>().interactable = false;
          break;
      }
    }

    public void FillShopPanelPreview(ItemDefinition item, string description = "")
    {
      this.ShowDLCLoadingPanel(false);
      this.bundle = (ShopBundleData) null;
      this.itemDescriptionText.gameObject.SetActive(false);
      this.DisableAllPanels();
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.hidden);
      this.bundle = (ShopBundleData) null;
      this.infoPanel_minimal.SetActive(true);
      this.SetTurntableLoading(false);
      this.itemNameText_minimalPanel.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.fileName);
      if (description == "")
      {
        this.infoTextBG_minimalPanel.SetActive(false);
      }
      else
      {
        this.infoTextBG_minimalPanel.SetActive(true);
        this.infoText_minimalPanel.text = description;
      }
      this.oldPriceContainer.SetActive(false);
      this.SetTurntable(item);
      this.buyButton.gameObject.SetActive(false);
    }

    public void FillShopPanel(ShopBundleData bundle, bool enoughCredits)
    {
      this.ShowDLCLoadingPanel(false);
      this.HighlightBuyButton();
      this._itemId = -1;
      this.bundle = bundle;
      this.DisableAllPanels();
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.hidden);
      this.infoPanel.SetActive(true);
      this.bundleParentObject.SetActive(true);
      this.itemChampionText.gameObject.SetActive(false);
      this.itemTypeText.gameObject.SetActive(false);
      this.buyButton.gameObject.SetActive(true);
      foreach (Transform componentsInChild in this.contentListParent.transform.GetComponentsInChildren<Transform>())
      {
        if ((UnityEngine.Object) componentsInChild.gameObject != (UnityEngine.Object) this.contentListParent)
          UnityEngine.Object.Destroy((UnityEngine.Object) componentsInChild.gameObject);
      }
      if (bundle.descriptionLoca.IsNullOrEmpty())
      {
        this.FillBundleListEntries(bundle.items, bundle.creditsGained, bundle.steelGained, bundle.additionalEntries);
        this.itemDescriptionText.gameObject.SetActive(false);
      }
      else
      {
        this.itemDescriptionText.gameObject.SetActive(true);
        this.itemDescriptionText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + bundle.descriptionLoca);
      }
      this.activeItem = 0;
      if (bundle.items == null || bundle.items.Count == 0)
      {
        ImiServices.Instance.progressManager.GetDlcItemList(bundle.bundleId);
        this.SetTurntableLoading(true);
      }
      else
      {
        this.SetTurntable(bundle.items);
        this.SetTurntableLoading(false);
      }
      switch (bundle.currencyType)
      {
        case ShopManager.CurrencyType.steel:
          this.currencyImage.sprite = this.shopManager.steelSprite;
          this.notEnoughCreditsText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughSteel");
          break;
        case ShopManager.CurrencyType.credits:
          this.currencyImage.sprite = this.shopManager.creditsSprite;
          this.notEnoughCreditsText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughCredits");
          break;
      }
      this.FillInfoPanel(ImiServices.Instance.LocaService.GetLocalizedValue("@" + bundle.nameLoca), bundle.price, bundle.currencyType, ImiServices.Instance.LocaService.GetLocalizedValue("@bundle"), enoughCredits, bundle.hasDiscount, bundle.priceBeforeDiscount, bundle.isoCurrency);
      this.FillSuccessPanel(bundle.nameLoca, bundle.icon, 3);
    }

    private void OnDlcItemListReceived(
      int bundleId,
      List<ShopItem> items,
      int credsGained,
      int steelGained)
    {
      this.bundle.creditsGained = credsGained;
      this.bundle.steelGained = steelGained;
      items = ShopItemSortHelper.SortItemsByType(items);
      this.SetTurntable(items);
    }

    private void SetTurntable(List<ShopItem> bundleItems)
    {
      this.SetTurntableLoading(false);
      this.bundle.items = bundleItems;
      this.SetCurrentActiveItemText(this.bundle.items[0].itemDefinition);
      this.SetTurntable(this.bundle.items[0].itemDefinition);
    }

    private void FillBundleListEntries(
      List<ShopItem> items,
      int creditsGained = 0,
      int steelGained = 0,
      List<string> additionalEntries = null)
    {
      foreach (ShopItem shopItem in items)
      {
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.contentListPrefab, this.contentListParent.transform, false);
        if (shopItem.itemDefinition.type == ShopManager.ShopItemType.champion)
          gameObject.GetComponentInChildren<TextMeshProUGUI>().text = "- " + ImiServices.Instance.LocaService.GetLocalizedValue("@" + shopItem.itemDefinition.champion.displayName) + " -";
        else
          gameObject.GetComponentInChildren<TextMeshProUGUI>().text = "- " + ImiServices.Instance.LocaService.GetLocalizedValue("@" + shopItem.itemDefinition.fileName) + " -";
        if (shopItem.ownedByPlayer)
          gameObject.GetComponentInChildren<TextMeshProUGUI>().faceColor = (Color32) new Color(0.3f, 0.3f, 0.3f);
      }
      if (this.bundle.steelGained > 0)
        UnityEngine.Object.Instantiate<GameObject>(this.contentListPrefab, this.contentListParent.transform, false).GetComponentInChildren<TextMeshProUGUI>().text = "+ " + (object) this.bundle.steelGained + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@Steel");
      if (this.bundle.creditsGained > 0)
        UnityEngine.Object.Instantiate<GameObject>(this.contentListPrefab, this.contentListParent.transform, false).GetComponentInChildren<TextMeshProUGUI>().text = "+ " + (object) this.bundle.steelGained + " " + ImiServices.Instance.LocaService.GetLocalizedValue("@Credits");
      if (additionalEntries != null)
      {
        foreach (string additionalEntry in additionalEntries)
          UnityEngine.Object.Instantiate<GameObject>(this.contentListPrefab, this.contentListParent.transform, false).GetComponentInChildren<TextMeshProUGUI>().text = "+ " + ImiServices.Instance.LocaService.GetLocalizedValue("@" + additionalEntry);
      }
      this.ShowItem(0);
    }

    private void SetCurrentActiveItemText(ItemDefinition item)
    {
      if (item.type == ShopManager.ShopItemType.champion)
        this.currentActiveItemText.GetComponentInChildren<TextMeshProUGUI>().text = "- " + ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.champion.displayName) + " -";
      else
        this.currentActiveItemText.GetComponentInChildren<TextMeshProUGUI>().text = "- " + ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.fileName) + " -";
    }

    public void HighlightBuyButton()
    {
    }

    public void FillShopPanel(
      ShopItem item,
      bool enoughCurrency,
      ShopManager.CurrencyType currency)
    {
      this.ShowDLCLoadingPanel(false);
      this.bundle = (ShopBundleData) null;
      this.currencyType = currency;
      this.itemDescriptionText.gameObject.SetActive(false);
      this.buyButton.gameObject.SetActive(true);
      this.DisableAllPanels();
      this.HighlightBuyButton();
      this.SetEquipButtonsState(ShopPanel.EquipButtonState.hidden);
      this.infoPanel.SetActive(true);
      this.SetTurntableLoading(false);
      this.itemIconImage.transform.localScale = new Vector3(1f, 1f, 1f);
      string title = item.itemDefinition.type != ShopManager.ShopItemType.champion ? ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.itemDefinition.fileName) : ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.itemDefinition.champion.displayName);
      this.itemTypeText.gameObject.SetActive(true);
      this.itemNameText.color = SingletonScriptableObject<ColorsConfig>.Instance.TierColorLight(item.itemDefinition.tier);
      if (item.itemDefinition.type == ShopManager.ShopItemType.champion || (UnityEngine.Object) item.itemDefinition.champion == (UnityEngine.Object) null || item.itemDefinition.champion.championType == ChampionType.Invalid || item.itemDefinition.champion.championType == ChampionType.Random)
      {
        this.itemChampionText.gameObject.SetActive(false);
      }
      else
      {
        this.itemChampionText.gameObject.SetActive(true);
        this.itemChampionText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + item.itemDefinition.champion.displayName);
      }
      switch (currency)
      {
        case ShopManager.CurrencyType.steel:
          this.FillInfoPanel(title, item.itemDefinition.priceSteel, currency, ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) item.itemDefinition.type), enoughCurrency);
          break;
        case ShopManager.CurrencyType.credits:
          this.FillInfoPanel(title, item.itemDefinition.priceCreds, currency, ImiServices.Instance.LocaService.GetLocalizedValue("@" + (object) item.itemDefinition.type), enoughCurrency);
          break;
      }
      this.currencyImage.preserveAspect = true;
      if (item.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
      {
        Sprite shopItemIcon = UnityEngine.Resources.Load<Sprite>(ItemsConfig.avatarHighResIconPath + item.itemDefinition.fileName);
        this.FillSuccessPanel(title, shopItemIcon, (int) item.itemDefinition.tier);
      }
      else
        this.FillSuccessPanel(title, item.itemDefinition.icon, (int) item.itemDefinition.tier);
      this._itemId = item.itemDefinition.definitionId;
      this.SetTurntable(item.itemDefinition);
    }

    private void FillInfoPanel(
      string title,
      int price,
      ShopManager.CurrencyType currencyType,
      string itemType,
      bool hasEnoughCurrency,
      bool hasDiscount = false,
      int priceBeforedisount = 0,
      string isoCurrency = "EUR")
    {
      switch (currencyType)
      {
        case ShopManager.CurrencyType.steel:
          this.currencyImage.gameObject.SetActive(true);
          this.notEnoughCreditsText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughSteel");
          this.currencyImage.sprite = this.shopManager.steelSprite;
          this.itempriceText.color = SingletonScriptableObject<ColorsConfig>.Instance.steelColor;
          break;
        case ShopManager.CurrencyType.credits:
          this.currencyImage.gameObject.SetActive(true);
          this.notEnoughCreditsText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughCredits");
          this.itempriceText.color = SingletonScriptableObject<ColorsConfig>.Instance.credsColor;
          this.currencyImage.sprite = this.shopManager.creditsSprite;
          break;
        case ShopManager.CurrencyType.realMoney:
          this.currencyImage.gameObject.SetActive(false);
          break;
      }
      this.itemNameText.text = title;
      this.itemTypeText.text = itemType;
      if (!hasDiscount)
        this.oldPriceContainer.SetActive(false);
      else
        this.oldPriceContainer.SetActive(true);
      if (currencyType == ShopManager.CurrencyType.realMoney)
      {
        this.SetButton(true);
        this.itempriceText.text = CurrencyContainer.GetFormattedPrice(price, isoCurrency);
        this.itemOldPriceText.text = CurrencyContainer.GetFormattedPrice(priceBeforedisount, isoCurrency);
      }
      else
      {
        this.SetButton(hasEnoughCurrency);
        this.itempriceText.text = price.ToString();
        this.itemOldPriceText.text = priceBeforedisount.ToString();
      }
    }

    private void FillSuccessPanel(string title, Sprite shopItemIcon, int tier)
    {
      this.itemBoughtNameText.text = title;
      this.itemIconImage.sprite = shopItemIcon;
      this.itemBackgroundImage.sprite = this.shopManager.tieredBackgrounds[tier];
      this.itemIconImage.preserveAspect = true;
    }

    public void ShowNextItem()
    {
      ++this.activeItem;
      if (this.activeItem >= this.bundle.items.Count)
        this.activeItem = 0;
      this.ShowItem(this.activeItem);
    }

    public void ShowPreviousItem()
    {
      --this.activeItem;
      if (this.activeItem < 0)
        this.activeItem = this.bundle.items.Count - 1;
      this.ShowItem(this.activeItem);
    }

    private void ShowItem(int itemIndex)
    {
      this.SetCurrentActiveItemText(this.bundle.items[itemIndex].itemDefinition);
      this.SetTurntable(this.bundle.items[itemIndex].itemDefinition);
    }

    private void SetTurntable(ItemDefinition item) => MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowItem(item);

    private void SetButton(bool active)
    {
      this.buyText.gameObject.SetActive(active);
      this.buttonPromptImg.gameObject.SetActive(active);
      this.notEnoughCreditsText.gameObject.SetActive(!active);
      this.buyButton.interactable = active;
    }

    public void UnlockItem()
    {
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      if (this.bundle == null)
      {
        ShopItem itemByDefinitionId = ImiServices.Instance.progressManager.GetItemByDefinitionId(this._itemId);
        if (itemByDefinitionId.itemDefinition.type == ShopManager.ShopItemType.champion || itemByDefinitionId.itemDefinition.type == ShopManager.ShopItemType.avatarIcon || itemByDefinitionId.itemDefinition.champion.championType == ChampionType.Invalid || singleEntity.hasMetaChampionsUnlocked && singleEntity.metaChampionsUnlocked.championLockStateDict[itemByDefinitionId.itemDefinition.champion.championType])
          this.ExecuteUnlockItem();
        else
          PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup(ImiServices.Instance.LocaService.GetLocalizedValue("@ChampionNotOwnedPopupText"), ImiServices.Instance.LocaService.GetLocalizedValue("@ChampionNotOwnedPopupConfirmBtn"), ImiServices.Instance.LocaService.GetLocalizedValue("@CancelButton"), title: ImiServices.Instance.LocaService.GetLocalizedValue("@ChampionNotOwnedPopupTitle")), new Action(this.ExecuteUnlockItem), (Action) null, (Action) null, (Action) null, (Selectable) null);
      }
      else
      {
        if (this.bundle.appID == 0U)
          return;
        this.openedSteamOverlayThroughShop = true;
        this.m_gameOverlayActivated = Callback<GameOverlayActivated_t>.Create(new Callback<GameOverlayActivated_t>.DispatchDelegate(this.OnComeBackFromSteamOverlay));
        SteamFriends.ActivateGameOverlayToStore(new AppId_t(this.bundle.appID), EOverlayToStoreFlag.k_EOverlayToStoreFlag_None);
      }
    }

    private void OnComeBackFromSteamOverlay(GameOverlayActivated_t pCallback)
    {
      if (pCallback.m_bActive != (byte) 0 || !this.openedSteamOverlayThroughShop)
        return;
      Log.Debug("On Return from steam overlay.");
      this.openedSteamOverlayThroughShop = false;
      this.m_gameOverlayActivated.Dispose();
      this.ShowDLCLoadingPanel(true);
      this.StartCoroutine(this.WaitForDlcPurchaseInformation());
    }

    private IEnumerator WaitForDlcPurchaseInformation()
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      ShopPanel shopPanel = this;
      Coroutine timeout;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        shopPanel.StopCoroutine(timeout);
        shopPanel.ShowDLCLoadingPanel(false);
        shopPanel.ReturnToShop();
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      Coroutine waitForDlcInfo = shopPanel.StartCoroutine(MetaServiceHelpers.CheckDlcStatus(new Action<JObject>(ImiServices.Instance.Analytics.BuyChampionDlcGameAnalyticsEvent)));
      timeout = shopPanel.StartCoroutine(shopPanel.Timeout(5f, waitForDlcInfo));
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) waitForDlcInfo;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    private IEnumerator Timeout(float seconds, Coroutine waitForDlcInfo)
    {
      // ISSUE: reference to a compiler-generated field
      int num = this.\u003C\u003E1__state;
      ShopPanel shopPanel = this;
      if (num != 0)
      {
        if (num != 1)
          return false;
        // ISSUE: reference to a compiler-generated field
        this.\u003C\u003E1__state = -1;
        shopPanel.StopCoroutine(waitForDlcInfo);
        shopPanel.ShowDLCLoadingPanel(false);
        shopPanel.ReturnToShop();
        return false;
      }
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = -1;
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E2__current = (object) new WaitForSeconds(seconds);
      // ISSUE: reference to a compiler-generated field
      this.\u003C\u003E1__state = 1;
      return true;
    }

    public void ShowDLCLoadingPanel(bool show)
    {
      this.dlcLoadingPanel.SetActive(show);
      this.parentCanvasGroup.interactable = !show;
    }

    public void ExecuteUnlockItem()
    {
      if (PopupManager.Instance.IsActive())
        PopupManager.Instance.HidePopup();
      this.buyButton.interactable = false;
      this.buyButtonAnimator.SetTrigger("load");
      ImiServices.Instance.progressManager.UnlockItem(ImiServices.Instance.LoginService.GetPlayerId(), this._itemId, this.currencyType);
    }

    public void UnlockSuccess()
    {
      if (this.IsEquipButtonShown())
        this.SetEquipButtonsState(ShopPanel.EquipButtonState.active);
      this.buyAnimationController.SetTrigger("buy");
    }

    public void StopAnimationCoroutines()
    {
    }

    public void ReturnToShop()
    {
      this._itemId = 0;
      this.bundle = (ShopBundleData) null;
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.Invoke();
    }

    private enum EquipButtonState
    {
      hidden,
      active,
      loading,
      equipped,
    }
  }
}
