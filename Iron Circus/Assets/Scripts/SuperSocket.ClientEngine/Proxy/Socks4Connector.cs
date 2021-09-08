// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.Socks4Connector
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Net;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine.Proxy
{
  public class Socks4Connector : ProxyConnectorBase
  {
    private const int m_ValidResponseSize = 8;

    public string UserID { get; private set; }

    public Socks4Connector(EndPoint proxyEndPoint, string userID)
      : base(proxyEndPoint)
    {
      this.UserID = userID;
    }

    public override void Connect(EndPoint remoteEndPoint)
    {
      if (!(remoteEndPoint is IPEndPoint ipEndPoint))
      {
        this.OnCompleted(new ProxyEventArgs(new Exception("The argument 'remoteEndPoint' must be a IPEndPoint")));
      }
      else
      {
        try
        {
          this.ProxyEndPoint.ConnectAsync((EndPoint) null, new ConnectedCallback(((ProxyConnectorBase) this).ProcessConnect), (object) ipEndPoint);
        }
        catch (Exception ex)
        {
          this.OnException(new Exception("Failed to connect proxy server", ex));
        }
      }
    }

    protected virtual byte[] GetSendingBuffer(EndPoint targetEndPoint, out int actualLength)
    {
      IPEndPoint ipEndPoint = targetEndPoint as IPEndPoint;
      byte[] addressBytes = ipEndPoint.Address.GetAddressBytes();
      byte[] bytes = new byte[Math.Max(8, (string.IsNullOrEmpty(this.UserID) ? 0 : ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(this.UserID.Length)) + 5 + addressBytes.Length)];
      bytes[0] = (byte) 4;
      bytes[1] = (byte) 1;
      bytes[2] = (byte) (ipEndPoint.Port / 256);
      bytes[3] = (byte) (ipEndPoint.Port % 256);
      Buffer.BlockCopy((Array) addressBytes, 0, (Array) bytes, 4, addressBytes.Length);
      actualLength = 4 + addressBytes.Length;
      if (!string.IsNullOrEmpty(this.UserID))
        actualLength += ProxyConnectorBase.ASCIIEncoding.GetBytes(this.UserID, 0, this.UserID.Length, bytes, actualLength);
      bytes[actualLength++] = (byte) 0;
      return bytes;
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
          int actualLength;
          byte[] sendingBuffer = this.GetSendingBuffer((EndPoint) targetEndPoint, out actualLength);
          e.SetBuffer(sendingBuffer, 0, actualLength);
          e.UserToken = (object) socket;
          e.Completed += new EventHandler<SocketAsyncEventArgs>(((ProxyConnectorBase) this).AsyncEventArgsCompleted);
          this.StartSend(socket, e);
        }
      }
    }

    protected override void ProcessSend(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      e.SetBuffer(0, 8);
      this.StartReceive((Socket) e.UserToken, e);
    }

    protected override void ProcessReceive(SocketAsyncEventArgs e)
    {
      if (!this.ValidateAsyncResult(e))
        return;
      int offset = e.Offset + e.BytesTransferred;
      if (offset < 8)
      {
        e.SetBuffer(offset, 8 - offset);
        this.StartReceive((Socket) e.UserToken, e);
      }
      else if (offset == 8)
      {
        byte status = e.Buffer[1];
        if (status == (byte) 90)
          this.OnCompleted(new ProxyEventArgs((Socket) e.UserToken));
        else
          this.HandleFaultStatus(status);
      }
      else
        this.OnException("socks protocol error: size of response cannot be larger than 8");
    }

    protected virtual void HandleFaultStatus(byte status)
    {
      string empty = string.Empty;
      string exception;
      switch (status)
      {
        case 91:
          exception = "request rejected or failed";
          break;
        case 92:
          exception = "request failed because client is not running identd (or not reachable from the server)";
          break;
        case 93:
          exception = "request failed because client's identd could not confirm the user ID string in the reques";
          break;
        default:
          exception = "request rejected for unknown error";
          break;
      }
      this.OnException(exception);
    }
  }
}
