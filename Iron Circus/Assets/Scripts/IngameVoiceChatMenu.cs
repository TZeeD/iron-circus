// Decompiled with JetBrains decompiler
// Type: IngameVoiceChatMenu
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using SteelCircus.Core.Services;
using SteelCircus.UI.OptionsUI;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;
using VivoxUnity;

public class IngameVoiceChatMenu : MonoBehaviour
{
  private readonly string leavebuttonLoca = "@LeaveVCBtn";
  private readonly string joinButtonLoca = "@JoinVCBtn";
  private readonly string connectingToVCLoca = "@ConnectingToVoiceChat";
  private readonly string muteSelfButtonLoca = "@MuteSelfButton";
  private readonly string unMuteSelfButtonLoca = "@UnmuteSelfButton";
  private readonly string muteButtonLoca = "@MuteBtn";
  private readonly string unmuteButtonLoca = "@UnmuteBtn";
  private bool waitingForTeam;
  [Header("MenuItems")]
  [SerializeField]
  private Button joinVCButton;
  [SerializeField]
  private GameObject sliderObject;
  [SerializeField]
  private Slider volumeSlider;
  [SerializeField]
  private Slider micVolumeSlider;
  [SerializeField]
  private AudioMixer mixer;
  [Header("AudioSliders")]
  [SerializeField]
  private Slider masterVolumeSlider;
  [SerializeField]
  private Slider musicVolumeSlider;
  [SerializeField]
  private Slider sfxVolumeSlider;
  [Header("PlayerButtons")]
  [SerializeField]
  private GameObject ownPlayerObject;
  [SerializeField]
  private Button ownPlayerMuteButton;
  [SerializeField]
  private GameObject player2Object;
  [SerializeField]
  private TextMeshProUGUI player2NameText;
  [SerializeField]
  private Button player2MuteButton;
  [SerializeField]
  private GameObject player3Object;
  [SerializeField]
  private TextMeshProUGUI player3NameText;
  [SerializeField]
  private Button player3MuteButton;
  private ulong player2id;
  private ulong player3id;

  private void Start()
  {
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered += new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnEnterVC);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft += new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLeaveVC);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerConnectingToVoiceChat += new VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler(this.OnConnectingToVC);
    ImiServices.Instance.VoiceChatService.OnVoiceChatConnectionError += new VoiceChatService.OnVoiceChatConnectionErrorEventHandler(this.OnConnectionError);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered += new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft += new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerUpdated);
    ImiServices.Instance.VoiceChatService.OnUserMuted += new VoiceChatService.OnUserMutedEventHandler(this.OnUserMuted);
    this.ownPlayerObject.GetComponentInChildren<VoiceChatMuteButton>().SetPlayerID(ImiServices.Instance.LoginService.GetPlayerId());
    this.SetJoinedState(ImiServices.Instance.VoiceChatService.IsInVoiceChannel());
    this.ownPlayerObject.GetComponentInChildren<TextMeshProUGUI>().text = Contexts.sharedInstance.game.GetFirstLocalEntity().playerUsername.username;
    this.StartCoroutine(this.DelayedUpdateConnectedPlayersInterface());
    this.UpdateButtonMuteStates();
  }

  private void Update()
  {
    if (!this.waitingForTeam || !Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerChampionData || Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team == Team.None)
      return;
    ImiServices.Instance.VoiceChatService.LoginAndJoinVoiceChannel((int) Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value);
    this.waitingForTeam = false;
  }

  private void OnEnable()
  {
    this.micVolumeSlider.minValue = -100f;
    this.micVolumeSlider.maxValue = 100f;
    this.volumeSlider.minValue = -100f;
    this.volumeSlider.maxValue = 100f;
    this.masterVolumeSlider.minValue = 0.0f;
    this.masterVolumeSlider.maxValue = 100f;
    this.musicVolumeSlider.minValue = 0.0f;
    this.musicVolumeSlider.maxValue = 100f;
    this.sfxVolumeSlider.minValue = 0.0f;
    this.sfxVolumeSlider.maxValue = 100f;
    this.UpdateButtonMuteStates();
    this.UpdateConnectedPlayersInterface();
    this.LoadSliderValuesFromService();
  }

  private void OnDestroy()
  {
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered -= new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnEnterVC);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft -= new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLeaveVC);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerConnectingToVoiceChat -= new VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler(this.OnConnectingToVC);
    ImiServices.Instance.VoiceChatService.OnVoiceChatConnectionError -= new VoiceChatService.OnVoiceChatConnectionErrorEventHandler(this.OnConnectionError);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered -= new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft -= new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerUpdated);
    ImiServices.Instance.VoiceChatService.OnUserMuted -= new VoiceChatService.OnUserMutedEventHandler(this.OnUserMuted);
  }

  private void OnRemotePlayerUpdated(ulong playerId) => this.StartCoroutine(this.DelayedUpdateConnectedPlayersInterface());

  private void LoadSliderValuesFromService()
  {
    this.LoadAudioSettingsFromPlayerPrefs();
    VoiceChatSetting currentSetting = ImiServices.Instance.VoiceChatService.GetCurrentSetting();
    this.volumeSlider.value = (float) currentSetting.volume;
    this.micVolumeSlider.value = (float) currentSetting.micVolume;
  }

  public void OnVolumeSliderValueUpdated()
  {
    VoiceChatSetting currentSetting = ImiServices.Instance.VoiceChatService.GetCurrentSetting();
    currentSetting.volume = (int) this.volumeSlider.value;
    ImiServices.Instance.VoiceChatService.UpdateVCSettings(currentSetting);
    PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatVolumePref, currentSetting.volume);
  }

  public void OnMicVolumeSliderUpdate()
  {
    VoiceChatSetting currentSetting = ImiServices.Instance.VoiceChatService.GetCurrentSetting();
    currentSetting.micVolume = (int) this.micVolumeSlider.value;
    ImiServices.Instance.VoiceChatService.UpdateVCSettings(currentSetting);
    PlayerPrefs.SetInt(VoiceChatOptionsController.VoiceChatMicVolumePref, currentSetting.micVolume);
  }

  private void LoadAudioSettingsFromPlayerPrefs()
  {
    this.masterVolumeSlider.value = !PlayerPrefs.HasKey("MasterVolume") ? 100f : PlayerPrefs.GetFloat("MasterVolume");
    this.musicVolumeSlider.value = !PlayerPrefs.HasKey("MusicVolume") ? 100f : PlayerPrefs.GetFloat("MusicVolume");
    if (PlayerPrefs.HasKey("SFXVolume"))
      this.sfxVolumeSlider.value = PlayerPrefs.GetFloat("SFXVolume");
    else
      this.sfxVolumeSlider.value = 100f;
  }

  public void OnMasterVolumeSliderUpdate()
  {
    this.mixer.SetFloat("Master", AudioSettingsController.ConvertLinearToDecibel(this.masterVolumeSlider.value));
    PlayerPrefs.SetFloat("MasterVolume", this.masterVolumeSlider.value);
  }

  public void OnMusicVolumeSliderUpdate()
  {
    this.mixer.SetFloat("MUSIC", AudioSettingsController.ConvertLinearToDecibel(this.musicVolumeSlider.value));
    PlayerPrefs.SetFloat("MusicVolume", this.musicVolumeSlider.value);
  }

  public void OnSFXVolumeSliderUpdate()
  {
    this.mixer.SetFloat("SFX ALL", AudioSettingsController.ConvertLinearToDecibel(this.sfxVolumeSlider.value));
    PlayerPrefs.SetFloat("SFXVolume", this.sfxVolumeSlider.value);
  }

  private IEnumerator DelayedUpdateConnectedPlayersInterface()
  {
    this.player2Object.SetActive(false);
    this.player3Object.SetActive(false);
    yield return (object) null;
    this.UpdateConnectedPlayersInterface();
  }

  private void UpdateConnectedPlayersInterface()
  {
    if (!ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      return;
    IReadOnlyDictionary<string, IParticipant> participants = ImiServices.Instance.VoiceChatService.GetParticipants();
    if (participants == null)
    {
      Log.Error("VOICECHAT: Participants could not be found!");
      this.player2Object.SetActive(false);
      this.player3Object.SetActive(false);
    }
    else
    {
      Log.Debug("VOICECHAT: Getting Participants from VoiceChatService: ");
      this.player2id = 0UL;
      this.player3id = 0UL;
      foreach (IParticipant participant in (IEnumerable<IParticipant>) participants)
      {
        Log.Debug("VOICECHAT: Participant PlayerID: " + participant.Account.Name);
        ulong num = ulong.Parse(participant.Account.Name);
        if ((long) num != (long) ImiServices.Instance.LoginService.GetPlayerId())
        {
          if (this.player2id == 0UL)
          {
            this.player2id = num;
            this.player2NameText.text = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(num).playerUsername.username;
            this.player2Object.GetComponentInChildren<VoiceChatMuteButton>().SetPlayerID(num);
            this.player2Object.GetComponentInChildren<VoiceChatMuteButton>().SetMuteIcon(participant.LocalMute);
          }
          else if (this.player3id == 0UL)
          {
            this.player3id = num;
            this.player3NameText.text = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(num).playerUsername.username;
            this.player3Object.GetComponentInChildren<VoiceChatMuteButton>().SetPlayerID(num);
            this.player3Object.GetComponentInChildren<VoiceChatMuteButton>().SetMuteIcon(participant.LocalMute);
          }
          else
            Log.Error("VOICECHAT: Too many players in voicechat!");
        }
      }
      this.SetRemotePlayerButtons();
      this.UpdateButtonMuteStates();
    }
  }

  private void HidePlayerButtons()
  {
    this.ownPlayerObject.SetActive(false);
    this.player2Object.SetActive(false);
    this.player3Object.SetActive(false);
  }

  private void SetRemotePlayerButtons()
  {
    this.player2Object.SetActive(this.player2id > 0UL);
    if (this.player2id != 0UL)
      this.player2Object.GetComponentInChildren<TextMeshProUGUI>().text = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.player2id).playerUsername.username;
    this.player3Object.SetActive(this.player3id > 0UL);
    if (this.player3id == 0UL)
      return;
    this.player3Object.GetComponentInChildren<TextMeshProUGUI>().text = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.player3id).playerUsername.username;
  }

  public void JoinVCButtonAction()
  {
    if (!Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerChampionData || Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team == Team.None)
    {
      this.joinVCButton.interactable = false;
      this.waitingForTeam = true;
    }
    else if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      ImiServices.Instance.VoiceChatService.LeaveVoiceChannel();
    else if (CustomLobbyUi.isInitialized)
    {
      ImiServices.Instance.VoiceChatService.JoinVoiceChannel(ImiServices.Instance.PartyService.GetLobbyId());
    }
    else
    {
      if (!Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerTeam)
        return;
      ImiServices.Instance.VoiceChatService.LoginAndJoinVoiceChannel((int) Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value);
    }
  }

  public void MuteSelfButtonAction()
  {
    ImiServices.Instance.VoiceChatService.ToggleMute();
    if (ImiServices.Instance.VoiceChatService.GetMutedState())
      this.ownPlayerMuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.unMuteSelfButtonLoca);
    else
      this.ownPlayerMuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.muteSelfButtonLoca);
  }

  public void OnUserMuted(ulong playerId, bool muted) => this.UpdateButtonMuteStates();

  public void MutePlayer2ButtonAction() => ImiServices.Instance.VoiceChatService.SetUserMute(this.player2id.ToString(), !ImiServices.Instance.VoiceChatService.GetParticipant(this.player2id).LocalMute);

  public void MutePlayer3ButtonAction() => ImiServices.Instance.VoiceChatService.SetUserMute(this.player3id.ToString(), !ImiServices.Instance.VoiceChatService.GetParticipant(this.player3id).LocalMute);

  private void UpdateButtonMuteStates()
  {
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
    {
      if (ImiServices.Instance.VoiceChatService.GetMutedState())
        this.ownPlayerMuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.unMuteSelfButtonLoca);
      else
        this.ownPlayerMuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.muteSelfButtonLoca);
    }
    if (ImiServices.Instance.VoiceChatService.GetParticipant(this.player2id) != null)
    {
      if (ImiServices.Instance.VoiceChatService.GetParticipant(this.player2id).LocalMute)
        this.player2MuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.unmuteButtonLoca);
      else
        this.player2MuteButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(this.muteButtonLoca);
    }
    if (ImiServices.Instance.VoiceChatService.GetParticipant(this.player3id) == null)
      return;
    if (ImiServices.Instance.VoiceChatService.GetParticipant(this.player3id).LocalMute)
      this.player3MuteButton.GetComponentInChildren<TextMeshProUGUI>(true).text = ImiServices.Instance.LocaService.GetLocalizedValue(this.unmuteButtonLoca);
    else
      this.player3MuteButton.GetComponentInChildren<TextMeshProUGUI>(true).text = ImiServices.Instance.LocaService.GetLocalizedValue(this.muteButtonLoca);
  }

  private void OnConnectingToVC()
  {
    this.SetJoinedState(false);
    this.SetJoinText(this.connectingToVCLoca);
    this.joinVCButton.interactable = false;
  }

  private void OnConnectionError(string errorMsg)
  {
    this.SetJoinedState(false);
    this.joinVCButton.interactable = true;
  }

  private void OnEnterVC(string name)
  {
    this.SetJoinedState(true);
    this.StartCoroutine(this.DelayedUpdateConnectedPlayersInterface());
    this.joinVCButton.interactable = true;
  }

  private void OnLeaveVC(string name)
  {
    this.SetJoinedState(false);
    this.joinVCButton.interactable = true;
  }

  private void SetJoinedState(bool joined)
  {
    this.ownPlayerObject.SetActive(true);
    if (joined)
    {
      this.sliderObject.SetActive(true);
      this.SetJoinText(this.leavebuttonLoca);
      this.ownPlayerObject.SetActive(true);
      this.UpdateConnectedPlayersInterface();
    }
    else
    {
      this.sliderObject.SetActive(false);
      this.SetJoinText(this.joinButtonLoca);
      this.HidePlayerButtons();
    }
  }

  private void SetJoinText(string text) => this.joinVCButton.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(text);
}
