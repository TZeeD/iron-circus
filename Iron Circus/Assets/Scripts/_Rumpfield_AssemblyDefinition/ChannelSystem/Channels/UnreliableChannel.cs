// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channels.UnreliableChannel
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channels
{
  public class UnreliableChannel : Channel
  {
    public const int SequenceBufferSize = 256;
    public ushort messageId;
    private readonly Queue<RMessage> recvQueue;
    private readonly Queue<RMessage> sendQueue;

    public UnreliableChannel()
    {
      this.sendQueue = new Queue<RMessage>(256);
      this.recvQueue = new Queue<RMessage>(256);
    }

    public override void Reset()
    {
      this.sendQueue.Clear();
      this.recvQueue.Clear();
    }

    public override bool HasMessageToSend() => this.sendQueue.Count > 0;

    public override bool CanSendMessage() => this.sendQueue.Count < 256;

    public override int SendMessage(RMessage message)
    {
      message.Id = this.messageId;
      this.sendQueue.Enqueue(message);
      return (int) this.messageId++;
    }

    public override RMessage RecvMessage() => this.recvQueue.Count > 0 ? this.recvQueue.Dequeue() : (RMessage) null;

    public override void Tick(double timestamp)
    {
    }

    public override void ToPacketData(ushort sequence, IChannelTransport channelTransport)
    {
      while (this.HasMessageToSend() && channelTransport.TryToAdd(this.sendQueue.Peek()))
        this.sendQueue.Dequeue();
    }

    public override void ProcessPacketData(ushort sequence, IChannelTransport channeltransport)
    {
      for (int index = 0; index < (int) channeltransport.GetCount(); ++index)
      {
        if (this.recvQueue.Count < 256)
          this.recvQueue.Enqueue(channeltransport.GetMessages()[index]);
      }
    }

    public override void ProcessPacketAck(ushort ackSequence)
    {
    }
  }
}
