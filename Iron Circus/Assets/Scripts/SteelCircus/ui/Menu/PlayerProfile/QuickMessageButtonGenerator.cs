// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.PlayerProfile.QuickMessageButtonGenerator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu.PlayerProfile
{
  public class QuickMessageButtonGenerator : MonoBehaviour
  {
    public static readonly string QuickMessageSlotPlayerPrefString = "QuickMessage_Slot_";
    public static readonly int numberOfQuickMessages = 25;
    public GameObject quickMessageButtonPrefab;
    public GameObject buttonContainerParent;
    public QuickMessageEquipWheel buttonEquipWheel;
    public List<GameObject> allButtons;
    public ScrollThroughButtons buttonScroller;
    public Button returnToListButton;
    private int lastSelectedButtonIndex;
    private int[] equippedMessages;

    private void Start()
    {
      this.equippedMessages = this.GetEquippedQuickMessages();
      this.buttonEquipWheel.HideEquipWheel();
      this.allButtons = new List<GameObject>();
      this.GenerateQuickMessageButtons();
      this.buttonEquipWheel.OnQuickChatEquipWheelClosed += new QuickMessageEquipWheel.OnQuickChatEquipWheelClosedEventHandler(this.ShowButtonList);
      MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.ResetLastSelectedButtonIndex));
    }

    private void OnDestroy()
    {
      this.buttonEquipWheel.OnQuickChatEquipWheelClosed -= new QuickMessageEquipWheel.OnQuickChatEquipWheelClosedEventHandler(this.ShowButtonList);
      MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.ResetLastSelectedButtonIndex));
    }

    private void ResetLastSelectedButtonIndex() => this.lastSelectedButtonIndex = 0;

    private void ClearButtons()
    {
      foreach (Object allButton in this.allButtons)
        Object.Destroy(allButton);
      this.allButtons = new List<GameObject>();
    }

    private int[] GetEquippedQuickMessages()
    {
      this.equippedMessages = new int[8];
      for (int index = 0; index < 8; ++index)
      {
        if (PlayerPrefs.HasKey(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString + (object) index))
        {
          this.equippedMessages[index] = PlayerPrefs.GetInt(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString + (object) index);
        }
        else
        {
          this.equippedMessages[index] = index;
          PlayerPrefs.SetInt(QuickMessageButtonGenerator.QuickMessageSlotPlayerPrefString, index);
        }
      }
      return this.equippedMessages;
    }

    public void UpdateQuickMessageButtons(int scrollToButton)
    {
      this.returnToListButton.gameObject.SetActive(false);
      this.equippedMessages = this.GetEquippedQuickMessages();
      this.buttonEquipWheel.SetEquippedMessages(this.equippedMessages);
      this.buttonEquipWheel.PopulateButtons(false);
      for (int index = 0; index < this.allButtons.Count; ++index)
        this.SetupButton(this.allButtons[index], index);
      this.buttonScroller.ScrollToButton(this.allButtons[scrollToButton]);
      if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
        MenuController.Instance.buttonFocusManager.FocusOnButton((Selectable) this.allButtons[scrollToButton].GetComponent<Button>());
      else
        EventSystem.current.SetSelectedGameObject((GameObject) null);
    }

    private void GenerateQuickMessageButtons(int scrollToButton = 0)
    {
      this.returnToListButton.gameObject.SetActive(false);
      this.ClearButtons();
      this.buttonEquipWheel.SetEquippedMessages(this.equippedMessages);
      this.buttonEquipWheel.PopulateButtons(false);
      for (int messageNr = 0; messageNr < QuickMessageButtonGenerator.numberOfQuickMessages; ++messageNr)
      {
        GameObject button = Object.Instantiate<GameObject>(this.quickMessageButtonPrefab, this.buttonContainerParent.transform, false);
        button.name = "QuickmessageEquipButton " + (object) messageNr;
        this.allButtons.Add(button);
        this.SetupButton(button, messageNr);
      }
      this.buttonScroller.SetupScrollView(this.allButtons.ToArray(), scrollToButton);
      this.buttonScroller.ForceUpdateLayout();
      if (ImiServices.Instance.InputService.GetLastInputSource() != InputSource.Mouse)
        MenuController.Instance.buttonFocusManager.FocusOnButton((bool) (Object) this.allButtons[scrollToButton]);
      else
        EventSystem.current.SetSelectedGameObject((GameObject) null);
    }

    public void ReturnToListButtonAction() => this.buttonEquipWheel.HideEquipWheel();

    private void SetupButton(GameObject button, int messageNr)
    {
      button.GetComponent<ScrollOnSelected>().buttonScrollController = this.buttonScroller;
      button.GetComponent<QuickMessageEquipButton>().StyleButton(messageNr, this, this.IsEquipped(messageNr));
    }

    private bool IsEquipped(int buttonNr)
    {
      bool flag = false;
      if (this.equippedMessages != null)
      {
        for (int index = 0; index < this.equippedMessages.Length; ++index)
        {
          if (this.equippedMessages[index] == buttonNr)
          {
            flag = true;
            break;
          }
        }
      }
      return flag;
    }

    public void ShowEquipWheel(int toEquip)
    {
      this.lastSelectedButtonIndex = toEquip;
      this.HidebuttonList();
      this.buttonEquipWheel.ShowEquipWheel(toEquip, this.equippedMessages);
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.hideLayeredMenu);
    }

    public void HidebuttonList()
    {
      this.GetComponent<CanvasGroup>().alpha = 0.0f;
      this.GetComponent<CanvasGroup>().interactable = false;
      this.GetComponent<CanvasGroup>().blocksRaycasts = false;
      this.returnToListButton.gameObject.SetActive(true);
    }

    public void ShowButtonList()
    {
      this.GenerateQuickMessageButtons(this.lastSelectedButtonIndex);
      this.UpdateQuickMessageButtons(this.lastSelectedButtonIndex);
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().SetupNavigatorButtons(SimplePromptSwitch.ButtonFunction.submit, SimplePromptSwitch.ButtonFunction.disabled, SimplePromptSwitch.ButtonFunction.goBackToMenu);
      this.GetComponent<CanvasGroup>().alpha = 1f;
      this.GetComponent<CanvasGroup>().interactable = true;
      this.GetComponent<CanvasGroup>().blocksRaycasts = true;
      this.returnToListButton.gameObject.SetActive(false);
    }
  }
}
