// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ChampionPageButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using SteelCircus.UI.Menu.ChampionGallery;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ChampionPageButton : 
    MonoBehaviour,
    IPointerEnterHandler,
    IEventSystemHandler,
    IPointerExitHandler,
    IPointerClickHandler,
    ISelectHandler,
    ISubmitHandler
  {
    public ShopItem item;
    public ChampionPageButtonGenerator buttonGenerator;
    public int id;
    public ChampionPageButton.itemButtonAction onPointerEnterAction;
    public ChampionPageButton.itemButtonAction onPointerExitAction;
    public ChampionPageButton.itemButtonAction onClickAction;
    public ChampionPageButton.itemButtonAction onSelectAction;
    public ChampionPageButton.itemButtonAction onSubmitAction;

    public void ExecuteButtonAction(ChampionPageButton.itemButtonAction action)
    {
      switch (action)
      {
        case ChampionPageButton.itemButtonAction.Equip:
          if (this.item.ownedByPlayer)
          {
            this.ExecuteEquip();
            break;
          }
          this.ExecuteBuy();
          break;
        case ChampionPageButton.itemButtonAction.OpenSlotEquip:
          if (this.item.ownedByPlayer)
          {
            this.ExecuteOpenSlotEquip();
            break;
          }
          this.ExecuteBuy();
          break;
        case ChampionPageButton.itemButtonAction.UpdateActiveItem:
          this.ExecuteUpdateActiveItem();
          break;
        case ChampionPageButton.itemButtonAction.ResetAnimation:
          this.ExecuteResetAnimation();
          break;
        case ChampionPageButton.itemButtonAction.ShowDebugAnim:
          this.ExecuteShowDebugAnim();
          break;
        case ChampionPageButton.itemButtonAction.UpdateAvatarIcon:
          this.ExecuteUpdateAvatarIcon();
          break;
      }
    }

    public void ExecuteBuy()
    {
      this.buttonGenerator.SetButtonNavigation(false);
      MenuController.Instance.shopBuyPanel.GetComponent<MenuObject>().ActualShowMenu(MenuObject.animationType.changeInstantly, showOnTopOfOldMenu: true);
      if (this.item.buyable)
        MenuController.Instance.shopBuyPanel.gameObject.GetComponent<ShopPanel>().FillShopPanel(this.item, ImiServices.Instance.progressManager.GetPlayerCreds() >= this.item.itemDefinition.priceCreds, ShopManager.CurrencyType.credits);
      else
        MenuController.Instance.shopBuyPanel.gameObject.GetComponent<ShopPanel>().FillShopPanelPreview(this.item.itemDefinition, ImiServices.Instance.LocaService.GetLocalizedValue("@CantPurchaseLong"));
    }

    public void ExecuteEquip()
    {
      if (this.item.itemDefinition.type == ShopManager.ShopItemType.avatarIcon)
        ImiServices.Instance.progressManager.EquipAvatar(ImiServices.Instance.LoginService.GetPlayerId(), this.item.itemDefinition.definitionId);
      else
        ImiServices.Instance.progressManager.EquipItem(ImiServices.Instance.LoginService.GetPlayerId(), this.item.itemDefinition.definitionId, MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion.championType, -1);
    }

    public void ExecuteOpenSlotEquip()
    {
      this.buttonGenerator.SetButtonNavigation(false);
      MenuController.Instance.championPage.GetComponent<ChampionPage>().activeShopItemButton = this;
      MenuController.Instance.slotEquipMenu.GetComponent<ItemSlotEquipPage>().ShowItemSlotEquipPage(this.item);
    }

    public void ExecuteResetAnimation() => MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().StopAnimationLoop();

    public void ExecuteUpdateActiveItem()
    {
      MenuController.Instance.currentMenu.SetHighlightedButton(this.gameObject.GetComponentInChildren<Selectable>());
      if ((Object) this.buttonGenerator != (Object) null)
      {
        Log.Debug("Set active button id to: " + (object) this.id);
        this.buttonGenerator.activeButton = this.id;
      }
      MenuController.Instance.championPage.GetComponent<ChampionPage>().activeShopItemButton = this;
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().ShowItem(this.item.itemDefinition);
    }

    public void ExecuteUpdateAvatarIcon()
    {
      MenuController.Instance.playerProfile.GetComponent<SteelCircus.UI.Menu.PlayerProfile.PlayerProfile>().UpdateAvatarPreview(this.item);
      this.ExecuteUpdateActiveItem();
    }

    public void ExecuteShowDebugAnim()
    {
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().StopAnimationLoop();
      switch (this.item.itemDefinition.type)
      {
        case ShopManager.ShopItemType.emote:
          MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().StartPlayingAnimationOnRepeat(this.item.itemDefinition.prefab as AnimationClip, 0.5f);
          break;
        case ShopManager.ShopItemType.victoryPose:
          MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().StartPlayingAnimationOnRepeat(this.item.itemDefinition.prefab as AnimationClip, -0.25f);
          break;
      }
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.ExecuteButtonAction(this.onPointerEnterAction);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.ExecuteButtonAction(this.onPointerExitAction);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.ExecuteButtonAction(this.onClickAction);
    }

    public void OnSelect(BaseEventData eventData)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.ExecuteButtonAction(this.onSelectAction);
    }

    public void OnSubmit(BaseEventData eventData)
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.championPage) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.ExecuteButtonAction(this.onSubmitAction);
    }

    public enum itemButtonAction
    {
      None,
      Equip,
      OpenSlotEquip,
      UpdateActiveItem,
      ResetAnimation,
      ShowDebugAnim,
      UpdateAvatarIcon,
    }
  }
}
