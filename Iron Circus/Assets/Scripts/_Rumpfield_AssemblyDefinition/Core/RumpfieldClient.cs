// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Core.RumpfieldClient
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Netcode;
using Imi.SharedWithServer.Networking.Netcode.Core;
using Imi.SharedWithServer.Networking.reliable.core;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using SharedWithServer.Networking.Netcode.Udp;
using System;
using System.Net;

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
  public class RumpfieldClient
  {
    private NetcodeClient netcodeClient;
    private double time;

    public RumpfieldClient(ulong clientId, double time, Func<EndPoint, IUdpSocket> socketFactory = null)
    {
      this.time = time;
      this.Id = clientId;
      this.State = RumpfieldState.Disconnected;
      this.InternalConnection = (IConnection) null;
      this.CreateNetcodeClient(clientId, time, socketFactory);
    }

    public ulong Id { get; }

    public IConnection InternalConnection { get; private set; }

    public int ClientIndex => this.InternalConnection == null ? -1 : this.InternalConnection.GetIndex();

    public RumpfieldState State { get; private set; }

    public NetcodeClientState NetcodeState => this.netcodeClient == null ? NetcodeClientState.Disconnected : this.netcodeClient.State;

    public event RumpfieldClient.OnMessageReceivedDelegate OnMessageReceived;

    public event RumpfieldClient.OnMessageAckedDelegate OnMessageAcknowledged;

    public event RumpfieldClient.OnStateChangedDelegate OnStateChanged;

    private void CreateNetcodeClient(
      ulong clientId,
      double time,
      Func<EndPoint, IUdpSocket> socketFactory = null)
    {
      this.netcodeClient = new NetcodeClient(clientId, time, socketFactory);
      this.netcodeClient.OnStateChanged += new NetcodeClient.ClientStateChangedHandler(this.OnNetcodeStateChanged);
      this.netcodeClient.OnMessageReceived += new NetcodeClient.ClientMessageReceivedHandler(this.OnNetcodeMessageReceived);
    }

    private void Create()
    {
      ReliableEndpointConfig config = ReliableEndpointConfig.DefaultConfig("C", -1);
      config.TransmitFunction = new ReliableEndpointConfig.TransmitPacketDelegate(this.TransmitPacketFunction);
      config.ProcessFunction = new ReliableEndpointConfig.ProcessPacketDelegate(this.ProcessPacketFunction);
      config.AckFunction = new ReliableEndpointConfig.AckPacketDelegate(this.AckPacketFunction);
      this.InternalConnection = (IConnection) new Connection(this.Id, -1, new ReliableEndpoint(config, this.time), this.time, true);
    }

    private void ForwardOnMessageAcknowledged(int index, ushort sequence)
    {
      if (this.OnMessageAcknowledged == null)
        return;
      this.OnMessageAcknowledged(index, sequence);
    }

    public void Connect(byte[] connectToken)
    {
      this.Disconnect();
      this.Create();
      this.netcodeClient.Connect(connectToken);
      if (this.netcodeClient.State > NetcodeClientState.Disconnected)
        this.SetClientState(RumpfieldState.Connecting);
      else
        this.Disconnect();
    }

    public int SendPayload(QualityOfService qos, byte[] data, int size) => !this.IsConnected() ? -1 : this.InternalConnection.SendMessage(qos, new RMessage(data, (ushort) size));

    private void ReceivePacket(int clientIndex, byte[] payload, int payloadSize)
    {
      if (!this.IsConnected())
        return;
      this.InternalConnection.GetEndpoint().RecvPacket(payload, payloadSize);
    }

    private void OnNetcodeMessageReceived(byte[] payload, int payloadSize) => this.ReceivePacket(this.InternalConnection.GetIndex(), payload, payloadSize);

    private void OnNetcodeStateChanged(NetcodeClientState state)
    {
      Log.Netcode(string.Format("Client NetcodeClientState changed to {0}", (object) state));
      if (this.netcodeClient.State < NetcodeClientState.Disconnected)
      {
        this.Disconnect();
        this.SetClientState(RumpfieldState.Error);
      }
      else if (this.netcodeClient.State == NetcodeClientState.Disconnected)
      {
        this.Disconnect();
        this.SetClientState(RumpfieldState.Disconnected);
      }
      else if (this.netcodeClient.State == NetcodeClientState.SendingConnectionRequest || this.netcodeClient.State == NetcodeClientState.SendingChallengeResponse)
      {
        this.SetClientState(RumpfieldState.Connecting);
      }
      else
      {
        if (this.InternalConnection.GetIndex() == -1)
          this.InternalConnection.Connect(this.netcodeClient.clientIndex);
        this.SetClientState(RumpfieldState.Connected);
      }
    }

    private void AckPacketFunction(int clientIndex, ushort ackSequence)
    {
    }

    private void ProcessPacketFunction(int index, ushort sequence, byte[] buffer, int bufferSize)
    {
      this.InternalConnection.ProcessPacket(sequence, buffer, bufferSize);
      while (this.InternalConnection != null)
      {
        RMessage rmessage = this.InternalConnection.RecvMessage();
        if (rmessage == null)
          break;
        if (this.OnMessageReceived != null)
          this.OnMessageReceived(index, sequence, rmessage.buffer, (int) rmessage.BufferSize);
      }
    }

    public void Tick(double time)
    {
      this.time = time;
      this.NetcodeTick();
      this.ReliableTick();
    }

    public void ForceSend(double time)
    {
      if (this.InternalConnection == null || this.InternalConnection.GetEndpoint() == null)
        return;
      this.InternalConnection.Send(time);
    }

    private void TransmitPacketFunction(int index, ushort sequence, byte[] buffer, int bufferSize) => this.netcodeClient.SendPayload(buffer, bufferSize);

    private void ReliableTick()
    {
      if (this.InternalConnection == null || this.InternalConnection.GetEndpoint() == null)
        return;
      this.InternalConnection.Tick(this.time);
    }

    private void AckCallback(int i, ushort ackSequence)
    {
      if (this.OnMessageAcknowledged == null)
        return;
      this.OnMessageAcknowledged(this.ClientIndex, ackSequence);
    }

    private void NetcodeTick()
    {
      if (this.netcodeClient == null)
        return;
      this.netcodeClient.Tick(this.time);
    }

    public void Disconnect()
    {
      this.SetClientState(RumpfieldState.Disconnected);
      this.netcodeClient.Disconnect();
      this.InternalConnection = (IConnection) null;
    }

    private void SetClientState(RumpfieldState state)
    {
      if (this.State != state)
      {
        RumpfieldClient.OnStateChangedDelegate onStateChanged = this.OnStateChanged;
        if (onStateChanged != null)
          onStateChanged(state);
      }
      this.State = state;
    }

    public int GetClientIndex() => this.netcodeClient != null ? this.netcodeClient.clientIndex : -1;

    public bool IsConnected() => this.State == RumpfieldState.Connected;

    public bool IsConnecting() => this.State == RumpfieldState.Connecting;

    public bool IsDisconnected() => this.State <= RumpfieldState.Disconnected;

    public bool HasConnectionFailed() => this.State == RumpfieldState.Error;

    public int GetMaxServerSlots() => this.netcodeClient != null ? (int) this.netcodeClient.MaxSlots : -1;

    public delegate void OnMessageAckedDelegate(int clientindex, ushort ackSequence);

    public delegate void OnMessageReceivedDelegate(
      int clientIndex,
      ushort sequence,
      byte[] buffer,
      int bufferSize);

    public delegate void OnStateChangedDelegate(RumpfieldState state);
  }
}
