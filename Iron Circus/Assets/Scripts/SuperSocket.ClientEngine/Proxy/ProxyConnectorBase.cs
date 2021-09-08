// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.ProxyConnectorBase
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace SuperSocket.ClientEngine.Proxy
{
  public abstract class ProxyConnectorBase : IProxyConnector
  {
    protected static Encoding ASCIIEncoding = (Encoding) new System.Text.ASCIIEncoding();
    private EventHandler<ProxyEventArgs> m_Completed;

    public EndPoint ProxyEndPoint { get; private set; }

    public string TargetHostHame { get; private set; }

    public ProxyConnectorBase(EndPoint proxyEndPoint)
      : this(proxyEndPoint, (string) null)
    {
    }

    public ProxyConnectorBase(EndPoint proxyEndPoint, string targetHostHame)
    {
      this.ProxyEndPoint = proxyEndPoint;
      this.TargetHostHame = targetHostHame;
    }

    public abstract void Connect(EndPoint remoteEndPoint);

    public event EventHandler<ProxyEventArgs> Completed
    {
      add => this.m_Completed += value;
      remove => this.m_Completed -= value;
    }

    protected void OnCompleted(ProxyEventArgs args)
    {
      if (this.m_Completed == null)
        return;
      this.m_Completed((object) this, args);
    }

    protected void OnException(Exception exception) => this.OnCompleted(new ProxyEventArgs(exception));

    protected void OnException(string exception) => this.OnCompleted(new ProxyEventArgs(new Exception(exception)));

    protected bool ValidateAsyncResult(SocketAsyncEventArgs e)
    {
      if (e.SocketError == SocketError.Success)
        return true;
      SocketException socketException = new SocketException((int) e.SocketError);
      this.OnCompleted(new ProxyEventArgs(new Exception(socketException.Message, (Exception) socketException)));
      return false;
    }

    protected void AsyncEventArgsCompleted(object sender, SocketAsyncEventArgs e)
    {
      if (e.LastOperation == SocketAsyncOperation.Send)
        this.ProcessSend(e);
      else
        this.ProcessReceive(e);
    }

    protected void StartSend(Socket socket, SocketAsyncEventArgs e)
    {
      bool flag;
      try
      {
        flag = socket.SendAsync(e);
      }
      catch (Exception ex)
      {
        this.OnException(new Exception(ex.Message, ex));
        return;
      }
      if (flag)
        return;
      this.ProcessSend(e);
    }

    protected virtual void StartReceive(Socket socket, SocketAsyncEventArgs e)
    {
      bool async;
      try
      {
        async = socket.ReceiveAsync(e);
      }
      catch (Exception ex)
      {
        this.OnException(new Exception(ex.Message, ex));
        return;
      }
      if (async)
        return;
      this.ProcessReceive(e);
    }

    protected abstract void ProcessConnect(
      Socket socket,
      object targetEndPoint,
      SocketAsyncEventArgs e,
      Exception exception);

    protected abstract void ProcessSend(SocketAsyncEventArgs e);

    protected abstract void ProcessReceive(SocketAsyncEventArgs e);
  }
}
