// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.DisconnectMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class DisconnectMessage : Message
  {
    public ulong id;
    public byte index;

    public DisconnectMessage()
      : base(RumpfieldMessageType.Disconnect, true)
    {
    }

    public DisconnectMessage(ulong id, byte index)
      : base(RumpfieldMessageType.Disconnect, true)
    {
      this.id = id;
      this.index = index;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.id);
      messageSerDes.Byte(ref this.index);
    }
  }
}
