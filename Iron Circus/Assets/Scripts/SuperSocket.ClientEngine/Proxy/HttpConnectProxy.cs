﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.HttpConnectProxy
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine.Proxy
{
  public class HttpConnectProxy : ProxyConnectorBase
  {
    private const string m_RequestTemplate = "CONNECT {0}:{1} HTTP/1.1\r\nHost: {0}:{1}\r\nProxy-Connection: Keep-Alive\r\n\r\n";
    private const string m_ResponsePrefix = "HTTP/1.1";
    private const char m_Space = ' ';
    private static byte[] m_LineSeparator = ProxyConnectorBase.ASCIIEncoding.GetBytes("\r\n\r\n");
    private int m_ReceiveBufferSize;

    public HttpConnectProxy(EndPoint proxyEndPoint)
      : this(proxyEndPoint, 128, (string) null)
    {
    }

    public HttpConnectProxy(EndPoint proxyEndPoint, string targetHostName)
      : this(proxyEndPoint, 128, targetHostName)
    {
    }

    public HttpConnectProxy(EndPoint proxyEndPoint, int receiveBufferSize, string targetHostName)
      : base(proxyEndPoint, targetHostName)
    {
      this.m_ReceiveBufferSize = receiveBufferSize;
    }

    public override void Connect(EndPoint remoteEndPoint)
    {
      switch (remoteEndPoint)
      {
        case null:
          throw new ArgumentNullException(nameof (remoteEndPoint));
        case IPEndPoint _:
        case DnsEndPoint _:
          try
          {
            this.ProxyEndPoint.ConnectAsync((EndPoint) null, new ConnectedCallback(((ProxyConnectorBase) this).ProcessConnect), (object) remoteEndPoint);
            break;
          }
          catch (Exception ex)
          {
            this.OnException(new Exception("Failed to connect proxy server", ex));
            break;
          }
        default:
          throw new ArgumentException("remoteEndPoint must be IPEndPoint or DnsEndPoint", nameof (remoteEndPoint));
      }
    }

    protected override void ProcessConnect(
      Socket socket,
      object targetEndPoint,
      SocketAsyncEventArgs e,
      Exception exception)
    {
      if (exception != null)
      {
        this.OnException(exception);
      }
      else
      {
        if (e != null && !this.ValidateAsyncResult(e))
          return;
        if (socket == null)
        {
          this.OnException((Exception) new SocketException(10053));
        }
        else
        {
          if (e == null)
            e = new SocketAsyncEventArgs();
          string s;
          if (targetEndPoint is DnsEndPoint)
          {
            DnsEndPoint dnsEndPoint = (DnsEndPoint) targetEndPoint;
            s = string.Format("CONNECT {0}:{1} HTTP/1.1\r\nHost: {0}:{1}\r\nProxy-Connection: Keep-Alive\r\n\r\n", (object) dnsEndPoint.Host, (object) dnsEndPoint.Port);
          }
          else
          {
            IPEndPoint ipEndPoint = (IPEndPoint) targetEndPoint;
            s = string.Format("CONNECT {0}:{1} HTTP/1.1\r\nHost: {0}:{1}\r\nProxy-Connection: Keep-Alive\r\n\r\n", (object) ipEndPoint.Address, (object) ipEndPoint.Port);
          }
          byte[] bytes = ProxyConnectorBase.ASCIIEncoding.GetBytes(s);
          e.Completed += new EventHandler<SocketAsyncEventArgs>(((ProxyConnectorBase) this).AsyncEventArgsCompleted);
          e.UserToken = (object) new HttpConnectProxy.ConnectContext()
          {
            Socket = socket,
            SearchState = new SearchMarkState<byte>(HttpConnectProxy.m_LineSeparator)
          };
          e.SetBuffer(bytes, 0, bytes.Length);
          this.StartSend(socket, e);
        }
      }
    }

    protected override void ProcessSend(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      HttpConnectProxy.ConnectContext userToken = (HttpConnectProxy.ConnectContext) e.UserToken;
      byte[] buffer = new byte[this.m_ReceiveBufferSize];
      e.SetBuffer(buffer, 0, buffer.Length);
      this.StartReceive(userToken.Socket, e);
    }

    protected override void ProcessReceive(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      HttpConnectProxy.ConnectContext userToken = (HttpConnectProxy.ConnectContext) e.UserToken;
      int matched = userToken.SearchState.Matched;
      int num1 = ((IList<byte>) e.Buffer).SearchMark<byte>(e.Offset, e.BytesTransferred, userToken.SearchState);
      if (num1 < 0)
      {
        int offset = e.Offset + e.BytesTransferred;
        if (offset >= this.m_ReceiveBufferSize)
        {
          this.OnException("receive buffer size has been exceeded");
        }
        else
        {
          e.SetBuffer(offset, this.m_ReceiveBufferSize - offset);
          this.StartReceive(userToken.Socket, e);
        }
      }
      else
      {
        int count = matched > 0 ? e.Offset - matched : e.Offset + num1;
        if (e.Offset + e.BytesTransferred > count + HttpConnectProxy.m_LineSeparator.Length)
        {
          this.OnException("protocol error: more data has been received");
        }
        else
        {
          string str = new StringReader(ProxyConnectorBase.ASCIIEncoding.GetString(e.Buffer, 0, count)).ReadLine();
          if (string.IsNullOrEmpty(str))
          {
            this.OnException("protocol error: invalid response");
          }
          else
          {
            int length = str.IndexOf(' ');
            if (length <= 0 || str.Length <= length + 2)
              this.OnException("protocol error: invalid response");
            else if (!"HTTP/1.1".Equals(str.Substring(0, length)))
            {
              this.OnException("protocol error: invalid protocol");
            }
            else
            {
              int num2 = str.IndexOf(' ', length + 1);
              if (num2 < 0)
              {
                this.OnException("protocol error: invalid response");
              }
              else
              {
                int result;
                if (!int.TryParse(str.Substring(length + 1, num2 - length - 1), out result) || result > 299 || result < 200)
                  this.OnException("the proxy server refused the connection");
                else
                  this.OnCompleted(new ProxyEventArgs(userToken.Socket, this.TargetHostHame));
              }
            }
          }
        }
      }
    }

    private class ConnectContext
    {
      public Socket Socket { get; set; }

      public SearchMarkState<byte> SearchState { get; set; }
    }
  }
}
