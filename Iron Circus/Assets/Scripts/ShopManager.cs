// Decompiled with JetBrains decompiler
// Type: ShopManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using Steamworks;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using SteelCircus.UI.Popups;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class ShopManager : MonoBehaviour
{
  protected Callback<DlcInstalled_t> m_DLCInstalled;
  public static uint AllChampionsDlcAppID = 1101500;
  [Header("Prefabs")]
  [SerializeField]
  private GameObject shopContainerPrefab_Spraytags;
  [SerializeField]
  private GameObject shopConatinerPrefab_Skins;
  [SerializeField]
  private GameObject shopContainerPrefab_Animations;
  [SerializeField]
  private GameObject shopContainerPrefab_Champions;
  [SerializeField]
  private GameObject shopContainerPrefab_Bundles;
  [SerializeField]
  private GameObject shopContainerPrefab_DLC;
  public GameObject shopContainerPrefab_HalloweenDLC;
  [SerializeField]
  private GameObject shopContainerPrefab_AllChampionsDLC;
  [Header("Shop Pages")]
  [SerializeField]
  public PopulateCurrencyContainers currencyPage;
  [SerializeField]
  private ShopPage spraytagShopPage;
  [SerializeField]
  private ShopPage skinShopPage;
  [SerializeField]
  private ShopPage emoteShopPage;
  [SerializeField]
  private ShopPage victoryPoseShopPage;
  [SerializeField]
  private ShopPage ChampionShopPage;
  [SerializeField]
  private ShopPage weeklyRotationPage;
  [SerializeField]
  private ShopPanel shopBuyPanel;
  [Header("Weekly Rotation Items")]
  [SerializeField]
  private List<ShopRotationData> shopRotationData;
  public bool errorLoadingShop;
  [Header("Settings")]
  public static float verticalSections = 12f;
  public static int horizontalSections = 12;
  public static float gutterSize = 48f;
  public static float columnWidth = 78f;
  public static float lineHeight = 6f;
  private int transactionButtonIndex;
  private int clickedCurrencyAmount;
  [Header("Sprites")]
  public Sprite[] tieredBackgrounds;
  public Sprite creditsSprite;
  public Sprite steelSprite;
  public MenuObject shopPanel;
  [Header("Debug")]
  public Sprite bundleDefaultSprite;
  protected Callback<DlcInstalled_t> m_dlcInstalled;

  private void PrintDLC()
  {
  }

  private void Start()
  {
    MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnShopMenuEntered));
    ImiServices.Instance.progressManager.OnItemUnlocked += new ProgressManager.OnItemUnlockedEventHandler(this.OnItemBought);
  }

  private void OnDestroy()
  {
    MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnShopMenuEntered));
    ImiServices.Instance.progressManager.OnItemUnlocked -= new ProgressManager.OnItemUnlockedEventHandler(this.OnItemBought);
  }

  private void OnEnable()
  {
    if (!SteamManager.Initialized)
      return;
    this.m_DLCInstalled = Callback<DlcInstalled_t>.Create(new Callback<DlcInstalled_t>.DispatchDelegate(this.OnDlcBought));
  }

  private void OnDlcBought(DlcInstalled_t pCallback)
  {
    Log.Error("DLC installed. Fetching champion data");
    ImiServices.Instance.progressManager.FetchChampionUnlockInfo();
    ImiServices.Instance.progressManager.FetchShopPage(ShopManager.ShopItemType.champion);
    this.UpdateChampionPanelIfDLCInstalled();
    this.StartCoroutine(MetaServiceHelpers.CheckDlcStatus(new Action<JObject>(ImiServices.Instance.Analytics.BuyChampionDlcGameAnalyticsEvent)));
  }

  public void OnItemBought(JObject unlockMessage, int itemId)
  {
    if (unlockMessage["error"] != null || unlockMessage["msg"] != null)
    {
      Log.Error("Error received when unlocking item: " + (object) unlockMessage["error"]);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(ImiServices.Instance.LocaService.GetLocalizedValue("@ItemAlreadyUnlockedErrorMsg"), "OK", title: "@ItemAlreadyUnlockedErrorTitle"), new Action(this.shopBuyPanel.ReturnToShop), (Action) null, (Action) null, (Action) null, (Selectable) null);
    }
    else
      this.shopBuyPanel.UnlockSuccess();
  }

  public void ReloadUserCurrency() => ImiServices.Instance.progressManager.FetchPlayerProgress();

  public void ReloadShopPages() => ImiServices.Instance.progressManager.FetchAllItems();

  public void RebuildCurrentShopPage() => this.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject().GetComponent<ShopPage>().PopulateShopPage();

  public void OnShopMenuEntered()
  {
    if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.GetComponent<MenuObject>()) || !SteamManager.Initialized)
      return;
    this.UpdateChampionPanelIfDLCInstalled();
  }

  public void AddDlcContainers()
  {
    this.ChampionShopPage.ResetSpecialContainers();
    this.ChampionShopPage.AddSpecialContainer(this.shopContainerPrefab_AllChampionsDLC);
  }

  public void OnShopItemsLoaded()
  {
    this.spraytagShopPage.ResetItemList();
    this.skinShopPage.ResetItemList();
    this.emoteShopPage.ResetItemList();
    this.victoryPoseShopPage.ResetItemList();
    this.ChampionShopPage.ResetItemList();
    foreach (ShopItem playerItem in ImiServices.Instance.progressManager.GetPlayerItems())
    {
      switch (playerItem.itemDefinition.type)
      {
        case ShopManager.ShopItemType.spray:
          if (!playerItem.ownedByPlayer)
          {
            this.spraytagShopPage.AddToItemList(playerItem);
            continue;
          }
          continue;
        case ShopManager.ShopItemType.skin:
          if (!playerItem.ownedByPlayer)
          {
            this.skinShopPage.AddToItemList(playerItem);
            continue;
          }
          continue;
        case ShopManager.ShopItemType.emote:
          if (!playerItem.ownedByPlayer)
          {
            this.emoteShopPage.AddToItemList(playerItem);
            continue;
          }
          continue;
        case ShopManager.ShopItemType.victoryPose:
          if (!playerItem.ownedByPlayer)
          {
            this.victoryPoseShopPage.AddToItemList(playerItem);
            continue;
          }
          continue;
        case ShopManager.ShopItemType.champion:
          if (!playerItem.ownedByPlayer)
          {
            this.ChampionShopPage.AddToItemList(playerItem);
            continue;
          }
          continue;
        default:
          continue;
      }
    }
    this.AddDlcContainers();
    if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.GetComponent<MenuObject>()))
      return;
    this.RebuildCurrentShopPage();
  }

  private void UpdateChampionPanelIfDLCInstalled()
  {
    if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) MenuController.Instance.shopMenu))
      return;
    foreach (SubPanelObjectData menuPanel in this.GetComponent<SubPanelNavigation>().menuPanels)
    {
      if ((UnityEngine.Object) menuPanel.panel == (UnityEngine.Object) this.ChampionShopPage.GetComponent<SubPanelObject>())
      {
        if (SteamApps.BIsDlcInstalled(new AppId_t(1101500U)))
        {
          Log.Debug("ALL CHAMPIONS PACK INSTALLED!");
          if (menuPanel.isVisible)
          {
            menuPanel.isActive = false;
            menuPanel.isVisible = false;
            this.GetComponent<SubPanelNavigation>().NavigationSetup(false);
          }
        }
        else
        {
          Log.Debug("ALL CHAMPIONS PACK NOT INSTALLED!");
          if (!menuPanel.isActive || !menuPanel.isVisible)
          {
            menuPanel.isActive = true;
            menuPanel.isVisible = true;
          }
          this.GetComponent<SubPanelNavigation>().NavigationSetup(false);
        }
      }
    }
  }

  public GameObject GetShopContainerPrefab(ShopManager.ShopItemType itemType)
  {
    switch (itemType)
    {
      case ShopManager.ShopItemType.spray:
        return this.shopContainerPrefab_Spraytags;
      case ShopManager.ShopItemType.skin:
        return this.shopConatinerPrefab_Skins;
      case ShopManager.ShopItemType.emote:
        return this.shopContainerPrefab_Animations;
      case ShopManager.ShopItemType.victoryPose:
        return this.shopContainerPrefab_Animations;
      case ShopManager.ShopItemType.champion:
        return this.shopContainerPrefab_Champions;
      default:
        return this.shopContainerPrefab_Spraytags;
    }
  }

  public GameObject GetBundleContainerPrefab() => this.shopContainerPrefab_Bundles;

  public GameObject GetDLCBundleContainerPrefab() => this.shopContainerPrefab_DLC;

  public void OpenBuyWindow(ShopBundleData shopBundle, int nButton = 0)
  {
    this.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject().GetComponent<ShopPage>().SetHighlightedButton(nButton);
    List<ShopItem> shopItemList = new List<ShopItem>();
    this.shopPanel.ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
    bool enoughCredits;
    switch (shopBundle.currencyType)
    {
      case ShopManager.CurrencyType.steel:
        enoughCredits = shopBundle.priceBeforeDiscount <= ImiServices.Instance.progressManager.GetPlayerSteel();
        break;
      case ShopManager.CurrencyType.credits:
        enoughCredits = shopBundle.priceBeforeDiscount <= ImiServices.Instance.progressManager.GetPlayerCreds();
        break;
      default:
        enoughCredits = false;
        break;
    }
    this.shopPanel.GetComponent<ShopPanel>().FillShopPanel(shopBundle, enoughCredits);
  }

  public void OpenBuyWindow(int definitionID, int nButton = -1, ShopManager.CurrencyType currencyType = ShopManager.CurrencyType.credits)
  {
    if (nButton != -1)
      this.GetComponent<SubPanelNavigation>().GetCurrentSubPanelObject().GetComponent<ShopPage>().SetHighlightedButton(nButton);
    ShopItem itemByDefinitionId = ImiServices.Instance.progressManager.GetItemByDefinitionId(definitionID);
    this.shopPanel.ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
    bool enoughCurrency;
    switch (currencyType)
    {
      case ShopManager.CurrencyType.steel:
        enoughCurrency = itemByDefinitionId.itemDefinition.priceSteel <= ImiServices.Instance.progressManager.GetPlayerSteel();
        break;
      case ShopManager.CurrencyType.credits:
        enoughCurrency = itemByDefinitionId.itemDefinition.priceCreds <= ImiServices.Instance.progressManager.GetPlayerCreds();
        break;
      default:
        enoughCurrency = false;
        break;
    }
    this.shopPanel.GetComponent<ShopPanel>().FillShopPanel(itemByDefinitionId, enoughCurrency, currencyType);
  }

  public void OpenCurrencyBuyWindow(int amountCurrency)
  {
    this.shopPanel.ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
    this.shopPanel.GetComponent<ShopPanel>().ShowCreditsPurchased(amountCurrency, this.transactionButtonIndex);
  }

  public Sprite GetTieredBackgroundSprite(ShopManager.ItemTier tier)
  {
    switch (tier)
    {
      case ShopManager.ItemTier.tier0:
        return this.tieredBackgrounds[0];
      case ShopManager.ItemTier.tier1:
        return this.tieredBackgrounds[1];
      case ShopManager.ItemTier.tier2:
        return this.tieredBackgrounds[2];
      case ShopManager.ItemTier.tier3:
        return this.tieredBackgrounds[3];
      default:
        return this.tieredBackgrounds[0];
    }
  }

  public static ShopManager.ShopItemType GetItemTypeFromString(string itemType)
  {
    ShopManager.ShopItemType shopItemType;
    switch (itemType)
    {
      case "avatarIcon":
        shopItemType = ShopManager.ShopItemType.avatarIcon;
        break;
      case "champion":
        shopItemType = ShopManager.ShopItemType.champion;
        break;
      case "currency":
        shopItemType = ShopManager.ShopItemType.currency;
        break;
      case "emote":
        shopItemType = ShopManager.ShopItemType.emote;
        break;
      case "generic":
        shopItemType = ShopManager.ShopItemType.generic;
        break;
      case "goalAnimation":
        shopItemType = ShopManager.ShopItemType.goalAnimation;
        break;
      case "skin":
        shopItemType = ShopManager.ShopItemType.skin;
        break;
      case "spray":
        shopItemType = ShopManager.ShopItemType.spray;
        break;
      case "victoryPose":
        shopItemType = ShopManager.ShopItemType.victoryPose;
        break;
      default:
        shopItemType = ShopManager.ShopItemType.generic;
        break;
    }
    return shopItemType;
  }

  public enum ShopItemType
  {
    generic,
    spray,
    goalAnimation,
    skin,
    emote,
    victoryPose,
    champion,
    avatarIcon,
    currency,
  }

  public enum CurrencyType
  {
    none,
    steel,
    credits,
    realMoney,
    rankedPoints,
  }

  public enum ItemTier
  {
    tier0,
    tier1,
    tier2,
    tier3,
  }
}
