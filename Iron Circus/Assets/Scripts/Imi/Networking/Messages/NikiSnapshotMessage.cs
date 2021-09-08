// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.NikiSnapshotMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.Networking.Messages
{
  public class NikiSnapshotMessage : Message
  {
    public ulong playerid;
    public JVector position;
    public JVector velocity;
    public JQuaternion orientation;
    public int serverTick;

    public NikiSnapshotMessage()
      : base(RumpfieldMessageType.NikiSnapshot)
    {
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.serverTick);
      messageSerDes.ULong(ref this.playerid);
      messageSerDes.Float(ref this.position.X);
      messageSerDes.Float(ref this.position.Y);
      messageSerDes.Float(ref this.position.Z);
      messageSerDes.Float(ref this.velocity.X);
      messageSerDes.Float(ref this.velocity.Y);
      messageSerDes.Float(ref this.velocity.Z);
      messageSerDes.Float(ref this.orientation.X);
      messageSerDes.Float(ref this.orientation.Y);
      messageSerDes.Float(ref this.orientation.Z);
      messageSerDes.Float(ref this.orientation.W);
    }
  }
}
