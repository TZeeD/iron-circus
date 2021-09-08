// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.PickupConsumedMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.Networking.Messages
{
  public class PickupConsumedMessage : Message
  {
    public UniqueId id;
    public UniqueId playerUniqueId;

    public PickupConsumedMessage()
      : base(RumpfieldMessageType.PickupConsumed, true)
    {
    }

    public PickupConsumedMessage(UniqueId id, UniqueId playerUniqueId)
      : base(RumpfieldMessageType.PickupConsumed, true)
    {
      this.id = id;
      this.playerUniqueId = playerUniqueId;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UniqueId(ref this.id);
      messageSerDes.UniqueId(ref this.playerUniqueId);
    }
  }
}
