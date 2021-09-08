// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.PlayerRespawnMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class PlayerRespawnMessage : Message
  {
    private const RumpfieldMessageType Type = RumpfieldMessageType.PlayerRespawn;
    public JQuaternion orientation;
    public JVector position;

    public PlayerRespawnMessage()
      : this(RumpfieldMessageType.PlayerRespawn)
    {
    }

    public PlayerRespawnMessage(JVector position, JQuaternion orientation)
      : this(position, orientation, RumpfieldMessageType.PlayerRespawn)
    {
    }

    protected PlayerRespawnMessage(RumpfieldMessageType messageType)
      : base(messageType, true)
    {
    }

    protected PlayerRespawnMessage(
      JVector position,
      JQuaternion orientation,
      RumpfieldMessageType messageType)
      : base(messageType, true)
    {
      this.position = position;
      this.orientation = orientation;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes) => this.SerializeOrDeserializeData(messageSerDes);

    protected void SerializeOrDeserializeData(IMessageSerDes messageSerDes)
    {
      messageSerDes.Float(ref this.position.X);
      messageSerDes.Float(ref this.position.Y);
      messageSerDes.Float(ref this.position.Z);
      messageSerDes.Float(ref this.orientation.X);
      messageSerDes.Float(ref this.orientation.Y);
      messageSerDes.Float(ref this.orientation.Z);
      messageSerDes.Float(ref this.orientation.W);
    }
  }
}
