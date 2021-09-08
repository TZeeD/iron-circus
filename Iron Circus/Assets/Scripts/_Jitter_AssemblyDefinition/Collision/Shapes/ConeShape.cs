// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.ConeShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;
using System;

namespace Jitter.Collision.Shapes
{
  public class ConeShape : RoundShapeBase
  {
    private float height;
    private float sina;

    public ConeShape(float height, float radius)
    {
      this.height = height;
      this.radius = radius;
      this.UpdateShape(false);
    }

    public float Height
    {
      get => this.height;
      set
      {
        this.height = value;
        this.UpdateShape(false);
      }
    }

    public float Radius
    {
      get => this.radius;
      set
      {
        this.radius = value;
        this.UpdateShape(false);
      }
    }

    public override void UpdateShape(bool skipMassInertia = false)
    {
      this.sina = this.radius / (float) Math.Sqrt((double) this.radius * (double) this.radius + (double) this.height * (double) this.height);
      base.UpdateShape(skipMassInertia);
    }

    public override void CalculateMassInertia()
    {
      this.mass = 1.047198f * this.radius * this.radius * this.height;
      this.inertia = JMatrix.Identity;
      this.inertia.M11 = (float) (0.0375000014901161 * (double) this.mass * ((double) this.radius * (double) this.radius + 4.0 * (double) this.height * (double) this.height));
      this.inertia.M22 = 0.3f * this.mass * this.radius * this.radius;
      this.inertia.M33 = (float) (0.0375000014901161 * (double) this.mass * ((double) this.radius * (double) this.radius + 4.0 * (double) this.height * (double) this.height));
      this.geomCen = JVector.Zero;
    }

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      float num = (float) Math.Sqrt((double) direction.X * (double) direction.X + (double) direction.Z * (double) direction.Z);
      if ((double) direction.Y > (double) direction.Length() * (double) this.sina)
      {
        result.X = 0.0f;
        result.Y = 0.6666667f * this.height;
        result.Z = 0.0f;
      }
      else if ((double) num > 0.0)
      {
        result.X = this.radius * direction.X / num;
        result.Y = -0.3333333f * this.height;
        result.Z = this.radius * direction.Z / num;
      }
      else
      {
        result.X = 0.0f;
        result.Y = -0.3333333f * this.height;
        result.Z = 0.0f;
      }
    }
  }
}
