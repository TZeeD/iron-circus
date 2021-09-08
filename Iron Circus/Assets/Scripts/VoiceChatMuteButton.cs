// Decompiled with JetBrains decompiler
// Type: VoiceChatMuteButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[RequireComponent(typeof (Button))]
[RequireComponent(typeof (Image))]
public class VoiceChatMuteButton : 
  MonoBehaviour,
  ISubmitHandler,
  IEventSystemHandler,
  IPointerClickHandler
{
  private static readonly string talkingIconPath = "UI/voiceChat/voiceChat_playerTalking_icon_ui";
  private static readonly string mutedIconPath = "UI/voiceChat/voiceChat_playerMuted_icon_ui";
  private static readonly string silentIconPath = "UI/voiceChat/voiceChat_playerSilent_icon_ui";
  [SerializeField]
  private ulong playerId;

  private void Start()
  {
    this.GetComponent<Image>().sprite = UnityEngine.Resources.Load<Sprite>(VoiceChatMuteButton.silentIconPath);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered += new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnLocalPlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft += new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLocalPlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered += new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft += new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnPlayerStartSpeaking += new VoiceChatService.OnPlayerStartSpeakingEventHandler(this.OnStartSpeaking);
    ImiServices.Instance.VoiceChatService.OnPlayerStopSpeaking += new VoiceChatService.OnPlayerStopSpeakingEventHandler(this.OnStopSpeaking);
    ImiServices.Instance.VoiceChatService.OnUserMuted += new VoiceChatService.OnUserMutedEventHandler(this.OnUserMuted);
  }

  private void OnEnable() => this.UpdateButtonVisibility();

  private void OnDestroy()
  {
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered -= new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnLocalPlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft -= new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLocalPlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered -= new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft -= new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerVoiceChatStatusUpdated);
    ImiServices.Instance.VoiceChatService.OnPlayerStartSpeaking -= new VoiceChatService.OnPlayerStartSpeakingEventHandler(this.OnStartSpeaking);
    ImiServices.Instance.VoiceChatService.OnPlayerStopSpeaking -= new VoiceChatService.OnPlayerStopSpeakingEventHandler(this.OnStopSpeaking);
    ImiServices.Instance.VoiceChatService.OnUserMuted -= new VoiceChatService.OnUserMutedEventHandler(this.OnUserMuted);
  }

  public void OnSubmit(BaseEventData eventData) => this.OnMuteButtonClicked();

  public void OnPointerClick(PointerEventData eventData) => this.OnMuteButtonClicked();

  public void SetPlayerID(ulong playerId)
  {
    this.playerId = playerId;
    this.UpdateButtonVisibility();
  }

  public void OnRemotePlayerVoiceChatStatusUpdated(ulong playerId)
  {
    if ((long) playerId != (long) this.playerId)
      return;
    this.UpdateButtonVisibility();
  }

  public void OnLocalPlayerVoiceChatStatusUpdated(string name) => this.UpdateButtonVisibility();

  public IEnumerator DelayedUpdateButtonVisibility()
  {
    yield return (object) null;
    this.SetActive(false);
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel() && ImiServices.Instance.VoiceChatService.GetParticipant(this.playerId) != null)
    {
      this.SetActive(true);
      if ((long) this.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
      {
        if (ImiServices.Instance.VoiceChatService.GetMutedState())
          this.SetMuteIcon(true);
      }
      else if (ImiServices.Instance.VoiceChatService.GetParticipant(this.playerId).LocalMute)
        this.SetMuteIcon(true);
    }
  }

  public void UpdateButtonVisibility()
  {
    if (!this.gameObject.activeInHierarchy)
      return;
    this.StartCoroutine(this.DelayedUpdateButtonVisibility());
  }

  private void SetActive(bool active) => this.GetComponent<Image>().enabled = active;

  private void OnMuteButtonClicked()
  {
    if ((long) this.playerId == (long) ImiServices.Instance.LoginService.GetPlayerId())
      ImiServices.Instance.VoiceChatService.ToggleMute();
    else
      ImiServices.Instance.VoiceChatService.ToggleUserMute(this.playerId.ToString());
  }

  private void OnUserMuted(ulong playerId, bool muted)
  {
    if ((long) playerId != (long) this.playerId)
      return;
    this.SetMuteIcon(muted);
  }

  public void SetMuteIcon(bool mute)
  {
    if (mute)
      this.GetComponent<Image>().sprite = UnityEngine.Resources.Load<Sprite>(VoiceChatMuteButton.mutedIconPath);
    else
      this.GetComponent<Image>().sprite = UnityEngine.Resources.Load<Sprite>(VoiceChatMuteButton.silentIconPath);
  }

  public void OnStartSpeaking(ulong playerId)
  {
    if ((long) playerId != (long) this.playerId || ImiServices.Instance.VoiceChatService.GetMutedState(playerId))
      return;
    this.SetSpeakingIcon(VoiceChatMuteButton.talkingIconPath);
  }

  public void OnStopSpeaking(ulong playerId)
  {
    if ((long) playerId != (long) this.playerId || ImiServices.Instance.VoiceChatService.GetMutedState(playerId))
      return;
    this.SetSpeakingIcon(VoiceChatMuteButton.silentIconPath);
  }

  public void SetSpeakingIcon(string resourcePath) => this.GetComponent<Image>().sprite = UnityEngine.Resources.Load<Sprite>(resourcePath);
}
