// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Networking.Messages.BumperCollisionDisableMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace SharedWithServer.Networking.Messages
{
  public class BumperCollisionDisableMessage : Message
  {
    public UniqueId[] BumperIds;

    public BumperCollisionDisableMessage()
      : base(RumpfieldMessageType.BumperCollisionDisable)
    {
    }

    public BumperCollisionDisableMessage(UniqueId[] newBumperIds)
      : base(RumpfieldMessageType.BumperCollisionDisable)
    {
      this.BumperIds = newBumperIds;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      if (messageSerDes.IsSerializer())
        this.SerializeUniqueIdArray(messageSerDes);
      else
        this.DeserializeUniqueIdArray(messageSerDes);
    }

    private void SerializeUniqueIdArray(IMessageSerDes messageSerDes)
    {
      byte length = (byte) this.BumperIds.Length;
      messageSerDes.Byte(ref length);
      for (int index = 0; index < (int) length; ++index)
        messageSerDes.UniqueId(ref this.BumperIds[index]);
    }

    private void DeserializeUniqueIdArray(IMessageSerDes messageSerDes)
    {
      byte num = 0;
      messageSerDes.Byte(ref num);
      this.BumperIds = new UniqueId[(int) num];
      for (int index = 0; index < (int) num; ++index)
        messageSerDes.UniqueId(ref this.BumperIds[index]);
    }
  }
}
