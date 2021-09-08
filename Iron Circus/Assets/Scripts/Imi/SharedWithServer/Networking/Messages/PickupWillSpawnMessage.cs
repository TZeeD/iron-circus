// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.PickupWillSpawnMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class PickupWillSpawnMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.PickupWillSpawn;
    public UniqueId id;
    public PickupType pickupType;
    public float duration;

    public PickupWillSpawnMessage()
      : base(PickupWillSpawnMessage.Type, true)
    {
    }

    public PickupWillSpawnMessage(UniqueId id, PickupType pickupType, float duration)
      : base(PickupWillSpawnMessage.Type, true)
    {
      this.id = id;
      this.duration = duration;
      this.pickupType = pickupType;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UniqueId(ref this.id);
      messageSerDes.Float(ref this.duration);
      byte pickupType = (byte) this.pickupType;
      messageSerDes.Byte(ref pickupType);
      this.pickupType = (PickupType) pickupType;
    }
  }
}
