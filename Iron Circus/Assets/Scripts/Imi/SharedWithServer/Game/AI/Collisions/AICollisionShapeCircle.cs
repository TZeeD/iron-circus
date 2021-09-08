// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.Collisions.AICollisionShapeCircle
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.AI.Collisions
{
  public class AICollisionShapeCircle : AICollisionShape
  {
    private float radius;
    private JVector position;
    private float sqrRadius;

    public float Radius
    {
      get => this.radius;
      set
      {
        this.radius = value;
        this.sqrRadius = this.radius * this.radius;
      }
    }

    public JVector Position
    {
      get => this.position;
      set => this.position = value;
    }

    public AICollisionShapeCircle(
      JVector position,
      float radius,
      bool isTrigger = false,
      GameEntity entity = null)
      : base(isTrigger, entity)
    {
      this.position = position;
      this.radius = radius;
      this.sqrRadius = radius * radius;
    }

    public override void Expand(float units)
    {
      this.radius += units;
      this.sqrRadius = this.radius * this.radius;
    }

    public override string ToString() => string.Format("Circle - pos: {0} radius {1}\n", (object) this.position.ToString(), (object) this.radius);

    public override bool SegmentIntersection(
      JVector rayStart,
      JVector rayDir,
      out JVector contact,
      out float distance,
      out JVector normal)
    {
      contact = normal = JVector.Zero;
      distance = 0.0f;
      float num1 = rayStart.X - this.position.X;
      float num2 = rayStart.Z - this.position.Z;
      float num3 = (float) ((double) rayDir.X * (double) rayDir.X + (double) rayDir.Z * (double) rayDir.Z);
      float num4 = (float) (-2.0 * ((double) rayDir.X * (double) num1 + (double) rayDir.Z * (double) num2));
      float num5 = (float) ((double) num1 * (double) num1 + (double) num2 * (double) num2) - this.sqrRadius;
      float num6 = num3 * 2f;
      float number = (float) ((double) num4 * (double) num4 - 2.0 * (double) num6 * (double) num5);
      if ((double) number < 0.0 || (double) num3 == 0.0)
        return false;
      float num7 = JMath.Sqrt(number);
      float num8 = (num4 + num7) / num6;
      float num9 = (num4 - num7) / num6;
      bool flag1 = (double) num8 >= 0.0 && (double) num8 <= 1.0 && !float.IsNaN(num8);
      bool flag2 = (double) num9 >= 0.0 && (double) num9 <= 1.0 && !float.IsNaN(num9);
      if (!flag1 && !flag2)
        return false;
      distance = flag1 ? (flag2 ? JMath.Min(num8, num9) : num8) : num9;
      contact = rayStart + distance * rayDir;
      normal = (contact - this.position).Normalized();
      return true;
    }
  }
}
