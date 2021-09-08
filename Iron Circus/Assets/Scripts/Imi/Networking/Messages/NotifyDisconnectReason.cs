// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.NotifyDisconnectReason
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class NotifyDisconnectReason : Message
  {
    public DisconnectReason reason;

    public NotifyDisconnectReason()
      : base(RumpfieldMessageType.NotifyDisconnect, true)
    {
    }

    public NotifyDisconnectReason(DisconnectReason reason)
      : base(RumpfieldMessageType.NotifyDisconnect, true)
    {
      this.reason = reason;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      byte reason = (byte) this.reason;
      messageSerDes.Byte(ref reason);
      this.reason = (DisconnectReason) reason;
    }
  }
}
