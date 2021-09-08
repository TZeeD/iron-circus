// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channels.ReliableOrderedChannel
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.reliable;
using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.Channels
{
  public class ReliableOrderedChannel : Channel
  {
    public const int PacketBufferSize = 256;
    public const int ResendBufferSize = 64;
    public const double MessageResendTime = 0.1;
    private ushort lastReceivedMessageId;
    private SequenceBufferClass<ReliableOrderedChannel.MessageReceivedQueueEntry> messageReceivedQueue;
    private SequenceBufferClass<ReliableOrderedChannel.MessageSendQueueEntry> messageSendQueue;
    private ushort oldestUnackedMessageId;
    private ushort sendMessageId;
    private SequenceBufferClass<ReliableOrderedChannel.SentPacketEntry> sentPackets;
    private double time;

    public ReliableOrderedChannel() => this.Reset();

    public override sealed void Reset()
    {
      this.sentPackets = new SequenceBufferClass<ReliableOrderedChannel.SentPacketEntry>(256);
      this.messageSendQueue = new SequenceBufferClass<ReliableOrderedChannel.MessageSendQueueEntry>(256);
      this.messageReceivedQueue = new SequenceBufferClass<ReliableOrderedChannel.MessageReceivedQueueEntry>(256);
      this.lastReceivedMessageId = (ushort) 0;
      this.sendMessageId = (ushort) 0;
      this.oldestUnackedMessageId = (ushort) 0;
      this.time = 0.0;
    }

    public override bool HasMessageToSend()
    {
      if ((int) this.oldestUnackedMessageId == (int) this.sendMessageId)
        return false;
      int num = 64;
      for (int index = 0; index < num; ++index)
      {
        ReliableOrderedChannel.MessageSendQueueEntry messageSendQueueEntry = this.messageSendQueue.Find((ushort) ((uint) this.oldestUnackedMessageId + (uint) index));
        if (messageSendQueueEntry != null && messageSendQueueEntry.timeLastSent + 0.1 <= this.time)
          return true;
      }
      return false;
    }

    public override RMessage RecvMessage()
    {
      ReliableOrderedChannel.MessageReceivedQueueEntry receivedQueueEntry = this.messageReceivedQueue.Find(this.lastReceivedMessageId);
      if (receivedQueueEntry == null)
        return (RMessage) null;
      RMessage message = receivedQueueEntry.message;
      this.messageReceivedQueue.Remove(this.lastReceivedMessageId);
      ++this.lastReceivedMessageId;
      return message;
    }

    public override void Tick(double time) => this.time = time;

    public override void ToPacketData(ushort sequence, IChannelTransport channelTransport)
    {
      if (!this.HasMessageToSend())
        return;
      List<ushort> ushortList = new List<ushort>(64);
      int num = 256;
      for (int index = 0; index < num; ++index)
      {
        ushort sequence1 = (ushort) ((uint) this.oldestUnackedMessageId + (uint) index);
        ReliableOrderedChannel.MessageSendQueueEntry messageSendQueueEntry = this.messageSendQueue.Find(sequence1);
        if (messageSendQueueEntry != null && messageSendQueueEntry.timeLastSent + 0.1 <= this.time)
        {
          if (channelTransport.TryToAdd(messageSendQueueEntry.message))
          {
            ushortList.Add(sequence1);
            messageSendQueueEntry.timeLastSent = this.time;
          }
          else
            break;
        }
      }
      if (ushortList.Count <= 0)
        return;
      ReliableOrderedChannel.SentPacketEntry sentPacketEntry = this.sentPackets.Insert(sequence);
      if (sentPacketEntry == null)
        return;
      sentPacketEntry.acked = false;
      sentPacketEntry.timeSent = this.time;
      sentPacketEntry.messageIds = ushortList.ToArray();
      sentPacketEntry.numMessages = (ushort) ushortList.Count;
    }

    public override void ProcessPacketData(ushort sequence, IChannelTransport channeltransport)
    {
      ushort receivedMessageId = this.lastReceivedMessageId;
      ushort s2 = (ushort) ((int) this.lastReceivedMessageId + this.messageReceivedQueue.Capacity - 1);
      int count = (int) channeltransport.GetCount();
      List<RMessage> messages = channeltransport.GetMessages();
      for (int index = 0; index < count; ++index)
      {
        ushort id = messages[index].Id;
        if (!SequenceUtil.SequenceLessThan(id, receivedMessageId))
        {
          if (SequenceUtil.SequenceGreaterThan(id, s2))
            break;
          if (this.messageReceivedQueue.Find(id) == null)
          {
            ReliableOrderedChannel.MessageReceivedQueueEntry receivedQueueEntry = this.messageReceivedQueue.Insert(id);
            if (receivedQueueEntry == null)
              break;
            receivedQueueEntry.message = messages[index];
          }
        }
      }
    }

    public override void ProcessPacketAck(ushort ackSequence)
    {
      ReliableOrderedChannel.SentPacketEntry sentPacketEntry = this.sentPackets.Find(ackSequence);
      if (sentPacketEntry == null)
        return;
      for (int index = 0; index < (int) sentPacketEntry.numMessages; ++index)
      {
        ushort messageId = sentPacketEntry.messageIds[index];
        if (this.messageSendQueue.Find(messageId) == null)
          break;
        this.messageSendQueue.Remove(messageId);
        ushort mostRecentSequence = this.messageSendQueue.MostRecentSequence;
        while ((int) this.oldestUnackedMessageId != (int) mostRecentSequence && this.messageSendQueue.Find(this.oldestUnackedMessageId) == null)
          ++this.oldestUnackedMessageId;
      }
    }

    public override bool CanSendMessage() => this.messageSendQueue.Available(this.sendMessageId);

    public override int SendMessage(RMessage message)
    {
      message.Id = this.sendMessageId;
      ReliableOrderedChannel.MessageSendQueueEntry messageSendQueueEntry = this.messageSendQueue.Insert(this.sendMessageId);
      messageSendQueueEntry.message = message;
      messageSendQueueEntry.timeLastSent = -1.0;
      ++this.sendMessageId;
      return (int) message.Id;
    }

    public class MessageSendQueueEntry
    {
      public RMessage message;
      public double timeLastSent;
    }

    public class MessageReceivedQueueEntry
    {
      public RMessage message;
    }

    public class SentPacketEntry
    {
      public bool acked;
      public ushort[] messageIds;
      public ushort numMessages;
      public double timeSent;
    }
  }
}
