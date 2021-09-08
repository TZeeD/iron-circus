// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.IClientSession
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;

namespace SuperSocket.ClientEngine
{
  public interface IClientSession
  {
    Socket Socket { get; }

    IProxyConnector Proxy { get; set; }

    int ReceiveBufferSize { get; set; }

    int SendingQueueSize { get; set; }

    bool IsConnected { get; }

    void Connect(EndPoint remoteEndPoint);

    void Send(ArraySegment<byte> segment);

    void Send(IList<ArraySegment<byte>> segments);

    void Send(byte[] data, int offset, int length);

    bool TrySend(ArraySegment<byte> segment);

    bool TrySend(IList<ArraySegment<byte>> segments);

    void Close();

    event EventHandler Connected;

    event EventHandler Closed;

    event EventHandler<ErrorEventArgs> Error;

    event EventHandler<DataEventArgs> DataReceived;
  }
}
