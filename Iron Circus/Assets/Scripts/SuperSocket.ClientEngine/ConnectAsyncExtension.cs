// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.ConnectAsyncExtension
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Net;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine
{
  public static class ConnectAsyncExtension
  {
    private static void SocketAsyncEventCompleted(object sender, SocketAsyncEventArgs e)
    {
      e.Completed -= new EventHandler<SocketAsyncEventArgs>(ConnectAsyncExtension.SocketAsyncEventCompleted);
      ConnectAsyncExtension.ConnectToken userToken = (ConnectAsyncExtension.ConnectToken) e.UserToken;
      e.UserToken = (object) null;
      userToken.Callback(sender as Socket, userToken.State, e, (Exception) null);
    }

    private static SocketAsyncEventArgs CreateSocketAsyncEventArgs(
      EndPoint remoteEndPoint,
      ConnectedCallback callback,
      object state)
    {
      SocketAsyncEventArgs socketAsyncEventArgs = new SocketAsyncEventArgs();
      socketAsyncEventArgs.UserToken = (object) new ConnectAsyncExtension.ConnectToken()
      {
        State = state,
        Callback = callback
      };
      socketAsyncEventArgs.RemoteEndPoint = remoteEndPoint;
      socketAsyncEventArgs.Completed += new EventHandler<SocketAsyncEventArgs>(ConnectAsyncExtension.SocketAsyncEventCompleted);
      return socketAsyncEventArgs;
    }

    internal static bool PreferIPv4Stack() => Environment.GetEnvironmentVariable("PREFER_IPv4_STACK") != null;

    public static void ConnectAsync(
      this EndPoint remoteEndPoint,
      EndPoint localEndPoint,
      ConnectedCallback callback,
      object state)
    {
      SocketAsyncEventArgs socketAsyncEventArgs = ConnectAsyncExtension.CreateSocketAsyncEventArgs(remoteEndPoint, callback, state);
      Socket socket = ConnectAsyncExtension.PreferIPv4Stack() ? new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp) : new Socket(SocketType.Stream, ProtocolType.Tcp);
      if (localEndPoint != null)
      {
        try
        {
          socket.ExclusiveAddressUse = false;
          socket.Bind(localEndPoint);
        }
        catch (Exception ex)
        {
          callback((Socket) null, state, (SocketAsyncEventArgs) null, ex);
          return;
        }
      }
      socket.ConnectAsync(socketAsyncEventArgs);
    }

    private class ConnectToken
    {
      public object State { get; set; }

      public ConnectedCallback Callback { get; set; }
    }
  }
}
