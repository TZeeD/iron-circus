﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.AuthenticatedStreamTcpSession
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.IO;
using System.Net.Security;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine
{
  public abstract class AuthenticatedStreamTcpSession : TcpClientSession
  {
    private AuthenticatedStream m_Stream;

    public SecurityOption Security { get; set; }

    protected override void SocketEventArgsCompleted(object sender, SocketAsyncEventArgs e) => this.ProcessConnect(sender as Socket, (object) null, e, (Exception) null);

    protected abstract void StartAuthenticatedStream(Socket client);

    protected override void OnGetSocket(SocketAsyncEventArgs e)
    {
      try
      {
        this.StartAuthenticatedStream(this.Client);
      }
      catch (Exception ex)
      {
        if (this.IsIgnorableException(ex))
          return;
        this.OnError(ex);
      }
    }

    protected void OnAuthenticatedStreamConnected(AuthenticatedStream stream)
    {
      this.m_Stream = stream;
      this.OnConnected();
      if (this.Buffer.Array == null)
      {
        int length = this.ReceiveBufferSize;
        if (length <= 0)
          length = 4096;
        this.ReceiveBufferSize = length;
        this.Buffer = new ArraySegment<byte>(new byte[length]);
      }
      this.BeginRead();
    }

    private void OnDataRead(IAsyncResult result)
    {
      if (!(result.AsyncState is AuthenticatedStreamTcpSession.StreamAsyncState asyncState) || asyncState.Stream == null)
      {
        this.OnError((Exception) new NullReferenceException("Null state or stream."));
      }
      else
      {
        AuthenticatedStream stream = asyncState.Stream;
        int length;
        try
        {
          length = stream.EndRead(result);
        }
        catch (Exception ex)
        {
          if (!this.IsIgnorableException(ex))
            this.OnError(ex);
          if (!this.EnsureSocketClosed(asyncState.Client))
            return;
          this.OnClosed();
          return;
        }
        if (length == 0)
        {
          if (!this.EnsureSocketClosed(asyncState.Client))
            return;
          this.OnClosed();
        }
        else
        {
          this.OnDataReceived(this.Buffer.Array, this.Buffer.Offset, length);
          this.BeginRead();
        }
      }
    }

    private void BeginRead() => this.StartRead();

    private void StartRead()
    {
      Socket client = this.Client;
      if (client == null)
        return;
      if (this.m_Stream == null)
        return;
      try
      {
        ArraySegment<byte> buffer = this.Buffer;
        this.m_Stream.BeginRead(buffer.Array, buffer.Offset, buffer.Count, new AsyncCallback(this.OnDataRead), (object) new AuthenticatedStreamTcpSession.StreamAsyncState()
        {
          Stream = this.m_Stream,
          Client = client
        });
      }
      catch (Exception ex)
      {
        if (!this.IsIgnorableException(ex))
          this.OnError(ex);
        if (!this.EnsureSocketClosed(client))
          return;
        this.OnClosed();
      }
    }

    protected override bool IsIgnorableException(Exception e) => base.IsIgnorableException(e) || e is IOException && (e.InnerException is ObjectDisposedException || e.InnerException is IOException && e.InnerException.InnerException is ObjectDisposedException);

    protected override void SendInternal(PosList<ArraySegment<byte>> items)
    {
      Socket client = this.Client;
      try
      {
        PosList<ArraySegment<byte>> posList = items;
        ArraySegment<byte> arraySegment = posList[posList.Position];
        this.m_Stream.BeginWrite(arraySegment.Array, arraySegment.Offset, arraySegment.Count, new AsyncCallback(this.OnWriteComplete), (object) new AuthenticatedStreamTcpSession.StreamAsyncState()
        {
          Stream = this.m_Stream,
          Client = client,
          SendingItems = items
        });
      }
      catch (Exception ex)
      {
        if (!this.IsIgnorableException(ex))
          this.OnError(ex);
        if (!this.EnsureSocketClosed(client))
          return;
        this.OnClosed();
      }
    }

    private void OnWriteComplete(IAsyncResult result)
    {
      if (!(result.AsyncState is AuthenticatedStreamTcpSession.StreamAsyncState asyncState) || asyncState.Stream == null)
      {
        this.OnError((Exception) new NullReferenceException("State of Ssl stream is null."));
      }
      else
      {
        AuthenticatedStream stream = asyncState.Stream;
        try
        {
          stream.EndWrite(result);
        }
        catch (Exception ex)
        {
          if (!this.IsIgnorableException(ex))
            this.OnError(ex);
          if (!this.EnsureSocketClosed(asyncState.Client))
            return;
          this.OnClosed();
          return;
        }
        PosList<ArraySegment<byte>> sendingItems = asyncState.SendingItems;
        int num = sendingItems.Position + 1;
        if (num < sendingItems.Count)
        {
          sendingItems.Position = num;
          this.SendInternal(sendingItems);
        }
        else
        {
          try
          {
            this.m_Stream.Flush();
          }
          catch (Exception ex)
          {
            if (!this.IsIgnorableException(ex))
              this.OnError(ex);
            if (!this.EnsureSocketClosed(asyncState.Client))
              return;
            this.OnClosed();
            return;
          }
          this.OnSendingCompleted();
        }
      }
    }

    public override void Close()
    {
      AuthenticatedStream stream = this.m_Stream;
      if (stream != null)
      {
        stream.Close();
        stream.Dispose();
        this.m_Stream = (AuthenticatedStream) null;
      }
      base.Close();
    }

    private class StreamAsyncState
    {
      public AuthenticatedStream Stream { get; set; }

      public Socket Client { get; set; }

      public PosList<ArraySegment<byte>> SendingItems { get; set; }
    }
  }
}
