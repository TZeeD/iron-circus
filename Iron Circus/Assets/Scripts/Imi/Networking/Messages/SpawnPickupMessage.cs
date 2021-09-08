// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.SpawnPickupMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.Networking.Messages
{
  public class SpawnPickupMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.PickupSpawned;
    public UniqueId id;
    public int pickupType;
    public float x;
    public float y;
    public float z;

    public SpawnPickupMessage()
      : base(SpawnPickupMessage.Type, true)
    {
    }

    public SpawnPickupMessage(JVector position, PickupType pickupType, UniqueId id)
      : base(SpawnPickupMessage.Type, true)
    {
      this.x = position.X;
      this.y = position.Y;
      this.z = position.Z;
      this.pickupType = (int) pickupType;
      this.id = id;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.x);
      messageSerDes.Float(ref this.y);
      messageSerDes.Float(ref this.z);
      messageSerDes.Int(ref this.pickupType);
      messageSerDes.UniqueId(ref this.id);
    }
  }
}
