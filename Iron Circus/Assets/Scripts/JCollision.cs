// Decompiled with JetBrains decompiler
// Type: JCollision
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.Dynamics;
using Jitter.LinearMath;

public struct JCollision
{
  public GameEntity entity1;
  public GameEntity entity2;
  public JRigidbody body1;
  public JRigidbody body2;
  public JVector point1;
  public JVector point2;
  public JVector normal;
  public float penetration;

  public JCollision(
    GameEntity entity1,
    GameEntity entity2,
    JRigidbody body1,
    JRigidbody body2,
    JVector point1,
    JVector point2,
    JVector normal,
    float penetration)
  {
    this.entity1 = entity1;
    this.entity2 = entity2;
    this.body1 = body1;
    this.body2 = body2;
    this.point1 = point1;
    this.point2 = point2;
    this.normal = normal;
    this.penetration = penetration;
  }
}
