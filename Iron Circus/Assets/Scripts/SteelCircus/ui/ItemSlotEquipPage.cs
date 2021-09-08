// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.ItemSlotEquipPage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class ItemSlotEquipPage : MonoBehaviour
  {
    [SerializeField]
    private Image selectedSpraytagImage;
    [SerializeField]
    private Image spraytag0Sprite;
    [SerializeField]
    private Image spraytag1Sprite;
    [SerializeField]
    private Image spraytag2Sprite;
    [SerializeField]
    private Image spraytag3Sprite;
    [SerializeField]
    private Button selectedSpraytagButton;
    [SerializeField]
    private ChampionDescriptions championPage;
    [SerializeField]
    private Sprite noSpriteIcon;
    private ShopItem spraytagToEdit;
    private ShopItem selectedSpraytag;
    private ShopItem[] equippedSprays;

    private void Start() => this.equippedSprays = new ShopItem[4];

    private void SetSelectedSpraytag(ShopItem selected) => this.selectedSpraytag = selected;

    public void ShowItemSlotEquipPage(
      ShopItem selectedItem,
      bool addPreviousToStack = true,
      bool showOnTopOfOldMenu = true)
    {
      this.SetSelectedSpraytag(selectedItem);
      this.SetEquippedItems(ImiServices.Instance.progressManager.GetEquippedSlotsByType(selectedItem.itemDefinition.type, MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion));
      this.selectedSpraytagButton.Select();
      this.selectedSpraytagButton.OnSelect((BaseEventData) null);
      this.InitializeSpraytagPreview();
      this.GetComponent<MenuObject>().ActualShowMenu(MenuObject.animationType.changeInstantly, addPreviousToStack, showOnTopOfOldMenu);
      ChampionConfig champConfig = this.selectedSpraytag.itemDefinition.champion;
      if ((Object) champConfig == (Object) null || champConfig.championType == ChampionType.Random || champConfig.championType == ChampionType.Invalid)
        champConfig = MenuController.Instance.championPage.GetComponent<ChampionDescriptions>().activeChampion;
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().SetActiveChampion(champConfig);
      MenuController.Instance.championGalleryTurntable.GetComponent<ChampionTurntableUI>().SetChampSelected();
    }

    private void InitializeSpraytagPreview() => this.PopulateSpraytagPreviews();

    private void SetEquippedItems(ShopItem[] items)
    {
      if (items.Length != 4)
        Log.Error("Length of array of equipped items needs to be 4! Was  " + (object) items.Length + " instead.\n" + items.ToString());
      this.equippedSprays = items;
    }

    private void PopulateSpraytagPreviews()
    {
      this.selectedSpraytagImage.sprite = this.selectedSpraytag == null ? this.noSpriteIcon : this.selectedSpraytag.itemDefinition.icon;
      this.selectedSpraytagImage.preserveAspect = true;
      this.spraytag0Sprite.sprite = this.equippedSprays[0] == null ? this.noSpriteIcon : this.equippedSprays[0].itemDefinition.icon;
      this.spraytag1Sprite.sprite = this.equippedSprays[1] == null ? this.noSpriteIcon : this.equippedSprays[1].itemDefinition.icon;
      this.spraytag2Sprite.sprite = this.equippedSprays[2] == null ? this.noSpriteIcon : this.equippedSprays[2].itemDefinition.icon;
      if (this.equippedSprays[3] != null)
        this.spraytag3Sprite.sprite = this.equippedSprays[3].itemDefinition.icon;
      else
        this.spraytag3Sprite.sprite = this.noSpriteIcon;
    }

    public void CloseSprayEquipMenu() => MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.Invoke();

    public void SwapActiveSprayTag(string spraytagSlot)
    {
      int slot = spraytagSlot == "spraytag0" ? 1 : (spraytagSlot == "spraytag1" ? 2 : (spraytagSlot == "spraytag2" ? 3 : (spraytagSlot == "spraytag3" ? 4 : 1)));
      ShopItem equippedSpray = this.equippedSprays[slot - 1];
      this.equippedSprays[slot - 1] = this.selectedSpraytag;
      this.selectedSpraytag = equippedSpray;
      if (this.equippedSprays[slot - 1] != null)
        ImiServices.Instance.progressManager.EquipItem(ImiServices.Instance.LoginService.GetPlayerId(), this.equippedSprays[slot - 1].itemDefinition.definitionId, this.championPage.activeChampion.championType, slot);
      this.PopulateSpraytagPreviews();
    }
  }
}
