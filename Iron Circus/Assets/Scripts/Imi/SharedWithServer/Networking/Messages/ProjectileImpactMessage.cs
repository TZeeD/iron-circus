// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.ProjectileImpactMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class ProjectileImpactMessage : Message
  {
    public int projectileType;
    public JVector position;
    public int aoeShape;
    public float aoeRadius;
    public float aoeAngle;
    public float aoeDeadZone;

    public ProjectileImpactMessage()
      : base(RumpfieldMessageType.ProjectileImpact)
    {
    }

    public ProjectileImpactMessage(
      int projectileType,
      JVector position,
      int aoeShape,
      float aoeRadius,
      float aoeAngle,
      float aoeDeadZone)
      : base(RumpfieldMessageType.ProjectileImpact)
    {
      this.projectileType = projectileType;
      this.position = position;
      this.aoeShape = aoeShape;
      this.aoeRadius = aoeRadius;
      this.aoeAngle = aoeAngle;
      this.aoeDeadZone = aoeDeadZone;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.Int(ref this.projectileType);
      messageSerDes.JVector(ref this.position);
      messageSerDes.Int(ref this.aoeShape);
      messageSerDes.Float(ref this.aoeRadius);
      messageSerDes.Float(ref this.aoeAngle);
      messageSerDes.Float(ref this.aoeDeadZone);
    }
  }
}
