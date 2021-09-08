// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SpawnProjectileMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class SpawnProjectileMessage : Message
  {
    private static readonly RumpfieldMessageType Type = RumpfieldMessageType.SpawnProjectile;
    public ushort uniqueId;
    public ulong owner;
    public int projectileType;
    public float radius;
    public float height;
    public JVector position;
    public JVector velocity;
    public JQuaternion orientation;
    public int areaOfEffectShape;
    public float aoeRadius;
    public float aoeDeadzone;
    public float aoeAngle;
    public int projectileDmg;
    public float projectilePushback;

    public ProjectileImpactEffect GetImpactEffect() => new ProjectileImpactEffect(new AreaOfEffect()
    {
      shape = (AoeShape) this.areaOfEffectShape,
      radius = this.aoeRadius,
      angle = this.aoeAngle,
      deadZone = this.aoeDeadzone
    }, this.projectileDmg, this.projectilePushback);

    public SpawnProjectileMessage()
      : base(SpawnProjectileMessage.Type)
    {
    }

    public SpawnProjectileMessage(
      ushort uniqueId,
      ulong owner,
      ProjectileType projectileType,
      float radius,
      float height,
      JVector position,
      JQuaternion orientation,
      JVector velocity,
      int areaOfEffectShape,
      float aoeRadius,
      float aoeDeadzone,
      float aoeAngle,
      int projectileDmg,
      float projectilePushback)
      : base(SpawnProjectileMessage.Type)
    {
      this.uniqueId = uniqueId;
      this.owner = owner;
      this.projectileType = (int) projectileType;
      this.radius = radius;
      this.height = height;
      this.position = position;
      this.velocity = velocity;
      this.orientation = orientation;
      this.areaOfEffectShape = areaOfEffectShape;
      this.aoeRadius = aoeRadius;
      this.aoeDeadzone = aoeDeadzone;
      this.aoeAngle = aoeAngle;
      this.projectileDmg = projectileDmg;
      this.projectilePushback = projectilePushback;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.UShort(ref this.uniqueId);
      messageSerDes.ULong(ref this.owner);
      messageSerDes.JVector(ref this.position);
      messageSerDes.JVector(ref this.velocity);
      messageSerDes.JQuaternion(ref this.orientation);
      messageSerDes.Int(ref this.projectileType);
      messageSerDes.Int(ref this.projectileDmg);
      messageSerDes.Int(ref this.areaOfEffectShape);
      messageSerDes.Float(ref this.radius);
      messageSerDes.Float(ref this.height);
      messageSerDes.Float(ref this.aoeRadius);
      messageSerDes.Float(ref this.aoeDeadzone);
      messageSerDes.Float(ref this.aoeAngle);
      messageSerDes.Float(ref this.projectilePushback);
    }
  }
}
