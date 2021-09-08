// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.CapsuleShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Collision.Shapes
{
  public class CapsuleShape : RoundShapeBase
  {
    private float length;

    public CapsuleShape(float length, float radius)
    {
      this.length = length;
      this.radius = radius;
      this.UpdateShape();
    }

    public float Length
    {
      get => this.length;
      set
      {
        this.length = value;
        this.UpdateShape();
      }
    }

    public float Radius
    {
      get => this.radius;
      set
      {
        this.radius = value;
        this.UpdateShape();
      }
    }

    public override void CalculateMassInertia()
    {
      float num1 = 2.356194f * this.radius * this.radius * this.radius;
      float num2 = 3.141593f * this.radius * this.radius * this.length;
      this.mass = num2 + num1;
      this.inertia.M11 = (float) (0.25 * (double) num2 * (double) this.radius * (double) this.radius + 0.0833333358168602 * (double) num2 * (double) this.length * (double) this.length + 0.400000005960464 * (double) num1 * (double) this.radius * (double) this.radius + 0.25 * (double) this.length * (double) this.length * (double) num1);
      this.inertia.M22 = (float) (0.5 * (double) num2 * (double) this.radius * (double) this.radius + 0.400000005960464 * (double) num1 * (double) this.radius * (double) this.radius);
      this.inertia.M33 = (float) (0.25 * (double) num2 * (double) this.radius * (double) this.radius + 0.0833333358168602 * (double) num2 * (double) this.length * (double) this.length + 0.400000005960464 * (double) num1 * (double) this.radius * (double) this.radius + 0.25 * (double) this.length * (double) this.length * (double) num1);
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      float num = (float) Math.Sqrt((double) direction.X * (double) direction.X + (double) direction.Z * (double) direction.Z);
      if ((double) Math.Abs(direction.Y) > 0.0)
      {
        JVector result1;
        JVector.Normalize(ref direction, out result1);
        JVector.Multiply(ref result1, this.radius, out result);
        result.Y += (float) Math.Sign(direction.Y) * 0.5f * this.length;
      }
      else if ((double) num > 0.0)
      {
        result.X = direction.X / num * this.radius;
        result.Y = 0.0f;
        result.Z = direction.Z / num * this.radius;
      }
      else
      {
        result.X = 0.0f;
        result.Y = 0.0f;
        result.Z = 0.0f;
      }
    }
  }
}
