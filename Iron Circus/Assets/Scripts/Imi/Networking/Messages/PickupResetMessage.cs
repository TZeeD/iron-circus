// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.PickupResetMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class PickupResetMessage : Message
  {
    public UniqueId id;

    public PickupResetMessage()
      : base(RumpfieldMessageType.ResetPickup, true)
    {
    }

    public PickupResetMessage(UniqueId id)
      : base(RumpfieldMessageType.ResetPickup, true)
    {
      this.id = id;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => messageSerDes.UniqueId(ref this.id);
  }
}
