// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.SteelClient
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Networking.Messages;
using Imi.Networking.Messages.SerDes;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.Networking.Netcode.Utils;
using Imi.SharedWithServer.Networking.reliable.core;
using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using Imi.SharedWithServer.Networking.Rumpfield.Core;
using System;
using UnityEngine;

namespace Imi.SteelCircus.Networking
{
  public sealed class SteelClient
  {
    private static readonly SteelClient internalInstance = new SteelClient();
    private readonly SteelClientAdapter typeMapping;
    private RumpfieldClient rumpfieldClient;
    private RumpfieldState rumpfieldState;
    private Action onConnected;
    private Action onConnectedTmp;
    private ReliableEndpoint reliableEndpoint;
    private MessageBitSizeReader messageSizeReader;
    private MessageBitSerializer messageSerializer;
    private MessageBitDeserializer messageDeserializer;
    private Action<float, float, float, float, float> infoCallback;

    public SteelClient()
    {
      this.typeMapping = new SteelClientAdapter();
      this.messageSizeReader = new MessageBitSizeReader();
      this.messageSerializer = new MessageBitSerializer();
    }

    public RumpfieldClient Client => this.rumpfieldClient;

    public event SteelClient.OnMessageReceivedDelegate OnMessageReceived;

    public event SteelClient.OnMessageAckedDelegate OnMessageAcknowledged;

    public event SteelClient.OnStateChangedDelegate OnStateChanged;

    public void Connect(byte[] token)
    {
      this.rumpfieldClient.Connect(token);
      this.reliableEndpoint = this.rumpfieldClient.InternalConnection.GetEndpoint();
    }

    public void Connect(
      byte[] token,
      ulong clientId,
      double time,
      Action connected,
      Action<string> failed)
    {
      this.rumpfieldClient = new RumpfieldClient(clientId, time);
      this.onConnectedTmp = this.onConnected;
      this.onConnectedTmp += connected;
      this.ForwardCallbacks(this.onConnectedTmp, failed);
      this.rumpfieldClient.Connect(token);
      this.reliableEndpoint = this.rumpfieldClient.InternalConnection.GetEndpoint();
    }

    private void ForwardCallbacks(Action connected, Action<string> failed)
    {
      this.rumpfieldClient.OnStateChanged += (RumpfieldClient.OnStateChangedDelegate) (state =>
      {
        if (this.OnStateChanged == null)
          return;
        this.OnStateChanged(state);
      });
      this.rumpfieldClient.OnStateChanged += (RumpfieldClient.OnStateChangedDelegate) (state =>
      {
        if (this.rumpfieldState == state)
          return;
        this.rumpfieldState = state;
        if (state == RumpfieldState.Connected)
        {
          connected();
          this.onConnected = (Action) null;
        }
        else
        {
          if (state != RumpfieldState.Error)
            return;
          failed(NetcodeStateHelper.Get(this.rumpfieldClient.NetcodeState));
        }
      });
      this.rumpfieldClient.OnMessageReceived += (RumpfieldClient.OnMessageReceivedDelegate) ((index, sequence, buffer, size) => this.BufferToMessage(buffer));
      this.rumpfieldClient.OnMessageAcknowledged += (RumpfieldClient.OnMessageAckedDelegate) ((index, sequence) =>
      {
        if (this.OnMessageAcknowledged == null)
          return;
        this.OnMessageAcknowledged(index, sequence);
      });
    }

    private void BufferToMessage(byte[] buffer)
    {
      if (this.messageDeserializer == null)
        this.messageDeserializer = new MessageBitDeserializer(buffer);
      else
        this.messageDeserializer.BeginNew(buffer);
      Message message = this.typeMapping.CreateMessage((RumpfieldMessageType) buffer[0]);
      message.SerDes((IMessageSerDes) this.messageDeserializer);
      this.messageDeserializer.Finish();
      this.ReceivedMessage(message);
      if (!message.IsPooled())
        return;
      this.typeMapping.Return(message);
    }

    private void ReceivedMessage(Message m) => this.typeMapping.CreateEvent(m);

    public void SendReliable(Message msg)
    {
      if (this.rumpfieldClient == null)
        return;
      this.messageSizeReader.Begin(0);
      msg.SerDes((IMessageSerDes) this.messageSizeReader);
      int bytesRequired = this.messageSizeReader.GetBytesRequired();
      this.rumpfieldClient.SendPayload(QualityOfService.Reliable, this.Serialize(msg, bytesRequired), (int) (ushort) bytesRequired);
    }

    private byte[] Serialize(Message msg, int size)
    {
      this.messageSerializer.Begin(size);
      msg.SerDes((IMessageSerDes) this.messageSerializer);
      this.messageSerializer.Finish();
      return this.messageSerializer.GetBuffer();
    }

    public void SendUnreliable(Message msg)
    {
      if (this.rumpfieldClient == null)
        return;
      this.messageSizeReader.Begin(0);
      msg.SerDes((IMessageSerDes) this.messageSizeReader);
      this.messageSizeReader.Finish();
      int bytesRequired = this.messageSizeReader.GetBytesRequired();
      this.rumpfieldClient.SendPayload(QualityOfService.Unreliable, this.Serialize(msg, bytesRequired), (int) (ushort) bytesRequired);
    }

    public RumpfieldState GetState() => this.rumpfieldState;

    public int GetIndex() => this.rumpfieldClient != null ? this.rumpfieldClient.ClientIndex : -1;

    public int GetMaxServerClients() => this.rumpfieldClient != null ? this.rumpfieldClient.GetMaxServerSlots() : -1;

    public void Disconnect()
    {
      if (this.rumpfieldClient == null)
        return;
      this.rumpfieldState = RumpfieldState.Disconnected;
      this.rumpfieldClient.Disconnect();
    }

    public void HandleTick(double time)
    {
      if (this.rumpfieldClient == null)
        return;
      this.rumpfieldClient.Tick(time);
      if (this.reliableEndpoint == null)
        return;
      Action<float, float, float, float, float> infoCallback = this.infoCallback;
      if (infoCallback == null)
        return;
      infoCallback(this.reliableEndpoint.Rtt, this.reliableEndpoint.PacketLoss, this.reliableEndpoint.SentBandwidth, this.reliableEndpoint.RecvBandwidth, this.reliableEndpoint.AckedBandwidth);
    }

    public void SetNetworkInfoCallback(
      Action<float, float, float, float, float> infoCallback)
    {
      this.infoCallback = infoCallback;
    }

    public void ForceSend(double time)
    {
      if (this.rumpfieldClient == null)
        return;
      this.rumpfieldClient.ForceSend(time);
    }

    public void Destroy()
    {
      if (this.rumpfieldClient == null)
        return;
      if (this.rumpfieldClient.State == RumpfieldState.Disconnected)
      {
        this.rumpfieldClient = (RumpfieldClient) null;
      }
      else
      {
        this.rumpfieldClient.Disconnect();
        this.rumpfieldClient = (RumpfieldClient) null;
      }
    }

    public void ExecuteOnConnect(Action doOnConnected)
    {
      if (this.rumpfieldState == RumpfieldState.Connected)
        doOnConnected();
      else
        this.onConnected += doOnConnected;
    }

    public int GetRttt(int tickRate) => this.rumpfieldClient.IsConnected() ? Mathf.CeilToInt(this.rumpfieldClient.InternalConnection.GetEndpoint().Rtt / (float) (1.0 / (double) tickRate * 1000.0)) : -1;

    public void ReleaseGameMessage(GameMessage m) => this.typeMapping.ReleaseGameMessage(m);

    public bool IsConnected() => this.rumpfieldClient != null && this.rumpfieldClient.IsConnected();

    public bool IsConnecting() => this.rumpfieldClient != null && this.rumpfieldClient.IsConnecting();

    public delegate void OnMessageReceivedDelegate(
      int clientIndex,
      ushort sequence,
      Message message);

    public delegate void OnMessageAckedDelegate(int clientindex, ushort ackSequence);

    public delegate void OnStateChangedDelegate(RumpfieldState state);
  }
}
