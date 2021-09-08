// Decompiled with JetBrains decompiler
// Type: EmoteSelectionWheel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.UI;

public class EmoteSelectionWheel : BaseSelectionWheel
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

  public override void Initialize(
    GameContext gameContext,
    InputController inputController,
    ulong playerId)
  {
    base.Initialize(gameContext, inputController, playerId);
  }

  public override void SelectItem(int index)
  {
    base.SelectItem(index);
    DigitalInput button = DigitalInput.None;
    switch (index)
    {
      case 0:
        button = DigitalInput.Emote0;
        break;
      case 1:
        button = DigitalInput.Emote1;
        break;
      case 2:
        button = DigitalInput.Emote2;
        break;
      case 3:
        button = DigitalInput.Emote3;
        break;
    }
    this.inputController.TriggerButton(button, true);
  }

  public override void SubmitSelection()
  {
    if (this.selectedItemIndex == -1)
      return;
    DigitalInput button = DigitalInput.None;
    switch (this.selectedItemIndex)
    {
      case 0:
        button = DigitalInput.Emote0;
        break;
      case 1:
        button = DigitalInput.Emote1;
        break;
      case 2:
        button = DigitalInput.Emote2;
        break;
      case 3:
        button = DigitalInput.Emote3;
        break;
    }
    this.inputController.TriggerButton(button, true);
    this.selectedItemIndex = -1;
  }

  private void SetEquippedItems(ShopItem[] items)
  {
    if (items.Length != 4)
      Log.Error("Length of array of equipped items needs to be 4! Was  " + (object) items.Length + " instead.\n" + items.ToString());
    this.equippedItems = items;
  }

  protected override void UpdateInput() => base.UpdateInput();

  protected override void PopulateSelectionWheel()
  {
    GameEntity firstLocalEntity = this.gameContext.GetFirstLocalEntity();
    Debug.Log((object) firstLocalEntity.championConfig.value);
    this.SetEquippedItems(ImiServices.Instance.progressManager.GetEquippedSlotsByType(ShopManager.ShopItemType.emote, firstLocalEntity.championConfig.value));
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

  protected override bool AllowSelectionWheel()
  {
    Imi.SharedWithServer.Game.MatchState matchState = Contexts.sharedInstance.game.matchState.value;
    int num;
    switch (matchState)
    {
      case Imi.SharedWithServer.Game.MatchState.Intro:
      case Imi.SharedWithServer.Game.MatchState.MatchOver:
      case Imi.SharedWithServer.Game.MatchState.VictoryScreen:
      case Imi.SharedWithServer.Game.MatchState.VictoryPose:
      case Imi.SharedWithServer.Game.MatchState.StatsScreens:
        num = 1;
        break;
      default:
        num = matchState == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers ? 1 : 0;
        break;
    }
    return num == 0;
  }
}
