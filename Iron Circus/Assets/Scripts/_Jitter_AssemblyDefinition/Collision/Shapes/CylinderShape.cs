// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.CylinderShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Collision.Shapes
{
  public class CylinderShape : RoundShapeBase
  {
    private float height;

    public CylinderShape(float height, float radius)
    {
      this.height = height;
      this.radius = radius;
      this.UpdateShape();
    }

    public float Height
    {
      get => this.height;
      set
      {
        this.height = value;
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
      this.mass = 3.141593f * this.radius * this.radius * this.height;
      this.inertia.M11 = (float) (0.25 * (double) this.mass * (double) this.radius * (double) this.radius + 0.0833333358168602 * (double) this.mass * (double) this.height * (double) this.height);
      this.inertia.M22 = 0.5f * this.mass * this.radius * this.radius;
      this.inertia.M33 = (float) (0.25 * (double) this.mass * (double) this.radius * (double) this.radius + 0.0833333358168602 * (double) this.mass * (double) this.height * (double) this.height);
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      float num = (float) Math.Sqrt((double) direction.X * (double) direction.X + (double) direction.Z * (double) direction.Z);
      if ((double) num > 0.0)
      {
        result.X = direction.X / num * this.radius;
        result.Y = (float) ((double) Math.Sign(direction.Y) * (double) this.height * 0.5);
        result.Z = direction.Z / num * this.radius;
      }
      else
      {
        result.X = 0.0f;
        result.Y = (float) ((double) Math.Sign(direction.Y) * (double) this.height * 0.5);
        result.Z = 0.0f;
      }
    }
  }
}
