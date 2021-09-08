// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.OptionsMenuScript
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using SteelCircus.UI.Menu;
using SteelCircus.UI.Popups;
using UnityEngine;
using UnityEngine.Events;

namespace SteelCircus.UI.OptionsUI
{
  public class OptionsMenuScript : MonoBehaviour
  {
    [SerializeField]
    private SubPanelNavigation navigator;
    [SerializeField]
    private Settings settingsMaster;
    [SerializeField]
    private bool controlMapperPopupActive;
    [SerializeField]
    public Rewired.UI.ControlMapper.ControlMapper controlMapper;
    [Header("Option Menues")]
    [SerializeField]
    private OptionsMenuSubPanelObject controlsPanel;
    private InputService input;
    public bool popupIsActive = true;
    public bool popupIsActive2 = true;

    private void Awake()
    {
      this.input = ImiServices.Instance.InputService;
      this.settingsMaster.OnSettingsPopupDeactivate += new Settings.OnSettingsPopupDeactivatedEventHandler(this.OnPopupDeactivated);
    }

    private void OnPopupDeactivated()
    {
      Log.Debug(nameof (OnPopupDeactivated));
      this.popupIsActive = false;
    }

    private void OnEnable()
    {
      this.popupIsActive = false;
      if (!((Object) MenuController.Instance != (Object) null))
        return;
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().optionApplyEvent.AddListener(new UnityAction(this.OnOptionApply));
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().optionRevertEvent.AddListener(new UnityAction(this.OnOptionRevert));
    }

    private void OnDisable()
    {
      if (!((Object) MenuController.Instance != (Object) null) || !((Object) MenuController.Instance.navigator != (Object) null))
        return;
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().optionApplyEvent.RemoveListener(new UnityAction(this.OnOptionApply));
      MenuController.Instance.navigator.GetComponent<SimplePromptSwitch>().optionRevertEvent.RemoveListener(new UnityAction(this.OnOptionRevert));
    }

    public bool IsControlMapperPopupActive() => this.controlMapperPopupActive;

    public void OnOptionRevert()
    {
      if (this.popupIsActive2 || PopupManager.Instance.IsActive() || this.controlMapperPopupActive)
        return;
      this.settingsMaster.PromtRevertSettings();
      this.popupIsActive = true;
    }

    public void OnOptionApply()
    {
      if (this.popupIsActive2 || PopupManager.Instance.IsActive() || this.controlMapperPopupActive)
        return;
      this.settingsMaster.CheckForDisplaySettingsAndApplyOptions();
    }

    private void Update()
    {
      if (this.input.IsUsingSteamInput() && this.input.GetButtonDown(DigitalInput.UIShortcut) && (Object) this.navigator.GetCurrentSubPanelObject() == (Object) this.controlsPanel)
        this.input.ShowSteamBindingPanel();
      if (!((Object) this.navigator.GetCurrentSubPanelObject() == (Object) this.controlsPanel))
        return;
      this.input.ForceButtonSpriteReload();
    }

    private void LateUpdate()
    {
      this.popupIsActive2 = this.popupIsActive;
      if ((Object) this.navigator.GetCurrentSubPanelObject() == (Object) this.controlsPanel)
        this.controlMapperPopupActive = this.controlMapper.windowManager.isWindowOpen;
      else
        this.controlMapperPopupActive = false;
    }
  }
}
