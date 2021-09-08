// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.VoiceChatService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.UI.Network;
using Newtonsoft.Json.Linq;
using SharedWithServer.ScEvents;
using SharedWithServer.Utils.Extensions;
using Steamworks;
using SteelCircus.UI.OptionsUI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using VivoxUnity;

namespace SteelCircus.Core.Services
{
  public class VoiceChatService
  {
    private Client client;
    private ILoginSession vivoxLoginSession;
    private ImiServicesHelper imiHelper;
    private bool muted;
    private bool pushToTalkPressed;
    private bool connecting;
    private bool waitForConnection;
    private VoiceChatSetting vcSettings;
    private IChannelSession currentChannelSession;
    public static readonly string TOKEN_ISSUER = "imi-scvoice-w";
    public static readonly string SERVER_URI = "https://mt1p.www.vivox.com/api2";
    public static readonly string TOKEN_DOMAIN = "mt1p.vivox.com";
    private ChannelId scTestChannelID;
    private AccountId vivoxAccountID;
    private bool waitForPlayerTeam;

    public event VoiceChatService.OnPlayerStartSpeakingEventHandler OnPlayerStartSpeaking;

    public event VoiceChatService.OnPlayerStopSpeakingEventHandler OnPlayerStopSpeaking;

    public event VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler OnLocalPlayerVoiceChatEntered;

    public event VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler OnLocalPlayerVoiceChatLeft;

    public event VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler OnLocalPlayerConnectingToVoiceChat;

    public event VoiceChatService.OnVoiceChatConnectionErrorEventHandler OnVoiceChatConnectionError;

    public event VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler OnRemotePlayerVoiceChatEntered;

    public event VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler OnRemotePlayerVoiceChatLeft;

    public event VoiceChatService.OnUserMutedEventHandler OnUserMuted;

    public bool IsInVoiceChannel() => this.currentChannelSession != null;

    public IChannelSession GetChannelSession() => this.IsInVoiceChannel() ? this.currentChannelSession : (IChannelSession) null;

    public void InvokeOnChannelJoined()
    {
      VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler voiceChatEntered = this.OnLocalPlayerVoiceChatEntered;
      if (voiceChatEntered == null)
        return;
      voiceChatEntered(this.currentChannelSession.Key.Name);
    }

    public void InvokeOnChannelLeft()
    {
      VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler playerVoiceChatLeft = this.OnLocalPlayerVoiceChatLeft;
      if (playerVoiceChatLeft == null)
        return;
      playerVoiceChatLeft("");
    }

    public LoginState GetVoiceChannelConnectionState() => this.vivoxLoginSession.State;

    public VoiceChatService(ImiServicesHelper imiHelper)
    {
      this.imiHelper = imiHelper;
      imiHelper.UpdateEvent += new Action(this.OnUpdate);
      imiHelper.ApplicationQuitEvent += new Action(this.Uninitialize);
      ImiServices.Instance.OnMetaLoginSuccessful += new ImiServices.OnMetaLoginSuccessfulEventHandler(this.ConnectToVoiceChatService);
    }

    public void ConnectToVoiceChatService(ulong playerId) => Events.Global.OnEventMatchInfo += new Events.EventMatchInfo(this.OnJoinGame);

    public string GetVoiceChatInfo() => "Muted: " + this.GetMutedState().ToString() + "\nVolume:" + (object) this.client.AudioInputDevices.VolumeAdjustment + "/" + (object) this.client.AudioOutputDevices.VolumeAdjustment;

    private void InitializeSCVivoxClient()
    {
      this.vivoxLoginSession.PropertyChanged += new PropertyChangedEventHandler(this.VivoxLoginStateChanged);
      this.ApplyVolumeSettings();
    }

    public void OnUpdate()
    {
      if (this.waitForConnection && this.IsInVoiceChannel())
      {
        this.connecting = false;
        this.LeaveVoiceChannel();
        this.waitForConnection = false;
      }
      if (this.waitForPlayerTeam && Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerChampionData && Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team != Team.None)
      {
        this.waitForPlayerTeam = false;
        this.OnGetPlayerTeam((int) Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team);
      }
      if (this.client == null)
        return;
      if (this.vivoxLoginSession != null)
        this.RunClient();
      if (ImiServices.Instance.InputService.GetButtonDown(DigitalInput.VoicePushToTalk) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIVoicePushToTalk) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIMatchMakingLeave))
        this.pushToTalkPressed = true;
      if (ImiServices.Instance.InputService.GetButtonUp(DigitalInput.VoicePushToTalk) || ImiServices.Instance.InputService.GetButtonUp(DigitalInput.UIVoicePushToTalk) || ImiServices.Instance.InputService.GetButtonUp(DigitalInput.UIMatchMakingLeave))
        this.pushToTalkPressed = false;
      if (this.currentChannelSession == null)
        return;
      if (ImiServices.Instance.InputService.GetButtonDown(DigitalInput.VoiceMute) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.UIVoiceMute))
      {
        this.muted = !this.muted;
        VoiceChatService.OnUserMutedEventHandler onUserMuted = this.OnUserMuted;
        if (onUserMuted != null)
          onUserMuted(ImiServices.Instance.LoginService.GetPlayerId(), this.muted);
        Log.Debug("VOICECHAT: MUTED AUDIO: " + this.muted.ToString());
      }
      bool flag = this.client.AudioInputDevices.VolumeAdjustment < -12 || this.muted || this.vcSettings.pushToTalkSetting == 1 && !this.pushToTalkPressed;
      if (this.client.AudioInputDevices.Muted == flag)
        return;
      this.client.AudioInputDevices.Muted = flag;
    }

    public void RunClient() => Client.RunOnce();

    public void UpdateVCSettings(VoiceChatSetting newSetting)
    {
      this.vcSettings = newSetting;
      if (this.client == null)
        return;
      this.ApplyVolumeSettings();
    }

    private void ApplyVolumeSettings()
    {
      this.AdjustVolume(this.client.AudioInputDevices, this.vcSettings.micVolume);
      this.AdjustVolume(this.client.AudioOutputDevices, this.vcSettings.volume);
    }

    public VoiceChatSetting GetCurrentSetting() => this.vcSettings;

    private void AdjustVolume(IAudioDevices outputDevices, int volumeSetting)
    {
      int audioLevel = volumeSetting / 6 + 6;
      if (volumeSetting < -99)
        audioLevel = -50;
      outputDevices.BeginRefresh((AsyncCallback) (result => outputDevices.VolumeAdjustment = audioLevel));
    }

    public void ToggleMute() => this.SetMute(!this.muted);

    public void SetMute(bool mute)
    {
      VoiceChatService.OnUserMutedEventHandler onUserMuted = this.OnUserMuted;
      if (onUserMuted != null)
        onUserMuted(ImiServices.Instance.LoginService.GetPlayerId(), mute);
      this.muted = mute;
    }

    public bool GetMutedState(ulong playerId = 0)
    {
      if (playerId == 0UL)
        return this.muted;
      IParticipant participant = this.currentChannelSession.Participants.FirstOrDefault<IParticipant>((Func<IParticipant, bool>) (p => p.Account.Name == playerId.ToString()));
      return participant != null && participant.LocalMute;
    }

    public int GetNumberOfParticipants() => this.currentChannelSession != null ? this.currentChannelSession.Participants.Count : 0;

    public IReadOnlyDictionary<string, IParticipant> GetParticipants() => this.currentChannelSession != null ? this.currentChannelSession.Participants : (IReadOnlyDictionary<string, IParticipant>) null;

    public IParticipant GetParticipant(ulong playerID)
    {
      bool flag = false;
      if (this.currentChannelSession == null)
        return (IParticipant) null;
      foreach (IParticipant participant in (IEnumerable<IParticipant>) this.currentChannelSession.Participants)
      {
        if (participant.Account.Name == playerID.ToString())
          flag = true;
      }
      return flag ? this.currentChannelSession.Participants.FirstOrDefault<IParticipant>((Func<IParticipant, bool>) (p => p.Account.Name == playerID.ToString())) : (IParticipant) null;
    }

    public bool ToggleUserMute(string username)
    {
      IParticipant participant = this.currentChannelSession.Participants.FirstOrDefault<IParticipant>((Func<IParticipant, bool>) (p => p.Account.Name == username));
      if (participant == null)
        return false;
      bool localMute = participant.LocalMute;
      return this.SetUserMute(username, !localMute);
    }

    public bool SetUserMute(string username, bool mute)
    {
      if (this.vivoxLoginSession == null || this.currentChannelSession == null)
        return false;
      this.client.GetLoginSession(this.vivoxAccountID);
      IParticipant participant = this.currentChannelSession.Participants.FirstOrDefault<IParticipant>((Func<IParticipant, bool>) (p => p.Account.Name == username));
      if (participant == null)
        return false;
      participant.LocalMute = mute;
      VoiceChatService.OnUserMutedEventHandler onUserMuted = this.OnUserMuted;
      if (onUserMuted != null)
        onUserMuted(ulong.Parse(username), mute);
      return true;
    }

    public void OnJoinGame(string arena, string matchId, GameType gameType)
    {
      if ((gameType.IsPlayground() || gameType.IsCustomMatch() || gameType.IsBasicTraining() ? 0 : (!gameType.IsAdvancedTraining() ? 1 : 0)) == 0)
        return;
      if (Contexts.sharedInstance.game.GetFirstLocalEntity().hasPlayerTeam)
        this.OnGetPlayerTeam((int) Contexts.sharedInstance.game.GetFirstLocalEntity().playerTeam.value);
      else
        this.waitForPlayerTeam = true;
    }

    private void OnGetPlayerTeam(int team)
    {
      if (this.vcSettings.autoJoinSetting != 0)
        return;
      this.LoginAndJoinVoiceChannel(team);
    }

    public void LoginAndJoinVoiceChannel(string customChannelName)
    {
      this.CheckAndInitializeClient();
      this.connecting = true;
      if (this.vivoxLoginSession == null || this.vivoxLoginSession.State == LoginState.LoggedOut)
      {
        this.RequestLoginToken(new Action<JObject>(this.LoginToVivox));
        this.imiHelper.StartCoroutine(this.JoinChannelAfterLogin(customChannelName));
        VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler connectingToVoiceChat = this.OnLocalPlayerConnectingToVoiceChat;
        if (connectingToVoiceChat == null)
          return;
        connectingToVoiceChat();
      }
      else
        this.RequestJoinVoiceChannelToken(customChannelName, new Action<JObject>(this.JoinVoiceChannel));
    }

    public void LoginAndJoinVoiceChannel(int team)
    {
      this.CheckAndInitializeClient();
      this.connecting = true;
      if (this.vivoxLoginSession == null || this.vivoxLoginSession.State == LoginState.LoggedOut)
      {
        this.RequestLoginToken(new Action<JObject>(this.LoginToVivox));
        this.imiHelper.StartCoroutine(this.JoinChannelAfterLogin(team));
        VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler connectingToVoiceChat = this.OnLocalPlayerConnectingToVoiceChat;
        if (connectingToVoiceChat == null)
          return;
        connectingToVoiceChat();
      }
      else
        this.RequestJoinVoiceChannelToken(team, new Action<JObject>(this.JoinVoiceChannel));
    }

    private void CheckAndInitializeClient()
    {
      if (this.client != null)
        return;
      this.client = new Client();
      try
      {
        this.client.Initialize(0);
      }
      catch (VivoxApiException ex)
      {
        VoiceChatService.OnVoiceChatConnectionErrorEventHandler chatConnectionError = this.OnVoiceChatConnectionError;
        if (chatConnectionError != null)
          chatConnectionError("VOICECHAT: initialization Error");
        Log.Error("VOICECHAT: initialization Error: " + (object) ex);
      }
    }

    public IEnumerator JoinChannelAfterLogin(string customChannel)
    {
      VoiceChatService voiceChatService = this;
      do
      {
        yield return (object) null;
      }
      while (voiceChatService.vivoxLoginSession == null || voiceChatService.vivoxLoginSession.State != LoginState.LoggedIn);
      voiceChatService.RequestJoinVoiceChannelToken(customChannel, new Action<JObject>(voiceChatService.JoinVoiceChannel));
    }

    public IEnumerator JoinChannelAfterLogin(int team)
    {
      VoiceChatService voiceChatService = this;
      do
      {
        yield return (object) null;
      }
      while (voiceChatService.vivoxLoginSession == null || voiceChatService.vivoxLoginSession.State != LoginState.LoggedIn);
      voiceChatService.RequestJoinVoiceChannelToken(team, new Action<JObject>(voiceChatService.JoinVoiceChannel));
    }

    private void RequestJoinVoiceChannelToken(int team, Action<JObject> onSuccess)
    {
      if (Contexts.sharedInstance.meta.hasMetaMatch && !Contexts.sharedInstance.meta.metaMatch.gameSessionId.IsNullOrEmpty())
      {
        this.RequestJoinVoiceChannelToken(Contexts.sharedInstance.meta.metaMatch.gameSessionId.Replace("/", "A").Replace(":", "A").Replace("-", "A") + team.ToString(), onSuccess);
      }
      else
      {
        VoiceChatService.OnVoiceChatConnectionErrorEventHandler chatConnectionError = this.OnVoiceChatConnectionError;
        if (chatConnectionError != null)
          chatConnectionError("VOICECHAT: Error: Cannot find match id. Cannot connect to vivox server");
        Log.Error("VOICECHAT: Error: Cannot find match id. Cannot connect to vivox server");
      }
    }

    private void RequestJoinVoiceChannelToken(string channelName, Action<JObject> onSuccess)
    {
      this.scTestChannelID = new ChannelId(VoiceChatService.TOKEN_ISSUER, channelName, VoiceChatService.TOKEN_DOMAIN);
      this.currentChannelSession = this.vivoxLoginSession.GetChannelSession(this.scTestChannelID);
      SingletonManager<MetaServiceHelpers>.Instance.StartVoiceChatTokenCoroutine(new JObject()
      {
        ["iss"] = (JToken) VoiceChatService.TOKEN_ISSUER,
        ["exp"] = (JToken) "",
        ["vxa"] = (JToken) "join",
        ["vxi"] = (JToken) "",
        ["f"] = (JToken) ("sip:." + VoiceChatService.TOKEN_ISSUER + "." + (object) ImiServices.Instance.LoginService.GetPlayerId() + ".@" + VoiceChatService.TOKEN_DOMAIN),
        ["t"] = (JToken) ("sip:confctl-g-" + VoiceChatService.TOKEN_ISSUER + "." + channelName + "@" + VoiceChatService.TOKEN_DOMAIN)
      }, onSuccess, new Action<JObject>(this.OnTokenError));
    }

    public void JoinVoiceChannel(CSteamID steamGroup) => this.LoginAndJoinVoiceChannel(steamGroup.ToString());

    public void JoinVoiceChannel(JObject token)
    {
      if (token["error"] != null || token["msg"] != null || token[nameof (token)] == null)
        this.OnTokenError(token);
      else
        this.JoinVoiceChannel(token[nameof (token)].ToString());
    }

    public void JoinVoiceChannel(string token)
    {
      if (this.currentChannelSession == null)
        return;
      this.currentChannelSession.PropertyChanged += new PropertyChangedEventHandler(this.OnChannelPropertyChanged);
      this.currentChannelSession.Participants.AfterValueUpdated += new EventHandler<ValueEventArg<string, IParticipant>>(this.OnUserVoiceInputStateChanged);
      this.currentChannelSession.Participants.AfterKeyAdded += new EventHandler<KeyEventArg<string>>(this.OnRemoteUserJoinedChannel);
      this.currentChannelSession.Participants.BeforeKeyRemoved += new EventHandler<KeyEventArg<string>>(this.OnRemoteUserLeftChannel);
      Log.Debug("VOICECHAT: Trying To Connect to Voice Channel");
      this.currentChannelSession.BeginConnect(true, false, TransmitPolicy.Yes, token, (AsyncCallback) (ar =>
      {
        try
        {
          this.currentChannelSession.EndConnect(ar);
        }
        catch (Exception ex)
        {
          Log.Error(ex.ToString());
          VoiceChatService.OnVoiceChatConnectionErrorEventHandler chatConnectionError = this.OnVoiceChatConnectionError;
          if (chatConnectionError == null)
            return;
          chatConnectionError(ex.ToString());
          return;
        }
        Log.Debug("VOICECHAT: Connecting to VoiceChannel");
      }));
    }

    private void OnUserVoiceInputStateChanged(
      object sender,
      ValueEventArg<string, IParticipant> eventArg)
    {
      string name = eventArg.Value.Account.Name;
      ChannelId key = eventArg.Value.ParentChannelSession.Key;
      string propertyName = eventArg.PropertyName;
      Log.Debug("VOICECHAT: VoiceChat Participant event: " + propertyName);
      if (!(propertyName == "AudioEnergy"))
        return;
      IParticipantProperties participantProperties = (IParticipantProperties) eventArg.Value;
      if (participantProperties.AudioEnergy > 0.300000011920929)
      {
        VoiceChatService.OnPlayerStartSpeakingEventHandler playerStartSpeaking = this.OnPlayerStartSpeaking;
        if (playerStartSpeaking != null)
          playerStartSpeaking(ulong.Parse(name));
      }
      else
      {
        VoiceChatService.OnPlayerStopSpeakingEventHandler playerStopSpeaking = this.OnPlayerStopSpeaking;
        if (playerStopSpeaking != null)
          playerStopSpeaking(ulong.Parse(name));
      }
      Log.Debug("VOICECHAT: " + name + " - Audio Level:" + (object) participantProperties.AudioEnergy);
    }

    private void OnRemoteUserJoinedChannel(object sender, KeyEventArg<string> eventArg)
    {
      string key = eventArg.Key;
      Log.Debug("VOICECHAT: Remote Participant joined: " + key);
      string s = key.Replace("sip:." + VoiceChatService.TOKEN_ISSUER + ".", "").Replace(".@" + VoiceChatService.TOKEN_DOMAIN, "");
      VoiceChatService.OnRemotePlayerVoiceChatEnteredEventHandler voiceChatEntered = this.OnRemotePlayerVoiceChatEntered;
      if (voiceChatEntered == null)
        return;
      voiceChatEntered(ulong.Parse(s));
    }

    private void OnRemoteUserLeftChannel(object sender, KeyEventArg<string> eventArg)
    {
      string s = eventArg.Key.Replace("sip:." + VoiceChatService.TOKEN_ISSUER + ".", "").Replace(".@" + VoiceChatService.TOKEN_DOMAIN, "");
      Log.Debug("VOICECHAT: Remote Participant left: " + s);
      VoiceChatService.OnRemotePlayerVoiceChatLeftEventHandler playerVoiceChatLeft = this.OnRemotePlayerVoiceChatLeft;
      if (playerVoiceChatLeft == null)
        return;
      playerVoiceChatLeft(ulong.Parse(s));
    }

    public void LeaveVoiceChannel()
    {
      if (this.connecting)
      {
        this.waitForConnection = true;
      }
      else
      {
        if (this.scTestChannelID == null)
          return;
        Log.Debug("VOICECHAT: Attempting to leave Voice Channel");
        if (this.currentChannelSession == null)
          return;
        foreach (IChannelSession channelSession in (IEnumerable<IChannelSession>) this.vivoxLoginSession.ChannelSessions)
          channelSession.Disconnect();
        this.vivoxLoginSession.DeleteChannelSession(this.scTestChannelID);
        this.currentChannelSession.Participants.AfterValueUpdated -= new EventHandler<ValueEventArg<string, IParticipant>>(this.OnUserVoiceInputStateChanged);
        this.currentChannelSession.Participants.AfterKeyAdded -= new EventHandler<KeyEventArg<string>>(this.OnRemoteUserJoinedChannel);
        this.currentChannelSession.Participants.BeforeKeyRemoved += new EventHandler<KeyEventArg<string>>(this.OnRemoteUserLeftChannel);
        this.currentChannelSession.PropertyChanged -= new PropertyChangedEventHandler(this.OnChannelPropertyChanged);
        this.currentChannelSession = (IChannelSession) null;
      }
    }

    private void OnChannelPropertyChanged(object sender, PropertyChangedEventArgs eventArgs)
    {
      IChannelSession channelSession = (IChannelSession) sender;
      if (!(eventArgs.PropertyName == "AudioState"))
        return;
      switch (channelSession.AudioState)
      {
        case ConnectionState.Disconnected:
          Log.Debug("VOICECHAT: Audio disconnected in " + channelSession.Key.Name);
          this.connecting = false;
          break;
        case ConnectionState.Connecting:
          Log.Debug("VOICECHAT: Audio connecting in " + channelSession.Key.Name);
          VoiceChatService.OnLocalPlayerConnectingToVoiceChatEventHandler connectingToVoiceChat = this.OnLocalPlayerConnectingToVoiceChat;
          if (connectingToVoiceChat != null)
            connectingToVoiceChat();
          this.connecting = true;
          break;
        case ConnectionState.Connected:
          Log.Debug("VOICECHAT: Audio connected in " + channelSession.Key.Name);
          VoiceChatService.OnLocalPlayerVoiceChatEnteredEventHandler voiceChatEntered = this.OnLocalPlayerVoiceChatEntered;
          if (voiceChatEntered != null)
            voiceChatEntered(channelSession.Key.Name);
          this.connecting = false;
          break;
        case ConnectionState.Disconnecting:
          Log.Debug("VOICECHAT: Audio disconnecting in " + channelSession.Key.Name);
          VoiceChatService.OnLocalPlayerVoiceChatLeftEventHandler playerVoiceChatLeft = this.OnLocalPlayerVoiceChatLeft;
          if (playerVoiceChatLeft != null)
            playerVoiceChatLeft(channelSession.Key.Name);
          this.connecting = false;
          break;
      }
    }

    private void OnTokenError(JObject token)
    {
      Log.Error("VOICECHAT: Error getting VoiceChat connect token.");
      VoiceChatService.OnVoiceChatConnectionErrorEventHandler chatConnectionError = this.OnVoiceChatConnectionError;
      if (chatConnectionError == null)
        return;
      chatConnectionError("VOICECHAT: Error getting VoiceChat connect token.");
    }

    public void RequestLoginToken(Action<JObject> onSuccess) => SingletonManager<MetaServiceHelpers>.Instance.StartVoiceChatTokenCoroutine(new JObject()
    {
      ["iss"] = (JToken) VoiceChatService.TOKEN_ISSUER,
      ["exp"] = (JToken) "",
      ["vxa"] = (JToken) "login",
      ["vxi"] = (JToken) "",
      ["f"] = (JToken) ("sip:." + VoiceChatService.TOKEN_ISSUER + "." + (object) ImiServices.Instance.LoginService.GetPlayerId() + ".@" + VoiceChatService.TOKEN_DOMAIN)
    }, onSuccess, new Action<JObject>(this.OnTokenError));

    public void LoginToVivox(JObject token)
    {
      if (token["error"] != null || token["msg"] != null || token[nameof (token)] == null)
        this.OnTokenError(token);
      else
        this.LoginToVivox(token[nameof (token)].ToString());
    }

    public void LoginToVivox(string token)
    {
      this.vivoxAccountID = new AccountId(VoiceChatService.TOKEN_ISSUER, ImiServices.Instance.LoginService.GetPlayerId().ToString(), VoiceChatService.TOKEN_DOMAIN);
      this.vivoxLoginSession = this.client.GetLoginSession(this.vivoxAccountID);
      this.vivoxLoginSession.BeginLogin(new Uri(VoiceChatService.SERVER_URI), token, (AsyncCallback) (ar =>
      {
        Log.Debug("VOICECHAT: Attempting to Log in to Vivox");
        try
        {
          this.vivoxLoginSession.EndLogin(ar);
        }
        catch (Exception ex)
        {
          Log.Error(ex.ToString());
          VoiceChatService.OnVoiceChatConnectionErrorEventHandler chatConnectionError = this.OnVoiceChatConnectionError;
          if (chatConnectionError == null)
            return;
          chatConnectionError(ex.ToString());
          return;
        }
        this.EndLoginToVivox();
      }));
      this.InitializeSCVivoxClient();
    }

    public void LogoutFromVivox()
    {
      Log.Debug("VOICECHAT: Logging out from Vivox");
      this.vivoxLoginSession.Logout();
    }

    public void EndLoginToVivox() => Log.Debug("VOICECHAT: End Login To Vivox");

    public void VivoxLoginStateChanged(object sender, PropertyChangedEventArgs eventArgs)
    {
      if (!(eventArgs.PropertyName == "State"))
        return;
      switch ((sender as ILoginSession).State)
      {
        case LoginState.LoggedOut:
          Log.Debug("VOICECHAT: Logged out from Vivox");
          break;
        case LoginState.LoggedIn:
          Log.Debug("VOICECHAT: Logged in to Vivox");
          break;
        case LoginState.LoggingIn:
          Log.Debug("VOICECHAT: Logging in to Vivox");
          break;
      }
    }

    private void Uninitialize()
    {
      if (this.vivoxLoginSession != null && this.vivoxLoginSession.State == LoginState.LoggedIn)
      {
        this.vivoxLoginSession.PropertyChanged -= new PropertyChangedEventHandler(this.VivoxLoginStateChanged);
        this.LogoutFromVivox();
      }
      if (this.client != null)
      {
        this.client.Uninitialize();
        this.imiHelper.UpdateEvent -= new Action(this.RunClient);
        this.imiHelper.DestroyEvent -= new Action(this.Uninitialize);
        ImiServices.Instance.OnMetaLoginSuccessful -= new ImiServices.OnMetaLoginSuccessfulEventHandler(this.ConnectToVoiceChatService);
      }
      Events.Global.OnEventMatchInfo -= new Events.EventMatchInfo(this.OnJoinGame);
    }

    public delegate void OnPlayerStartSpeakingEventHandler(ulong playerId);

    public delegate void OnPlayerStopSpeakingEventHandler(ulong playerId);

    public delegate void OnLocalPlayerVoiceChatEnteredEventHandler(string voiceChatName);

    public delegate void OnLocalPlayerConnectingToVoiceChatEventHandler();

    public delegate void OnVoiceChatConnectionErrorEventHandler(string errorMsg);

    public delegate void OnLocalPlayerVoiceChatLeftEventHandler(string voiceChatName);

    public delegate void OnRemotePlayerVoiceChatEnteredEventHandler(ulong playerID);

    public delegate void OnRemotePlayerVoiceChatLeftEventHandler(ulong playerID);

    public delegate void OnUserMutedEventHandler(ulong playerID, bool muted);
  }
}
