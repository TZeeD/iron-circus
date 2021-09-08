// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.Shapes.SphereShape
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Collision.Shapes
{
  public class SphereShape : RoundShapeBase
  {
    public SphereShape(float radius)
    {
      this.radius = radius;
      this.UpdateShape();
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

    public override void SupportMapping(ref JVector direction, out JVector result)
    {
      result = direction;
      result.Normalize();
      JVector.Multiply(ref result, this.radius, out result);
    }

    public override void GetBoundingBox(ref JMatrix orientation, out JBBox box)
    {
      box.Min.X = -this.radius;
      box.Min.Y = -this.radius;
      box.Min.Z = -this.radius;
      box.Max.X = this.radius;
      box.Max.Y = this.radius;
      box.Max.Z = this.radius;
    }

    public override void CalculateMassInertia()
    {
      this.mass = 4.18879f * this.radius * this.radius * this.radius;
      this.inertia = JMatrix.Identity;
      this.inertia.M11 = 0.4f * this.mass * this.radius * this.radius;
      this.inertia.M22 = 0.4f * this.mass * this.radius * this.radius;
      this.inertia.M33 = 0.4f * this.mass * this.radius * this.radius;
    }
  }
}
