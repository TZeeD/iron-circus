// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ShowSpraytagsInChampionGallery
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.Utils.Extensions;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ShowSpraytagsInChampionGallery : MonoBehaviour
  {
    private const string PathToSprites = "Prefabs/UI/SprayTags/Sprites/";
    public GameObject spraytagLayoutContainer;
    public GameObject spraytagButtonPrefab;
    public MenuObject championPageMenu;
    public GameObject activeSpraytag;
    [SerializeField]
    private GameObject loadingSpraytagsText;
    [SerializeField]
    private GameObject loadingErrorText;
    [SerializeField]
    private ScrollThroughButtons buttonScroller;
    private List<ShopItem> allSprays;
    [SerializeField]
    private GameObject[] allSprayButtons;
    [SerializeField]
    private int activeSprayButton;
    [SerializeField]
    private ChampionDescriptions championPage;
    public MenuObject sprayEquipMenu;
    public MenuObject shopBuyPanel;
    public GameObject buyItemPanel;
    public bool menuInteractable = true;
    public ShopManager shopManager;
    [SerializeField]
    private LoadoutNavigation subPanelNavigator;

    private void Start()
    {
      this.allSprays = new List<ShopItem>();
      this.allSprayButtons = new GameObject[this.allSprays.Count];
      ImiServices.Instance.progressManager.OnItemReceived += new ProgressManager.OnItemsReceivedEventHandler(this.OnGetItemsFromServer);
      ImiServices.Instance.progressManager.OnItemUnlocked += new ProgressManager.OnItemUnlockedEventHandler(this.OnGetUnlockInformationFromServer);
    }

    private void OnDestroy()
    {
      ImiServices.Instance.progressManager.OnItemReceived -= new ProgressManager.OnItemsReceivedEventHandler(this.OnGetItemsFromServer);
      ImiServices.Instance.progressManager.OnItemUnlocked -= new ProgressManager.OnItemUnlockedEventHandler(this.OnGetUnlockInformationFromServer);
    }

    public Sprite GetActiveSprayTagSprite() => this.activeSpraytag.GetComponent<SwapSpraytagSprite>().spraytagSprite.sprite;

    private void OnEnable() => MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.AddListener(new UnityAction(this.OnReturnFromSprayEquip));

    private void OnDisable()
    {
      if (!((UnityEngine.Object) MenuController.Instance != (UnityEngine.Object) null) || !((UnityEngine.Object) MenuController.Instance.navigator != (UnityEngine.Object) null))
        return;
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.RemoveListener(new UnityAction(this.OnReturnFromSprayEquip));
    }

    public void OnGetUnlockInformationFromServer(JObject itemInformation, int itemId)
    {
      if (itemInformation["error"] == null)
        return;
      Log.Warning("Local credits not synced correctly with server. This should never happen");
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup(ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughCreditsMsg"), "OK", title: ImiServices.Instance.LocaService.GetLocalizedValue("@NotEnoughCreditsTitle")), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
    }

    public void OnGetItemsFromServer()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.championPageMenu) && !((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.shopBuyPanel) && !((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.sprayEquipMenu) || !((UnityEngine.Object) this.subPanelNavigator.currentPanel == (UnityEngine.Object) this.GetComponent<SubPanelObject>()))
        return;
      this.allSprays = new List<ShopItem>();
      foreach (ShopItem playerItem in ImiServices.Instance.progressManager.GetPlayerItems())
      {
        if (playerItem.itemDefinition.type == ShopManager.ShopItemType.spray && ((UnityEngine.Object) playerItem.itemDefinition.champion == (UnityEngine.Object) null || playerItem.itemDefinition.champion.championType == ChampionType.Invalid || playerItem.itemDefinition.champion.championType == this.championPageMenu.GetComponent<ChampionDescriptions>().activeChampion.championType))
          this.allSprays.Add(playerItem);
      }
      this.loadingSpraytagsText.SetActive(false);
      this.SetSprayUI();
    }

    public void LoadSpraysFromServer()
    {
      this.ClearSprayButtons();
      this.loadingSpraytagsText.SetActive(true);
    }

    public ShopItem[] GetEquippedSprays(ChampionConfig champion)
    {
      ShopItem[] shopItemArray = new ShopItem[4];
      foreach (ShopItem allSpray in this.allSprays)
      {
        foreach (EquipSlot equipSlot in allSpray.equipped)
        {
          if (equipSlot.champion == champion.championType && equipSlot.slot <= shopItemArray.Length)
            shopItemArray[equipSlot.slot - 1] = allSpray;
        }
      }
      return shopItemArray;
    }

    public void SetSprayUI(int selectedButton = 0)
    {
      this.ClearSprayButtons();
      this.allSprayButtons = new GameObject[this.allSprays.Count];
      GameObject[] allButtons = new GameObject[this.allSprays.Count];
      if (this.allSprays.Count == 0)
      {
        Log.Error("Error loading spraytags. No Spraytags loaded.");
        this.loadingErrorText.SetActive(true);
      }
      else
      {
        this.loadingErrorText.SetActive(false);
        this.spraytagLayoutContainer.GetComponent<RectTransform>().sizeDelta = new Vector2(0.0f, (float) (173 * (this.allSprays.Count / 4 + 1)));
        string str = "";
        for (int index = 0; index < this.allSprays.Count; ++index)
        {
          str = str + this.allSprays[index].itemDefinition.name + "\n";
          this.allSprayButtons[index] = UnityEngine.Object.Instantiate<GameObject>(this.spraytagButtonPrefab);
          this.allSprayButtons[index].name = this.allSprays[index].itemDefinition.name;
          this.allSprayButtons[index].gameObject.GetComponent<SwapSpraytagSprite>().SwapSprayTagImage(UnityEngine.Resources.Load<Sprite>("Prefabs/UI/SprayTags/Sprites/" + this.allSprays[index].itemDefinition.fileName));
          this.allSprayButtons[index].GetComponent<RectTransform>().SetParent((Transform) this.spraytagLayoutContainer.GetComponent<RectTransform>());
          this.allSprayButtons[index].GetComponentInChildren<ScrollOnSelected>().buttonScrollController = this.buttonScroller;
          this.allSprayButtons[index].GetComponentInChildren<ScrollOnSelected>().rowNumber = index / 4;
          allButtons[index] = this.allSprayButtons[index].GetComponentInChildren<ScrollOnSelected>().gameObject;
          string name = this.allSprays[index].itemDefinition.name;
          this.allSprayButtons[index].name = this.allSprays[index].itemDefinition.fileName;
          this.allSprayButtons[index].GetComponent<SwapSpraytagSprite>().sprayID = this.allSprays[index].itemDefinition.definitionId;
          this.allSprayButtons[index].gameObject.GetComponent<SwapSpraytagSprite>().sprayTagShopItem = this.allSprays[index];
          foreach (EquipSlot equipSlot in this.allSprays[index].equipped)
          {
            if (equipSlot.champion == this.championPageMenu.gameObject.GetComponent<ChampionDescriptions>().activeChampion.championType && equipSlot.slot <= 4)
            {
              int slot = equipSlot.slot;
            }
          }
          EventTrigger e = this.allSprayButtons[index].GetComponentInChildren<Button>().gameObject.AddComponent<EventTrigger>();
          e.AddListener(EventTriggerType.PointerEnter, (Action<BaseEventData>) (obj => this.SprayButtonMouseOverListener(e)));
          this.allSprayButtons[index].gameObject.GetComponent<StyleLoadoutButton>().StyleButton(this.allSprays[index], this.championPage.activeChampion);
          e.AddListener(EventTriggerType.Select, (Action<BaseEventData>) (obj =>
          {
            this.activeSpraytag = e.gameObject.transform.parent.gameObject;
            MenuController.Instance.currentMenu.SetHighlightedButton((Selectable) this.activeSpraytag.GetComponentInChildren<Button>());
            MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowSpraytag(this.activeSpraytag.GetComponent<SwapSpraytagSprite>().spraytagSprite.sprite);
          }));
          this.activeSpraytag = this.allSprayButtons[0];
          MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowSpraytag(this.activeSpraytag.GetComponent<SwapSpraytagSprite>().spraytagSprite.sprite);
        }
        Debug.Log((object) ("All Spray names: " + str));
        this.buttonScroller.SetupScrollView(allButtons, selectedButton);
        this.menuInteractable = true;
        Selectable componentInChildren = this.allSprayButtons[this.activeSprayButton].GetComponentInChildren<Selectable>();
        if (!this.sprayEquipMenu.IsMenuObjectActive())
          MenuController.Instance.buttonFocusManager.FocusOnButton(componentInChildren);
        this.buttonScroller.ScrollToButton((this.activeSprayButton + 1) / this.buttonScroller.nObjectsPerScrollelement);
      }
    }

    public void SprayButtonMouseOverListener(EventTrigger e)
    {
      if (!this.menuInteractable)
        return;
      this.activeSpraytag = e.gameObject.transform.parent.gameObject;
      MenuController.Instance.currentMenu.SetHighlightedButton((Selectable) e.gameObject.GetComponentInChildren<Button>());
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowSpraytag(this.activeSpraytag.GetComponent<SwapSpraytagSprite>().spraytagSprite.sprite);
    }

    public void OnSprayButtonSubmit()
    {
      for (int index = 0; index < this.allSprayButtons.Length; ++index)
      {
        int num = (UnityEngine.Object) this.allSprayButtons[index] == (UnityEngine.Object) this.activeSpraytag ? 1 : 0;
      }
    }

    public void OnReturnFromSprayEquip()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.championPageMenu) || !((UnityEngine.Object) this.subPanelNavigator.currentPanel == (UnityEngine.Object) this.GetComponent<SubPanelObject>()))
        return;
      Log.Debug("Return from spray equip page");
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToPanel);
      this.menuInteractable = true;
      this.championPageMenu.UpdateTurntableRenderTexture();
      this.SetSprayButtonNavigation(true);
    }

    public void OnEnterSprayEquip()
    {
      if (!((UnityEngine.Object) MenuController.Instance.currentMenu == (UnityEngine.Object) this.championPageMenu) || !((UnityEngine.Object) this.subPanelNavigator.currentPanel == (UnityEngine.Object) this.GetComponent<SubPanelObject>()))
        return;
      this.menuInteractable = false;
    }

    public void RebuildSprayUI() => this.SetSprayUI();

    private void ClearSprayButtons()
    {
      if (this.allSprayButtons == null)
        return;
      foreach (UnityEngine.Object allSprayButton in this.allSprayButtons)
        UnityEngine.Object.Destroy(allSprayButton);
    }

    private void SetSprayButtonNavigation(bool navigatable)
    {
      Navigation navigation = new Navigation();
      navigation.mode = navigatable ? Navigation.Mode.Automatic : Navigation.Mode.None;
      foreach (GameObject allSprayButton in this.allSprayButtons)
        allSprayButton.GetComponentInChildren<Selectable>().navigation = navigation;
    }
  }
}
