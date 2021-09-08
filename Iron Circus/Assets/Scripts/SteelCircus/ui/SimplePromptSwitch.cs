// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.SimplePromptSwitch
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class SimplePromptSwitch : MonoBehaviour
  {
    [SerializeField]
    private MenuController menuController;
    [SerializeField]
    private Button confirmButton;
    private Image confirmButtonImage;
    private Text confirmButtonText;
    public SimplePromptSwitch.ButtonFunction confirmButtonFunction;
    [SerializeField]
    private Button secondaryButton;
    private Image secondaryImage;
    private Text secondaryButtonText;
    public SimplePromptSwitch.ButtonFunction secondaryButtonFunction;
    [SerializeField]
    private Button leaveMatchmakingButton;
    private Text leaveMatchmakingButtonText;
    [SerializeField]
    private Button backButton;
    private Image backImage;
    private Text backButtonText;
    public SimplePromptSwitch.ButtonFunction backButtonFunction;
    [Space]
    public UnityEvent goBackToMenuEvent;
    public UnityEvent goBackToPanelEvent;
    public UnityEvent optionApplyEvent;
    public UnityEvent optionRevertEvent;
    public UnityEvent championGalleryShortcutEvent;
    public UnityEvent lobbyShortcutEvent;
    public UnityEvent hideLayeredMenuEvent;
    public UnityEvent optionSkipAllEvent;
    public UnityEvent optionSkipStepEvent;
    public Action leaveSteamGroupEvent;
    private ButtonSpriteSet sprites;
    private DebugLobbySkillDescription lobbySkillDescription;

    private void Start()
    {
      ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.ControllerChangedDelegate);
      this.goBackToPanelEvent = new UnityEvent();
      this.GetButtonImageReferences();
      this.SetSprites();
    }

    private void OnDestroy() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.ControllerChangedDelegate);

    private void GetButtonImageReferences()
    {
      this.confirmButtonImage = this.confirmButton.GetComponentInDirectChildren<Image>(true);
      this.confirmButtonText = this.confirmButton.GetComponentInDirectChildren<Text>(true);
      this.secondaryImage = this.secondaryButton.GetComponentInDirectChildren<Image>(true);
      this.secondaryButtonText = this.secondaryButton.GetComponentInDirectChildren<Text>(true);
      int num = (UnityEngine.Object) this.leaveMatchmakingButton != (UnityEngine.Object) null ? 1 : 0;
      this.backImage = this.backButton.GetComponentInDirectChildren<Image>(true);
      this.backButtonText = this.backButton.GetComponentInDirectChildren<Text>(true);
    }

    public void SetupNavigatorButtons(
      SimplePromptSwitch.ButtonFunction newConfirmButtonFunction,
      SimplePromptSwitch.ButtonFunction newSecondaryButtonFunction,
      SimplePromptSwitch.ButtonFunction newBackButtonFunction,
      string confirmButtonLocaOverride = "",
      string secondaryButtonLocaOverride = "",
      string backButtonLocaOverride = "")
    {
      this.GetButtonImageReferences();
      if (newConfirmButtonFunction == SimplePromptSwitch.ButtonFunction.disabled)
      {
        this.confirmButtonFunction = SimplePromptSwitch.ButtonFunction.disabled;
        this.confirmButton.gameObject.SetActive(false);
      }
      else
      {
        this.confirmButton.gameObject.SetActive(true);
        this.confirmButtonFunction = newConfirmButtonFunction;
        this.SetButtonText(this.confirmButtonText, this.confirmButtonFunction, confirmButtonLocaOverride);
      }
      if (newSecondaryButtonFunction == SimplePromptSwitch.ButtonFunction.disabled)
      {
        this.secondaryButtonFunction = SimplePromptSwitch.ButtonFunction.disabled;
        this.secondaryButton.gameObject.SetActive(false);
      }
      else
      {
        this.secondaryButton.gameObject.SetActive(true);
        this.secondaryButtonFunction = newSecondaryButtonFunction;
        this.SetButtonText(this.secondaryButtonText, this.secondaryButtonFunction, secondaryButtonLocaOverride);
      }
      if (newBackButtonFunction == SimplePromptSwitch.ButtonFunction.disabled)
      {
        this.backButtonFunction = SimplePromptSwitch.ButtonFunction.disabled;
        this.backButton.gameObject.SetActive(false);
      }
      else
      {
        this.backButton.gameObject.SetActive(true);
        this.backButtonFunction = newBackButtonFunction;
        this.SetButtonText(this.backButtonText, this.backButtonFunction, backButtonLocaOverride);
      }
    }

    public void SetButtonText(
      Text newText,
      SimplePromptSwitch.ButtonFunction function,
      string locaOverride)
    {
      if (!locaOverride.IsNullOrEmpty())
      {
        newText.text = ImiServices.Instance.LocaService.GetLocalizedValue(locaOverride);
      }
      else
      {
        switch (function)
        {
          case SimplePromptSwitch.ButtonFunction.goBackToMenu:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@backButton");
            break;
          case SimplePromptSwitch.ButtonFunction.goBackToPanel:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@backButton");
            break;
          case SimplePromptSwitch.ButtonFunction.submit:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@confirmButton");
            break;
          case SimplePromptSwitch.ButtonFunction.optionApply:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@applyButton");
            break;
          case SimplePromptSwitch.ButtonFunction.optionRevert:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@discardButton");
            break;
          case SimplePromptSwitch.ButtonFunction.championGalleryShortcut:
          case SimplePromptSwitch.ButtonFunction.lobbyShortcut:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@toggleButton");
            break;
          case SimplePromptSwitch.ButtonFunction.hideLayeredMenu:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@backButton");
            break;
          case SimplePromptSwitch.ButtonFunction.skipAll:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@skipButton");
            break;
          case SimplePromptSwitch.ButtonFunction.skipStep:
            newText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@nextButton");
            break;
        }
      }
    }

    public void InvokeButtonFunction(SimplePromptSwitch.ButtonFunction invokedFunction)
    {
      switch (invokedFunction)
      {
        case SimplePromptSwitch.ButtonFunction.goBackToMenu:
          this.goBackToMenuEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.goBackToPanel:
          this.goBackToPanelEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.optionApply:
          this.optionApplyEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.optionRevert:
          this.optionRevertEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.championGalleryShortcut:
          this.championGalleryShortcutEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.lobbyShortcut:
          this.lobbyShortcutEvent.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.hideLayeredMenu:
          this.hideLayeredMenuEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.skipAll:
          this.optionSkipAllEvent?.Invoke();
          break;
        case SimplePromptSwitch.ButtonFunction.leaveSteamGroup:
          Action leaveSteamGroupEvent = this.leaveSteamGroupEvent;
          if (leaveSteamGroupEvent == null)
            break;
          leaveSteamGroupEvent();
          break;
        case SimplePromptSwitch.ButtonFunction.skipStep:
          this.optionSkipStepEvent?.Invoke();
          break;
      }
    }

    private void ShowAllButtons()
    {
      this.confirmButtonText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@selectButton");
      this.secondaryButtonText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@toggleButton");
      this.backButtonText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@backButton");
      this.confirmButton.gameObject.SetActive(true);
      this.secondaryButton.gameObject.SetActive(true);
      this.backButton.gameObject.SetActive(true);
    }

    public void HideAllButtons()
    {
      this.confirmButton.gameObject.SetActive(false);
      this.secondaryButton.gameObject.SetActive(false);
      this.backButton.gameObject.SetActive(false);
    }

    private void ControllerChangedDelegate(InputSource inputSource) => this.SetSprites();

    private void SetSprites()
    {
      this.sprites = ImiServices.Instance.InputService.GetButtonSprites();
      this.confirmButtonImage.sprite = this.sprites.GetButtonSprite(DigitalInput.UISubmit);
      this.secondaryImage.sprite = this.sprites.GetButtonSprite(DigitalInput.UIShortcut);
      this.backImage.sprite = this.sprites.GetButtonSprite(DigitalInput.UICancel);
      if (!((UnityEngine.Object) this.lobbySkillDescription != (UnityEngine.Object) null))
        return;
      this.lobbySkillDescription.SetButtonSprites(this.sprites.GetButtonSprite(DigitalInput.UICancel), this.sprites.GetButtonSprite(DigitalInput.UIShortcut));
    }

    public void SubmitButtonInvoke() => this.InvokeButtonFunction(this.confirmButtonFunction);

    public void ShortcutButtonInvoke() => this.InvokeButtonFunction(this.secondaryButtonFunction);

    public void BackButtonInvoke()
    {
      Log.Debug(string.Format("Invoke Back: {0}", (object) this.backButtonFunction));
      this.InvokeButtonFunction(this.backButtonFunction);
    }

    public void InitializeCurrentDebugLobbySkillDescription(
      DebugLobbySkillDescription lobbyDescription)
    {
      this.lobbySkillDescription = lobbyDescription;
      if (this.sprites == null)
        return;
      this.lobbySkillDescription.SetButtonSprites(this.sprites.GetButtonSprite(DigitalInput.UICancel), this.sprites.GetButtonSprite(DigitalInput.UIShortcut));
    }

    public enum ButtonFunction
    {
      disabled,
      goBackToMenu,
      goBackToPanel,
      submit,
      optionApply,
      optionRevert,
      championGalleryShortcut,
      lobbyShortcut,
      hideLayeredMenu,
      skipAll,
      leaveSteamGroup,
      skipStep,
    }
  }
}
