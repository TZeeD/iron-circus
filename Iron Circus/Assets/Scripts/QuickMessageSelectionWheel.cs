// Decompiled with JetBrains decompiler
// Type: QuickMessageSelectionWheel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.GameElements;
using SteelCircus.UI.Menu.PlayerProfile;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class QuickMessageSelectionWheel : BaseSelectionWheel
{
  public Button button4;
  public Button button5;
  public Button button6;
  public Button button7;
  [SerializeField]
  private TMP_Text msg0Text;
  [SerializeField]
  private TMP_Text msg1Text;
  [SerializeField]
  private TMP_Text msg2Text;
  [SerializeField]
  private TMP_Text msg3Text;
  [SerializeField]
  private TMP_Text msg4Text;
  [SerializeField]
  private TMP_Text msg5Text;
  [SerializeField]
  private TMP_Text msg6Text;
  [SerializeField]
  private TMP_Text msg7Text;
  private static QuickChatMessageController quickMessageController;

  protected override bool ProcessSelectionInput(Vector2 stickInput)
  {
    if ((double) stickInput.x > 0.5)
    {
      if ((double) stickInput.y > 0.5)
      {
        this.selectedItemIndex = 3;
        this.button3.Select();
        return true;
      }
      if ((double) stickInput.y < -0.5)
      {
        this.selectedItemIndex = 1;
        this.button1.Select();
        return true;
      }
      this.selectedItemIndex = 2;
      this.button2.Select();
      return true;
    }
    if ((double) stickInput.x < -0.5)
    {
      if ((double) stickInput.y > 0.5)
      {
        this.selectedItemIndex = 5;
        this.button5.Select();
        return true;
      }
      if ((double) stickInput.y < -0.5)
      {
        this.selectedItemIndex = 7;
        this.button7.Select();
        return true;
      }
      this.selectedItemIndex = 6;
      this.button6.Select();
      return true;
    }
    if ((double) stickInput.y > 0.5)
    {
      this.selectedItemIndex = 4;
      this.button4.Select();
      return true;
    }
    if ((double) stickInput.y >= -0.5)
      return false;
    this.selectedItemIndex = 0;
    this.button0.Select();
    return true;
  }

  public override void Initialize(
    GameContext gameContext,
    InputController inputController,
    ulong playerId)
  {
    base.Initialize(gameContext, inputController, playerId);
    QuickMessageSelectionWheel.quickMessageController = new QuickChatMessageController(gameContext);
  }

  public override void SelectItem(int index)
  {
    base.SelectItem(index);
    QuickMessageSelectionWheel.quickMessageController.TriggerChatMessage(this.GetMessageIndexForSlot(index));
  }

  public override void SubmitSelection()
  {
    if (this.selectedItemIndex == -1)
      return;
    QuickMessageSelectionWheel.quickMessageController.TriggerChatMessage(this.GetMessageIndexForSlot(this.selectedItemIndex));
    this.selectedItemIndex = -1;
  }

  protected override void PopulateSelectionWheel()
  {
    this.msg0Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(0));
    this.msg1Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(1));
    this.msg2Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(2));
    this.msg3Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(3));
    this.msg4Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(4));
    this.msg5Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(5));
    this.msg6Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(6));
    this.msg7Text.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.GetQuickMessageLoca(7));
  }

  private int GetMessageIndexForSlot(int slot) => PlayerPrefs.HasKey(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString + (object) slot) ? PlayerPrefs.GetInt(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString + (object) slot) : slot;

  private string GetQuickMessageLoca(int slot) => "@Quickmessage" + (object) this.GetMessageIndexForSlot(slot);

  protected override bool AllowSelectionWheel() => !QuickMessageSelectionWheel.quickMessageController.IsQuickMessageLockedInMatchState();
}
