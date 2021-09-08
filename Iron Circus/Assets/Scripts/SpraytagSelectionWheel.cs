// Decompiled with JetBrains decompiler
// Type: SpraytagSelectionWheel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.UI;

public class SpraytagSelectionWheel : BaseSelectionWheel
{
  [SerializeField]
  private Image item0Sprite;
  [SerializeField]
  private Image item1Sprite;
  [SerializeField]
  private Image item2Sprite;
  [SerializeField]
  private Image item3Sprite;
  [SerializeField]
  private Sprite noSpriteIcon;
  private ShopItem[] equippedItems;
  private static SpraytagController spraytagController;

  public override void Initialize(
    GameContext gameContext,
    InputController inputController,
    ulong playerId)
  {
    base.Initialize(gameContext, inputController, playerId);
    SpraytagSelectionWheel.spraytagController = new SpraytagController(gameContext);
  }

  public override void SelectItem(int index)
  {
    base.SelectItem(index);
    SpraytagSelectionWheel.spraytagController.SpawnSpraytag(this.playerId, index + 1);
  }

  public override void SubmitSelection()
  {
    if (this.selectedItemIndex == -1)
      return;
    SpraytagSelectionWheel.spraytagController.SpawnSpraytag(this.playerId, this.selectedItemIndex + 1);
    this.selectedItemIndex = -1;
  }

  private void SetEquippedItems(ShopItem[] items)
  {
    if (items.Length != 4)
      Log.Error("Length of array of equipped items needs to be 4! Was  " + (object) items.Length + " instead.\n" + items.ToString());
    this.equippedItems = items;
  }

  protected override void PopulateSelectionWheel()
  {
    GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
    Debug.Log((object) firstLocalEntity.championConfig.value);
    this.SetEquippedItems(ImiServices.Instance.progressManager.GetEquippedSlotsByType(ShopManager.ShopItemType.spray, firstLocalEntity.championConfig.value));
    if (this.equippedItems[0] != null)
    {
      Debug.Log((object) ("populate 0 with: " + this.equippedItems[0].itemDefinition.name));
      this.item0Sprite.sprite = this.equippedItems[0].itemDefinition.icon;
    }
    else
    {
      Debug.Log((object) "populate 0 with none");
      this.item0Sprite.sprite = this.noSpriteIcon;
    }
    if (this.equippedItems[1] != null)
    {
      Debug.Log((object) ("populate 1 with: " + this.equippedItems[1].itemDefinition.name));
      this.item1Sprite.sprite = this.equippedItems[1].itemDefinition.icon;
    }
    else
    {
      Debug.Log((object) "populate 1 with none");
      this.item1Sprite.sprite = this.noSpriteIcon;
    }
    if (this.equippedItems[2] != null)
    {
      Debug.Log((object) ("populate 2 with: " + this.equippedItems[2].itemDefinition.name));
      this.item2Sprite.sprite = this.equippedItems[2].itemDefinition.icon;
    }
    else
    {
      Debug.Log((object) "populate 2 with none");
      this.item2Sprite.sprite = this.noSpriteIcon;
    }
    if (this.equippedItems[3] != null)
    {
      Debug.Log((object) ("populate 3 with: " + this.equippedItems[3].itemDefinition.name));
      this.item3Sprite.sprite = this.equippedItems[3].itemDefinition.icon;
    }
    else
    {
      Debug.Log((object) "populate 3 with none");
      this.item3Sprite.sprite = this.noSpriteIcon;
    }
  }

  protected override bool AllowSelectionWheel() => !SpraytagSelectionWheel.spraytagController.IsSpawnSpraytagLockedInMatchState();
}
