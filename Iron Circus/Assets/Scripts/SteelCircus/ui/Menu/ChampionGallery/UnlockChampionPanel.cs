// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.ChampionGallery.UnlockChampionPanel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using Steamworks;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.ChampionGallery
{
  public class UnlockChampionPanel : MonoBehaviour
  {
    public TextMeshProUGUI priceText;
    public Button buyButton;
    public GameObject notEnoughCreditsText;
    public GameObject buyText;
    public GameObject buyButtonPrompt;
    private InputService input;

    private void Update()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) || !((Object) this.GetComponent<SubPanelObject>().panelManager.GetCurrentSubPanelObject() == (Object) this.GetComponent<SubPanelObject>()))
        return;
      if (this.input.GetButtonDown(DigitalInput.UISubmit))
        this.ButtonPressAction();
      if (!this.input.GetButtonDown(DigitalInput.UIShortcut))
        return;
      this.BuyDLCAction();
    }

    private void Start() => this.input = ImiServices.Instance.InputService;

    public void FillUnlockInfo(int price)
    {
      this.priceText.text = price.ToString();
      if (ImiServices.Instance.progressManager.GetPlayerSteel() >= price)
      {
        this.buyButton.interactable = true;
        this.buyText.SetActive(true);
        this.buyButtonPrompt.SetActive(true);
        this.notEnoughCreditsText.SetActive(false);
      }
      else
      {
        this.buyButton.interactable = false;
        this.buyText.SetActive(false);
        this.buyButtonPrompt.SetActive(false);
        this.notEnoughCreditsText.SetActive(true);
      }
    }

    public void ButtonPressAction() => MenuController.Instance.shopMenu.GetComponent<ShopManager>().OpenBuyWindow(SingletonScriptableObject<ItemsConfig>.Instance.GetChampionItemId(MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion.championType), currencyType: ShopManager.CurrencyType.steel);

    public void BuyDLCAction() => SteamFriends.ActivateGameOverlayToStore(new AppId_t(1101500U), EOverlayToStoreFlag.k_EOverlayToStoreFlag_None);
  }
}
