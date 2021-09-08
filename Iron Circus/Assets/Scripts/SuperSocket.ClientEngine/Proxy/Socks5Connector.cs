﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.Socks5Connector
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine.Proxy
{
  public class Socks5Connector : ProxyConnectorBase
  {
    private ArraySegment<byte> m_UserNameAuthenRequest;
    private static byte[] m_AuthenHandshake = new byte[4]
    {
      (byte) 5,
      (byte) 2,
      (byte) 0,
      (byte) 2
    };

    public Socks5Connector(EndPoint proxyEndPoint)
      : base(proxyEndPoint)
    {
    }

    public Socks5Connector(EndPoint proxyEndPoint, string username, string password)
      : base(proxyEndPoint)
    {
      if (string.IsNullOrEmpty(username))
        throw new ArgumentNullException(nameof (username));
      byte[] numArray = new byte[3 + ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(username.Length) + (string.IsNullOrEmpty(password) ? 0 : ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(password.Length))];
      numArray[0] = (byte) 5;
      int bytes1 = ProxyConnectorBase.ASCIIEncoding.GetBytes(username, 0, username.Length, numArray, 2);
      numArray[1] = bytes1 <= (int) byte.MaxValue ? (byte) bytes1 : throw new ArgumentException("the length of username cannot exceed 255", nameof (username));
      int index = bytes1 + 2;
      int count;
      if (!string.IsNullOrEmpty(password))
      {
        int bytes2 = ProxyConnectorBase.ASCIIEncoding.GetBytes(password, 0, password.Length, numArray, index + 1);
        numArray[index] = bytes2 <= (int) byte.MaxValue ? (byte) bytes2 : throw new ArgumentException("the length of password cannot exceed 255", nameof (password));
        count = index + (bytes2 + 1);
      }
      else
      {
        numArray[index] = (byte) 0;
        count = index + 1;
      }
      this.m_UserNameAuthenRequest = new ArraySegment<byte>(numArray, 0, count);
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
          e.UserToken = (object) new Socks5Connector.SocksContext()
          {
            TargetEndPoint = (EndPoint) targetEndPoint,
            Socket = socket,
            State = Socks5Connector.SocksState.NotAuthenticated
          };
          e.Completed += new EventHandler<SocketAsyncEventArgs>(((ProxyConnectorBase) this).AsyncEventArgsCompleted);
          e.SetBuffer(Socks5Connector.m_AuthenHandshake, 0, Socks5Connector.m_AuthenHandshake.Length);
          this.StartSend(socket, e);
        }
      }
    }

    protected override void ProcessSend(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      Socks5Connector.SocksContext userToken = e.UserToken as Socks5Connector.SocksContext;
      if (userToken.State == Socks5Connector.SocksState.NotAuthenticated)
      {
        e.SetBuffer(0, 2);
        this.StartReceive(userToken.Socket, e);
      }
      else if (userToken.State == Socks5Connector.SocksState.Authenticating)
      {
        e.SetBuffer(0, 2);
        this.StartReceive(userToken.Socket, e);
      }
      else
      {
        e.SetBuffer(0, e.Buffer.Length);
        this.StartReceive(userToken.Socket, e);
      }
    }

    private bool ProcessAuthenticationResponse(Socket socket, SocketAsyncEventArgs e)
    {
      int offset = e.BytesTransferred + e.Offset;
      if (offset < 2)
      {
        e.SetBuffer(offset, 2 - offset);
        this.StartReceive(socket, e);
        return false;
      }
      if (offset > 2)
      {
        this.OnException("received length exceeded");
        return false;
      }
      if (e.Buffer[0] == (byte) 5)
        return true;
      this.OnException("invalid protocol version");
      return false;
    }

    protected override void ProcessReceive(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      Socks5Connector.SocksContext userToken = (Socks5Connector.SocksContext) e.UserToken;
      if (userToken.State == Socks5Connector.SocksState.NotAuthenticated)
      {
        if (!this.ProcessAuthenticationResponse(userToken.Socket, e))
          return;
        switch (e.Buffer[1])
        {
          case 0:
            userToken.State = Socks5Connector.SocksState.Authenticated;
            this.SendHandshake(e);
            break;
          case 2:
            userToken.State = Socks5Connector.SocksState.Authenticating;
            this.AutheticateWithUserNamePassword(e);
            break;
          case byte.MaxValue:
            this.OnException("no acceptable methods were offered");
            break;
          default:
            this.OnException("protocol error");
            break;
        }
      }
      else if (userToken.State == Socks5Connector.SocksState.Authenticating)
      {
        if (!this.ProcessAuthenticationResponse(userToken.Socket, e))
          return;
        if (e.Buffer[1] == (byte) 0)
        {
          userToken.State = Socks5Connector.SocksState.Authenticated;
          this.SendHandshake(e);
        }
        else
          this.OnException("authentication failure");
      }
      else
      {
        byte[] numArray = new byte[e.BytesTransferred];
        Buffer.BlockCopy((Array) e.Buffer, e.Offset, (Array) numArray, 0, e.BytesTransferred);
        userToken.ReceivedData.AddRange((IEnumerable<byte>) numArray);
        if (userToken.ExpectedLength > userToken.ReceivedData.Count)
          this.StartReceive(userToken.Socket, e);
        else if (userToken.State != Socks5Connector.SocksState.FoundLength)
        {
          int num;
          switch (userToken.ReceivedData[3])
          {
            case 1:
              num = 10;
              break;
            case 3:
              num = 7 + (int) userToken.ReceivedData[4];
              break;
            default:
              num = 22;
              break;
          }
          if (userToken.ReceivedData.Count < num)
          {
            userToken.ExpectedLength = num;
            this.StartReceive(userToken.Socket, e);
          }
          else if (userToken.ReceivedData.Count > num)
            this.OnException("response length exceeded");
          else
            this.OnGetFullResponse(userToken);
        }
        else if (userToken.ReceivedData.Count > userToken.ExpectedLength)
          this.OnException("response length exceeded");
        else
          this.OnGetFullResponse(userToken);
      }
    }

    private void OnGetFullResponse(Socks5Connector.SocksContext context)
    {
      List<byte> receivedData = context.ReceivedData;
      if (receivedData[0] != (byte) 5)
      {
        this.OnException("invalid protocol version");
      }
      else
      {
        byte num = receivedData[1];
        if (num == (byte) 0)
        {
          this.OnCompleted(new ProxyEventArgs(context.Socket));
        }
        else
        {
          string empty = string.Empty;
          string exception;
          switch ((int) num - 2)
          {
            case 0:
              exception = "connection not allowed by ruleset";
              break;
            case 1:
              exception = "network unreachable";
              break;
            case 2:
              exception = "host unreachable";
              break;
            case 3:
              exception = "connection refused by destination host";
              break;
            case 4:
              exception = "TTL expired";
              break;
            case 5:
              exception = "command not supported / protocol error";
              break;
            case 6:
              exception = "address type not supported";
              break;
            default:
              exception = "general failure";
              break;
          }
          this.OnException(exception);
        }
      }
    }

    private void SendHandshake(SocketAsyncEventArgs e)
    {
      Socks5Connector.SocksContext userToken = e.UserToken as Socks5Connector.SocksContext;
      EndPoint targetEndPoint = userToken.TargetEndPoint;
      int port;
      byte[] numArray;
      int count;
      if (targetEndPoint is IPEndPoint)
      {
        IPEndPoint ipEndPoint = targetEndPoint as IPEndPoint;
        port = ipEndPoint.Port;
        if (ipEndPoint.AddressFamily == AddressFamily.InterNetwork)
        {
          numArray = new byte[10];
          numArray[3] = (byte) 1;
          Buffer.BlockCopy((Array) ipEndPoint.Address.GetAddressBytes(), 0, (Array) numArray, 4, 4);
        }
        else if (ipEndPoint.AddressFamily == AddressFamily.InterNetworkV6)
        {
          numArray = new byte[22];
          numArray[3] = (byte) 4;
          Buffer.BlockCopy((Array) ipEndPoint.Address.GetAddressBytes(), 0, (Array) numArray, 4, 16);
        }
        else
        {
          this.OnException("unknown address family");
          return;
        }
        count = numArray.Length;
      }
      else
      {
        DnsEndPoint dnsEndPoint = targetEndPoint as DnsEndPoint;
        port = dnsEndPoint.Port;
        numArray = new byte[7 + ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(dnsEndPoint.Host.Length)];
        numArray[3] = (byte) 3;
        int byteIndex = 5;
        count = byteIndex + ProxyConnectorBase.ASCIIEncoding.GetBytes(dnsEndPoint.Host, 0, dnsEndPoint.Host.Length, numArray, byteIndex) + 2;
      }
      numArray[0] = (byte) 5;
      numArray[1] = (byte) 1;
      numArray[2] = (byte) 0;
      numArray[count - 2] = (byte) (port / 256);
      numArray[count - 1] = (byte) (port % 256);
      e.SetBuffer(numArray, 0, count);
      userToken.ReceivedData = new List<byte>(count + 5);
      userToken.ExpectedLength = 5;
      this.StartSend(userToken.Socket, e);
    }

    private void AutheticateWithUserNamePassword(SocketAsyncEventArgs e)
    {
      Socket socket = ((Socks5Connector.SocksContext) e.UserToken).Socket;
      e.SetBuffer(this.m_UserNameAuthenRequest.Array, this.m_UserNameAuthenRequest.Offset, this.m_UserNameAuthenRequest.Count);
      this.StartSend(socket, e);
    }

    private enum SocksState
    {
      NotAuthenticated,
      Authenticating,
      Authenticated,
      FoundLength,
      Connected,
    }

    private class SocksContext
    {
      public Socket Socket { get; set; }

      public Socks5Connector.SocksState State { get; set; }

      public EndPoint TargetEndPoint { get; set; }

      public List<byte> ReceivedData { get; set; }

      public int ExpectedLength { get; set; }
    }
  }
}
