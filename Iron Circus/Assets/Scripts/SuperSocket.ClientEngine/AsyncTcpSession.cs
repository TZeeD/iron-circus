// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.AsyncTcpSession
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine
{
  public class AsyncTcpSession : TcpClientSession
  {
    private SocketAsyncEventArgs m_SocketEventArgs;
    private SocketAsyncEventArgs m_SocketEventArgsSend;

    protected override void SocketEventArgsCompleted(object sender, SocketAsyncEventArgs e)
    {
      if (e.LastOperation == SocketAsyncOperation.Connect)
        this.ProcessConnect(sender as Socket, (object) null, e, (Exception) null);
      else
        this.ProcessReceive(e);
    }

    protected override void SetBuffer(ArraySegment<byte> bufferSegment)
    {
      base.SetBuffer(bufferSegment);
      if (this.m_SocketEventArgs == null)
        return;
      this.m_SocketEventArgs.SetBuffer(bufferSegment.Array, bufferSegment.Offset, bufferSegment.Count);
    }

    protected override void OnGetSocket(SocketAsyncEventArgs e)
    {
      if (this.Buffer.Array == null)
      {
        int length = this.ReceiveBufferSize;
        if (length <= 0)
          length = 4096;
        this.ReceiveBufferSize = length;
        this.Buffer = new ArraySegment<byte>(new byte[length]);
      }
      e.SetBuffer(this.Buffer.Array, this.Buffer.Offset, this.Buffer.Count);
      this.m_SocketEventArgs = e;
      this.OnConnected();
      this.StartReceive();
    }

    private void BeginReceive()
    {
      if (this.Client.ReceiveAsync(this.m_SocketEventArgs))
        return;
      this.ProcessReceive(this.m_SocketEventArgs);
    }

    private void ProcessReceive(SocketAsyncEventArgs e)
    {
      if (e.SocketError != SocketError.Success)
      {
        if (this.EnsureSocketClosed())
          this.OnClosed();
        if (this.IsIgnorableSocketError((int) e.SocketError))
          return;
        this.OnError((Exception) new SocketException((int) e.SocketError));
      }
      else if (e.BytesTransferred == 0)
      {
        if (!this.EnsureSocketClosed())
          return;
        this.OnClosed();
      }
      else
      {
        this.OnDataReceived(e.Buffer, e.Offset, e.BytesTransferred);
        this.StartReceive();
      }
    }

    private void StartReceive()
    {
      Socket client = this.Client;
      if (client == null)
        return;
      bool async;
      try
      {
        async = client.ReceiveAsync(this.m_SocketEventArgs);
      }
      catch (SocketException ex)
      {
        if (!this.IsIgnorableSocketError(ex.ErrorCode))
          this.OnError((Exception) ex);
        if (!this.EnsureSocketClosed(client))
          return;
        this.OnClosed();
        return;
      }
      catch (Exception ex)
      {
        if (!this.IsIgnorableException(ex))
          this.OnError(ex);
        if (!this.EnsureSocketClosed(client))
          return;
        this.OnClosed();
        return;
      }
      if (async)
        return;
      this.ProcessReceive(this.m_SocketEventArgs);
    }

    protected override void SendInternal(PosList<ArraySegment<byte>> items)
    {
      if (this.m_SocketEventArgsSend == null)
      {
        this.m_SocketEventArgsSend = new SocketAsyncEventArgs();
        this.m_SocketEventArgsSend.Completed += new EventHandler<SocketAsyncEventArgs>(this.Sending_Completed);
      }
      bool flag;
      try
      {
        if (items.Count > 1)
        {
          if (this.m_SocketEventArgsSend.Buffer != null)
            this.m_SocketEventArgsSend.SetBuffer((byte[]) null, 0, 0);
          this.m_SocketEventArgsSend.BufferList = (IList<ArraySegment<byte>>) items;
        }
        else
        {
          ArraySegment<byte> arraySegment = items[0];
          try
          {
            if (this.m_SocketEventArgsSend.BufferList != null)
              this.m_SocketEventArgsSend.BufferList = (IList<ArraySegment<byte>>) null;
          }
          catch
          {
          }
          this.m_SocketEventArgsSend.SetBuffer(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
        }
        flag = this.Client.SendAsync(this.m_SocketEventArgsSend);
      }
      catch (SocketException ex)
      {
        int errorCode = ex.ErrorCode;
        if (!this.EnsureSocketClosed() || this.IsIgnorableSocketError(errorCode))
          return;
        this.OnError((Exception) ex);
        return;
      }
      catch (Exception ex)
      {
        if (!this.EnsureSocketClosed() || !this.IsIgnorableException(ex))
          return;
        this.OnError(ex);
        return;
      }
      if (flag)
        return;
      this.Sending_Completed((object) this.Client, this.m_SocketEventArgsSend);
    }

    private void Sending_Completed(object sender, SocketAsyncEventArgs e)
    {
      if (e.SocketError != SocketError.Success || e.BytesTransferred == 0)
      {
        if (this.EnsureSocketClosed())
          this.OnClosed();
        if (e.SocketError == SocketError.Success || this.IsIgnorableSocketError((int) e.SocketError))
          return;
        this.OnError((Exception) new SocketException((int) e.SocketError));
      }
      else
        this.OnSendingCompleted();
    }

    protected override void OnClosed()
    {
      if (this.m_SocketEventArgsSend != null)
      {
        this.m_SocketEventArgsSend.Dispose();
        this.m_SocketEventArgsSend = (SocketAsyncEventArgs) null;
      }
      if (this.m_SocketEventArgs != null)
      {
        this.m_SocketEventArgs.Dispose();
        this.m_SocketEventArgs = (SocketAsyncEventArgs) null;
      }
      base.OnClosed();
    }
  }
}
