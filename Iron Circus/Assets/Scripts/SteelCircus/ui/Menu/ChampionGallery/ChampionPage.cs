// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.ChampionGallery.ChampionPage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.ChampionGallery
{
  [RequireComponent(typeof (ChampionDescriptions))]
  public class ChampionPage : MonoBehaviour
  {
    public ChampionPageButton activeShopItemButton;
    [SerializeField]
    private GameObject viewInShopPanel;
    [SerializeField]
    private GameObject buyInShopButton;
    [SerializeField]
    private GameObject buyInShopButtonPrompt;
    [SerializeField]
    private GameObject equipNowButton;
    [SerializeField]
    private GameObject equipNowButtonPrompt;
    [SerializeField]
    private MenuObject shopBuyPanel;
    [SerializeField]
    private GameObject championLockedInfoGroup;
    private bool championJustUnlocked;
    private SubPanelNavigation subPanelNavigation;
    private ChampionDescriptions championDescription;
    [SerializeField]
    private SubPanelObject unlockChampionSubPanel;

    private void Start()
    {
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnEnteredMenu));
      ImiServices.Instance.progressManager.OnChampionUnlockInfoUpdated += new ProgressManager.OnChampionUnlockInfoUpdatedHandler(this.CheckUpdateSubPanels);
      this.subPanelNavigation = this.GetComponent<SubPanelNavigation>();
      this.championDescription = this.GetComponent<ChampionDescriptions>();
      this.buyInShopButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@ViewItemInShop");
      this.equipNowButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@EquipItem");
    }

    private void OnDestroy()
    {
      if (!((Object) MenuController.Instance != (Object) null))
        return;
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnEnteredMenu));
      ImiServices.Instance.progressManager.OnChampionUnlockInfoUpdated -= new ProgressManager.OnChampionUnlockInfoUpdatedHandler(this.CheckUpdateSubPanels);
    }

    public void OnEnteredMenu()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) this.GetComponent<MenuObject>()))
        return;
      this.activeShopItemButton = (ChampionPageButton) null;
    }

    public void CheckUpdateSubPanels() => this.UpdateSubPanels(true);

    public void UpdateSubPanels(bool force = false, bool active = false)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) this.GetComponent<MenuObject>()) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championGallery) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.shopBuyPanel))
        return;
      MetaEntity singleEntity = Contexts.sharedInstance.meta.GetGroup(MetaMatcher.MetaPlayerId).GetSingleEntity();
      if (!((Object) this.championDescription.activeChampion != (Object) null))
        return;
      bool flag = singleEntity.metaChampionsUnlocked.championLockStateDict[this.championDescription.activeChampion.championType];
      int num = singleEntity.metaChampionsUnlocked.championRotationStateDict[this.championDescription.activeChampion.championType] ? 1 : 0;
      bool buyPanelActive = singleEntity.hasMetaChampionsUnlocked && !flag;
      this.championLockedInfoGroup.SetActive(buyPanelActive);
      if (force)
        this.SetBuyPanel(active);
      else
        this.SetBuyPanel(buyPanelActive);
      this.subPanelNavigation.HideAllPanels();
      this.subPanelNavigation.GenerateButtons();
      this.subPanelNavigation.ShowStartPanel();
    }

    private void SetBuyPanel(bool buyPanelActive)
    {
      if (buyPanelActive)
      {
        SubPanelObjectData menuPanel = this.subPanelNavigation.menuPanels[this.subPanelNavigation.GetIndexOfSubPanel(this.unlockChampionSubPanel)];
        menuPanel.isVisible = true;
        menuPanel.isActive = true;
        ItemDefinition itemById = SingletonScriptableObject<ItemsConfig>.Instance.GetItemByID(SingletonScriptableObject<ItemsConfig>.Instance.GetChampionItemId(MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion.championType), ShopManager.ShopItemType.champion);
        this.unlockChampionSubPanel.GetComponent<UnlockChampionPanel>().FillUnlockInfo(itemById.priceSteel);
      }
      else
      {
        int indexOfSubPanel = this.subPanelNavigation.GetIndexOfSubPanel(this.unlockChampionSubPanel);
        if (indexOfSubPanel == -1)
          return;
        SubPanelObjectData menuPanel = this.subPanelNavigation.menuPanels[indexOfSubPanel];
        menuPanel.isVisible = false;
        menuPanel.isActive = false;
      }
    }

    private void Update()
    {
      if ((Object) this.activeShopItemButton == (Object) null || this.activeShopItemButton.item.itemDefinition.definitionId == 0)
      {
        this.viewInShopPanel.SetActive(false);
      }
      else
      {
        this.viewInShopPanel.SetActive(true);
        if (!this.activeShopItemButton.item.ownedByPlayer)
        {
          this.buyInShopButton.GetComponent<Button>().interactable = true;
          this.buyInShopButtonPrompt.SetActive(true);
          this.equipNowButton.GetComponent<Button>().interactable = false;
          this.equipNowButtonPrompt.SetActive(false);
        }
        else
        {
          this.buyInShopButton.GetComponent<Button>().interactable = false;
          this.buyInShopButtonPrompt.SetActive(false);
          this.equipNowButton.GetComponent<Button>().interactable = true;
          this.equipNowButtonPrompt.SetActive(true);
        }
      }
    }

    public void ShopPanelOnClick() => this.activeShopItemButton.OnSubmit((BaseEventData) null);
  }
}
