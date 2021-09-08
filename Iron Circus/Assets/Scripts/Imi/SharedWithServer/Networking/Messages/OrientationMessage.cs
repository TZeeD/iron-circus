// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.OrientationMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class OrientationMessage : Message
  {
    public const RumpfieldMessageType Type = RumpfieldMessageType.Orientation;
    public int id;
    public JQuaternion orientation;

    public OrientationMessage()
      : base(RumpfieldMessageType.Orientation)
    {
    }

    public OrientationMessage(int id, JQuaternion orientation)
      : base(RumpfieldMessageType.Orientation)
    {
      this.id = id;
      this.orientation = orientation;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.id);
      messageSerDes.Float(ref this.orientation.X);
      messageSerDes.Float(ref this.orientation.Y);
      messageSerDes.Float(ref this.orientation.Z);
      messageSerDes.Float(ref this.orientation.W);
    }

    public override string ToString() => string.Format("{0} {1}", (object) this.id, (object) this.orientation);
  }
}
