// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.PlayerMovementMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class PlayerMovementMessage : PlayerRespawnMessage
  {
    private const RumpfieldMessageType Type = RumpfieldMessageType.PlayerMovement;
    public ushort sequence;

    public PlayerMovementMessage()
      : base(RumpfieldMessageType.PlayerMovement)
    {
    }

    public PlayerMovementMessage(ushort sequence, JVector position, JQuaternion orientation)
      : base(position, orientation, RumpfieldMessageType.PlayerMovement)
    {
      this.sequence = sequence;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UShort(ref this.sequence);
      this.SerializeOrDeserializeData(messageSerDes);
    }

    public override string ToString() => string.Format("PlayerMovementMessage {0} {1} {2}", (object) this.sequence, (object) this.position, (object) this.orientation);
  }
}
