// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Popups.PopupManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Rewired;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Popups
{
  public class PopupManager : MonoBehaviour, IPopup, IPopupButtons
  {
    public GameObject PopupButtonPrefab;
    private Action buttonAction1;
    private Action buttonAction2;
    private Action buttonAction3;
    private Action timerEnd;
    public UnityEvent OnPopupHideEvent;
    public GameObject background;
    [Header("Popup Information")]
    public GameObject popup;
    public TextMeshProUGUI title;
    public TextMeshProUGUI information;
    [Header("Buttons Text")]
    public TextMeshProUGUI txtLeft;
    public TextMeshProUGUI txtRight;
    [Header("Horizontal Buttons")]
    public GameObject buttonPanel;
    public UnityEngine.UI.Button btnLeft;
    public UnityEngine.UI.Button btnRight;
    [Header("Vertical Buttons")]
    public GameObject verticalButtonPanel;
    public List<SCPopupButton> verticalButtons;
    private Selectable selectAfterExitPopup;
    private Player input;
    private IEnumerator countDown;

    public static PopupManager Instance { get; set; }

    private void Awake()
    {
      PopupManager.Instance = this;
      UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) this);
      this.input = ReInput.players.GetPlayer(0);
      this.OnPopupHideEvent = new UnityEvent();
    }

    private void Update()
    {
      if (!this.input.GetAnyButtonDown() || !((UnityEngine.Object) EventSystem.current.currentSelectedGameObject == (UnityEngine.Object) null) || !this.IsActive() || ImiServices.Instance.InputService.GetLastInputSource() == Imi.SteelCircus.Controls.InputSource.Mouse)
        return;
      this.SelectPopupButton();
    }

    public void ShowPopup(
      PopupManager.Popup popupType,
      IPopupSettings popupSettings,
      Action action1 = null,
      Action action2 = null,
      Action action3 = null,
      Action onTimerEnd = null,
      Selectable selectAfterExit = null)
    {
      this.ClearVerticalButtons();
      this.buttonAction1 = action1;
      this.buttonAction2 = action2;
      this.buttonAction3 = action3;
      this.timerEnd = onTimerEnd;
      this.selectAfterExitPopup = selectAfterExit;
      switch (popupType)
      {
        case PopupManager.Popup.TimeInformation:
          this.TimeInformation(popupSettings);
          break;
        case PopupManager.Popup.TimeInformationNoCountdown:
          this.TimeInformationNoCountdown(popupSettings);
          break;
        case PopupManager.Popup.NoButton:
          this.NoButton(popupSettings);
          break;
        case PopupManager.Popup.OneButton:
          this.OneButton(popupSettings);
          break;
        case PopupManager.Popup.TwoButtons:
          this.TwoButtons(popupSettings);
          break;
        case PopupManager.Popup.NButtons:
          this.NButtons(popupSettings);
          break;
      }
      this.popup.SetActive(true);
      this.background.SetActive(true);
      if (ImiServices.Instance.InputService.GetLastInputSource() == Imi.SteelCircus.Controls.InputSource.Mouse)
        return;
      if (popupType == PopupManager.Popup.NButtons)
        this.verticalButtons[0].button.Select();
      else
        this.btnLeft.GetComponent<Selectable>().Select();
    }

    public void HidePopup()
    {
      this.StopAllCoroutines();
      this.buttonAction1 = (Action) null;
      this.buttonAction2 = (Action) null;
      this.buttonAction3 = (Action) null;
      this.background.SetActive(false);
      if (this.IsActive())
        this.popup.SetActive(false);
      if ((UnityEngine.Object) this.selectAfterExitPopup != (UnityEngine.Object) null)
        this.selectAfterExitPopup.Select();
      this.OnPopupHideEvent?.Invoke();
    }

    public bool IsActive() => this.popup.activeSelf;

    public void ButtonAction1()
    {
      if (this.buttonAction1 != null)
        this.buttonAction1();
      else
        this.HidePopup();
    }

    public void ButtonAction2()
    {
      if (this.buttonAction2 != null)
        this.buttonAction2();
      else
        this.HidePopup();
    }

    public void ButtonAction3()
    {
      if (this.buttonAction3 != null)
        this.buttonAction3();
      else
        this.HidePopup();
    }

    private void TimeInformation(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(true);
      this.verticalButtonPanel.SetActive(false);
      if (popupSettings.Button1.IsNullOrEmpty())
        this.btnLeft.gameObject.SetActive(false);
      else
        this.btnLeft.gameObject.SetActive(true);
      if (popupSettings.Button2.IsNullOrEmpty())
        this.btnRight.gameObject.SetActive(false);
      else
        this.btnRight.gameObject.SetActive(true);
      this.txtRight.text = popupSettings.Button1;
      this.txtLeft.text = popupSettings.Button2;
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
      if (popupSettings.Button1.StartsWith("@"))
        this.txtLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button1);
      else
        this.txtLeft.text = popupSettings.Button1;
      if (popupSettings.Button2.StartsWith("@"))
        this.txtRight.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button2);
      else
        this.txtRight.text = popupSettings.Button2;
      this.countDown = this.TimerInformationPopup(popupSettings);
      this.StartCoroutine(this.countDown);
    }

    private void TimeInformationNoCountdown(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(true);
      this.verticalButtonPanel.SetActive(false);
      if (popupSettings.Button1.IsNullOrEmpty())
        this.btnLeft.gameObject.SetActive(false);
      else
        this.btnLeft.gameObject.SetActive(true);
      if (popupSettings.Button2.IsNullOrEmpty())
        this.btnRight.gameObject.SetActive(false);
      else
        this.btnRight.gameObject.SetActive(true);
      this.txtRight.text = popupSettings.Button1;
      this.txtLeft.text = popupSettings.Button2;
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
      if (popupSettings.Button1.StartsWith("@"))
        this.txtLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button1);
      else
        this.txtLeft.text = popupSettings.Button1;
      if (popupSettings.Button2.StartsWith("@"))
        this.txtRight.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button2);
      else
        this.txtRight.text = popupSettings.Button2;
      this.countDown = this.TimerInformationNoCountdownPopup(popupSettings);
      this.StartCoroutine(this.countDown);
    }

    private void NoButton(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(false);
      this.verticalButtonPanel.SetActive(false);
      this.btnRight.gameObject.SetActive(false);
      this.btnLeft.gameObject.SetActive(false);
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
    }

    private void OneButton(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(true);
      this.verticalButtonPanel.SetActive(false);
      this.btnRight.gameObject.SetActive(false);
      this.btnLeft.gameObject.SetActive(true);
      if (popupSettings.Button1.StartsWith("@"))
        this.txtLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button1);
      else
        this.txtLeft.text = popupSettings.Button1;
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
      this.btnLeft.GetComponent<Selectable>().Select();
    }

    private void TwoButtons(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(true);
      this.verticalButtonPanel.SetActive(false);
      this.btnRight.gameObject.SetActive(true);
      this.btnLeft.gameObject.SetActive(true);
      if (popupSettings.Button1.StartsWith("@"))
        this.txtLeft.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button1);
      else
        this.txtLeft.text = popupSettings.Button1;
      if (popupSettings.Button2.StartsWith("@"))
        this.txtRight.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Button2);
      else
        this.txtRight.text = popupSettings.Button2;
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
    }

    private void ClearVerticalButtons()
    {
      if (this.verticalButtons != null)
      {
        foreach (SCPopupButton verticalButton in this.verticalButtons)
          UnityEngine.Object.Destroy((UnityEngine.Object) verticalButton.button.gameObject);
      }
      this.verticalButtons = new List<SCPopupButton>();
    }

    private void NButtons(IPopupSettings popupSettings)
    {
      this.buttonPanel.SetActive(false);
      this.verticalButtonPanel.SetActive(true);
      foreach (SCPopupButton button in popupSettings.buttons)
      {
        this.verticalButtons.Add(button);
        GameObject gameObject = UnityEngine.Object.Instantiate<GameObject>(this.PopupButtonPrefab, this.verticalButtonPanel.transform, false);
        button.SetButtonFunction(gameObject.GetComponent<UnityEngine.UI.Button>(), gameObject.GetComponentInChildren<TextMeshProUGUI>());
      }
      for (int index = 0; index < this.verticalButtons.Count; ++index)
      {
        Navigation navigation = this.verticalButtons[index].button.navigation;
        navigation.selectOnUp = index <= 0 ? (Selectable) this.verticalButtons[index].button : (Selectable) this.verticalButtons[index - 1].button;
        navigation.selectOnDown = index >= this.verticalButtons.Count - 1 ? (Selectable) this.verticalButtons[index].button : (Selectable) this.verticalButtons[index + 1].button;
        this.verticalButtons[index].button.navigation = navigation;
      }
      if (popupSettings.Title.StartsWith("@"))
        this.title.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Title);
      else
        this.title.text = popupSettings.Title;
      if (popupSettings.Information.StartsWith("@"))
        this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information);
      else
        this.information.text = popupSettings.Information;
    }

    private IEnumerator TimerInformationPopup(IPopupSettings popupSettings)
    {
      for (int i = popupSettings.Timer - 1; 0 <= i; --i)
      {
        if (popupSettings.Information.StartsWith("@"))
          this.information.text = ImiServices.Instance.LocaService.GetLocalizedValue(popupSettings.Information) + " " + (object) i;
        else
          this.information.text = popupSettings.Information + " " + (object) i;
        yield return (object) new WaitForSeconds(1f);
      }
      Action timerEnd = this.timerEnd;
      if (timerEnd != null)
        timerEnd();
      this.HidePopup();
    }

    private IEnumerator TimerInformationNoCountdownPopup(IPopupSettings popupSettings)
    {
      for (int i = popupSettings.Timer - 1; 0 <= i; --i)
        yield return (object) new WaitForSeconds(1f);
      Action timerEnd = this.timerEnd;
      if (timerEnd != null)
        timerEnd();
      this.HidePopup();
    }

    public void SelectPopupButton()
    {
      if (this.btnLeft.gameObject.activeInHierarchy)
      {
        this.btnLeft.GetComponent<Selectable>().Select();
      }
      else
      {
        if (this.verticalButtons == null || this.verticalButtons.Count <= 0)
          return;
        this.verticalButtons[0].button.gameObject.GetComponent<Selectable>().Select();
      }
    }

    public enum Popup
    {
      TimeInformation,
      TimeInformationNoCountdown,
      NoButton,
      OneButton,
      TwoButtons,
      NButtons,
    }
  }
}
