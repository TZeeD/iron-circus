// Decompiled with JetBrains decompiler
// Type: DiscordOld.Discord
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;
using UnityEngine.Events;

namespace DiscordOld
{
  public class Discord : MonoBehaviour
  {
    public DiscordRpc.RichPresence presence = new DiscordRpc.RichPresence();
    public string applicationId;
    public string optionalSteamId;
    public int clickCounter;
    public DiscordRpc.DiscordUser joinRequest;
    public UnityEvent onConnect;
    public UnityEvent onDisconnect;
    public UnityEvent hasResponded;
    public DiscordJoinEvent onJoin;
    public DiscordJoinEvent onSpectate;
    public DiscordJoinRequestEvent onJoinRequest;
    private DiscordRpc.EventHandlers handlers;

    public void OnDefaultPresence()
    {
      this.presence.largeImageKey = "sc_logo_512px_w";
      this.presence.state = "Testing secret stuff..";
      DiscordRpc.UpdatePresence(this.presence);
    }

    public void OnClick()
    {
      Log.Debug("Discord: on click!");
      ++this.clickCounter;
      this.presence.details = string.Format("Button clicked {0} times", (object) this.clickCounter);
      DiscordRpc.UpdatePresence(this.presence);
    }

    public void RequestRespondYes()
    {
      Log.Debug("Discord: responding yes to Ask to Join request");
      DiscordRpc.Respond(this.joinRequest.userId, DiscordRpc.Reply.Yes);
      this.hasResponded.Invoke();
    }

    public void RequestRespondNo()
    {
      Log.Debug("Discord: responding no to Ask to Join request");
      DiscordRpc.Respond(this.joinRequest.userId, DiscordRpc.Reply.No);
      this.hasResponded.Invoke();
    }

    public void ReadyCallback(ref DiscordRpc.DiscordUser connectedUser)
    {
      Log.Debug(string.Format("Discord: connected to {0}#{1}: {2}", (object) connectedUser.username, (object) connectedUser.discriminator, (object) connectedUser.userId));
      this.onConnect.Invoke();
    }

    public void DisconnectedCallback(int errorCode, string message)
    {
      Log.Debug(string.Format("Discord: disconnect {0}: {1}", (object) errorCode, (object) message));
      this.onDisconnect.Invoke();
    }

    public void ErrorCallback(int errorCode, string message) => Log.Debug(string.Format("Discord: error {0}: {1}", (object) errorCode, (object) message));

    public void JoinCallback(string secret)
    {
      Log.Debug(string.Format("Discord: join ({0})", (object) secret));
      this.onJoin.Invoke(secret);
    }

    public void SpectateCallback(string secret)
    {
      Log.Debug(string.Format("Discord: spectate ({0})", (object) secret));
      this.onSpectate.Invoke(secret);
    }

    public void RequestCallback(ref DiscordRpc.DiscordUser request)
    {
      Log.Debug(string.Format("Discord: join request {0}#{1}: {2}", (object) request.username, (object) request.discriminator, (object) request.userId));
      this.joinRequest = request;
      this.onJoinRequest.Invoke(request);
    }

    private void Start()
    {
    }

    private void Update() => DiscordRpc.RunCallbacks();

    private void OnEnable()
    {
      Log.Debug("Discord: init");
      this.handlers = new DiscordRpc.EventHandlers();
      this.handlers.readyCallback += new DiscordRpc.OnReadyInfo(this.ReadyCallback);
      this.handlers.disconnectedCallback += new DiscordRpc.OnDisconnectedInfo(this.DisconnectedCallback);
      this.handlers.errorCallback += new DiscordRpc.OnErrorInfo(this.ErrorCallback);
      this.handlers.joinCallback += new DiscordRpc.OnJoinInfo(this.JoinCallback);
      this.handlers.spectateCallback += new DiscordRpc.OnSpectateInfo(this.SpectateCallback);
      this.handlers.requestCallback += new DiscordRpc.OnRequestInfo(this.RequestCallback);
      DiscordRpc.Initialize(this.applicationId, ref this.handlers, true, this.optionalSteamId);
    }

    private void OnDisable()
    {
      Log.Debug("Discord: shutdown");
      DiscordRpc.Shutdown();
    }

    private void OnDestroy()
    {
    }
  }
}
