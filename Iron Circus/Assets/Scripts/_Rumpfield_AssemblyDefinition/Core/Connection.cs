// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Core.Connection
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.reliable.core;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channels;
using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Rumpfield.Core
{
  public class Connection : IConnection
  {
    private readonly Dictionary<int, Channel> channels;
    private readonly ReliableEndpoint endpoint;
    private ulong id;
    private int index;
    private double lastTickTime = double.MaxValue;
    private RumpfieldState state;
    private double time;
    private bool autoSend;

    public Connection(int index, ReliableEndpoint endpoint, double time)
      : this(0UL, index, endpoint, time)
    {
    }

    public Connection(ulong id, int index, ReliableEndpoint endpoint, double time, bool autoSend = false)
    {
      this.id = id;
      this.index = index;
      this.endpoint = endpoint;
      this.time = time;
      this.channels = new Dictionary<int, Channel>(2);
      this.channels.Add(0, (Channel) new UnreliableChannel());
      this.channels.Add(1, (Channel) new ReliableOrderedChannel());
      this.state = RumpfieldState.Disconnected;
      this.autoSend = autoSend;
    }

    public int GetIndex() => this.index;

    public void SetIndex(int value) => this.index = value;

    public ulong GetId() => this.id;

    public void SetId(ulong id) => this.id = id;

    public RumpfieldState GetState() => this.state;

    public void SetState(RumpfieldState state) => this.state = state;

    public ReliableEndpoint GetEndpoint() => this.endpoint;

    public double GetLastTickTime() => this.lastTickTime;

    public int SendMessage(QualityOfService qos, RMessage message) => this.channels[(int) qos].CanSendMessage() ? this.channels[(int) qos].SendMessage(message) : -1;

    public RMessage RecvMessage()
    {
      for (int key = 0; key < this.channels.Count; ++key)
      {
        RMessage rmessage = this.channels[key].RecvMessage();
        if (rmessage != null)
          return rmessage;
      }
      return (RMessage) null;
    }

    public void ProcessPacket(ushort sequence, byte[] data, int size)
    {
      RPacketTransport rpacketTransport = new RPacketTransport(this.channels.Count);
      rpacketTransport.FillWithByteArray(data);
      for (int index = 0; index < this.channels.Count; ++index)
      {
        IChannelTransport transport = rpacketTransport.GetTransport(index);
        if (transport.GetCount() > (ushort) 0)
          this.channels[index].ProcessPacketData(sequence, transport);
      }
    }

    public void Tick(double timestamp)
    {
      this.lastTickTime = this.time;
      this.time = timestamp;
      if (this.autoSend)
        this.Send(timestamp);
      for (int key = 0; key < this.channels.Count; ++key)
        this.channels[key].Tick(this.time);
      ushort[] acks = this.endpoint.GetAcks();
      uint numAcks = (uint) this.endpoint.NumAcks;
      for (int index = 0; (long) index < (long) numAcks; ++index)
      {
        for (int key = 0; key < this.channels.Count; ++key)
          this.channels[key].ProcessPacketAck(acks[index]);
      }
      this.endpoint.ClearAcks();
      this.endpoint.Tick(this.time);
    }

    public void Send(double time)
    {
      while (this.AnyChannelWantsToSend())
      {
        ushort nextSequence = this.endpoint.NextSequence;
        RPacketTransport rpacketTransport = new RPacketTransport(this.channels.Count);
        for (int key = 0; key < this.channels.Count; ++key)
        {
          Channel channel = this.channels[key];
          ChannelTransportWithBudget transportWithBudget1 = new ChannelTransportWithBudget(new Budget(300, 5));
          rpacketTransport.AddChannelTransport((IChannelTransport) transportWithBudget1);
          int num = (int) nextSequence;
          ChannelTransportWithBudget transportWithBudget2 = transportWithBudget1;
          channel.ToPacketData((ushort) num, (IChannelTransport) transportWithBudget2);
        }
        byte[] byteArray = rpacketTransport.ToByteArray();
        this.endpoint.SendPacket(byteArray, byteArray.Length);
      }
    }

    public void Reset()
    {
      this.index = -1;
      this.id = 0UL;
      this.endpoint.Reset();
      this.ResetChannels();
    }

    public void ResetChannels()
    {
      for (int key = 0; key < this.channels.Count; ++key)
        this.channels[key].Reset();
    }

    public void Connect(int index)
    {
      this.state = RumpfieldState.Connected;
      this.index = index;
      this.endpoint.Config.Index = index;
    }

    public void Disconnect()
    {
      this.state = RumpfieldState.Disconnected;
      this.index = -1;
      this.endpoint.Config.Index = -1;
      this.ResetChannels();
      this.endpoint.Reset();
    }

    public event Connection.OnMessageAckedDelegate OnMessageAcknowledged;

    private void AckCallback(ushort ackSequence)
    {
      if (this.OnMessageAcknowledged == null)
        return;
      this.OnMessageAcknowledged(this.index, ackSequence);
    }

    private bool AnyChannelWantsToSend()
    {
      for (int key = 0; key < this.channels.Count; ++key)
      {
        if (this.channels[key].HasMessageToSend())
          return true;
      }
      return false;
    }

    public delegate void OnMessageAckedDelegate(int clientIndex, ushort ackedSequence);
  }
}
