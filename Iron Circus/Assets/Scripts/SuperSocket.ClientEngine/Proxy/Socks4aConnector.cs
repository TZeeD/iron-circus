// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.Socks4aConnector
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Net;

namespace SuperSocket.ClientEngine.Proxy
{
  public class Socks4aConnector : Socks4Connector
  {
    private static Random m_Random = new Random();

    public Socks4aConnector(EndPoint proxyEndPoint, string userID)
      : base(proxyEndPoint, userID)
    {
    }

    public override void Connect(EndPoint remoteEndPoint)
    {
      if (!(remoteEndPoint is DnsEndPoint dnsEndPoint))
      {
        this.OnCompleted(new ProxyEventArgs(new Exception("The argument 'remoteEndPoint' must be a DnsEndPoint")));
      }
      else
      {
        try
        {
          this.ProxyEndPoint.ConnectAsync((EndPoint) null, new ConnectedCallback(((ProxyConnectorBase) this).ProcessConnect), (object) dnsEndPoint);
        }
        catch (Exception ex)
        {
          this.OnException(new Exception("Failed to connect proxy server", ex));
        }
      }
    }

    protected override byte[] GetSendingBuffer(EndPoint targetEndPoint, out int actualLength)
    {
      DnsEndPoint dnsEndPoint = targetEndPoint as DnsEndPoint;
      byte[] bytes = new byte[Math.Max(8, (string.IsNullOrEmpty(this.UserID) ? 0 : ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(this.UserID.Length)) + 5 + 4 + ProxyConnectorBase.ASCIIEncoding.GetMaxByteCount(dnsEndPoint.Host.Length) + 1)];
      bytes[0] = (byte) 4;
      bytes[1] = (byte) 1;
      bytes[2] = (byte) (dnsEndPoint.Port / 256);
      bytes[3] = (byte) (dnsEndPoint.Port % 256);
      bytes[4] = (byte) 0;
      bytes[5] = (byte) 0;
      bytes[6] = (byte) 0;
      bytes[7] = (byte) Socks4aConnector.m_Random.Next(1, (int) byte.MaxValue);
      actualLength = 8;
      if (!string.IsNullOrEmpty(this.UserID))
        actualLength += ProxyConnectorBase.ASCIIEncoding.GetBytes(this.UserID, 0, this.UserID.Length, bytes, actualLength);
      bytes[actualLength++] = (byte) 0;
      actualLength += ProxyConnectorBase.ASCIIEncoding.GetBytes(dnsEndPoint.Host, 0, dnsEndPoint.Host.Length, bytes, actualLength);
      bytes[actualLength++] = (byte) 0;
      return bytes;
    }

    protected override void HandleFaultStatus(byte status)
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
