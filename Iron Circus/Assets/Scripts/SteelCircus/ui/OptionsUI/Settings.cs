// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.Settings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Rewired;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class Settings : Observer
  {
    private Dictionary<Settings.SettingType, ISetting> oldSettings;
    private Dictionary<Settings.SettingType, ISetting> newSettings;

    public event Settings.OnSettingsPopupDeactivatedEventHandler OnSettingsPopupDeactivate;

    private void Start() => this.newSettings = new Dictionary<Settings.SettingType, ISetting>();

    private void OnEnable()
    {
      this.oldSettings = new Dictionary<Settings.SettingType, ISetting>();
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        componentsInChild.RegisterObserver((Observer) this);
        this.oldSettings.Add(componentsInChild.SettingType, componentsInChild.GetCurrentSetting());
      }
    }

    private void ResetSettingsDictionaries() => MenuController.Instance.StartCoroutine(this.DelayedResetItemsDictionaries());

    private IEnumerator DelayedResetItemsDictionaries()
    {
      Settings settings = this;
      yield return (object) null;
      settings.oldSettings = new Dictionary<Settings.SettingType, ISetting>();
      foreach (ObservedSetting componentsInChild in settings.GetComponentsInChildren<ObservedSetting>(true))
        settings.oldSettings.Add(componentsInChild.SettingType, componentsInChild.GetCurrentSetting());
      settings.newSettings = new Dictionary<Settings.SettingType, ISetting>();
    }

    private void OnDisable() => this.oldSettings = (Dictionary<Settings.SettingType, ISetting>) null;

    public void PromtApplySettings() => PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@ApplySettingsPopupDescription", "@applyButton", "@CancelButton", title: "@ApplySettingsPopupTitle"), (Action) (() =>
    {
      this.ApplySettings();
      this.newSettings = new Dictionary<Settings.SettingType, ISetting>();
    }), (Action) (() =>
    {
      PopupManager.Instance.HidePopup();
      Settings.OnSettingsPopupDeactivatedEventHandler settingsPopupDeactivate = this.OnSettingsPopupDeactivate;
      if (settingsPopupDeactivate == null)
        return;
      settingsPopupDeactivate();
    }), (Action) null, (Action) null, (Selectable) null);

    public void TimedPromptRevertSettings()
    {
      this.ApplySettings(false);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.TimeInformation, (IPopupSettings) new Popup("@RevertDisplaySettingsPopupDescription", "@applyButton", "@revertButton", title: "@RevertDisplaySettingsPopupTitle", timer: 15), (Action) (() =>
      {
        this.ResetSettingsDictionaries();
        this.StoreDisplaySettings();
        PopupManager.Instance.HidePopup();
        MenuController.Instance.DisplayMainMenu();
      }), new Action(this.RevertDisplaySettingsAction), (Action) null, new Action(this.RevertDisplaySettingsAction), (Selectable) null);
    }

    private void RevertDisplaySettingsAction()
    {
      PopupManager.Instance.HidePopup();
      Settings.OnSettingsPopupDeactivatedEventHandler settingsPopupDeactivate = this.OnSettingsPopupDeactivate;
      if (settingsPopupDeactivate != null)
        settingsPopupDeactivate();
      this.RevertDisplaySettings();
      this.newSettings[Settings.SettingType.DisplaySettings] = (ISetting) null;
      MenuController.Instance.buttonFocusManager.FocusButtonOnPopupClosed();
      this.ResetSettingsDictionaries();
    }

    public void CheckForDisplaySettingsAndApplyOptions()
    {
      bool flag = false;
      Dictionary<Settings.SettingType, ISetting> oldSettings = this.oldSettings;
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        ISetting setting;
        this.newSettings.TryGetValue(componentsInChild.SettingType, out setting);
        if (setting != null && componentsInChild.SettingType == Settings.SettingType.DisplaySettings)
          flag = true;
      }
      if (!flag)
      {
        this.ApplySettings();
        this.ResetSettingsDictionaries();
      }
      else
        this.TimedPromptRevertSettings();
    }

    public void StoreDisplaySettings()
    {
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        if (componentsInChild.SettingType == Settings.SettingType.DisplaySettings && this.oldSettings.ContainsKey(Settings.SettingType.DisplaySettings))
          (componentsInChild as DisplaySettings).StoreDisplaySettingsToPlayerPrefs();
      }
    }

    public void RevertDisplaySettings()
    {
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        if (componentsInChild.SettingType == Settings.SettingType.DisplaySettings && this.oldSettings.ContainsKey(Settings.SettingType.DisplaySettings))
        {
          ISetting setting;
          this.oldSettings.TryGetValue(Settings.SettingType.DisplaySettings, out setting);
          componentsInChild.ApplySetting(setting);
          (componentsInChild as DisplaySettings).ResetSliders((DisplaySetting) setting);
          this.newSettings.Remove(Settings.SettingType.DisplaySettings);
          break;
        }
      }
    }

    private void OnApplicationQuit()
    {
      if (!this.gameObject.activeInHierarchy)
        return;
      Log.Debug("Application Quit called RevertDisplaySettings");
      this.RevertDisplaySettings();
    }

    public void ApplySettings() => this.ApplySettings(true);

    public void ApplySettings(bool goToPreviousMenu)
    {
      Debug.Log((object) string.Format("Applying new Settings: {0}.", (object) this.newSettings.Count));
      PopupManager.Instance.HidePopup();
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        ISetting setting;
        this.newSettings.TryGetValue(componentsInChild.SettingType, out setting);
        if (setting != null)
        {
          componentsInChild.ApplySetting(setting);
          Log.Debug(string.Format("TYPE: {0}", (object) setting.GetType()));
        }
      }
      if (ReInput.userDataStore != null)
        ReInput.userDataStore.Save();
      Log.Debug("ReInput.userDataStore: Saved");
      if (!goToPreviousMenu)
        return;
      MenuController.Instance.GoToPreviousMenu();
    }

    public void PromtRevertSettings() => PopupManager.Instance.ShowPopup(PopupManager.Popup.TwoButtons, (IPopupSettings) new Popup("@DiscardSettingsPopupDescription", "@applyButton", "@CancelButton", title: "@DiscardSettingsPopupTitle"), new Action(this.RevertSettings), (Action) (() =>
    {
      PopupManager.Instance.HidePopup();
      Settings.OnSettingsPopupDeactivatedEventHandler settingsPopupDeactivate = this.OnSettingsPopupDeactivate;
      if (settingsPopupDeactivate == null)
        return;
      settingsPopupDeactivate();
    }), (Action) null, (Action) null, (Selectable) null);

    private void RevertSettings()
    {
      Debug.Log((object) string.Format("Reverting Settings: {0}.", (object) this.oldSettings.Count));
      PopupManager.Instance.HidePopup();
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
        componentsInChild.ApplySetting(this.oldSettings[componentsInChild.SettingType]);
      if (ReInput.userDataStore != null)
        ReInput.userDataStore.Load();
      MenuController.Instance.GoToPreviousMenu();
    }

    public override void OnNotify(ISetting value, Settings.SettingType settingsType)
    {
      Debug.Log((object) string.Format("Settings Changed {0}", (object) settingsType));
      if (this.newSettings == null)
        return;
      if (!this.newSettings.ContainsKey(settingsType))
        this.newSettings.Add(settingsType, value);
      else
        this.newSettings[settingsType] = value;
    }

    public delegate void OnSettingsPopupDeactivatedEventHandler();

    public enum SettingType
    {
      Invalid,
      DisplaySettings,
      GraphicsTierSetting,
      AudioSettings,
      VoiceChatSettings,
      TwitchSettings,
    }
  }
}
