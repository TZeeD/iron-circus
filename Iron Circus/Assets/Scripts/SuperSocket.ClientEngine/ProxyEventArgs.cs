// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.ProxyEventArgs
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine
{
  public class ProxyEventArgs : EventArgs
  {
    public ProxyEventArgs(Socket socket)
      : this(true, socket, (string) null, (Exception) null)
    {
    }

    public ProxyEventArgs(Socket socket, string targetHostHame)
      : this(true, socket, targetHostHame, (Exception) null)
    {
    }

    public ProxyEventArgs(Exception exception)
      : this(false, (Socket) null, (string) null, exception)
    {
    }

    public ProxyEventArgs(
      bool connected,
      Socket socket,
      string targetHostName,
      Exception exception)
    {
      this.Connected = connected;
      this.Socket = socket;
      this.TargetHostName = targetHostName;
      this.Exception = exception;
    }

    public bool Connected { get; private set; }

    public Socket Socket { get; private set; }

    public Exception Exception { get; private set; }

    public string TargetHostName { get; private set; }
  }
}
