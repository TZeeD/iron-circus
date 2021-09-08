// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.Message
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public abstract class Message
  {
    protected const bool NotPooled = false;
    protected const bool Pooled = true;
    protected RumpfieldMessageType messageType;
    protected bool isPooled;

    protected Message(RumpfieldMessageType type) => this.messageType = type;

    protected Message(RumpfieldMessageType type, bool pooled)
    {
      this.messageType = type;
      this.isPooled = pooled;
    }

    protected abstract void SerializeOrDeserialize(IMessageSerDes messageSerDes);

    public RumpfieldMessageType GetMessageType() => this.messageType;

    public bool IsPooled() => this.isPooled;

    public void SerDes(IMessageSerDes messageSerDes)
    {
      this.SerializeOrDeserializeMessageType(messageSerDes);
      this.SerializeOrDeserialize(messageSerDes);
    }

    private void SerializeOrDeserializeMessageType(IMessageSerDes messageSerDes)
    {
      byte messageType = (byte) this.messageType;
      messageSerDes.Byte(ref messageType);
      this.messageType = (RumpfieldMessageType) messageType;
    }
  }
}
