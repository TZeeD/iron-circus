// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.PlayerProfile.QuickMessageEquipWheel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.PlayerProfile
{
  public class QuickMessageEquipWheel : MonoBehaviour
  {
    public Button[] equipButtons;
    public TextMeshProUGUI[] equipButtonTextMeshObjects;
    public Button newMessageButton;
    public TextMeshProUGUI newMessageButtonsTextMeshObject;
    private int[] messages;
    private int newMessage;

    public event QuickMessageEquipWheel.OnQuickChatEquipWheelClosedEventHandler OnQuickChatEquipWheelClosed;

    public void ShowEquipWheel(int newMessage, int[] equippedMessages)
    {
      this.GetComponent<CanvasGroup>().alpha = 1f;
      this.GetComponent<CanvasGroup>().interactable = true;
      this.GetComponent<CanvasGroup>().blocksRaycasts = true;
      this.newMessage = newMessage;
      this.messages = equippedMessages;
      this.PopulateButtons();
      this.DeselectButtons();
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.AddListener(new UnityAction(this.HideEquipWheel));
    }

    private void DeselectButtons()
    {
      foreach (Selectable equipButton in this.equipButtons)
        equipButton.OnDeselect((BaseEventData) null);
    }

    public void SetLastSelected(int n)
    {
    }

    public void SetEquippedMessages(int[] equippedMessages) => this.messages = equippedMessages;

    private void OnDestroy() => MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().hideLayeredMenuEvent.RemoveListener(new UnityAction(this.HideEquipWheel));

    public void HideEquipWheel()
    {
      if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playerProfile))
        return;
      this.GetComponent<CanvasGroup>().alpha = 0.0f;
      this.GetComponent<CanvasGroup>().interactable = false;
      this.GetComponent<CanvasGroup>().blocksRaycasts = false;
      QuickMessageEquipWheel.OnQuickChatEquipWheelClosedEventHandler equipWheelClosed = this.OnQuickChatEquipWheelClosed;
      if (equipWheelClosed == null)
        return;
      equipWheelClosed();
    }

    public void PopulateButtons(bool showNewMessageButton = true)
    {
      if (showNewMessageButton)
        this.newMessageButton.gameObject.SetActive(true);
      else
        this.newMessageButton.gameObject.SetActive(false);
      for (int index = 0; index < this.equipButtons.Length; ++index)
      {
        QuickMessageEquipWheelButton equipWheelButton = this.equipButtons[index].gameObject.AddComponent<QuickMessageEquipWheelButton>();
        equipWheelButton.buttonId = index;
        equipWheelButton.equipWheel = this;
      }
      this.UpdateButtons();
      if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
        MenuController.Instance.buttonFocusManager.FocusOnButton((Selectable) this.newMessageButton);
      else
        EventSystem.current.SetSelectedGameObject((GameObject) null);
    }

    public void UpdateButtons()
    {
      this.newMessageButtonsTextMeshObject.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Quickmessage" + (object) this.newMessage);
      for (int index = 0; index < this.equipButtons.Length; ++index)
        this.equipButtonTextMeshObjects[index].text = ImiServices.Instance.LocaService.GetLocalizedValue("@Quickmessage" + (object) this.messages[index]);
    }

    public void EquipMessageToSlot(int slot)
    {
      int message = this.messages[slot];
      this.messages[slot] = this.newMessage;
      this.newMessage = message;
      this.UpdateButtons();
      this.ApplyEquipSettings();
    }

    private void ApplyEquipSettings()
    {
      for (int index = 0; index < this.equipButtons.Length; ++index)
        PlayerPrefs.SetInt(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString + (object) index, this.messages[index]);
    }

    public delegate void OnQuickChatEquipWheelClosedEventHandler();
  }
}
