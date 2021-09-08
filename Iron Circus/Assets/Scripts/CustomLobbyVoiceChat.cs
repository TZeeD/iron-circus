// Decompiled with JetBrains decompiler
// Type: CustomLobbyVoiceChat
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Steamworks;
using SteelCircus.Core.Services;
using System.Collections;
using UnityEngine;

public class CustomLobbyVoiceChat : MonoBehaviour
{
  private void Start()
  {
    if (CustomLobbyUi.isInitialized && ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      ImiServices.Instance.VoiceChatService.InvokeOnChannelJoined();
    ImiServices.Instance.PartyService.OnCustomLobbyLeft += new APartyService.OnCustomLobbyLeftEventHandler(this.OnLeaveLobby);
    ImiServices.Instance.PartyService.OnCustomLobbyEntered += new APartyService.OnCustomLobbyEnteredEventHandler(this.OnEnterLobby);
  }

  private void OnDestroy()
  {
    ImiServices.Instance.PartyService.OnCustomLobbyLeft -= new APartyService.OnCustomLobbyLeftEventHandler(this.OnLeaveLobby);
    ImiServices.Instance.PartyService.OnCustomLobbyEntered -= new APartyService.OnCustomLobbyEnteredEventHandler(this.OnEnterLobby);
  }

  private void OnEnterLobby()
  {
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel() || ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting != 0)
      return;
    if (ImiServices.Instance.PartyService.GetLobbyId() != CSteamID.Nil)
      ImiServices.Instance.VoiceChatService.JoinVoiceChannel(ImiServices.Instance.PartyService.GetLobbyId());
    else
      this.StartCoroutine(this.WaitForSteamGroupAndJoinVC());
  }

  public IEnumerator WaitForSteamGroupAndJoinVC()
  {
    do
    {
      yield return (object) null;
    }
    while (ImiServices.Instance.PartyService.GetLobbyId() == CSteamID.Nil);
    ImiServices.Instance.VoiceChatService.JoinVoiceChannel(ImiServices.Instance.PartyService.GetLobbyId());
  }

  private void OnEnterLobby(CSteamID steamId)
  {
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel() || ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting != 0)
      return;
    ImiServices.Instance.VoiceChatService.JoinVoiceChannel(steamId);
  }

  private void OnLeaveLobby()
  {
    ImiServices.Instance.VoiceChatService.InvokeOnChannelLeft();
    ImiServices.Instance.VoiceChatService.LeaveVoiceChannel();
  }
}
