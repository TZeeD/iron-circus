// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Core.RumpfieldServer
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Netcode;
using Imi.SharedWithServer.Networking.Netcode.Core;
using Imi.SharedWithServer.Networking.Netcode.Utils;
using Imi.SharedWithServer.Networking.reliable.core;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using SharedWithServer.Networking.Netcode.Udp;
using System;
using System.Collections.Generic;
using unittests.server.SharedWithServer.Networking.Netcode.Core;

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
  public class RumpfieldServer
  {
    private readonly Dictionary<ulong, IConnection> clientDict = new Dictionary<ulong, IConnection>();
    private RumpfieldServerConfig config;

    public RumpfieldServer(RumpfieldServerConfig config, double time, IUdpSocket transport)
    {
      Log.Debug(string.Format("Creating Rumpfield on {0}{1}:{2}", (object) config.GatewayAddress, (object) config.Ip, (object) config.Port));
      this.config = config;
      this.NetcodeServer = new NetcodeServer(new NetcodeServerConfig(config.NumberOfPeers, config.ProtocolId, config.PrivateKey), transport, time, MiscUtils.CreateEndpoint(config.GatewayAddress, config.Port));
      this.Time = time;
      this.IsRunning = false;
      this.RegisterServerEvents();
    }

    public double Time { get; set; }

    public bool IsRunning { get; set; }

    public NetcodeServer NetcodeServer { get; }

    public event RumpfieldServer.OnMessageReceivedDelegate OnMessageReceived;

    public event RumpfieldServer.OnMessageAckedDelegate OnMessageAcknowledged;

    public event RumpfieldServer.OnClientConnectedDelegate OnClientConnected;

    public event RumpfieldServer.OnClientDisconnectedDelegate OnClientDisconnected;

    public event RumpfieldServer.OnClientDestroyedDelegate OnClientDestroyed;

    public void Start()
    {
      Log.Netcode("Reliable Server - Started");
      this.NetcodeServer.Start();
      this.IsRunning = true;
    }

    private void ForwardOnMessageAcknowledged(int index, ushort sequence)
    {
      if (this.OnMessageAcknowledged == null)
        return;
      this.OnMessageAcknowledged(index, sequence);
    }

    private void RegisterServerEvents()
    {
      this.NetcodeServer.OnClientConnected += new ClientConnectedEventHandler(this.OnNetcodeClientConnected);
      this.NetcodeServer.OnClientDisconnected += new ClientDisconnectedEventHandler(this.OnNetcodeClientDisconnected);
      this.NetcodeServer.OnClientMessageReceived += new ClientMessageReceivedEventHandler(this.OnNetcodeMessageReceived);
    }

    private void OnNetcodeClientDisconnected(NetcodeServerClient client)
    {
      Log.Netcode(string.Format("Client {0} is disconnected.", (object) client.Id));
      this.clientDict[client.Id].Disconnect();
      if (this.OnClientDisconnected == null)
        return;
      this.OnClientDisconnected(client.Index, client.Id);
    }

    private void OnNetcodeClientConnected(NetcodeServerClient client)
    {
      ulong id = client.Id;
      int index = client.Index;
      if (this.clientDict.ContainsKey(id))
      {
        Log.Netcode(string.Format("Client [{0}|{1}] re-connected.", (object) id, (object) index));
        IConnection connection = this.clientDict[id];
        this.clientDict[id].Connect(index);
      }
      else
      {
        Log.Netcode(string.Format("Client [{0}|{1}] connected.", (object) id, (object) index));
        ReliableEndpointConfig config = ReliableEndpointConfig.DefaultConfig(string.Format("[{0}|{1}]", (object) id, (object) index), index);
        config.TransmitFunction = new ReliableEndpointConfig.TransmitPacketDelegate(this.TransmitPacketFunction);
        config.ProcessFunction = new ReliableEndpointConfig.ProcessPacketDelegate(this.ProcessPacketFunction);
        config.AckFunction = new ReliableEndpointConfig.AckPacketDelegate(this.AckPacketFunction);
        this.clientDict.Add(id, (IConnection) new Connection(id, index, new ReliableEndpoint(config, this.Time), this.Time, true));
        this.clientDict[id].Connect(index);
      }
      if (this.OnClientConnected == null)
        return;
      this.OnClientConnected(client.Index, client.Id);
    }

    private void OnNetcodeMessageReceived(
      NetcodeServerClient sender,
      byte[] payload,
      int payloadSize)
    {
      this.clientDict[sender.Id].GetEndpoint().RecvPacket(payload, payloadSize);
    }

    private void AckPacketFunction(int clientIndex, ushort ackSequence)
    {
    }

    public void SendPayload(QualityOfService qos, ulong id, byte[] buffer, ushort bufferSize)
    {
      if (!this.IsConnected(id))
        return;
      this.clientDict[id].SendMessage(qos, new RMessage(buffer, bufferSize));
    }

    public void Broadcast(QualityOfService qos, byte[] buffer, ushort bufferSize)
    {
      foreach (IConnection connection in this.clientDict.Values)
      {
        ulong id = connection.GetId();
        this.SendPayload(qos, id, buffer, bufferSize);
      }
    }

    public void BroadcastUnreliableForce(byte[] buffer, ushort bufferSize)
    {
      Dictionary<ulong, IConnection>.ValueCollection values = this.clientDict.Values;
      for (int index = 0; index < 10; ++index)
      {
        foreach (IConnection connection in values)
          this.SendPayload(QualityOfService.Unreliable, connection.GetId(), buffer, bufferSize);
        this.Send(this.Time);
      }
    }

    private void ProcessPacketFunction(int index, ushort sequence, byte[] buffer, int bufferSize)
    {
      ulong id = this.NetcodeServer.GetClient(index).Id;
      this.clientDict[id].ProcessPacket(sequence, buffer, bufferSize);
      while (true)
      {
        RMessage rmessage;
        do
        {
          rmessage = this.clientDict[id].RecvMessage();
          if (rmessage == null)
            goto label_4;
        }
        while (this.OnMessageReceived == null);
        this.OnMessageReceived(id, index, sequence, rmessage.Buffer, (int) rmessage.BufferSize);
      }
label_4:;
    }

    private void TransmitPacketFunction(
      int clientIndex,
      ushort packetSequence,
      byte[] packet,
      int packetSize)
    {
      if (!this.NetcodeServer.IsClientConnected(clientIndex))
        return;
      this.NetcodeServer.SendPayload(clientIndex, packet, packetSize);
    }

    public void Tick(double time)
    {
      this.Time = time;
      this.NetcodeServer.Tick(time);
      Dictionary<ulong, IConnection>.ValueCollection values = this.clientDict.Values;
      List<ulong> ulongList = new List<ulong>();
      foreach (IConnection connection in values)
      {
        if (connection.GetState() == RumpfieldState.Connected)
          connection.Tick(time);
        else if (connection.GetState() == RumpfieldState.Disconnected && connection.GetLastTickTime() + (double) this.config.ClientDestroyTimeOut <= time)
          ulongList.Add(connection.GetId());
      }
      if (ulongList.Count <= 0)
        return;
      foreach (ulong num in ulongList)
      {
        this.clientDict.Remove(num);
        if (this.OnClientDestroyed != null)
          this.OnClientDestroyed(num);
      }
    }

    public void Stop()
    {
      if (!this.IsRunning)
        return;
      this.IsRunning = false;
      this.NetcodeServer.Stop();
      this.clientDict.Clear();
    }

    public int GetNumberOfConfirmedClients() => this.NetcodeServer.NumConnectedClients;

    private bool IsConnected(ulong id)
    {
      if (this.clientDict.ContainsKey(id))
      {
        IConnection connection = this.clientDict[id];
        if (connection.GetState() == RumpfieldState.Connected && connection.GetIndex() >= 0 && connection.GetIndex() < this.config.NumberOfPeers && this.NetcodeServer.IsClientConnected(connection.GetIndex()))
          return true;
      }
      return false;
    }

    public IConnection GetConnection(ulong id) => this.clientDict.ContainsKey(id) ? this.clientDict[id] : (IConnection) null;

    public void ForeachConnectionDo(Action<ulong, ReliableEndpoint> callback)
    {
      foreach (KeyValuePair<ulong, IConnection> keyValuePair in this.clientDict)
        callback(keyValuePair.Key, keyValuePair.Value.GetEndpoint());
    }

    public void Destroy() => this.NetcodeServer.Destroy();

    public void Send(double time)
    {
      foreach (IConnection connection in this.clientDict.Values)
      {
        if (connection.GetState() == RumpfieldState.Connected)
          connection.Send(time);
      }
    }

    public delegate void OnClientConnectedDelegate(int clientIndex, ulong clientId);

    public delegate void OnClientDestroyedDelegate(ulong clientId);

    public delegate void OnClientDisconnectedDelegate(int clientIndex, ulong clientId);

    public delegate void OnMessageAckedDelegate(int clientindex, ushort ackSequence);

    public delegate void OnMessageReceivedDelegate(
      ulong clientId,
      int clientIndex,
      ushort sequence,
      byte[] buffer,
      int bufferSize);
  }
}
