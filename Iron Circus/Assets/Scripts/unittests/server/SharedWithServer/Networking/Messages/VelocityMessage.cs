// Decompiled with JetBrains decompiler
// Type: unittests.server.SharedWithServer.Networking.Messages.VelocityMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;

namespace unittests.server.SharedWithServer.Networking.Messages
{
  public class VelocityMessage : Message
  {
    private const RumpfieldMessageType Type = RumpfieldMessageType.Velocity;
    public UniqueId id;
    public float x;
    public float y;
    public float z;

    public VelocityMessage()
      : base(RumpfieldMessageType.Velocity, true)
    {
    }

    public VelocityMessage(UniqueId id, float x, float y, float z)
      : base(RumpfieldMessageType.Velocity, true)
    {
      this.id = id;
      this.x = x;
      this.y = y;
      this.z = z;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UniqueId(ref this.id);
      messageSerDes.Float(ref this.x);
      messageSerDes.Float(ref this.y);
      messageSerDes.Float(ref this.z);
    }

    public override string ToString() => string.Format("VelocityMessage {0} {1} {2} {3}", (object) this.id, (object) this.x, (object) this.y, (object) this.z);
  }
}
