// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.MessageFactory
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using System.Collections.Generic;

namespace Imi.SteelCircus.Networking
{
  public class MessageFactory
  {
    private Dictionary<RumpfieldMessageType, Queue<Message>> messagePools;

    public MessageFactory() => this.messagePools = new Dictionary<RumpfieldMessageType, Queue<Message>>(32);

    public void RegisterPool<T>(RumpfieldMessageType messageType) where T : Message, new()
    {
      if (this.messagePools.ContainsKey(messageType))
        return;
      this.messagePools[messageType] = new Queue<Message>(10);
      for (int index = 0; index < 10; ++index)
        this.messagePools[messageType].Enqueue((Message) new T());
    }

    public T Get<T>(RumpfieldMessageType type) where T : Message, new()
    {
      Queue<Message> messageQueue;
      if (this.messagePools.TryGetValue(type, out messageQueue))
        return messageQueue.Count > 0 ? (T) messageQueue.Dequeue() : new T();
      this.messagePools[type] = new Queue<Message>(10);
      return new T();
    }

    public void Return<T>(T message) where T : Message
    {
      Queue<Message> messageQueue;
      if (!this.messagePools.TryGetValue(message.GetMessageType(), out messageQueue) || messageQueue.Count >= 10)
        return;
      messageQueue.Enqueue((Message) message);
    }
  }
}
