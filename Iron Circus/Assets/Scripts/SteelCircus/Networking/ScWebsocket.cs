// Decompiled with JetBrains decompiler
// Type: SteelCircus.Networking.ScWebsocket
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SuperSocket.ClientEngine;
using System;
using System.Collections.Generic;
using System.Security.Authentication;
using System.Threading;
using WebSocket4Net;

namespace SteelCircus.Networking
{
  public class ScWebsocket
  {
    private const SslProtocols EnabledSslProtocols = (SslProtocols) 4092;
    private WebSocket websocket;
    private Timer connectTimer;
    private ulong id;

    public ulong sendCounter { get; private set; }

    public ulong recvCounter { get; private set; }

    public bool IsOpen { get; private set; }

    public bool IsRunning { get; private set; }

    public event ScWebsocket.ClientOpenHandler OnOpen;

    public event ScWebsocket.ClientMessageReceivedHandler OnMessageReceived;

    public event ScWebsocket.ClientErrorHandler OnError;

    public event ScWebsocket.ClientClosedHandler OnClose;

    public ScWebsocket(string uri, ulong playerId)
    {
      this.id = playerId;
      this.websocket = new WebSocket(uri, customHeaderItems: new List<KeyValuePair<string, string>>(1)
      {
        new KeyValuePair<string, string>("playerIdHeader", this.id.ToString())
      }, version: WebSocketVersion.Rfc6455);
      this.websocket.Security.EnabledSslProtocols = (SslProtocols) 4092;
      this.websocket.Opened += new EventHandler(this.WebsocketOpened);
      this.websocket.MessageReceived += new EventHandler<MessageReceivedEventArgs>(this.WebsocketMessageReceived);
      this.websocket.Closed += new EventHandler(this.WebsocketClosed);
      this.websocket.Error += new EventHandler<ErrorEventArgs>(this.WebsocketError);
    }

    private void WebsocketOpened(object sender, EventArgs e)
    {
      this.DeactivateConnectTimer();
      this.IsOpen = true;
      ScWebsocket.ClientOpenHandler onOpen = this.OnOpen;
      if (onOpen == null)
        return;
      onOpen();
    }

    private void WebsocketMessageReceived(object sender, MessageReceivedEventArgs e)
    {
      ScWebsocket.ClientMessageReceivedHandler onMessageReceived = this.OnMessageReceived;
      if (onMessageReceived != null)
        onMessageReceived(e.Message);
      ++this.recvCounter;
    }

    private void WebsocketClosed(object sender, EventArgs args)
    {
      this.DeactivateConnectTimer();
      this.IsOpen = false;
      this.IsRunning = false;
      ScWebsocket.ClientClosedHandler onClose = this.OnClose;
      if (onClose == null)
        return;
      onClose();
    }

    private void WebsocketError(object sender, ErrorEventArgs e)
    {
      this.DeactivateConnectTimer();
      this.IsRunning = false;
      ScWebsocket.ClientErrorHandler onError = this.OnError;
      if (onError == null)
        return;
      onError(new ScWebsocketConnectionException(string.Format("Websocket[{0}] - see inner exception.", (object) this.id), e.Exception));
    }

    private void ActivateConnectTimer()
    {
      int num = 5000;
      this.connectTimer = new Timer(new TimerCallback(this.CouldNotConnectCallback), (object) null, num, num);
    }

    private void CouldNotConnectCallback(object state)
    {
      ScWebsocket.ClientErrorHandler onError = this.OnError;
      if (onError != null)
        onError(new ScWebsocketConnectionException(string.Format("Websocket[{0}] - Connection can't be established.", (object) this.id)));
      this.IsRunning = false;
      this.DeactivateConnectTimer();
    }

    private void DeactivateConnectTimer()
    {
      this.connectTimer?.Dispose();
      this.connectTimer = (Timer) null;
    }

    public void Start()
    {
      this.IsRunning = true;
      this.websocket.Open();
      this.ActivateConnectTimer();
    }

    public void Send(string message)
    {
      if (this.IsOpen && this.IsRunning)
      {
        this.websocket.Send(message);
        ++this.sendCounter;
      }
      else
        Log.Warning(string.Format("Websocket[{0}] - Could not send message. Websocket is not open/running.", (object) this.id));
    }

    public void Stop()
    {
      this.DeactivateConnectTimer();
      this.websocket.Close();
      this.IsRunning = false;
    }

    public delegate void ClientOpenHandler();

    public delegate void ClientMessageReceivedHandler(string msg);

    public delegate void ClientErrorHandler(ScWebsocketConnectionException e);

    public delegate void ClientClosedHandler();
  }
}
