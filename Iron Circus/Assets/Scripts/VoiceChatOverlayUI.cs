// Decompiled with JetBrains decompiler
// Type: VoiceChatOverlayUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using SharedWithServer.Utils.Extensions;
using SteelCircus.Core.Services;
using SteelCircus.UI;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class VoiceChatOverlayUI : MonoBehaviour
{
  private readonly string connectionErrorMsgLoca = "@VoiceChatConnectionError";
  private readonly string connectingMsg = "@ConnectingToVoiceChat";
  private readonly string connectToVCMsg = "@ConnectToVoiceChatBtn";
  private readonly string playersConnectedLoca = "@VoiceChatPlayersConnected";
  [SerializeField]
  private GameObject playerVCNamePrefab;
  [SerializeField]
  private GameObject playerVCContainerParent;
  [SerializeField]
  private GameObject connectionHelperTextObject;
  [SerializeField]
  private GameObject participantCountTextObject;
  [SerializeField]
  private GameObject joinButtonPrompt;
  [SerializeField]
  private GameObject pushToTalkPrompt;
  [SerializeField]
  private SwitchButtonSprite pushToTalkPromptSprite;
  [SerializeField]
  private TextMeshProUGUI pushToTalkPromtText;
  private List<PlayerVoiceChatInfo> playerSpeakingInfoObjects;
  private bool connecting;
  private bool connectionError;

  private void Start()
  {
    this.pushToTalkPromptSprite.actionType = !ImiServices.Instance.InputService.IsUsingSteamInput() ? DigitalInput.VoicePushToTalk : DigitalInput.UIVoicePushToTalk;
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      this.UpdateJoinedState();
    this.pushToTalkPromptSprite.SetSprite();
    this.connecting = false;
    this.ShowParticipantCount(false);
    this.ShowConnectionHelper(false, this.connectToVCMsg);
    this.ShowVoiceChatOverlay(false);
    this.pushToTalkPrompt.SetActive(false);
    this.playerSpeakingInfoObjects = new List<PlayerVoiceChatInfo>();
    this.pushToTalkPromtText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@PushToTalk") + ":";
    ImiServices.Instance.VoiceChatService.OnPlayerStartSpeaking += new VoiceChatService.OnPlayerStartSpeakingEventHandler(this.OnPlayerStartSpeaking);
    ImiServices.Instance.VoiceChatService.OnPlayerStopSpeaking += new VoiceChatService.OnPlayerStopSpeakingEventHandler(this.OnPlayerStopSpeaking);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered += new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnLocalPlayerJoinVoiceChat);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft += new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLocalPlayerLeaveVoiceChat);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerConnectingToVoiceChat += new VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler(this.OnConnectingToVC);
    ImiServices.Instance.VoiceChatService.OnVoiceChatConnectionError += new VoiceChatService.OnVoiceChatConnectionErrorEventHandler(this.OnConnectionError);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered += new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerJoinVoiceChat);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft += new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerLeaveVoiceChat);
    ImiServices.Instance.PartyService.OnCustomLobbyEntered += new APartyService.OnCustomLobbyEnteredEventHandler(this.OnCustomLobbyEntered);
    MenuController.Instance.EnteredMenuEvent.AddListener(new UnityAction(this.OnMainMenuEntered));
    SharedWithServer.ScEvents.Events.Global.OnEventMatchInfo += new SharedWithServer.ScEvents.Events.EventMatchInfo(this.OnJoinMatch);
    SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged += new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void OnDestroy()
  {
    ImiServices.Instance.VoiceChatService.OnPlayerStartSpeaking -= new VoiceChatService.OnPlayerStartSpeakingEventHandler(this.OnPlayerStartSpeaking);
    ImiServices.Instance.VoiceChatService.OnPlayerStopSpeaking -= new VoiceChatService.OnPlayerStopSpeakingEventHandler(this.OnPlayerStopSpeaking);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatEntered -= new VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler(this.OnLocalPlayerJoinVoiceChat);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerVoiceChatLeft -= new VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler(this.OnLocalPlayerLeaveVoiceChat);
    ImiServices.Instance.VoiceChatService.OnLocalPlayerConnectingToVoiceChat -= new VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler(this.OnConnectingToVC);
    ImiServices.Instance.VoiceChatService.OnVoiceChatConnectionError -= new VoiceChatService.OnVoiceChatConnectionErrorEventHandler(this.OnConnectionError);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatEntered -= new VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler(this.OnRemotePlayerJoinVoiceChat);
    ImiServices.Instance.VoiceChatService.OnRemotePlayerVoiceChatLeft -= new VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler(this.OnRemotePlayerLeaveVoiceChat);
    ImiServices.Instance.PartyService.OnCustomLobbyEntered -= new APartyService.OnCustomLobbyEnteredEventHandler(this.OnCustomLobbyEntered);
    MenuController.Instance.EnteredMenuEvent.RemoveListener(new UnityAction(this.OnMainMenuEntered));
    SharedWithServer.ScEvents.Events.Global.OnEventMatchInfo -= new SharedWithServer.ScEvents.Events.EventMatchInfo(this.OnJoinMatch);
    SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged -= new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
  }

  private void Update()
  {
    if (!this.connectionHelperTextObject.activeInHierarchy || !ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIMatchMakingLeave))
      return;
    this.JoinMatchVoiceChatButton();
  }

  private void OnMainMenuEntered()
  {
    if (!((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.mainMenuPanel) && !((Object) MenuController.Instance.currentMenu == (Object) MenuController.Instance.playMenu) || CustomLobbyUi.isInitialized)
      return;
    if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      ImiServices.Instance.VoiceChatService.LeaveVoiceChannel();
    this.OnLocalPlayerLeaveVoiceChat("");
  }

  private void OnCustomLobbyEntered()
  {
    if (ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting == 2)
    {
      this.ShowVoiceChatOverlay(false);
    }
    else
    {
      this.ShowVoiceChatOverlay(true);
      if (ImiServices.Instance.VoiceChatService.IsInVoiceChannel())
      {
        ImiServices.Instance.VoiceChatService.InvokeOnChannelJoined();
        this.UpdateChannelMemberCount();
      }
      else
      {
        if (ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting != 1)
          return;
        this.ShowParticipantCount(false);
        this.ShowConnectionHelper(true, this.connectToVCMsg);
        this.joinButtonPrompt.SetActive(true);
        this.pushToTalkPrompt.SetActive(false);
        this.connectionError = false;
        this.connecting = false;
      }
    }
  }

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    this.UpdateChannelMemberCount();
    if (matchState != Imi.SharedWithServer.Game.MatchState.Intro)
      return;
    this.ShowVoiceChatOverlay(ImiServices.Instance.VoiceChatService.IsInVoiceChannel());
    this.pushToTalkPromptSprite.actionType = DigitalInput.VoicePushToTalk;
    this.pushToTalkPromptSprite.SetSprite();
  }

  private void OnConnectingToVC()
  {
    this.connectionError = false;
    this.connecting = true;
    this.pushToTalkPrompt.SetActive(false);
    this.ShowVoiceChatOverlay(true);
    this.ShowParticipantCount(false);
    this.ShowConnectionHelper(true, this.connectingMsg);
    this.joinButtonPrompt.SetActive(false);
  }

  private void OnConnectionError(string errorMsg)
  {
    this.connectionError = true;
    this.ShowConnectionHelper(true, this.connectionErrorMsgLoca);
  }

  public void JoinMatchVoiceChatButton()
  {
    if (this.connectionError)
    {
      this.ShowConnectionHelper(false);
    }
    else
    {
      if (this.connecting)
        return;
      if (CustomLobbyUi.isInitialized)
      {
        ImiServices.Instance.VoiceChatService.JoinVoiceChannel(ImiServices.Instance.PartyService.GetLobbyId());
      }
      else
      {
        if (!Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerChampionData)
          return;
        ImiServices.Instance.VoiceChatService.LoginAndJoinVoiceChannel((int) Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team);
      }
    }
  }

  public void UpdateJoinedState()
  {
    this.ShowVoiceChatOverlay(true);
    this.ShowConnectionHelper(false);
    this.ShowParticipantCount(true);
    this.StartCoroutine(this.DelayedUpdateChannelMemberCount());
    if (ImiServices.Instance.VoiceChatService.GetCurrentSetting().pushToTalkSetting == 1)
      this.pushToTalkPrompt.SetActive(true);
    else
      this.pushToTalkPrompt.SetActive(false);
  }

  public void OnLocalPlayerJoinVoiceChat(string name) => this.UpdateJoinedState();

  public void OnLocalPlayerLeaveVoiceChat(string name)
  {
    this.connecting = false;
    this.pushToTalkPrompt.SetActive(false);
    this.ClearSpeakingInfoObjects();
    this.ShowConnectionHelper(true);
    this.ShowParticipantCount(false);
    this.ShowVoiceChatOverlay(false);
  }

  private void ClearSpeakingInfoObjects()
  {
    foreach (PlayerVoiceChatInfo speakingInfoObject in this.playerSpeakingInfoObjects)
      Object.Destroy((Object) speakingInfoObject.infoObject);
    this.playerSpeakingInfoObjects = new List<PlayerVoiceChatInfo>();
  }

  private void OnRemotePlayerJoinVoiceChat(ulong playerId) => this.UpdateChannelMemberCount();

  private void OnRemotePlayerLeaveVoiceChat(ulong playerId) => this.StartCoroutine(this.DelayedUpdateChannelMemberCount());

  private IEnumerator DelayedUpdateChannelMemberCount()
  {
    yield return (object) null;
    this.UpdateChannelMemberCount();
  }

  private void UpdateChannelMemberCount()
  {
    Log.Debug("VOICECHAT: Updating player count interface: " + (object) ImiServices.Instance.VoiceChatService.GetNumberOfParticipants());
    if (CustomLobbyUi.isInitialized)
      this.participantCountTextObject.GetComponent<TextMeshProUGUI>().text = string.Format("{0}: {1}", (object) ImiServices.Instance.LocaService.GetLocalizedValue(this.playersConnectedLoca), (object) ImiServices.Instance.VoiceChatService.GetNumberOfParticipants());
    else
      this.participantCountTextObject.GetComponent<TextMeshProUGUI>().text = string.Format("{0}: ({1}/3)", (object) ImiServices.Instance.LocaService.GetLocalizedValue(this.playersConnectedLoca), (object) ImiServices.Instance.VoiceChatService.GetNumberOfParticipants());
  }

  private void ShowParticipantCount(bool show) => this.participantCountTextObject.SetActive(show);

  private void ShowConnectionHelper(bool show, string text = "")
  {
    if (!text.IsNullOrEmpty())
      this.connectionHelperTextObject.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue(text);
    this.connectionHelperTextObject.SetActive(show);
  }

  private void ShowVoiceChatOverlay(bool show)
  {
    if (!((Object) this.playerVCContainerParent != (Object) null))
      return;
    this.playerVCContainerParent.SetActive(show);
  }

  public void OnJoinMatch(string arena, string matchId, GameType gameType)
  {
    if (gameType.IsCustomMatch())
      return;
    if (gameType.IsPlayground() || gameType.IsBasicTraining() || gameType.IsAdvancedTraining() || ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting == 2)
    {
      this.ShowVoiceChatOverlay(false);
    }
    else
    {
      this.ShowVoiceChatOverlay(true);
      if (ImiServices.Instance.VoiceChatService.GetCurrentSetting().autoJoinSetting == 1)
      {
        this.ShowParticipantCount(false);
        this.ShowConnectionHelper(true);
      }
      else
      {
        this.ShowParticipantCount(false);
        this.ShowConnectionHelper(false);
      }
    }
  }

  public void OnPlayerStartSpeaking(ulong playerId)
  {
    GameObject gameObject = (GameObject) null;
    foreach (PlayerVoiceChatInfo speakingInfoObject in this.playerSpeakingInfoObjects)
    {
      if (speakingInfoObject != null && (long) speakingInfoObject.playerId == (long) playerId)
        gameObject = speakingInfoObject.infoObject;
    }
    if (!((Object) gameObject == (Object) null))
      return;
    GameObject infoObject = Object.Instantiate<GameObject>(this.playerVCNamePrefab, this.playerVCContainerParent.transform, false);
    bool flag = false;
    infoObject.GetComponent<RectTransform>().SetAsFirstSibling();
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
    if (entityWithPlayerId == null || !entityWithPlayerId.hasPlayerUsername || entityWithPlayerId.playerUsername.username.IsNullOrEmpty())
    {
      APartyService.GroupMember groupMember;
      try
      {
        groupMember = ImiServices.Instance.PartyService.GetGroupMember(playerId);
      }
      catch (ImiException ex)
      {
        Log.Error(string.Format("Exception when trying to access group member ({0}): {1}", (object) playerId, (object) ex.Message));
        groupMember = (APartyService.GroupMember) null;
      }
      if (groupMember != null)
      {
        infoObject.GetComponent<TextMeshProUGUI>().text = groupMember.username;
      }
      else
      {
        flag = true;
        infoObject.GetComponent<TextMeshProUGUI>().text = string.Format("UsernameError ({0})", (object) playerId);
      }
    }
    else if (entityWithPlayerId.hasChampionConfig)
      infoObject.GetComponent<TextMeshProUGUI>().text = entityWithPlayerId.playerUsername.username + " [" + ImiServices.Instance.LocaService.GetLocalizedValue("@" + entityWithPlayerId.championConfig.value.displayName) + "]";
    else
      infoObject.GetComponent<TextMeshProUGUI>().text = entityWithPlayerId.playerUsername.username;
    if (!flag)
      this.playerSpeakingInfoObjects.Add(new PlayerVoiceChatInfo(infoObject, playerId));
    else
      Object.Destroy((Object) infoObject);
  }

  public void OnPlayerStopSpeaking(ulong playerId)
  {
    PlayerVoiceChatInfo playerVoiceChatInfo = (PlayerVoiceChatInfo) null;
    foreach (PlayerVoiceChatInfo speakingInfoObject in this.playerSpeakingInfoObjects)
    {
      if (speakingInfoObject != null && (long) speakingInfoObject.playerId == (long) playerId)
      {
        Object.Destroy((Object) speakingInfoObject.infoObject);
        playerVoiceChatInfo = speakingInfoObject;
      }
    }
    if (playerVoiceChatInfo == null)
      return;
    this.playerSpeakingInfoObjects.Remove(playerVoiceChatInfo);
  }
}
