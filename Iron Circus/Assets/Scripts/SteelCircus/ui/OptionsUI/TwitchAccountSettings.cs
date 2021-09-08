// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.TwitchAccountSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace SteelCircus.UI.OptionsUI
{
  public class TwitchAccountSettings : ObservedSetting
  {
    public static readonly string TwitchNameTogglePlayerPref = "ShowTwitchName";
    public static readonly string TwitchViewerCountTogglePlayerPref = "ShowTwitchViewerCount";
    public static readonly string ConnectedToTwitchAccountPlayerPref = "ConnectedToTwitchAccount";
    public static readonly string TwitchAccountNamePlayerPref = "";
    [SerializeField]
    private Button connectButton;
    [SerializeField]
    private TextMeshProUGUI buttonText;
    [SerializeField]
    private Animator buttonAnimator;
    [SerializeField]
    private Toggle twitchNameToggle;
    [SerializeField]
    private Toggle twitchViewerCountToggle;
    [SerializeField]
    private GameObject connectedInfo;
    [SerializeField]
    private TextMeshProUGUI showNameOptionsText;
    [SerializeField]
    private TextMeshProUGUI showViewerCountOptionsText;
    [SerializeField]
    private GameObject restartToApplyInfoObject;

    private void Awake()
    {
      this.connectButton.onClick.AddListener(new UnityAction(this.ConnectToTwitch));
      this.twitchNameToggle.isOn = PlayerPrefs.HasKey(TwitchAccountSettings.TwitchNameTogglePlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref) == 1;
      if (PlayerPrefs.HasKey(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref) == 1)
        this.twitchViewerCountToggle.isOn = true;
      else
        this.twitchViewerCountToggle.isOn = false;
    }

    private void OnEnable()
    {
      this.UpdateVisibility();
      this.restartToApplyInfoObject.SetActive(false);
    }

    private void OnDestroy() => this.connectButton.onClick.RemoveListener(new UnityAction(this.ConnectToTwitch));

    private void UpdateVisibility()
    {
      if (PlayerPrefs.HasKey(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) == 1)
      {
        this.connectButton.gameObject.SetActive(false);
        this.connectedInfo.SetActive(true);
        this.connectedInfo.GetComponent<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@ConnectedToTwitchAccount:") + " " + ImiServices.Instance.TwitchService.GetTwitchUserName();
        this.showNameOptionsText.color = Color.white;
        this.showViewerCountOptionsText.color = Color.white;
        this.twitchNameToggle.interactable = true;
        this.twitchViewerCountToggle.interactable = true;
      }
      else
      {
        this.connectButton.gameObject.SetActive(true);
        this.connectedInfo.SetActive(false);
        this.showNameOptionsText.color = new Color(0.5f, 0.5f, 0.5f, 0.7f);
        this.showViewerCountOptionsText.color = new Color(0.5f, 0.5f, 0.5f, 0.7f);
        this.twitchNameToggle.interactable = false;
        this.twitchViewerCountToggle.interactable = false;
      }
    }

    private void ConnectToTwitch()
    {
      this.StartCoroutine(MetaServiceHelpers.GetTwitchConnectToken(ImiServices.Instance.LoginService.GetPlayerId(), new Action<JObject>(this.OnGetTwitchToken), new Action<JObject>(this.OnGetTwitchTokenError)));
      this.buttonText.gameObject.SetActive(false);
      this.buttonAnimator.SetTrigger("load");
      this.restartToApplyInfoObject.SetActive(true);
    }

    private void OnGetTwitchToken(JObject obj)
    {
      if (obj["error"] != null || obj["msg"] != null)
      {
        this.OnGetTwitchTokenError(obj);
      }
      else
      {
        this.buttonText.gameObject.SetActive(true);
        this.buttonAnimator.SetTrigger("stopLoad");
        Log.Debug("Get Twitch token success:" + (object) obj);
        PlayerPrefs.SetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref, 1);
        Application.OpenURL(obj["twitchAuthLink"].ToString());
      }
    }

    private void OnGetTwitchTokenError(JObject obj)
    {
      this.buttonText.gameObject.SetActive(true);
      this.buttonAnimator.SetTrigger("stopLoad");
      Log.Error("Twitch service returned error:" + (object) obj);
      PopupManager.Instance.ShowPopup(PopupManager.Popup.OneButton, (IPopupSettings) new Popup("NoConnectionToTwitchPopupDescription", "Ok", title: "NoConnectionToTwitchPopupTitle"), (Action) null, (Action) null, (Action) null, (Action) null, (Selectable) null);
    }

    public void OnShowTwitchNameToggleChanged()
    {
      if (this.twitchNameToggle.isOn)
      {
        PlayerPrefs.SetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref, 1);
      }
      else
      {
        PlayerPrefs.SetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref, 0);
        this.twitchViewerCountToggle.isOn = false;
      }
      this.Notify(this.GetCurrentSetting(), Settings.SettingType.TwitchSettings);
    }

    public void OnShowTwitchViewerCountToggleChanged()
    {
      if (this.twitchViewerCountToggle.isOn)
      {
        PlayerPrefs.SetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref, 1);
        this.twitchNameToggle.isOn = true;
      }
      else
        PlayerPrefs.SetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref, 0);
      this.Notify(this.GetCurrentSetting(), Settings.SettingType.TwitchSettings);
    }

    public override void ApplySetting(ISetting value)
    {
      Log.Debug("Apply Twitch UI settings");
      TwitchAccountSetting currentSetting = this.GetCurrentSetting() as TwitchAccountSetting;
      MenuController.Instance.optionsMenu.StartCoroutine(MetaServiceHelpers.SetTwitchUISettings(ImiServices.Instance.LoginService.GetPlayerId(), currentSetting.showTwitchName, currentSetting.showViewerCount, new Action<JObject>(this.OnApplySetting)));
    }

    public void OnApplySetting(JObject obj) => Log.Debug("Applied Twitch UI settings: " + (object) obj);

    public override ISetting GetCurrentSetting()
    {
      int num1 = !PlayerPrefs.HasKey(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) ? 0 : (PlayerPrefs.GetInt(TwitchAccountSettings.ConnectedToTwitchAccountPlayerPref) == 1 ? 1 : 0);
      bool flag1 = PlayerPrefs.HasKey(TwitchAccountSettings.TwitchNameTogglePlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.TwitchNameTogglePlayerPref) == 1;
      bool flag2 = PlayerPrefs.HasKey(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref) && PlayerPrefs.GetInt(TwitchAccountSettings.TwitchViewerCountTogglePlayerPref) == 1;
      int num2 = flag1 ? 1 : 0;
      int num3 = flag2 ? 1 : 0;
      return (ISetting) new TwitchAccountSetting(num1 != 0, num2 != 0, num3 != 0);
    }
  }
}
