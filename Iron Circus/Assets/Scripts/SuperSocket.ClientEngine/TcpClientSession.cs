﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.TcpClientSession
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace SuperSocket.ClientEngine
{
  public abstract class TcpClientSession : ClientSession
  {
    private bool m_InConnecting;
    private IBatchQueue<ArraySegment<byte>> m_SendingQueue;
    private PosList<ArraySegment<byte>> m_SendingItems;
    private int m_IsSending;

    protected string HostName { get; private set; }

    public override EndPoint LocalEndPoint
    {
      get => base.LocalEndPoint;
      set
      {
        if (this.m_InConnecting || this.IsConnected)
          throw new Exception("You cannot set LocalEdnPoint after you start the connection.");
        base.LocalEndPoint = value;
      }
    }

    public override int ReceiveBufferSize
    {
      get => base.ReceiveBufferSize;
      set
      {
        if (this.Buffer.Array != null)
          throw new Exception("ReceiveBufferSize cannot be set after the socket has been connected!");
        base.ReceiveBufferSize = value;
      }
    }

    protected virtual bool IsIgnorableException(Exception e)
    {
      switch (e)
      {
        case ObjectDisposedException _:
          return true;
        case NullReferenceException _:
          return true;
        default:
          return false;
      }
    }

    protected bool IsIgnorableSocketError(int errorCode) => errorCode == 10058 || errorCode == 10053 || errorCode == 10054 || errorCode == 995;

    protected abstract void SocketEventArgsCompleted(object sender, SocketAsyncEventArgs e);

    public override void Connect(EndPoint remoteEndPoint)
    {
      if (remoteEndPoint == null)
        throw new ArgumentNullException(nameof (remoteEndPoint));
      if (remoteEndPoint is DnsEndPoint dnsEndPoint)
      {
        string host = dnsEndPoint.Host;
        if (!string.IsNullOrEmpty(host))
          this.HostName = host;
      }
      if (this.m_InConnecting)
        throw new Exception("The socket is connecting, cannot connect again!");
      if (this.Client != null)
        throw new Exception("The socket is connected, you needn't connect again!");
      if (this.Proxy != null)
      {
        this.Proxy.Completed += new EventHandler<ProxyEventArgs>(this.Proxy_Completed);
        this.Proxy.Connect(remoteEndPoint);
        this.m_InConnecting = true;
      }
      else
      {
        this.m_InConnecting = true;
        remoteEndPoint.ConnectAsync(this.LocalEndPoint, new ConnectedCallback(this.ProcessConnect), (object) null);
      }
    }

    private void Proxy_Completed(object sender, ProxyEventArgs e)
    {
      this.Proxy.Completed -= new EventHandler<ProxyEventArgs>(this.Proxy_Completed);
      if (e.Connected)
      {
        SocketAsyncEventArgs e1 = (SocketAsyncEventArgs) null;
        if (e.TargetHostName != null)
        {
          e1 = new SocketAsyncEventArgs();
          e1.RemoteEndPoint = (EndPoint) new DnsEndPoint(e.TargetHostName, 0);
        }
        this.ProcessConnect(e.Socket, (object) null, e1, (Exception) null);
      }
      else
      {
        this.OnError(new Exception("proxy error", e.Exception));
        this.m_InConnecting = false;
      }
    }

    protected void ProcessConnect(
      Socket socket,
      object state,
      SocketAsyncEventArgs e,
      Exception exception)
    {
      if (exception != null)
      {
        this.m_InConnecting = false;
        this.OnError(exception);
        e?.Dispose();
      }
      else if (e != null && e.SocketError != SocketError.Success)
      {
        this.m_InConnecting = false;
        this.OnError((Exception) new SocketException((int) e.SocketError));
        e.Dispose();
      }
      else if (socket == null)
      {
        this.m_InConnecting = false;
        this.OnError((Exception) new SocketException(10053));
      }
      else if (!socket.Connected)
      {
        this.m_InConnecting = false;
        SocketError socketError;
        try
        {
          socketError = (SocketError) socket.GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Error);
        }
        catch (Exception ex)
        {
          socketError = SocketError.HostUnreachable;
        }
        this.OnError((Exception) new SocketException((int) socketError));
      }
      else
      {
        if (e == null)
          e = new SocketAsyncEventArgs();
        e.Completed += new EventHandler<SocketAsyncEventArgs>(this.SocketEventArgsCompleted);
        this.Client = socket;
        this.m_InConnecting = false;
        try
        {
          this.LocalEndPoint = socket.LocalEndPoint;
        }
        catch
        {
        }
        EndPoint endPoint = e.RemoteEndPoint != null ? e.RemoteEndPoint : socket.RemoteEndPoint;
        if (string.IsNullOrEmpty(this.HostName))
          this.HostName = this.GetHostOfEndPoint(endPoint);
        else if (endPoint is DnsEndPoint dnsEndPoint7)
        {
          string host = dnsEndPoint7.Host;
          if (!string.IsNullOrEmpty(host) && !this.HostName.Equals(host, StringComparison.OrdinalIgnoreCase))
            this.HostName = host;
        }
        try
        {
          this.Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.KeepAlive, true);
        }
        catch
        {
        }
        this.OnGetSocket(e);
      }
    }

    private string GetHostOfEndPoint(EndPoint endPoint)
    {
      switch (endPoint)
      {
        case DnsEndPoint dnsEndPoint:
          return dnsEndPoint.Host;
        case IPEndPoint ipEndPoint:
          if (ipEndPoint.Address != null)
            return ipEndPoint.Address.ToString();
          break;
      }
      return string.Empty;
    }

    protected abstract void OnGetSocket(SocketAsyncEventArgs e);

    protected bool EnsureSocketClosed() => this.EnsureSocketClosed((Socket) null);

    protected bool EnsureSocketClosed(Socket prevClient)
    {
      Socket socket = this.Client;
      if (socket == null)
        return false;
      bool flag = true;
      if (prevClient != null && prevClient != socket)
      {
        socket = prevClient;
        flag = false;
      }
      else
      {
        this.Client = (Socket) null;
        this.m_IsSending = 0;
      }
      try
      {
        socket.Shutdown(SocketShutdown.Both);
      }
      catch
      {
      }
      finally
      {
        try
        {
          socket.Close();
        }
        catch
        {
        }
      }
      return flag;
    }

    private bool DetectConnected()
    {
      if (this.Client != null)
        return true;
      this.OnError((Exception) new SocketException(10057));
      return false;
    }

    private IBatchQueue<ArraySegment<byte>> GetSendingQueue()
    {
      if (this.m_SendingQueue != null)
        return this.m_SendingQueue;
      lock (this)
      {
        if (this.m_SendingQueue != null)
          return this.m_SendingQueue;
        this.m_SendingQueue = (IBatchQueue<ArraySegment<byte>>) new ConcurrentBatchQueue<ArraySegment<byte>>(Math.Max(this.SendingQueueSize, 1024), (Func<ArraySegment<byte>, bool>) (t => t.Array == null || t.Count == 0));
        return this.m_SendingQueue;
      }
    }

    private PosList<ArraySegment<byte>> GetSendingItems()
    {
      if (this.m_SendingItems == null)
        this.m_SendingItems = new PosList<ArraySegment<byte>>();
      return this.m_SendingItems;
    }

    protected bool IsSending => this.m_IsSending == 1;

    public override bool TrySend(ArraySegment<byte> segment)
    {
      if (segment.Array == null || segment.Count == 0)
        throw new Exception("The data to be sent cannot be empty.");
      if (!this.DetectConnected())
        return true;
      bool flag = this.GetSendingQueue().Enqueue(segment);
      if (Interlocked.CompareExchange(ref this.m_IsSending, 1, 0) != 0)
        return flag;
      this.DequeueSend();
      return flag;
    }

    public override bool TrySend(IList<ArraySegment<byte>> segments)
    {
      if (segments == null || segments.Count == 0)
        throw new ArgumentNullException(nameof (segments));
      for (int index = 0; index < segments.Count; ++index)
      {
        if (segments[index].Count == 0)
          throw new Exception("The data piece to be sent cannot be empty.");
      }
      if (!this.DetectConnected())
        return true;
      bool flag = this.GetSendingQueue().Enqueue(segments);
      if (Interlocked.CompareExchange(ref this.m_IsSending, 1, 0) != 0)
        return flag;
      this.DequeueSend();
      return flag;
    }

    private void DequeueSend()
    {
      PosList<ArraySegment<byte>> sendingItems = this.GetSendingItems();
      if (!this.m_SendingQueue.TryDequeue((IList<ArraySegment<byte>>) sendingItems))
        this.m_IsSending = 0;
      else
        this.SendInternal(sendingItems);
    }

    protected abstract void SendInternal(PosList<ArraySegment<byte>> items);

    protected void OnSendingCompleted()
    {
      PosList<ArraySegment<byte>> sendingItems = this.GetSendingItems();
      sendingItems.Clear();
      sendingItems.Position = 0;
      if (!this.m_SendingQueue.TryDequeue((IList<ArraySegment<byte>>) sendingItems))
        this.m_IsSending = 0;
      else
        this.SendInternal(sendingItems);
    }

    public override void Close()
    {
      if (!this.EnsureSocketClosed())
        return;
      this.OnClosed();
    }
  }
}
