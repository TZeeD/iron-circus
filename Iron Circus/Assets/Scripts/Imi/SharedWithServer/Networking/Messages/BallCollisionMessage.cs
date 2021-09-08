// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.BallCollisionMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class BallCollisionMessage : Message
  {
    private const RumpfieldMessageType Type = RumpfieldMessageType.BallCollision;
    public UniqueId collideeUniqueId;
    public JVector position;
    public JVector normal;

    public BallCollisionMessage()
      : base(RumpfieldMessageType.BallCollision, true)
    {
    }

    public BallCollisionMessage(UniqueId collideeUniqueId, JVector position, JVector normal)
      : base(RumpfieldMessageType.BallCollision, true)
    {
      this.collideeUniqueId = collideeUniqueId;
      this.position = position;
      this.normal = normal;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UniqueId(ref this.collideeUniqueId);
      messageSerDes.JVector(ref this.position);
      messageSerDes.JVector(ref this.normal);
    }
  }
}
